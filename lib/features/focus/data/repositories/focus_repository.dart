// lib/features/focus/data/repositories/focus_repository.dart
//
// StudySpark — Focus (Pomodoro) Repository
//
// Persists and queries [PomodoroSessionModel] records.
//
// Key responsibilities:
//   • Save a session when the timer completes or is abandoned.
//   • Compute daily / weekly focus totals for the analytics chart.
//   • Compute the current study streak (consecutive days with ≥ 1 session).
//
// The [localDateKey] "yyyy-MM-dd" string enables O(1) daily queries without
// scanning a DateTime range — see design notes in MODELS_README.md.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/enums/app_enums.dart';
import '../models/pomodoro_session_model.dart';

// ─── DailyFocusSummary ────────────────────────────────────────────────────────

/// Aggregated focus data for a single calendar day (used by the chart widget).
class DailyFocusSummary {
  const DailyFocusSummary({
    required this.dateKey,
    required this.totalMinutes,
    required this.sessionCount,
    required this.completedCount,
  });

  final String dateKey;
  final int totalMinutes;
  final int sessionCount;
  final int completedCount;

  /// Fraction of sessions that were completed (0.0–1.0).
  double get completionRate =>
      sessionCount == 0 ? 0.0 : completedCount / sessionCount;
}

// ─── FocusRepository ─────────────────────────────────────────────────────────

class FocusRepository {
  const FocusRepository(this._isar);

  final Isar _isar;
  static const _uuid = Uuid();
  static final _dateFmt = DateFormat('yyyy-MM-dd');

  // ── CREATE ────────────────────────────────────────────────────────────────

  /// Saves a completed or abandoned Pomodoro session.
  ///
  /// [actualDurationSeconds] is the wall-clock time the user focused
  /// (excluding paused time).  [plannedDurationSeconds] is the timer goal.
  Future<PomodoroSessionModel> saveSession({
    required PomodoroMode mode,
    required SessionStatus status,
    required int plannedDurationSeconds,
    required int actualDurationSeconds,
    String subjectId = '',
    String taskId = '',
    int pauseCount = 0,
    int totalPausedSeconds = 0,
    int distractionCount = 0,
    String notes = '',
    DateTime? startedAt,
  }) async {
    final start = startedAt ?? DateTime.now().toUtc();
    final session = PomodoroSessionModel(
      uuid: _uuid.v4(),
      mode: mode,
      status: status,
      subjectId: subjectId,
      taskId: taskId,
      plannedDurationSeconds: plannedDurationSeconds,
      actualDurationSeconds: actualDurationSeconds,
      pauseCount: pauseCount,
      totalPausedSeconds: totalPausedSeconds,
      distractionCount: distractionCount,
      notes: notes,
      startedAt: start,
      endedAt: DateTime.now().toUtc(),
      // Fast date-key for daily aggregation queries.
      localDateKey: _dateFmt.format(start.toLocal()),
    );

    await _isar.writeTxn(() async {
      session.id = await _isar.pomodoroSessionModels.put(session);
    });
    return session;
  }

  // ── READ ──────────────────────────────────────────────────────────────────

  /// Reactive stream of all sessions for [dateKey] (e.g. "2025-06-03").
  Stream<List<PomodoroSessionModel>> watchSessionsForDay(String dateKey) {
    return _isar.pomodoroSessionModels
        .filter()
        .localDateKeyEqualTo(dateKey)
        .sortByStartedAt()
        .watch(fireImmediately: true);
  }

  /// Returns all sessions for a specific date key (one-shot).
  Future<List<PomodoroSessionModel>> getSessionsForDay(String dateKey) {
    return _isar.pomodoroSessionModels
        .filter()
        .localDateKeyEqualTo(dateKey)
        .findAll();
  }

  /// Reactive stream of the last [dayCount] days of sessions (for charts).
  Stream<List<PomodoroSessionModel>> watchRecentSessions({int dayCount = 7}) {
    final cutoff = DateTime.now().toUtc().subtract(Duration(days: dayCount));
    return _isar.pomodoroSessionModels
        .filter()
        .startedAtGreaterThan(cutoff)
        .sortByStartedAt()
        .watch(fireImmediately: true);
  }

  /// Builds per-day focus summaries for the last [dayCount] days.
  ///
  /// Returns a list ordered by date ascending — ready for fl_chart.
  Future<List<DailyFocusSummary>> getWeeklyFocusSummary({
    int dayCount = 7,
  }) async {
    final today = DateTime.now().toLocal();
    final summaries = <DailyFocusSummary>[];

    for (int i = dayCount - 1; i >= 0; i--) {
      final day = today.subtract(Duration(days: i));
      final key = _dateFmt.format(day);
      final sessions = await getSessionsForDay(key);

      final total = sessions.fold<int>(
        0,
        (sum, s) => sum + s.actualDurationMinutes,
      );
      final completed =
          sessions.where((s) => s.status == SessionStatus.completed).length;

      summaries.add(DailyFocusSummary(
        dateKey: key,
        totalMinutes: total,
        sessionCount: sessions.length,
        completedCount: completed,
      ));
    }
    return summaries;
  }

  /// Total focus minutes across all time for a subject.
  Future<int> totalMinutesBySubject(String subjectId) async {
    final sessions = await _isar.pomodoroSessionModels
        .filter()
        .subjectIdEqualTo(subjectId)
        .statusEqualTo(SessionStatus.completed)
        .findAll();
    return sessions.fold(0, (sum, s) => sum + s.actualDurationMinutes);
  }

  /// Computes the current study streak: the number of consecutive calendar
  /// days (counting backwards from today) that have at least one completed
  /// session.
  Future<int> computeCurrentStreak() async {
    final today = DateTime.now().toLocal();
    int streak = 0;

    for (int i = 0;; i++) {
      final day = today.subtract(Duration(days: i));
      final key = _dateFmt.format(day);
      final count = await _isar.pomodoroSessionModels
          .filter()
          .localDateKeyEqualTo(key)
          .statusEqualTo(SessionStatus.completed)
          .count();

      if (count == 0) break;
      streak++;
    }
    return streak;
  }

  /// Returns today's total focus minutes (completed sessions only).
  Future<int> todayTotalMinutes() async {
    final key = _dateFmt.format(DateTime.now().toLocal());
    final sessions = await _isar.pomodoroSessionModels
        .filter()
        .localDateKeyEqualTo(key)
        .statusEqualTo(SessionStatus.completed)
        .findAll();
    return sessions.fold(0, (sum, s) => sum + s.actualDurationMinutes);
  }

  /// Today's session count (all statuses).
  Future<int> todaySessionCount() async {
    final key = _dateFmt.format(DateTime.now().toLocal());
    return _isar.pomodoroSessionModels
        .filter()
        .localDateKeyEqualTo(key)
        .count();
  }

  // ── DELETE ────────────────────────────────────────────────────────────────

  /// Removes a session by UUID (edge case: user deletes a mistaken entry).
  Future<bool> deleteSession(String uuid) async {
    final session = await _isar.pomodoroSessionModels
        .filter()
        .uuidEqualTo(uuid)
        .findFirst();
    if (session == null) return false;
    return _isar.writeTxn(
      () => _isar.pomodoroSessionModels.delete(session.id),
    );
  }
}
