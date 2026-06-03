// lib/features/profile/data/models/user_model.dart
//
// StudySpark — Isar collection for the local user profile.
//
// There is exactly ONE document in this collection (the singleton profile).
// The repository enforces this by always reading/writing id = 1.
//
// Gamification stats (streaks, XP, level) live here rather than in a
// separate collection because they are always loaded alongside the profile.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:isar/isar.dart';

part 'user_model.g.dart';

// ─── StudyReminderConfig (embedded) ──────────────────────────────────────────

/// User's preferred daily study reminder settings.
@embedded
class StudyReminderConfig {
  StudyReminderConfig({
    this.isEnabled = true,
    this.hour = 20,
    this.minute = 0,
    this.notificationId = 9999,
  });

  bool isEnabled;

  /// 24-hour format hour (0–23).
  int hour;

  int minute;

  /// flutter_local_notifications ID reserved for this reminder.
  int notificationId;
}

// ─── UserModel ────────────────────────────────────────────────────────────────

@Collection()
class UserModel {
  UserModel({
    this.id = Isar.autoIncrement,
    this.uuid = '',
    this.displayName = '',
    this.email = '',
    this.avatarPath = '',
    this.bio = '',
    this.institutionName = '',
    this.gradeOrYear = '',
    this.fieldOfStudy = '',
    // Gamification
    this.xp = 0,
    this.level = 1,
    this.currentStreakDays = 0,
    this.longestStreakDays = 0,
    this.lastActiveDate,
    this.totalTasksCompleted = 0,
    this.totalFocusMinutes = 0,
    this.totalNotesCreated = 0,
    this.totalFlashcardsReviewed = 0,
    this.totalQuizzesTaken = 0,
    this.earnedBadgeKeys = const [],
    // Preferences
    this.prefersDarkMode = false,
    this.dailyFocusGoalMinutes = 120,
    this.dailyTaskGoalCount = 5,
    this.weeklyFocusGoalMinutes = 600,
    this.pomodoroWorkMinutes = 25,
    this.pomodoroShortBreakMinutes = 5,
    this.pomodoroLongBreakMinutes = 15,
    this.pomodorosBeforeLongBreak = 4,
    this.studyReminder,
    this.hasCompletedOnboarding = false,
    // Timestamps
    this.createdAt,
    this.updatedAt,
  });

  // ── Primary key ───────────────────────────────────────────────────────────
  Id id;

  @Index(unique: true, replace: true)
  String uuid;

  // ── Identity ──────────────────────────────────────────────────────────────

  @Index(type: IndexType.value)
  String displayName;

  @Index()
  String email;

  /// Relative path under app documents dir; empty = use initials avatar.
  String avatarPath;

  String bio;

  // ── Academic context ──────────────────────────────────────────────────────

  String institutionName;

  /// E.g. "Year 2", "Grade 11", "3rd Semester".
  String gradeOrYear;

  /// E.g. "Computer Science", "Medicine".
  String fieldOfStudy;

  // ── Gamification ─────────────────────────────────────────────────────────

  /// Experience points (levelling currency).
  int xp;

  /// Current level (1–∞); computed from [xp] by GamificationService.
  int level;

  /// XP threshold for [level]: level^2 * 100.
  int get xpForNextLevel => level * level * 100;

  /// Current consecutive study streak in days.
  int currentStreakDays;

  int longestStreakDays;

  /// Last UTC date the user was active (used for streak calculation).
  @Index()
  DateTime? lastActiveDate;

  // ── Cumulative stats ──────────────────────────────────────────────────────

  int totalTasksCompleted;
  int totalFocusMinutes;
  int totalNotesCreated;
  int totalFlashcardsReviewed;
  int totalQuizzesTaken;

  /// Keys of all unlocked [BadgeModel]s.
  List<String> earnedBadgeKeys;

  // ── Preferences ───────────────────────────────────────────────────────────

  bool prefersDarkMode;

  int dailyFocusGoalMinutes;
  int dailyTaskGoalCount;
  int weeklyFocusGoalMinutes;

  // Pomodoro timer defaults (can be overridden per-session).
  int pomodoroWorkMinutes;
  int pomodoroShortBreakMinutes;
  int pomodoroLongBreakMinutes;
  int pomodorosBeforeLongBreak;

  StudyReminderConfig? studyReminder;

  bool hasCompletedOnboarding;

  // ── Timestamps ────────────────────────────────────────────────────────────

  DateTime? createdAt;
  DateTime? updatedAt;

  // ── Derived helpers ───────────────────────────────────────────────────────

  bool get hasAvatar => avatarPath.isNotEmpty;

  String get initials {
    final parts = displayName.trim().split(' ');
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  double get xpProgressToNextLevel {
    final threshold = xpForNextLevel;
    return threshold == 0 ? 0.0 : (xp % threshold) / threshold;
  }
}
