// lib/features/profile/data/models/badge_model.dart
//
// StudySpark — Isar collection for gamification achievement badges.
//
// Badges are awarded by the GamificationService when the user crosses
// predefined thresholds (e.g. "Complete 10 tasks", "7-day streak").
// They are stored locally and displayed on the Profile screen.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:isar/isar.dart';

import '../../../../core/enums/app_enums.dart';

part 'badge_model.g.dart';

// ─── BadgeModel ───────────────────────────────────────────────────────────────

@Collection()
class BadgeModel {
  BadgeModel({
    this.id = Isar.autoIncrement,
    this.uuid = '',
    this.badgeKey = '',
    this.title = '',
    this.description = '',
    this.category = BadgeCategory.tasks,
    this.iconName = 'star',
    this.colorHex = '#FFD700',
    this.tier = 1,
    this.isUnlocked = false,
    this.isNew = false,
    this.requiredThreshold = 1,
    this.currentProgress = 0,
    this.unlockedAt,
    this.createdAt,
  });

  // ── Primary key ───────────────────────────────────────────────────────────
  Id id;

  @Index(unique: true, replace: true)
  String uuid;

  /// Stable string key for matching badge definitions to earned records,
  /// e.g. "streak_7", "tasks_50", "focus_1000min".
  @Index(unique: true, replace: true)
  String badgeKey;

  // ── Display ───────────────────────────────────────────────────────────────

  String title;
  String description;

  @enumerated
  BadgeCategory category;

  /// HugeIcons name or Lottie asset key.
  String iconName;

  String colorHex;

  /// Badge tier: 1 = Bronze, 2 = Silver, 3 = Gold, 4 = Platinum.
  int tier;

  String get tierLabel {
    switch (tier) {
      case 1:
        return 'Bronze';
      case 2:
        return 'Silver';
      case 3:
        return 'Gold';
      case 4:
        return 'Platinum';
      default:
        return 'Special';
    }
  }

  // ── State ─────────────────────────────────────────────────────────────────

  @Index()
  bool isUnlocked;

  /// Drives "NEW" chip in the UI — cleared when the user views the badge.
  bool isNew;

  // ── Progress tracking ─────────────────────────────────────────────────────

  /// The numeric threshold that must be reached to unlock this badge.
  int requiredThreshold;

  /// The user's current progress toward [requiredThreshold].
  int currentProgress;

  double get progressRatio =>
      requiredThreshold == 0
          ? 0.0
          : (currentProgress / requiredThreshold).clamp(0.0, 1.0);

  // ── Timestamps ────────────────────────────────────────────────────────────

  @Index()
  DateTime? unlockedAt;

  DateTime? createdAt;
}
