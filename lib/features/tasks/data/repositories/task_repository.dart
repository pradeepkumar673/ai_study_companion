// lib/features/tasks/data/repositories/task_repository.dart
//
// StudySpark — Task Repository
//
// Provides all Isar read/write operations for [TaskModel].
// All write operations run inside an Isar write transaction.
// Reactive list queries return [Stream] so the UI rebuilds automatically.
//
// Notification scheduling is delegated to [NotificationService] so this
// class stays free of Flutter-plugin dependencies and is easily unit-tested.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/enums/app_enums.dart';
import '../models/task_model.dart';
import '../models/subtask_model.dart';

// ─── TaskRepository ───────────────────────────────────────────────────────────

/// Pure data-access object for [TaskModel].
///
/// Depend on this class via [taskRepositoryProvider]; never call Isar directly
/// from provider or UI code.
class TaskRepository {
  const TaskRepository(this._isar);

  final Isar _isar;
  static const _uuid = Uuid();

  // ── CREATE ────────────────────────────────────────────────────────────────

  /// Persists a new [TaskModel], assigns a UUID, and returns the saved record.
  ///
  /// [notificationId] should be pre-allocated by [NotificationService] before
  /// calling this method so the two stay in sync.
  Future<TaskModel> createTask({
    required String title,
    String description = '',
    Priority priority = Priority.medium,
    TaskStatus status = TaskStatus.todo,
    String subjectId = '',
    DateTime? deadline,
    List<SubtaskModel> subtasks = const [],
    List<String> tags = const [],
    RepeatFrequency repeat = RepeatFrequency.none,
    int? notificationId,
  }) async {
    final now = DateTime.now().toUtc();
    final task = TaskModel(
      uuid: _uuid.v4(),
      title: title,
      description: description,
      priority: priority,
      status: status,
      subjectId: subjectId,
      deadline: deadline,
      subtasks: subtasks,
      tags: tags,
      repeatFrequency: repeat,
      notificationId: notificationId,
      createdAt: now,
      updatedAt: now,
    );

    await _isar.writeTxn(() async {
      task.id = await _isar.taskModels.put(task);
    });

    return task;
  }

  // ── READ ──────────────────────────────────────────────────────────────────

  /// Returns the task with the given [uuid], or `null` if not found.
  Future<TaskModel?> getTaskByUuid(String uuid) =>
      _isar.taskModels.filter().uuidEqualTo(uuid).findFirst();

  /// Returns the task with the given Isar integer [id].
  Future<TaskModel?> getTaskById(Id id) => _isar.taskModels.get(id);

  /// Reactive stream of all non-archived tasks, ordered by deadline ascending,
  /// then by creation date descending.
  Stream<List<TaskModel>> watchAllTasks() {
    return _isar.taskModels
        .filter()
        .isArchivedEqualTo(false)
        .sortByDeadline()
        .thenByCreatedAtDesc()
        .watch(fireImmediately: true);
  }

  /// Reactive stream filtered to a specific [status].
  Stream<List<TaskModel>> watchTasksByStatus(TaskStatus status) {
    return _isar.taskModels
        .filter()
        .statusEqualTo(status)
        .isArchivedEqualTo(false)
        .sortByDeadline()
        .watch(fireImmediately: true);
  }

  /// Reactive stream filtered to a specific [priority].
  Stream<List<TaskModel>> watchTasksByPriority(Priority priority) {
    return _isar.taskModels
        .filter()
        .priorityEqualTo(priority)
        .isArchivedEqualTo(false)
        .sortByDeadline()
        .watch(fireImmediately: true);
  }

  /// Reactive stream of tasks linked to a given subject UUID.
  Stream<List<TaskModel>> watchTasksBySubject(String subjectId) {
    return _isar.taskModels
        .filter()
        .subjectIdEqualTo(subjectId)
        .isArchivedEqualTo(false)
        .sortByDeadline()
        .watch(fireImmediately: true);
  }

