// lib/features/focus/data/repositories/focus_repository.dart
//
// StudySpark — Focus Repository (Step 5 – updated)
//
// Handles persistence of PomodoroSessionModel to Isar.
// Used by PomodoroTimerNotifier (fire-and-forget) and Analytics providers.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/enums/app_enums.dart';
import '../models/pomodoro_session_model.dart';
import '../models/focus_session_model.dart';

final _dateFmt = DateFormat('yyyy-MM-dd');
const _uuid = Uuid();

// ─── Weekly summary ───────────────────────────────────────────────────────────

class DailyFocusSummary {
  const DailyFocusSummary({
    required this.dateKey,
    required this.totalMinutes,
    required this.sessionCount,
  });

  final String dateKey;
  final int totalMinutes;
  final int sessionCount;
}

// ─── Repository ───────────────────────────────────────────────────────────────

class FocusRepository {
  const FocusRepository(this._isar);

  final Isar _isar;

  // ── WRITE ────────────────────────────────────────────────────────────────

  /// Persists a [PomodoroSessionModel] to Isar.
  /// Called fire-and-forget from [PomodoroTimerNotifier].
  Future<void> saveSession(PomodoroSessionModel session) async {
    await _isar.writeTxn(() async {
      session.id = await _isar.pomodoroSessionModels.put(session);
    });
  }

  /// Persists a [FocusSessionModel] (deep-work / free-form session).
  Future<void> saveFocusSession(FocusSessionModel session) async {
    await _isar.writeTxn(() async {
      session.id = await _isar.focusSessionModels.put(session);
    });
  }

  // ── READ ─────────────────────────────────────────────────────────────────

  /// Total minutes of completed work sessions for today.
  Future<int> todayTotalMinutes() async {
    final key = _dateFmt.format(DateTime.now());
    final sessions = await _isar.pomodoroSessionModels
        .filter()
        .localDateKeyEqualTo(key)
        .wasCompletedEqualTo(true)
        .modeEqualTo(PomodoroMode.pomodoro)
        .findAll();

    final totalSecs = sessions.fold(0, (sum, s) => sum + s.actualDurationSeconds);
    return totalSecs ~/ 60;
  }

  /// Reactive stream of sessions for a given day.
  Stream<List<PomodoroSessionModel>> watchSessionsForDay(String dateKey) {
    return _isar.pomodoroSessionModels
        .filter()
        .localDateKeyEqualTo(dateKey)
        .sortByCompletedAtDesc()
        .watch(fireImmediately: true);
  }

  /// Weekly summary: last 7 days, each day's total work minutes + session count.
  Future<List<DailyFocusSummary>> getWeeklyFocusSummary() async {
    final today = DateTime.now();
    final summaries = <DailyFocusSummary>[];

    for (int i = 6; i >= 0; i--) {
      final day = today.subtract(Duration(days: i));
      final key = _dateFmt.format(day);
      final sessions = await _isar.pomodoroSessionModels
          .filter()
          .localDateKeyEqualTo(key)
          .wasCompletedEqualTo(true)
          .modeEqualTo(PomodoroMode.pomodoro)
          .findAll();

      final totalSecs =
          sessions.fold(0, (sum, s) => sum + s.actualDurationSeconds);

      summaries.add(DailyFocusSummary(
        dateKey: key,
        totalMinutes: totalSecs ~/ 60,
        sessionCount: sessions.length,
      ));
    }
    return summaries;
  }

  /// Current consecutive day streak (counts days with ≥1 completed work session).
  Future<int> computeCurrentStreak() async {
    final today = DateTime.now();
    int streak = 0;

    for (int i = 0; i < 365; i++) {
      final key = _dateFmt.format(today.subtract(Duration(days: i)));
      final count = await _isar.pomodoroSessionModels
          .filter()
          .localDateKeyEqualTo(key)
          .wasCompletedEqualTo(true)
          .modeEqualTo(PomodoroMode.pomodoro)
          .count();

      if (count > 0) {
        streak++;
      } else if (i > 0) {
        break;
      }
    }
    return streak;
  }

  /// Last [limit] completed sessions, descending.
  Future<List<PomodoroSessionModel>> getRecentSessions({int limit = 30}) {
    return _isar.pomodoroSessionModels
        .filter()
        .wasCompletedEqualTo(true)
        .sortByCompletedAtDesc()
        .limit(limit)
        .findAll();
  }

  /// All sessions in a date range (for heatmap).
  Future<List<PomodoroSessionModel>> getSessionsInRange(
      DateTime start, DateTime end) {
    return _isar.pomodoroSessionModels
        .filter()
        .completedAtGreaterThan(start.toUtc())
        .completedAtLessThan(end.toUtc())
        .wasCompletedEqualTo(true)
        .findAll();
  }
}
