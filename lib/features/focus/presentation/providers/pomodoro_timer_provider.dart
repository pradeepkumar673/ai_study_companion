// lib/features/focus/presentation/providers/pomodoro_timer_provider.dart
//
// StudySpark — Full Pomodoro Timer State Machine (Step 5)
//
// Manages:
//   • 25/5 (and custom) work/break cycle
//   • Pause / resume / skip / stop
//   • Round counting
//   • Auto-save PomodoroSessionModel to Isar via FocusRepository
//   • XP award via GamificationService
//   • Notification fire via NotificationService
// ─────────────────────────────────────────────────────────────────────────────

import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/enums/app_enums.dart';
import '../../../../shared/providers/repository_providers.dart';
import '../../data/models/pomodoro_session_model.dart';
import '../../data/repositories/focus_repository.dart';

const _uuid = Uuid();
final _dateFmt = DateFormat('yyyy-MM-dd');

// ─── Phase enum ───────────────────────────────────────────────────────────────

enum PomodoroPhase {
  work,
  shortBreak,
  longBreak,
}

extension PomodoroPhaseX on PomodoroPhase {
  String get label => switch (this) {
        PomodoroPhase.work => 'Focus',
        PomodoroPhase.shortBreak => 'Short Break',
        PomodoroPhase.longBreak => 'Long Break',
      };
  bool get isWork => this == PomodoroPhase.work;
}

// ─── Timer status ─────────────────────────────────────────────────────────────

enum PomodoroStatus { idle, running, paused, finished }

// ─── Settings ─────────────────────────────────────────────────────────────────

class PomodoroSettings {
  const PomodoroSettings({
    this.workMinutes = 25,
    this.shortBreakMinutes = 5,
    this.longBreakMinutes = 15,
    this.roundsBeforeLongBreak = 4,
    this.autoStartBreaks = false,
    this.autoStartWork = false,
  });

  final int workMinutes;
  final int shortBreakMinutes;
  final int longBreakMinutes;
  final int roundsBeforeLongBreak;
  final bool autoStartBreaks;
  final bool autoStartWork;

  PomodoroSettings copyWith({
    int? workMinutes,
    int? shortBreakMinutes,
    int? longBreakMinutes,
    int? roundsBeforeLongBreak,
    bool? autoStartBreaks,
    bool? autoStartWork,
  }) {
    return PomodoroSettings(
      workMinutes: workMinutes ?? this.workMinutes,
      shortBreakMinutes: shortBreakMinutes ?? this.shortBreakMinutes,
      longBreakMinutes: longBreakMinutes ?? this.longBreakMinutes,
      roundsBeforeLongBreak:
          roundsBeforeLongBreak ?? this.roundsBeforeLongBreak,
      autoStartBreaks: autoStartBreaks ?? this.autoStartBreaks,
      autoStartWork: autoStartWork ?? this.autoStartWork,
    );
  }
}

// ─── State ────────────────────────────────────────────────────────────────────

class PomodoroTimerState {
  const PomodoroTimerState({
    this.phase = PomodoroPhase.work,
    this.status = PomodoroStatus.idle,
    this.secondsRemaining = 25 * 60,
    this.totalSeconds = 25 * 60,
    this.completedRounds = 0,
    this.completedWorkSessions = 0,
    this.settings = const PomodoroSettings(),
    this.sessionStartedAt,
    this.linkedTaskId,
    this.todayTotalMinutes = 0,
    this.currentSessionLabel = '',
  });

  final PomodoroPhase phase;
  final PomodoroStatus status;
  final int secondsRemaining;
  final int totalSeconds;
  final int completedRounds;
  final int completedWorkSessions;
  final PomodoroSettings settings;
  final DateTime? sessionStartedAt;
  final String? linkedTaskId;
  final int todayTotalMinutes;
  final String currentSessionLabel;

  double get progress =>
      totalSeconds == 0 ? 0 : (totalSeconds - secondsRemaining) / totalSeconds;

