// lib/core/services/pomodoro_service.dart
//
// StudySpark — Pomodoro Timer Service
//
// Implements the Pomodoro state machine as a Riverpod [AsyncNotifier].
// The timer ticks every second via [Timer.periodic] and exposes:
//   • [PomodoroState]        — current phase, remaining seconds, session count
//   • [start] / [pause] / [resume] / [stop] — timer controls
//   • [skipPhase]            — jump to the next phase manually
//
// On session completion the notifier:
//   1. Saves the record via [FocusRepository].
//   2. Fires a completion notification via [NotificationService].
//   3. Awards XP via [ProfileRepository].
//   4. Auto-starts the break if [autoStartBreaks] is true.
//
// Timer phases follow the classic Pomodoro cycle:
//   work → short break → work → short break → … → long break (every N rounds)
// ─────────────────────────────────────────────────────────────────────────────

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../core/enums/app_enums.dart';
import '../../features/focus/data/models/pomodoro_session_model.dart';
import '../../features/focus/data/repositories/focus_repository.dart';
import '../../features/profile/data/repositories/profile_repository.dart';
import 'notification_service.dart' show NotificationService, notificationServiceProvider;
import '../../shared/providers/repository_providers.dart' show focusRepositoryProvider, profileRepositoryProvider;

// ─── PomodoroPhase ────────────────────────────────────────────────────────────

/// The four possible phases of the Pomodoro cycle.
final _pomodoroDateFmt = DateFormat('yyyy-MM-dd');
const _pomodoroUuid = Uuid();

enum PomodoroPhase { work, shortBreak, longBreak, idle }

// ─── PomodoroState ────────────────────────────────────────────────────────────

/// Immutable snapshot of the timer at any point in time.
class PomodoroState {
  const PomodoroState({
    this.phase = PomodoroPhase.idle,
    this.remainingSeconds = 0,
    this.totalSeconds = 0,
    this.isRunning = false,
    this.isPaused = false,
    this.completedWorkSessions = 0,
    this.pauseCount = 0,
    this.totalPausedSeconds = 0,
    this.distractionCount = 0,
    this.linkedTaskId,
    this.linkedSubjectId,
  });

  final PomodoroPhase phase;
  final int remainingSeconds;
  final int totalSeconds;
  final bool isRunning;
  final bool isPaused;

  /// Work sessions completed in this "set" (resets after a long break).
  final int completedWorkSessions;
  final int pauseCount;
  final int totalPausedSeconds;
  final int distractionCount;
  final String? linkedTaskId;
  final String? linkedSubjectId;

  /// 0.0 (start) → 1.0 (complete).
  double get progress =>
      totalSeconds == 0 ? 0.0 : 1.0 - (remainingSeconds / totalSeconds);

  PomodoroState copyWith({
    PomodoroPhase? phase,
    int? remainingSeconds,
    int? totalSeconds,
    bool? isRunning,
    bool? isPaused,
    int? completedWorkSessions,
    int? pauseCount,
    int? totalPausedSeconds,
    int? distractionCount,
    String? linkedTaskId,
    String? linkedSubjectId,
  }) {
    return PomodoroState(
      phase: phase ?? this.phase,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      totalSeconds: totalSeconds ?? this.totalSeconds,
      isRunning: isRunning ?? this.isRunning,
      isPaused: isPaused ?? this.isPaused,
      completedWorkSessions: completedWorkSessions ?? this.completedWorkSessions,
      pauseCount: pauseCount ?? this.pauseCount,
      totalPausedSeconds: totalPausedSeconds ?? this.totalPausedSeconds,
      distractionCount: distractionCount ?? this.distractionCount,
      linkedTaskId: linkedTaskId ?? this.linkedTaskId,
      linkedSubjectId: linkedSubjectId ?? this.linkedSubjectId,
    );
  }
}

// ─── PomodoroNotifier ─────────────────────────────────────────────────────────

/// Riverpod notifier that owns the timer lifecycle.
///
/// Provide via [pomodoroProvider] — see providers/focus_providers.dart.
class PomodoroNotifier extends Notifier<PomodoroState> {
  Timer? _ticker;
  DateTime? _sessionStart;
  int _pauseAccumulator = 0; // total paused seconds this session
  DateTime? _pausedAt;       // wall-clock when last paused

  // ── Config cache (read from UserModel on first use) ───────────────────────
  late int _workSeconds;
  late int _shortBreakSeconds;
  late int _longBreakSeconds;
  late int _sessionsBeforeLong;
  late bool _autoStartBreaks;

