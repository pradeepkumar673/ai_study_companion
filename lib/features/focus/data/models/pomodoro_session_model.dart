// lib/features/focus/data/models/pomodoro_session_model.dart
//
// StudySpark — PomodoroSessionModel (Step 5 — extended)
//
// Isar @collection storing each Pomodoro phase completion.
// Added fields vs Step 2:
//   • wasCompleted   — true if the timer ran to zero; false if stopped early
//   • label          — optional session name / task name
//   • linkedTaskId   — UUID of the TaskModel being worked on (optional)
// ─────────────────────────────────────────────────────────────────────────────

import 'package:isar/isar.dart';
import '../../../../core/enums/app_enums.dart';

part 'pomodoro_session_model.g.dart';

@collection
class PomodoroSessionModel {
  PomodoroSessionModel({
    this.id = Isar.autoIncrement,
    this.uuid = '',
    this.mode = PomodoroMode.work,
    this.plannedDurationSeconds = 1500,
    this.actualDurationSeconds = 0,
    this.completedAt,
    this.localDateKey = '',
    this.wasCompleted = false,
    this.linkedTaskId = '',
    this.label = '',
  });

  // ── Isar id ──────────────────────────────────────────────────────────────
  Id id;

  // ── Identity ──────────────────────────────────────────────────────────────
  @Index(unique: true)
  String uuid;

  // ── Session data ──────────────────────────────────────────────────────────

  @enumerated
  PomodoroMode mode; // work | shortBreak | longBreak

  /// How many seconds the phase was set to at the start.
  int plannedDurationSeconds;

  /// How many seconds were actually spent (may be less if stopped early).
  int actualDurationSeconds;

  /// When the session ended (UTC).
  @Index()
  DateTime? completedAt;

  /// "yyyy-MM-dd" key in local time — for fast daily aggregation.
  @Index()
  String localDateKey;

  /// True if the timer ran all the way to zero.
  @Index()
  bool wasCompleted;

  /// Optional UUID of TaskModel this session was linked to.
  @Index()
  String linkedTaskId;

  /// Human-readable label shown in history (task name or custom).
  String label;
}
