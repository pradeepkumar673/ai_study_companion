// lib/features/goals/data/models/goal_model.dart
//
// StudySpark — Isar collection for long-term study goals.
//
// Goals are high-level objectives (e.g. "Score 90% in Physics final")
// that contain milestones and are linked to tasks/subjects.  Progress is
// tracked via [currentValue] / [targetValue] so the UI can show a
// percentage ring.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:isar/isar.dart';

import '../../../../core/enums/app_enums.dart';

part 'goal_model.g.dart';

// ─── GoalMilestone (embedded) ─────────────────────────────────────────────────

/// A checkpoint within a [GoalModel].
@embedded
class GoalMilestone {
  GoalMilestone({
    this.id = '',
    this.title = '',
    this.isCompleted = false,
    this.targetDate,
    this.completedAt,
    this.position = 0,
  });

  String id;
  String title;
  bool isCompleted;
  DateTime? targetDate;
  DateTime? completedAt;

  /// Display order.
  int position;
}

// ─── GoalModel ────────────────────────────────────────────────────────────────

@Collection()
class GoalModel {
  GoalModel({
    this.id = Isar.autoIncrement,
    this.uuid = '',
    this.title = '',
    this.description = '',
    this.subjectId = '',
    this.priority = Priority.medium,
    this.status = GoalStatus.active,
    this.repeatFrequency = RepeatFrequency.none,
    this.targetValue = 100.0,
    this.currentValue = 0.0,
    this.unit = '%',
    this.milestones = const [],
    this.linkedTaskIds = const [],
    this.tags = const [],
    this.colorHex = '#6750A4',
    this.iconName = 'target',
    this.startDate,
    this.targetDate,
    this.completedAt,
    this.reminderAt,
    this.notificationId,
    this.streakDays = 0,
    this.createdAt,
    this.updatedAt,
  });

  // ── Primary key ───────────────────────────────────────────────────────────
  Id id;

  @Index(unique: true, replace: true)
  String uuid;

  // ── Identity ──────────────────────────────────────────────────────────────

  @Index(type: IndexType.value)
  String title;

  String description;

  @Index()
  String subjectId;

  // ── Priority / status ─────────────────────────────────────────────────────

  @enumerated
  Priority priority;

  @Index()
  @enumerated
  GoalStatus status;

  @enumerated
  RepeatFrequency repeatFrequency;

  // ── Measurable progress ───────────────────────────────────────────────────

  /// The numeric value to reach (e.g. 90 for "score 90%").
  double targetValue;

  /// Current measured value — updated by user or linked task completion.
  double currentValue;

  /// Display unit label (e.g. "%", "hours", "chapters", "pages").
  String unit;

  double get progressRatio =>
      targetValue == 0 ? 0.0 : (currentValue / targetValue).clamp(0.0, 1.0);

  double get progressPercent => progressRatio * 100;

  // ── Milestones ────────────────────────────────────────────────────────────

  List<GoalMilestone> milestones;

  int get completedMilestoneCount =>
      milestones.where((m) => m.isCompleted).length;

  // ── Linkage ───────────────────────────────────────────────────────────────

  /// UUIDs of [TaskModel] documents that contribute toward this goal.
  List<String> linkedTaskIds;

  List<String> tags;

  // ── Visual identity ───────────────────────────────────────────────────────

  String colorHex;
  String iconName;

  // ── Dates ─────────────────────────────────────────────────────────────────

  @Index()
  DateTime? startDate;

  @Index()
  DateTime? targetDate;

  DateTime? completedAt;
  DateTime? reminderAt;

  int? notificationId;

  // ── Streak ────────────────────────────────────────────────────────────────

  /// Consecutive days the user logged progress toward this goal.
  int streakDays;

  // ── Timestamps ────────────────────────────────────────────────────────────

  @Index()
  DateTime? createdAt;

  DateTime? updatedAt;

  // ── Derived ───────────────────────────────────────────────────────────────

  bool get isCompleted => status == GoalStatus.completed;

  bool get isOverdue =>
      targetDate != null &&
      targetDate!.isBefore(DateTime.now().toUtc()) &&
      !isCompleted;

  int get daysRemaining => targetDate == null
      ? -1
      : targetDate!.difference(DateTime.now().toUtc()).inDays;
}