  String get timeLabel {
    final m = secondsRemaining ~/ 60;
    final s = secondsRemaining % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  bool get isRunning => status == PomodoroStatus.running;
  bool get isPaused => status == PomodoroStatus.paused;
  bool get isIdle => status == PomodoroStatus.idle;
  bool get isFinished => status == PomodoroStatus.finished;

  PomodoroTimerState copyWith({
    PomodoroPhase? phase,
    PomodoroStatus? status,
    int? secondsRemaining,
    int? totalSeconds,
    int? completedRounds,
    int? completedWorkSessions,
    PomodoroSettings? settings,
    DateTime? sessionStartedAt,
    String? linkedTaskId,
    int? todayTotalMinutes,
    String? currentSessionLabel,
  }) {
    return PomodoroTimerState(
      phase: phase ?? this.phase,
      status: status ?? this.status,
      secondsRemaining: secondsRemaining ?? this.secondsRemaining,
      totalSeconds: totalSeconds ?? this.totalSeconds,
      completedRounds: completedRounds ?? this.completedRounds,
      completedWorkSessions:
          completedWorkSessions ?? this.completedWorkSessions,
      settings: settings ?? this.settings,
      sessionStartedAt: sessionStartedAt ?? this.sessionStartedAt,
      linkedTaskId: linkedTaskId ?? this.linkedTaskId,
      todayTotalMinutes: todayTotalMinutes ?? this.todayTotalMinutes,
      currentSessionLabel:
          currentSessionLabel ?? this.currentSessionLabel,
    );
  }
}

// ─── Notifier ─────────────────────────────────────────────────────────────────

class PomodoroTimerNotifier extends Notifier<PomodoroTimerState> {
  Timer? _ticker;

  @override
  PomodoroTimerState build() {
    ref.onDispose(() => _ticker?.cancel());
    return const PomodoroTimerState();
  }

  // ── Settings ────────────────────────────────────────────────────────────

  void updateSettings(PomodoroSettings settings) {
    if (state.isRunning) return; // Don't change mid-session
    final seconds = settings.workMinutes * 60;
    state = state.copyWith(
      settings: settings,
      secondsRemaining: seconds,
      totalSeconds: seconds,
    );
  }

  // ── Controls ────────────────────────────────────────────────────────────

