// lib/features/tasks/data/models/task_model.dart
//
// StudySpark — Isar collection for user tasks.
//
// Key design decisions:
//  • Subtasks are *embedded* (no FK join needed; always loaded with parent).
//  • subjectId links to SubjectModel.isarId — no Isar link used because
//    subjects are few and looked up by UUID in the repository.
//  • All DateTime fields stored as UTC; display layer converts to local.
//  • @Index on deadline + status enables efficient "overdue tasks" query.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:isar/isar.dart';

import '../../../../core/enums/app_enums.dart';
import 'subtask_model.dart';

part 'task_model.g.dart';

// ─── TaskModel ────────────────────────────────────────────────────────────────

@Collection()
class TaskModel {
  TaskModel({
    this.id = Isar.autoIncrement,
    this.uuid = '',
    this.title = '',
    this.description = '',
    this.subjectId = '',
    this.priority = Priority.medium,
    this.status = TaskStatus.todo,
    this.deadline,
    this.reminderAt,
    this.repeatFrequency = RepeatFrequency.none,
    this.subtasks = const [],
    this.tags = const [],
    this.estimatedMinutes = 0,
    this.actualMinutes = 0,
    this.attachmentPaths = const [],
    this.notificationId,
    this.isStarred = false,
    this.createdAt,
    this.updatedAt,
    this.completedAt,
  });

  // ── Primary key ───────────────────────────────────────────────────────────
  Id id;

  /// Stable UUID used in deep-links and notification payloads.
  @Index(unique: true, replace: true)
  String uuid;

  // ── Core fields ───────────────────────────────────────────────────────────

  /// Short task title shown in list cards (required, max ~80 chars).
  @Index(type: IndexType.value)
  String title;

  /// Optional longer description / notes about the task.
  String description;

  /// UUID of the [SubjectModel] this task belongs to; empty string = none.
  @Index()
  String subjectId;

  // ── Urgency / lifecycle ───────────────────────────────────────────────────

  @enumerated
  Priority priority;

  @Index(composite: [CompositeIndex('deadline')])
  @enumerated
  TaskStatus status;

  /// Due date-time (UTC). Null means no deadline set.
  @Index()
  DateTime? deadline;

  /// When the notification should fire; derived from [deadline] but can be
  /// overridden by the user (e.g. "remind 1 day before").
  DateTime? reminderAt;

  @enumerated
  RepeatFrequency repeatFrequency;

  // ── Subtasks (embedded) ───────────────────────────────────────────────────

  /// In-line checklist items; max 20 recommended (see AppConstants).
  List<SubtaskModel> subtasks;

  /// Convenience: how many subtasks have been completed.
  int get completedSubtaskCount =>
      subtasks.where((s) => s.isCompleted).length;

  /// Progress percentage (0.0–1.0). Returns 0 when list is empty.
  double get subtaskProgress =>
      subtasks.isEmpty ? 0.0 : completedSubtaskCount / subtasks.length;

  // ── Categorisation ────────────────────────────────────────────────────────

  /// Free-form colour-coded tags (e.g. "exam", "homework", "project").
  List<String> tags;

  // ── Time tracking ─────────────────────────────────────────────────────────

  /// Planned duration in minutes (0 = not estimated).
  int estimatedMinutes;

  /// Accumulated actual focus time in minutes (updated by FocusRepository).
  int actualMinutes;

  // ── Attachments ───────────────────────────────────────────────────────────

  /// Relative paths under the app's documents directory.
  List<String> attachmentPaths;

  // ── Notifications ─────────────────────────────────────────────────────────

  /// flutter_local_notifications notification ID; null if no reminder set.
  int? notificationId;

  // ── Extras ────────────────────────────────────────────────────────────────

  /// Starred / pinned to the top of the list.
  @Index()
  bool isStarred;

  // ── Timestamps ────────────────────────────────────────────────────────────

  @Index()
  DateTime? createdAt;

  DateTime? updatedAt;

  /// Populated when [status] transitions to [TaskStatus.done].
  DateTime? completedAt;

  // ── Derived helpers ───────────────────────────────────────────────────────

  bool get isCompleted => status == TaskStatus.done;

  bool get isOverdue =>
      deadline != null &&
      deadline!.isBefore(DateTime.now().toUtc()) &&
      !isCompleted;

  bool get hasDeadline => deadline != null;
}
