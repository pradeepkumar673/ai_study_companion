// lib/features/tasks/data/models/task_model.dart
//
// StudySpark — TaskModel (updated for Step 5)
//
// Changes vs Step 2 original:
//   • Added [localDeadlineKey] for fast date-equality queries
//   • Added [estimatedMinutes] for planner scheduling
//   • Added [reminderAt] for notification scheduling
//   • Added [completedAt] for streak / gamification
//   • Added [isRecurring] flag
// ─────────────────────────────────────────────────────────────────────────────

import 'package:isar/isar.dart';

import '../../../../core/enums/app_enums.dart';
import 'subtask_model.dart';

part 'task_model.g.dart';

@collection
class TaskModel {
  TaskModel({
    this.id = Isar.autoIncrement,
    required this.uuid,
    required this.title,
    this.description = '',
    this.priority = Priority.medium,
    this.status = TaskStatus.todo,
    this.deadline,
    this.localDeadlineKey,
    this.subjectId = '',
    this.tags = const [],
    this.subtasks = const [],
    this.repeatFrequency = RepeatFrequency.none,
    this.isRecurring = false,
    this.estimatedMinutes = 30,
    this.actualMinutes,
    this.notificationId,
    this.reminderAt,
    this.completedAt,
    this.createdAt,
    this.updatedAt,
  });

  // ── Isar primary key ─────────────────────────────────────────────────────
  Id id;

  // ── Identity ─────────────────────────────────────────────────────────────
  @Index(unique: true, replace: true)
  final String uuid;

  // ── Content ──────────────────────────────────────────────────────────────
  @Index(type: IndexType.value)
  String title;

  String description;

  // ── Priority & Status ────────────────────────────────────────────────────
  @enumerated
  Priority priority;

  @Index(type: IndexType.value)
  @enumerated
  TaskStatus status;

  // ── Scheduling ───────────────────────────────────────────────────────────
  @Index(type: IndexType.value)
  DateTime? deadline;

  /// 'yyyy-MM-dd' string of [deadline] in local time — fast equality filter.
  @Index(type: IndexType.hash)
  String? localDeadlineKey;

  /// When a reminder notification should fire (UTC).
  DateTime? reminderAt;

  /// Repeat cadence for recurring tasks.
  @enumerated
  RepeatFrequency repeatFrequency;

  bool isRecurring;

  // ── Effort ───────────────────────────────────────────────────────────────

  /// Estimated study time in minutes (used by planner).
  int estimatedMinutes;

  /// Actual time spent (set by focus timer integration).
  int? actualMinutes;

  // ── Relations ────────────────────────────────────────────────────────────

  /// UUID of the associated [SubjectModel] (empty string = no subject).
  @Index(type: IndexType.hash)
  String subjectId;

  List<String> tags;

  /// Embedded subtask checklist — always fetched with the task.
  List<SubtaskModel> subtasks;

  // ── Notification ─────────────────────────────────────────────────────────

  /// [NotificationService] notification id (stored so it can be cancelled).
  int? notificationId;

  // ── Timestamps ───────────────────────────────────────────────────────────
  @Index(type: IndexType.value)
  DateTime? completedAt;

  DateTime? createdAt;
  DateTime? updatedAt;

  // ── Computed helpers (not stored) ────────────────────────────────────────

  bool get isCompleted => status == TaskStatus.done;

  bool get isOverdue =>
      deadline != null &&
      deadline!.isBefore(DateTime.now().toUtc()) &&
      !isCompleted;

  int get completedSubtaskCount => subtasks.where((s) => s.isCompleted).length;

  double get subtaskProgress =>
      subtasks.isEmpty ? 0.0 : completedSubtaskCount / subtasks.length;

  bool get allSubtasksDone =>
      subtasks.isNotEmpty && subtasks.every((s) => s.isCompleted);

  int get daysUntilDeadline =>
      deadline?.difference(DateTime.now()).inDays ?? 999;
}
