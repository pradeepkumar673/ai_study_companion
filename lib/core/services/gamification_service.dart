// lib/core/services/gamification_service.dart
//
// StudySpark — Gamification Service
//
// Centralises all XP-award and badge-unlock logic so individual repositories
// don't need to know gamification rules.
//
// Call [GamificationService] methods after any significant user action:
//   • Task completed     → [onTaskCompleted]
//   • Focus session done → [onFocusSessionCompleted]
//   • Note created       → [onNoteCreated]
//   • Quiz passed        → [onQuizCompleted]
//   • Goal reached       → [onGoalCompleted]
//   • Streak updated     → [onStreakUpdated]
//
// Badge keys match the [badgeKey] field in the seeded [BadgeModel] records.
// The badge seed data should be inserted on first app launch (see main.dart).
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/profile/data/repositories/profile_repository.dart';
import '../../features/focus/data/repositories/focus_repository.dart';
import '../../features/tasks/data/repositories/task_repository.dart';
import '../enums/app_enums.dart';

// ─── XP Award Constants ───────────────────────────────────────────────────────

abstract final class XpRewards {
  // Tasks
  static const int taskCompleted = 15;
  static const int taskCompletedWithAllSubtasks = 25;
  static const int taskCompletedBeforeDeadline = 5; // bonus

  // Focus
  static const int pomodoroCompleted = 10;
  static const int focusSessionAbandoned = 3;
  static const int deepWorkSessionCompleted = 20;

  // Notes
  static const int noteCreated = 5;
  static const int noteWithAiSummary = 3; // bonus for using AI feature

  // Flashcards
  static const int flashcardReviewed = 2;
  static const int deckMastered = 50;

  // Quiz
  static const int quizPassed = 20;      // score ≥ 70%
  static const int quizPerfectScore = 15; // bonus for 100%

  // Goals
  static const int goalCompleted = 100;
  static const int milestonecompleted = 20;

  // Streak
  static const int streakDay7 = 50;
  static const int streakDay30 = 200;
  static const int streakDay100 = 1000;
}

// ─── Badge Key Constants ──────────────────────────────────────────────────────

abstract final class BadgeKeys {
  // Streak badges
  static const String streak3 = 'streak_3';
  static const String streak7 = 'streak_7';
  static const String streak30 = 'streak_30';
  static const String streak100 = 'streak_100';

  // Task badges
  static const String firstTask = 'first_task';
  static const String tasks10 = 'tasks_10';
  static const String tasks50 = 'tasks_50';
  static const String tasks100 = 'tasks_100';

  // Focus badges
  static const String firstPomodoro = 'first_pomodoro';
  static const String focus1h = 'focus_1h';
  static const String focus10h = 'focus_10h';
  static const String focus100h = 'focus_100h';

  // Notes badges
  static const String firstNote = 'first_note';
  static const String notes20 = 'notes_20';

  // Flashcard badges
  static const String firstDeck = 'first_deck';
  static const String deckMastered = 'deck_mastered';

  // Goal badges
  static const String firstGoal = 'first_goal';
  static const String goalCompleted = 'goal_completed';
}

// ─── GamificationService ──────────────────────────────────────────────────────

class GamificationService {
  const GamificationService({
    required this.profileRepo,
    required this.focusRepo,
    required this.taskRepo,
  });

  final ProfileRepository profileRepo;
  final FocusRepository focusRepo;
  final TaskRepository taskRepo;

  // ── Task events ───────────────────────────────────────────────────────────

  /// Call after any task is toggled to completed.
  Future<void> onTaskCompleted({
    required bool allSubtasksDone,
    required bool beforeDeadline,
  }) async {
    int xp = XpRewards.taskCompleted;
    if (allSubtasksDone) xp += XpRewards.taskCompletedWithAllSubtasks - XpRewards.taskCompleted;
    if (beforeDeadline) xp += XpRewards.taskCompletedBeforeDeadline;
    await profileRepo.addXp(xp);

    // Badge checks.
    final counts = await taskRepo.getStatusCounts();
    final completedCount = counts[TaskStatus.done] ?? 0;

    await profileRepo.unlockBadge(BadgeKeys.firstTask);
    await profileRepo.updateBadgeProgress(BadgeKeys.tasks10, completedCount);
    await profileRepo.updateBadgeProgress(BadgeKeys.tasks50, completedCount);
    await profileRepo.updateBadgeProgress(BadgeKeys.tasks100, completedCount);
  }

