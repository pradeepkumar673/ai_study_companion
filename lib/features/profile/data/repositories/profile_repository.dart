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


// ─── MoodRepository ───────────────────────────────────────────────────────────
// lib/features/mood/data/repositories/mood_repository.dart
// ─────────────────────────────────────────────────────────────────────────────

import 'package:intl/intl.dart';
import '../models/mood_entry_model.dart';

final _moodDateFmt = DateFormat('yyyy-MM-dd');
const _moodUuid = Uuid();

class MoodRepository {
  const MoodRepository(this._isar);

  final Isar _isar;

  // ── CREATE ────────────────────────────────────────────────────────────────

  /// Logs a new mood entry. Only one entry per day is recommended; the UI
  /// should call [getEntryForDay] first and update if one already exists.
  Future<MoodEntryModel> logMood({
    required MoodType mood,
    int energyLevel = 3,
    int stressLevel = 3,
    double sleepHours = 7.0,
    String notes = '',
    List<String> tags = const [],
  }) async {
    final now = DateTime.now().toUtc();
    final entry = MoodEntryModel(
      uuid: _moodUuid.v4(),
      mood: mood,
      energyLevel: energyLevel,
      stressLevel: stressLevel,
      sleepHours: sleepHours,
      notes: notes,
      tags: tags,
      localDateKey: _moodDateFmt.format(now.toLocal()),
      loggedAt: now,
      createdAt: now,
      updatedAt: now,
    );
    await _isar.writeTxn(() async {
      entry.id = await _isar.moodEntryModels.put(entry);
    });
    return entry;
  }

  // ── READ ──────────────────────────────────────────────────────────────────

  /// The mood entry for a given date key, or null if not logged.
  Future<MoodEntryModel?> getEntryForDay(String dateKey) =>
      _isar.moodEntryModels
          .filter()
          .localDateKeyEqualTo(dateKey)
          .findFirst();

  /// Reactive stream of the last [days] entries (for the mood trend chart).
  Stream<List<MoodEntryModel>> watchRecentEntries({int days = 14}) {
    final cutoff = DateTime.now().toUtc().subtract(Duration(days: days));
    return _isar.moodEntryModels
        .filter()
        .loggedAtGreaterThan(cutoff)
        .sortByLoggedAt()
        .watch(fireImmediately: true);
  }

  Future<void> updateEntry(MoodEntryModel entry) async {
    entry.updatedAt = DateTime.now().toUtc();
    await _isar.writeTxn(() => _isar.moodEntryModels.put(entry));
  }

  Future<bool> deleteEntry(String uuid) async {
    final entry = await _isar.moodEntryModels
        .filter()
        .uuidEqualTo(uuid)
        .findFirst();
    if (entry == null) return false;
    return _isar.writeTxn(() => _isar.moodEntryModels.delete(entry.id));
  }
}


// ─── ProfileRepository ────────────────────────────────────────────────────────
// lib/features/profile/data/repositories/profile_repository.dart
//
// Manages the singleton [UserModel] (one row in the collection).
// All XP, streak, and Pomodoro preference updates go through here.
// ─────────────────────────────────────────────────────────────────────────────

import '../models/user_model.dart';
import '../models/badge_model.dart';

const _profileUuid = Uuid();

class ProfileRepository {
  const ProfileRepository(this._isar);

  final Isar _isar;

  // ── Bootstrap ─────────────────────────────────────────────────────────────

  /// Returns the single user profile, creating it with defaults if absent.
  Future<UserModel> getOrCreateProfile() async {
    final existing = await _isar.userModels.where().findFirst();
    if (existing != null) return existing;

    final now = DateTime.now().toUtc();
    final profile = UserModel(
      uuid: _profileUuid.v4(),
      displayName: 'Student',
      xp: 0,
      level: 1,
      studyStreakDays: 0,
      pomodoroWorkMinutes: 25,
      pomodoroShortBreakMinutes: 5,
      pomodoroLongBreakMinutes: 15,
      pomodoroSessionsBeforeLongBreak: 4,
      enableSoundEffects: true,
      enableNotifications: true,
      createdAt: now,
      updatedAt: now,
    );

    await _isar.writeTxn(() async {
      profile.id = await _isar.userModels.put(profile);
    });
    return profile;
  }

  /// Reactive stream of the profile (updates when XP / streak changes).
  Stream<UserModel?> watchProfile() =>
      _isar.userModels.where().watch(fireImmediately: true).map(
            (list) => list.isNotEmpty ? list.first : null,
          );

  // ── UPDATE ────────────────────────────────────────────────────────────────

  Future<void> updateProfile(UserModel profile) async {
    profile.updatedAt = DateTime.now().toUtc();
    await _isar.writeTxn(() => _isar.userModels.put(profile));
  }

  /// Awards XP and recomputes the level (100 XP per level, capped at 100).
  Future<void> addXp(int amount) async {
    final profile = await getOrCreateProfile();
    profile.xp += amount;
    // Level up every 100 XP.
    profile.level = (profile.xp ~/ 100) + 1;
    profile.updatedAt = DateTime.now().toUtc();
    await _isar.writeTxn(() => _isar.userModels.put(profile));
  }

  /// Sets the streak to [days] (computed by [FocusRepository.computeCurrentStreak]).
  Future<void> setStreak(int days) async {
    final profile = await getOrCreateProfile();
    profile.studyStreakDays = days;
    profile.updatedAt = DateTime.now().toUtc();
    await _isar.writeTxn(() => _isar.userModels.put(profile));
  }

  // ── Badges ────────────────────────────────────────────────────────────────

  /// Returns all badges (locked and unlocked).
  Stream<List<BadgeModel>> watchBadges() =>
      _isar.badgeModels.where().watch(fireImmediately: true);

  /// Unlocks a badge by its [badgeKey].
  Future<void> unlockBadge(String badgeKey) async {
    final badge = await _isar.badgeModels
        .filter()
        .badgeKeyEqualTo(badgeKey)
        .findFirst();
    if (badge == null || badge.isUnlocked) return;

    badge.isUnlocked = true;
    badge.unlockedAt = DateTime.now().toUtc();
    await _isar.writeTxn(() => _isar.badgeModels.put(badge));
  }

  /// Updates progress toward a badge (for incremental badges like "10 tasks").
  Future<void> updateBadgeProgress(String badgeKey, int progress) async {
    final badge = await _isar.badgeModels
        .filter()
        .badgeKeyEqualTo(badgeKey)
        .findFirst();
    if (badge == null || badge.isUnlocked) return;

    badge.currentProgress = progress;
    if (badge.currentProgress >= badge.requiredProgress) {
      badge.isUnlocked = true;
      badge.unlockedAt = DateTime.now().toUtc();
    }
    await _isar.writeTxn(() => _isar.badgeModels.put(badge));
  }
}