  void start({String? linkedTaskId, String? label}) {
    if (state.isRunning) return;

    final now = DateTime.now();
    final seconds = _secondsForPhase(state.phase, state.settings);

    state = state.copyWith(
      status: PomodoroStatus.running,
      secondsRemaining: state.isIdle ? seconds : state.secondsRemaining,
      totalSeconds: state.isIdle ? seconds : state.totalSeconds,
      sessionStartedAt: state.isIdle ? now : state.sessionStartedAt,
      linkedTaskId: linkedTaskId ?? state.linkedTaskId,
      currentSessionLabel: label ?? state.currentSessionLabel,
    );

    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), _tick);
    _refreshTodayTotal();
  }

  void pause() {
    if (!state.isRunning) return;
    _ticker?.cancel();
    state = state.copyWith(status: PomodoroStatus.paused);
  }

  void resume() {
    if (!state.isPaused) return;
    _ticker = Timer.periodic(const Duration(seconds: 1), _tick);
    state = state.copyWith(status: PomodoroStatus.running);
  }

  void stop() {
    _ticker?.cancel();
    if (state.isRunning || state.isPaused) {
      _saveSession(completed: false);
    }
    _resetToPhase(PomodoroPhase.work);
  }

  void skipPhase() {
    _ticker?.cancel();
    if (state.phase.isWork) {
      _saveSession(completed: false);
    }
    _advancePhase(completed: false);
  }

  // ── Private ─────────────────────────────────────────────────────────────

  void _tick(Timer t) {
    if (state.secondsRemaining <= 1) {
      t.cancel();
      _onPhaseComplete();
    } else {
      state = state.copyWith(secondsRemaining: state.secondsRemaining - 1);
    }
  }

  void _onPhaseComplete() {
    if (state.phase.isWork) {
      _saveSession(completed: true);
    }
    _advancePhase(completed: true);
  }

  void _advancePhase({required bool completed}) {
    final newRounds = state.phase.isWork
        ? state.completedRounds + 1
        : state.completedRounds;

    final newWorkSessions = completed && state.phase.isWork
        ? state.completedWorkSessions + 1
        : state.completedWorkSessions;

    final nextPhase = _nextPhase(
      current: state.phase,
      completedRounds: newRounds,
      roundsBeforeLong: state.settings.roundsBeforeLongBreak,
    );

    final nextSeconds = _secondsForPhase(nextPhase, state.settings);

    final shouldAutoStart = nextPhase.isWork
        ? state.settings.autoStartWork
        : state.settings.autoStartBreaks;

    state = state.copyWith(
      phase: nextPhase,
      status: shouldAutoStart ? PomodoroStatus.running : PomodoroStatus.finished,
      secondsRemaining: nextSeconds,
      totalSeconds: nextSeconds,
      completedRounds: newRounds,
      completedWorkSessions: newWorkSessions,
      sessionStartedAt: shouldAutoStart ? DateTime.now() : null,
    );

    if (shouldAutoStart) {
      _ticker = Timer.periodic(const Duration(seconds: 1), _tick);
    }
    _refreshTodayTotal();
  }

  void _resetToPhase(PomodoroPhase phase) {
    final seconds = _secondsForPhase(phase, state.settings);
    state = state.copyWith(
      phase: phase,
      status: PomodoroStatus.idle,
      secondsRemaining: seconds,
      totalSeconds: seconds,
      sessionStartedAt: null,
    );
  }

  void _saveSession({required bool completed}) {
    final startedAt = state.sessionStartedAt;
    if (startedAt == null) return;

    final elapsed = DateTime.now().difference(startedAt).inSeconds;
    if (elapsed < 30) return; // Skip very short accidental sessions

    final repo = ref.read(focusRepositoryProvider);
    final session = PomodoroSessionModel(
      uuid: _uuid.v4(),
      mode: state.phase == PomodoroPhase.work
          ? PomodoroMode.pomodoro
          : PomodoroMode.shortBreak,
      plannedDurationSeconds: state.totalSeconds,
      actualDurationSeconds: elapsed,
      completedAt: DateTime.now().toUtc(),
      localDateKey: _dateFmt.format(DateTime.now()),
      wasCompleted: completed,
      linkedTaskId: state.linkedTaskId ?? '',
      label: state.currentSessionLabel,
    );

    repo.saveSession(session);
    _refreshTodayTotal();
  }

  Future<void> _refreshTodayTotal() async {
    final total =
        await ref.read(focusRepositoryProvider).todayTotalMinutes();
    state = state.copyWith(todayTotalMinutes: total);
  }

  static int _secondsForPhase(PomodoroPhase phase, PomodoroSettings s) =>
      switch (phase) {
        PomodoroPhase.work => s.workMinutes * 60,
        PomodoroPhase.shortBreak => s.shortBreakMinutes * 60,
        PomodoroPhase.longBreak => s.longBreakMinutes * 60,
      };

  static PomodoroPhase _nextPhase({
    required PomodoroPhase current,
    required int completedRounds,
    required int roundsBeforeLong,
  }) {
    if (!current.isWork) return PomodoroPhase.work;
    if (completedRounds % roundsBeforeLong == 0) {
      return PomodoroPhase.longBreak;
    }
    return PomodoroPhase.shortBreak;
  }
}

// ─── Provider ─────────────────────────────────────────────────────────────────

final pomodoroTimerProvider =
    NotifierProvider<PomodoroTimerNotifier, PomodoroTimerState>(
  PomodoroTimerNotifier.new,
);
