// lib/features/goals/data/repositories/goal_repository.dart
//
// StudySpark — Goal Repository
// ─────────────────────────────────────────────────────────────────────────────

import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/enums/app_enums.dart';
import '../models/goal_model.dart';

const _goalUuid = Uuid();

class GoalRepository {
  const GoalRepository(this._isar);

  final Isar _isar;

  // ── CREATE ────────────────────────────────────────────────────────────────

  Future<GoalModel> createGoal({
    required String title,
    String description = '',
    String subjectId = '',
    Priority priority = Priority.medium,
    double targetValue = 100.0,
    String unit = '%',
    DateTime? startDate,
    DateTime? targetDate,
    DateTime? reminderAt,
    List<GoalMilestone> milestones = const [],
    List<String> linkedTaskIds = const [],
    List<String> tags = const [],
    String colorHex = '#6750A4',
    String iconName = 'target',
    int? notificationId,
  }) async {
    final now = DateTime.now().toUtc();
    final goal = GoalModel(
      uuid: _goalUuid.v4(),
      title: title,
      description: description,
      subjectId: subjectId,
      priority: priority,
      status: GoalStatus.active,
      targetValue: targetValue,
      currentValue: 0.0,
      unit: unit,
      startDate: startDate ?? now,
      targetDate: targetDate,
      reminderAt: reminderAt,
      notificationId: notificationId,
      milestones: milestones,
      linkedTaskIds: linkedTaskIds,
      tags: tags,
      colorHex: colorHex,
      iconName: iconName,
      createdAt: now,
      updatedAt: now,
    );
    await _isar.writeTxn(() async {
      goal.id = await _isar.goalModels.put(goal);
    });
    return goal;
  }

  // ── READ ──────────────────────────────────────────────────────────────────

  /// Reactive stream of active goals sorted by target date ascending.
  Stream<List<GoalModel>> watchActiveGoals() {
    return _isar.goalModels
        .filter()
        .statusEqualTo(GoalStatus.active)
        .sortByTargetDate()
        .watch(fireImmediately: true);
  }

  Stream<List<GoalModel>> watchAllGoals() {
    return _isar.goalModels
        .filter()
        .sortByCreatedAtDesc()
        .watch(fireImmediately: true);
  }

  Future<GoalModel?> getGoalByUuid(String uuid) =>
      _isar.goalModels.filter().uuidEqualTo(uuid).findFirst();

  // ── UPDATE ────────────────────────────────────────────────────────────────

  Future<void> updateGoal(GoalModel updated) async {
    updated.updatedAt = DateTime.now().toUtc();
    await _isar.writeTxn(() => _isar.goalModels.put(updated));
  }

  /// Increments [currentValue] by [delta], auto-completes if target reached.
  Future<void> incrementProgress(String uuid, double delta) async {
    final goal = await getGoalByUuid(uuid);
    if (goal == null || goal.status.isTerminal) return;

    goal.currentValue = (goal.currentValue + delta).clamp(0.0, goal.targetValue);
    goal.updatedAt = DateTime.now().toUtc();

    if (goal.currentValue >= goal.targetValue) {
      goal.status = GoalStatus.completed;
      goal.completedAt = DateTime.now().toUtc();
    }

    await _isar.writeTxn(() => _isar.goalModels.put(goal));
  }

  /// Marks a milestone complete by its embedded id.
  Future<void> completeMilestone(String goalUuid, String milestoneId) async {
    final goal = await getGoalByUuid(goalUuid);
    if (goal == null) return;

    final idx = goal.milestones.indexWhere((m) => m.id == milestoneId);
    if (idx == -1) return;

    goal.milestones[idx].isCompleted = true;
    goal.milestones[idx].completedAt = DateTime.now().toUtc();
    goal.updatedAt = DateTime.now().toUtc();
    await _isar.writeTxn(() => _isar.goalModels.put(goal));
  }

  Future<bool> deleteGoal(String uuid) async {
    final goal = await getGoalByUuid(uuid);
    if (goal == null) return false;
    return _isar.writeTxn(() => _isar.goalModels.delete(goal.id));
  }
}