  @override
  PomodoroState build() {
    // Read user prefs from the profile repository.
    _loadPreferences();

    // Clean up timer on dispose (e.g. provider reset).
    ref.onDispose(_cancelTicker);

    return const PomodoroState();
  }

  // ── Public API ────────────────────────────────────────────────────────────

  /// Starts a new work session, optionally linked to a task or subject.
  void start({String? taskId, String? subjectId}) {
    _cancelTicker();
    _sessionStart = DateTime.now();
    _pauseAccumulator = 0;

    final seconds = _workSeconds;

    state = PomodoroState(
      phase: PomodoroPhase.work,
      remainingSeconds: seconds,
      totalSeconds: seconds,
      isRunning: true,
      linkedTaskId: taskId,
      linkedSubjectId: subjectId,
    );

    // Schedule system notification for when the timer ends.
    ref.read(notificationServiceProvider).scheduleTimerEnd(
          durationSeconds: seconds,
          title: '✅ Work session complete!',
          body: 'Time for a break. Great focus!',
        );

    _ticker = Timer.periodic(const Duration(seconds: 1), _onTick);
  }

  /// Pauses the running timer.
  void pause() {
    if (!state.isRunning || state.isPaused) return;
    _cancelTicker();
    _pausedAt = DateTime.now();

    // Cancel the scheduled end notification since the timer is paused.
    ref.read(notificationServiceProvider).cancelTimerNotification();

    state = state.copyWith(
      isRunning: false,
      isPaused: true,
      pauseCount: state.pauseCount + 1,
    );
  }

  /// Resumes after a pause.
  void resume() {
    if (!state.isPaused) return;

    // Accumulate paused duration.
    if (_pausedAt != null) {
      _pauseAccumulator +=
          DateTime.now().difference(_pausedAt!).inSeconds;
      _pausedAt = null;
    }

    state = state.copyWith(
      isRunning: true,
      isPaused: false,
      totalPausedSeconds: _pauseAccumulator,
    );

    // Re-schedule system notification.
    ref.read(notificationServiceProvider).scheduleTimerEnd(
          durationSeconds: state.remainingSeconds,
          title: '✅ Work session complete!',
          body: 'Time for a break. Great focus!',
        );

    _ticker = Timer.periodic(const Duration(seconds: 1), _onTick);
  }

  /// Stops and abandons the current session, persisting a partial record.
  Future<void> stop() async {
    _cancelTicker();
    ref.read(notificationServiceProvider).cancelTimerNotification();

    if (_sessionStart != null && state.phase == PomodoroPhase.work) {
      final actualSeconds = (_workSeconds - state.remainingSeconds)
          .clamp(0, _workSeconds);
      await _persistSession(
        status: SessionStatus.abandoned,
        actualSeconds: actualSeconds,
      );
    }

    state = const PomodoroState();
    _sessionStart = null;
  }

  /// Skips the current phase and moves to the next one immediately.
  Future<void> skipPhase() async {
    _cancelTicker();
    ref.read(notificationServiceProvider).cancelTimerNotification();

    if (state.phase == PomodoroPhase.work) {
      // Treat skip as an abandoned work session.
      if (_sessionStart != null) {
        final actualSeconds = (_workSeconds - state.remainingSeconds)
            .clamp(0, _workSeconds);
        await _persistSession(
          status: SessionStatus.abandoned,
          actualSeconds: actualSeconds,
        );
      }
      _startBreak();
    } else {
      // Skip a break — start the next work session.
      start(taskId: state.linkedTaskId, subjectId: state.linkedSubjectId);
    }
  }

  /// Increments the distraction counter (user tapped "I got distracted").
  void logDistraction() {
    state = state.copyWith(distractionCount: state.distractionCount + 1);
  }

  // ── Private ───────────────────────────────────────────────────────────────

  void _onTick(Timer _) {
    final remaining = state.remainingSeconds - 1;
    if (remaining <= 0) {
      _onPhaseComplete();
    } else {
      state = state.copyWith(remainingSeconds: remaining);
    }
  }

