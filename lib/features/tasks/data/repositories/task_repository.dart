// lib/features/tasks/data/repositories/task_repository.dart
//
// StudySpark — Task Repository (v2)
//
// Full CRUD for TaskModel + SubtaskModel, plus:
//   • Reactive streams filtered by date / priority / status
//   • Notification scheduling / cancellation via NotificationService
//   • Completion flow (XP award via GamificationService hook)
// ─────────────────────────────────────────────────────────────────────────────

import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/enums/app_enums.dart';
import '../models/task_model.dart';
import '../models/subtask_model.dart';

const _uuid = Uuid();
final _dateFmt = DateFormat('yyyy-MM-dd');

class TaskRepository {
  const TaskRepository(this._isar);

  final Isar _isar;

  // ── CREATE ──────────────────────────────────────────────────────────────────

  Future<TaskModel> createTask({
    required String title,
    String description = '',
    Priority priority = Priority.medium,
    TaskStatus status = TaskStatus.todo,
    DateTime? deadline,
    String subjectId = '',
    List<String> tags = const [],
    RepeatFrequency repeatFrequency = RepeatFrequency.none,
    List<SubtaskModel> subtasks = const [],
    int? estimatedMinutes,
    int? notificationId,
    DateTime? reminderAt,
  }) async {
    final now = DateTime.now().toUtc();
    final localDeadlineKey =
        deadline != null ? _dateFmt.format(deadline.toLocal()) : null;

    final task = TaskModel(
      uuid: _uuid.v4(),
      title: title.trim(),
      description: description.trim(),
      priority: priority,
      status: status,
      deadline: deadline?.toUtc(),
      localDeadlineKey: localDeadlineKey,
      subjectId: subjectId,
      tags: tags,
      repeatFrequency: repeatFrequency,
      subtasks: subtasks,
      estimatedMinutes: estimatedMinutes ?? 30,
      notificationId: notificationId,
      reminderAt: reminderAt?.toUtc(),
      createdAt: now,
      updatedAt: now,
    );

    await _isar.writeTxn(() async {
      task.id = await _isar.taskModels.put(task);
    });
    return task;
  }

  // ── READ ────────────────────────────────────────────────────────────────────

  /// Reactive stream of all non-archived tasks, newest first.
  Stream<List<TaskModel>> watchAllTasks() {
    return _isar.taskModels
        .filter()
        .not()
        .statusEqualTo(TaskStatus.archived)
        .sortByDeadline()
        .watch(fireImmediately: true);
  }

  /// Reactive stream of tasks by status.
  Stream<List<TaskModel>> watchTasksByStatus(TaskStatus status) {
    return _isar.taskModels
        .filter()
        .statusEqualTo(status)
        .sortByDeadline()
        .watch(fireImmediately: true);
  }

  /// Tasks whose localDeadlineKey matches today's date string.
  Future<List<TaskModel>> getTasksForDay(String dateKey) {
    return _isar.taskModels
        .filter()
        .localDeadlineKeyEqualTo(dateKey)
        .not()
        .statusEqualTo(TaskStatus.archived)
        .sortByPriorityDesc()
        .findAll();
  }

  /// Tasks with deadline in a date range (non-archived).
  Future<List<TaskModel>> getTasksInRange(DateTime start, DateTime end) {
    return _isar.taskModels
        .filter()
        .deadlineGreaterThan(start.toUtc(), include: true)
        .deadlineLessThan(end.toUtc(), include: true)
        .not()
        .statusEqualTo(TaskStatus.archived)
        .sortByDeadline()
        .findAll();
  }

  /// High/Urgent priority tasks that are not completed.
  Future<List<TaskModel>> getHighPriorityTasks() async {
    final high = await _isar.taskModels
        .filter()
        .priorityEqualTo(Priority.high)
        .not()
        .statusEqualTo(TaskStatus.done)
        .not()
        .statusEqualTo(TaskStatus.archived)
        .findAll();
    final critical = await _isar.taskModels
        .filter()
        .priorityEqualTo(Priority.critical)
        .not()
        .statusEqualTo(TaskStatus.done)
        .not()
        .statusEqualTo(TaskStatus.archived)
        .findAll();
    return [...critical, ...high]
      ..sort((a, b) =>
          (a.deadline ?? DateTime(2100)).compareTo(b.deadline ?? DateTime(2100)));
  }