  /// Reactive stream of tasks due on or before [date] (UTC midnight).
  Stream<List<TaskModel>> watchTasksDueToday(DateTime date) {
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59).toUtc();
    return _isar.taskModels
        .filter()
        .deadlineLessThan(endOfDay)
        .isArchivedEqualTo(false)
        .statusEqualTo(TaskStatus.todo)
        .or()
        .statusEqualTo(TaskStatus.inProgress)
        .sortByDeadline()
        .watch(fireImmediately: true);
  }

  /// Full-text search across [title] and [description].
  ///
  /// Uses Isar word index — efficient for moderate data sets.
  Future<List<TaskModel>> searchTasks(String query) {
    if (query.trim().isEmpty) return Future.value([]);
    return _isar.taskModels
        .filter()
        .titleContains(query, caseSensitive: false)
        .or()
        .descriptionContains(query, caseSensitive: false)
        .isArchivedEqualTo(false)
        .findAll();
  }

  /// Returns the total count of tasks by status (used for dashboard stats).
  Future<Map<TaskStatus, int>> getStatusCounts() async {
    final results = <TaskStatus, int>{};
    for (final status in TaskStatus.values) {
      results[status] = await _isar.taskModels
          .filter()
          .statusEqualTo(status)
          .isArchivedEqualTo(false)
          .count();
    }
    return results;
  }

  // ── UPDATE ────────────────────────────────────────────────────────────────

  /// Replaces the stored record with [updated] (matched by Isar [id]).
  Future<void> updateTask(TaskModel updated) async {
    updated.updatedAt = DateTime.now().toUtc();
    await _isar.writeTxn(() => _isar.taskModels.put(updated));
  }

  /// Convenience: toggle [TaskStatus.done] ↔ [TaskStatus.todo].
  Future<TaskModel?> toggleComplete(String uuid) async {
    final task = await getTaskByUuid(uuid);
    if (task == null) return null;

    task.status = task.status == TaskStatus.done
        ? TaskStatus.todo
        : TaskStatus.done;
    task.completedAt =
        task.status == TaskStatus.done ? DateTime.now().toUtc() : null;
    task.updatedAt = DateTime.now().toUtc();

    await _isar.writeTxn(() => _isar.taskModels.put(task));
    return task;
  }

  /// Marks a specific subtask as completed / uncompleted.
  Future<void> toggleSubtask(String taskUuid, String subtaskId) async {
    final task = await getTaskByUuid(taskUuid);
    if (task == null) return;

    final idx = task.subtasks.indexWhere((s) => s.id == subtaskId);
    if (idx == -1) return;

    final sub = task.subtasks[idx];
    final updated = SubtaskModel(
      id: sub.id,
      title: sub.title,
      isCompleted: !sub.isCompleted,
      position: sub.position,
      createdAt: sub.createdAt,
      completedAt: !sub.isCompleted ? DateTime.now().toUtc() : null,
    );
    task.subtasks[idx] = updated;
    task.updatedAt = DateTime.now().toUtc();

    await _isar.writeTxn(() => _isar.taskModels.put(task));
  }

  /// Soft-deletes a task by setting [isArchived] = true.
  Future<void> archiveTask(String uuid) async {
    final task = await getTaskByUuid(uuid);
    if (task == null) return;
    task.isArchived = true;
    task.updatedAt = DateTime.now().toUtc();
    await _isar.writeTxn(() => _isar.taskModels.put(task));
  }

  // ── DELETE ────────────────────────────────────────────────────────────────

  /// Permanently deletes a task. Prefer [archiveTask] for soft-delete.
  Future<bool> deleteTask(String uuid) async {
    final task = await getTaskByUuid(uuid);
    if (task == null) return false;
    return _isar.writeTxn(() => _isar.taskModels.delete(task.id));
  }

  /// Deletes all completed tasks (for "Clear Completed" action).
  Future<int> deleteAllCompleted() async {
    final completed = await _isar.taskModels
        .filter()
        .statusEqualTo(TaskStatus.done)
        .findAll();
    int count = 0;
    await _isar.writeTxn(() async {
      for (final t in completed) {
        if (await _isar.taskModels.delete(t.id)) count++;
      }
    });
    return count;
  }
}