  Future<void> _onPhaseComplete() async {
    _cancelTicker();

    if (state.phase == PomodoroPhase.work) {
      await _persistSession(
        status: SessionStatus.completed,
        actualSeconds: _workSeconds,
      );

      final completed = state.completedWorkSessions + 1;
      state = state.copyWith(
        completedWorkSessions: completed,
        isRunning: false,
        remainingSeconds: 0,
      );

      await ref.read(notificationServiceProvider).showPomodoroComplete(
            sessionType: 'Work',
            nextType: _isLongBreakDue(completed) ? 'Long Break' : 'Short Break',
          );

      if (_autoStartBreaks) {
        _startBreak(completedCount: completed);
      } else {
        // Stay idle; UI will show "Start Break" button.
        state = state.copyWith(phase: PomodoroPhase.idle);
      }
    } else {
      // Break complete.
      await ref.read(notificationServiceProvider).showPomodoroComplete(
            sessionType: state.phase == PomodoroPhase.longBreak
                ? 'Long Break'
                : 'Short Break',
            nextType: 'Work',
          );

      if (_autoStartBreaks) {
        start(taskId: state.linkedTaskId, subjectId: state.linkedSubjectId);
      } else {
        state = state.copyWith(phase: PomodoroPhase.idle, isRunning: false);
      }
    }
  }

  void _startBreak({int? completedCount}) {
    final count = completedCount ?? state.completedWorkSessions;
    final isLong = _isLongBreakDue(count);
    final seconds = isLong ? _longBreakSeconds : _shortBreakSeconds;

    state = PomodoroState(
      phase: isLong ? PomodoroPhase.longBreak : PomodoroPhase.shortBreak,
      remainingSeconds: seconds,
      totalSeconds: seconds,
      isRunning: true,
      completedWorkSessions: count,
      linkedTaskId: state.linkedTaskId,
      linkedSubjectId: state.linkedSubjectId,
    );

    ref.read(notificationServiceProvider).scheduleTimerEnd(
          durationSeconds: seconds,
          title: '☕ Break over!',
          body: "Let's get back to work.",
        );

    _ticker = Timer.periodic(const Duration(seconds: 1), _onTick);
  }

  bool _isLongBreakDue(int completedSessions) =>
      completedSessions % _sessionsBeforeLong == 0;

  Future<void> _persistSession({
    required SessionStatus status,
    required int actualSeconds,
  }) async {
    final focusRepo = ref.read(focusRepositoryProvider);
    final profileRepo = ref.read(profileRepositoryProvider);

    final session = PomodoroSessionModel(
      uuid: _pomodoroUuid.v4(),
      mode: PomodoroMode.pomodoro,
      plannedDurationSeconds: _workSeconds,
      actualDurationSeconds: actualSeconds,
      completedAt: DateTime.now().toUtc(),
      localDateKey: _pomodoroDateFmt.format(DateTime.now()),
      wasCompleted: status == SessionStatus.completed,
      linkedTaskId: state.linkedTaskId ?? '',
      label: '',
    );
    await focusRepo.saveSession(session);

    // Award XP: 10 per completed session, 3 for abandoned.
    if (status == SessionStatus.completed) {
      await profileRepo.addXp(10);
    } else {
      await profileRepo.addXp(3);
    }

    _sessionStart = null;
    _pauseAccumulator = 0;
  }

  void _cancelTicker() {
    _ticker?.cancel();
    _ticker = null;
  }

  /// Reads user Pomodoro preferences from the profile.
  ///
  /// Falls back to classic Pomodoro defaults if the profile is not yet loaded.
  void _loadPreferences() {
    // TODO: watch profileProvider here for live preference updates.
    // For now we use hard-coded defaults; the UI settings screen will
    // trigger a provider refresh when the user changes prefs.
    _workSeconds = 25 * 60;
    _shortBreakSeconds = 5 * 60;
    _longBreakSeconds = 15 * 60;
    _sessionsBeforeLong = 4;
    _autoStartBreaks = false;
  }

  /// Called by the settings screen after the user changes timer durations.
  void refreshPreferences({
    required int workMinutes,
    required int shortBreakMinutes,
    required int longBreakMinutes,
    required int sessionsBeforeLong,
    required bool autoStartBreaks,
  }) {
    _workSeconds = workMinutes * 60;
    _shortBreakSeconds = shortBreakMinutes * 60;
    _longBreakSeconds = longBreakMinutes * 60;
    _sessionsBeforeLong = sessionsBeforeLong;
    _autoStartBreaks = autoStartBreaks;
  }
}
/// Stateful Pomodoro timer ([PomodoroNotifier]).
final pomodoroProvider = NotifierProvider<PomodoroNotifier, PomodoroState>(
  PomodoroNotifier.new,
);