  // ── Focus events ──────────────────────────────────────────────────────────

  /// Call after a Pomodoro work session finishes (completed or abandoned).
  Future<void> onFocusSessionCompleted({required bool isCompleted}) async {
    if (!isCompleted) {
      await profileRepo.addXp(XpRewards.focusSessionAbandoned);
      return;
    }

    await profileRepo.addXp(XpRewards.pomodoroCompleted);
    await profileRepo.unlockBadge(BadgeKeys.firstPomodoro);

    // Total focus minutes for hour-based badges.
    final totalMinutes = await _totalFocusMinutes();
    await profileRepo.updateBadgeProgress(
        BadgeKeys.focus1h, totalMinutes ~/ 60);
    await profileRepo.updateBadgeProgress(
        BadgeKeys.focus10h, totalMinutes ~/ 60);
    await profileRepo.updateBadgeProgress(
        BadgeKeys.focus100h, totalMinutes ~/ 60);
  }

  // ── Note events ───────────────────────────────────────────────────────────

  Future<void> onNoteCreated({bool usedAiSummary = false}) async {
    int xp = XpRewards.noteCreated;
    if (usedAiSummary) xp += XpRewards.noteWithAiSummary;
    await profileRepo.addXp(xp);
    await profileRepo.unlockBadge(BadgeKeys.firstNote);
    // TODO: track note count for notes_20 badge progress.
  }

  // ── Flashcard events ──────────────────────────────────────────────────────

  Future<void> onFlashcardReviewed() async {
    await profileRepo.addXp(XpRewards.flashcardReviewed);
    await profileRepo.unlockBadge(BadgeKeys.firstDeck);
  }

  Future<void> onDeckMastered() async {
    await profileRepo.addXp(XpRewards.deckMastered);
    await profileRepo.unlockBadge(BadgeKeys.deckMastered);
  }

  // ── Quiz events ───────────────────────────────────────────────────────────

  Future<void> onQuizCompleted({
    required int score,
    required int totalQuestions,
  }) async {
    final pct = totalQuestions == 0 ? 0.0 : score / totalQuestions;
    if (pct >= 0.7) {
      int xp = XpRewards.quizPassed;
      if (pct == 1.0) xp += XpRewards.quizPerfectScore;
      await profileRepo.addXp(xp);
    }
  }

  // ── Goal events ───────────────────────────────────────────────────────────

  Future<void> onGoalCompleted() async {
    await profileRepo.addXp(XpRewards.goalCompleted);
    await profileRepo.unlockBadge(BadgeKeys.firstGoal);
    await profileRepo.unlockBadge(BadgeKeys.goalCompleted);
  }

  Future<void> onMilestoneCompleted() async {
    await profileRepo.addXp(XpRewards.milestonecompleted);
  }

  // ── Streak events ─────────────────────────────────────────────────────────

  /// Call once per day (e.g. from SplashScreen) to refresh the streak and
  /// unlock streak badges.
  Future<void> onStreakUpdated() async {
    final streak = await focusRepo.computeCurrentStreak();
    await profileRepo.setStreak(streak);

    // Milestone XP for key streak days.
    if (streak == 7) await profileRepo.addXp(XpRewards.streakDay7);
    if (streak == 30) await profileRepo.addXp(XpRewards.streakDay30);
    if (streak == 100) await profileRepo.addXp(XpRewards.streakDay100);

    // Badge progress.
    await profileRepo.updateBadgeProgress(BadgeKeys.streak3, streak);
    await profileRepo.updateBadgeProgress(BadgeKeys.streak7, streak);
    await profileRepo.updateBadgeProgress(BadgeKeys.streak30, streak);
    await profileRepo.updateBadgeProgress(BadgeKeys.streak100, streak);
  }

  // ── Private helpers ───────────────────────────────────────────────────────

  Future<int> _totalFocusMinutes() async {
    // Sum completed sessions across all time.
    final summaries = await focusRepo.getWeeklyFocusSummary();
    return summaries.fold<int>(0, (int sum, s) => sum + s.totalMinutes);
  }
}