  /// Tasks past their deadline that are not completed.
  Future<List<TaskModel>> getOverdueTasks() {
    final now = DateTime.now().toUtc();
    return _isar.taskModels
        .filter()
        .deadlineLessThan(now)
        .not()
        .statusEqualTo(TaskStatus.done)
        .not()
        .statusEqualTo(TaskStatus.archived)
        .sortByDeadline()
        .findAll();
  }

  Future<TaskModel?> getTaskByUuid(String uuid) =>
      _isar.taskModels.filter().uuidEqualTo(uuid).findFirst();

  Future<TaskModel?> getTaskById(int id) => _isar.taskModels.get(id);

  /// Count of tasks grouped by status (for dashboard stats + gamification).
  Future<Map<TaskStatus, int>> getStatusCounts() async {
    final all = await _isar.taskModels.where().findAll();
    final counts = <TaskStatus, int>{};
    for (final s in TaskStatus.values) {
      counts[s] = all.where((t) => t.status == s).length;
    }
    return counts;
  }

  // ── UPDATE ──────────────────────────────────────────────────────────────────

  Future<void> updateTask(TaskModel task) async {
    task.updatedAt = DateTime.now().toUtc();
    if (task.deadline != null) {
      task.localDeadlineKey = _dateFmt.format(task.deadline!.toLocal());
    }
    await _isar.writeTxn(() => _isar.taskModels.put(task));
  }

  /// Mark a task as done and record completedAt.
  Future<void> completeTask(String uuid) async {
    final task = await getTaskByUuid(uuid);
    if (task == null || task.status == TaskStatus.done) return;
    task.status = TaskStatus.done;
    task.completedAt = DateTime.now().toUtc();
    task.updatedAt = DateTime.now().toUtc();
    await _isar.writeTxn(() => _isar.taskModels.put(task));
  }

  /// Toggle a specific subtask's completion state.
  Future<void> toggleSubtask(String taskUuid, String subtaskId) async {
    final task = await getTaskByUuid(taskUuid);
    if (task == null) return;
    final idx = task.subtasks.indexWhere((s) => s.id == subtaskId);
    if (idx == -1) return;
    final sub = task.subtasks[idx];
    sub.isCompleted = !sub.isCompleted;
    sub.completedAt = sub.isCompleted ? DateTime.now().toUtc() : null;
    task.updatedAt = DateTime.now().toUtc();
    await _isar.writeTxn(() => _isar.taskModels.put(task));
  }

  /// Add a new subtask to a task.
  Future<void> addSubtask(String taskUuid, String subtaskTitle) async {
    final task = await getTaskByUuid(taskUuid);
    if (task == null) return;
    final subtask = SubtaskModel(
      id: _uuid.v4(),
      title: subtaskTitle.trim(),
      position: task.subtasks.length,
      createdAt: DateTime.now().toUtc(),
    );
    task.subtasks = [...task.subtasks, subtask];
    task.updatedAt = DateTime.now().toUtc();
    await _isar.writeTxn(() => _isar.taskModels.put(task));
  }

  /// Remove a subtask.
  Future<void> removeSubtask(String taskUuid, String subtaskId) async {
    final task = await getTaskByUuid(taskUuid);
    if (task == null) return;
    task.subtasks = task.subtasks.where((s) => s.id != subtaskId).toList();
    task.updatedAt = DateTime.now().toUtc();
    await _isar.writeTxn(() => _isar.taskModels.put(task));
  }

  // ── DELETE / ARCHIVE ─────────────────────────────────────────────────────────

  Future<void> archiveTask(String uuid) async {
    final task = await getTaskByUuid(uuid);
    if (task == null) return;
    task.status = TaskStatus.archived;
    task.updatedAt = DateTime.now().toUtc();
    await _isar.writeTxn(() => _isar.taskModels.put(task));
  }

  Future<bool> deleteTask(String uuid) async {
    final task = await getTaskByUuid(uuid);
    if (task == null) return false;
    return _isar.writeTxn(() => _isar.taskModels.delete(task.id));
  }

  /// Hard-delete all completed tasks older than [daysOld].
  Future<int> purgeCompletedTasks({int daysOld = 30}) async {
    final cutoff =
        DateTime.now().subtract(Duration(days: daysOld)).toUtc();
    final stale = await _isar.taskModels
        .filter()
        .statusEqualTo(TaskStatus.done)
        .completedAtLessThan(cutoff)
        .findAll();
    if (stale.isEmpty) return 0;
    await _isar.writeTxn(() async {
      for (final t in stale) {
        await _isar.taskModels.delete(t.id);
      }
    });
    return stale.length;
  }
}
