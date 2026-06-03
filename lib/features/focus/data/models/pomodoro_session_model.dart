// lib/features/focus/data/models/pomodoro_session_model.dart
//
// StudySpark — Isar collection for Pomodoro / deep-work focus sessions.
//
// Every completed or abandoned timer run is persisted here so the
// FocusRepository can compute streaks, weekly totals, and subject-level
// focus distribution for the analytics charts.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:isar/isar.dart';

import '../../../../core/enums/app_enums.dart';

part 'pomodoro_session_model.g.dart';

// ─── PomodoroSessionModel ────────────────────────────────────────────────────

@Collection()
class PomodoroSessionModel {
  PomodoroSessionModel({
    this.id = Isar.autoIncrement,
    this.uuid = '',
    this.mode = PomodoroMode.pomodoro,
    this.status = SessionStatus.completed,
    this.subjectId = '',
    this.taskId = '',
    this.plannedDurationSeconds = 1500,
    this.actualDurationSeconds = 0,
    this.pauseCount = 0,
    this.totalPausedSeconds = 0,
    this.notes = '',
    this.distractionCount = 0,
    this.startedAt,
    this.endedAt,
    this.localDateKey = '',
  });

  // ── Primary key ───────────────────────────────────────────────────────────
  Id id;

  @Index(unique: true, replace: true)
  String uuid;

  // ── Session config ────────────────────────────────────────────────────────

  @enumerated
  PomodoroMode mode;

  @enumerated
  SessionStatus status;

  // ── Linkage ───────────────────────────────────────────────────────────────

  /// UUID of the subject being studied; empty = general/unlinked.
  @Index()
  String subjectId;

  /// UUID of the task being worked on; empty = freeform session.
  @Index()
  String taskId;

  // ── Timing ────────────────────────────────────────────────────────────────

  /// Timer goal in seconds (e.g. 1500 for 25 min Pomodoro).
  int plannedDurationSeconds;

  /// How many seconds the user actually focused (excl. paused time).
  int actualDurationSeconds;

  /// Number of times the user hit Pause during this session.
  int pauseCount;

  /// Total wall-clock seconds spent paused.
  int totalPausedSeconds;

  // ── Reflections ───────────────────────────────────────────────────────────

  /// Optional end-of-session reflection note.
  String notes;

  /// User-logged distractions (incremented with the "distraction" button).
  int distractionCount;

  // ── Timestamps ────────────────────────────────────────────────────────────

  @Index()
  DateTime? startedAt;

  DateTime? endedAt;

  /// "yyyy-MM-dd" UTC date string — enables fast daily streak queries without
  /// a full DateTime range scan.
  @Index()
  String localDateKey;

  // ── Derived helpers ───────────────────────────────────────────────────────

  bool get isCompleted => status == SessionStatus.completed;

  /// Completion ratio (0.0–1.0). Useful for partial-credit charts.
  double get completionRatio => plannedDurationSeconds == 0
      ? 0.0
      : (actualDurationSeconds / plannedDurationSeconds).clamp(0.0, 1.0);

  int get actualDurationMinutes => actualDurationSeconds ~/ 60;
}
