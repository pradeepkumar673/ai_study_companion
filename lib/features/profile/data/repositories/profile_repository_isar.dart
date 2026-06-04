// lib/features/profile/data/repositories/profile_repository.dart
//
// StudySpark — Profile Repository
//
// Manages the singleton [UserModel] (one row in the collection).
// All XP, streak, and Pomodoro preference updates go through here.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

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
      currentStreakDays: 0,
      pomodoroWorkMinutes: 25,
      pomodoroShortBreakMinutes: 5,
      pomodoroLongBreakMinutes: 15,
      pomodorosBeforeLongBreak: 4,
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
    profile.currentStreakDays = days;
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
    if (badge.currentProgress >= badge.requiredThreshold) {
      badge.isUnlocked = true;
      badge.unlockedAt = DateTime.now().toUtc();
    }
    await _isar.writeTxn(() => _isar.badgeModels.put(badge));
  }
}
