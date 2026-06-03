// lib/features/dashboard/presentation/providers/dashboard_provider.dart
//
// StudySpark — Dashboard aggregated state provider.
// Pulls data from multiple repositories and surfaces a single DashboardStats model.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_provider.g.dart';

// ─── Dashboard Stats Model ────────────────────────────────────────────────────

class DashboardStats {
  const DashboardStats({
    this.tasksDueToday = 0,
    this.tasksOverdue = 0,
    this.focusMinutesToday = 0,
    this.focusScore = 0,
    this.currentStreak = 0,
    this.weeklyFocusMinutes = const [0, 0, 0, 0, 0, 0, 0],
    this.xp = 0,
    this.level = 1,
    this.userName = 'Student',
  });

  final int tasksDueToday;
  final int tasksOverdue;
  final int focusMinutesToday;
  final int focusScore;
  final int currentStreak;
  final List<double> weeklyFocusMinutes; // Mon..Sun
  final int xp;
  final int level;
  final String userName;

  String get focusTimeFormatted {
    final h = focusMinutesToday ~/ 60;
    final m = focusMinutesToday % 60;
    if (h > 0) return '${h}h ${m}m';
    return '${m}m';
  }
}

// ─── Providers ───────────────────────────────────────────────────────────────

/// Provides aggregated dashboard statistics.
/// TODO: Replace stub with real repository calls.
@riverpod
Future<DashboardStats> dashboardStats(DashboardStatsRef ref) async {
  // Stub — replace bodies with actual repository reads once wired:
  //
  //   final taskRepo  = ref.watch(taskRepositoryProvider);
  //   final focusRepo = ref.watch(focusRepositoryProvider);
  //   final profile   = await ref.watch(profileRepositoryProvider).getOrCreateProfile();
  //
  //   final dueToday    = await taskRepo.watchTasksDueToday().first;
  //   final overdue     = await taskRepo.watchOverdueTasks().first;
  //   final todayFocus  = await focusRepo.todayTotalMinutes();
  //   final weekFocus   = await focusRepo.getWeeklyFocusSummary();
  //   final streak      = await focusRepo.computeCurrentStreak();

  // Return mock data for now
  await Future.delayed(const Duration(milliseconds: 600)); // simulate load
  return const DashboardStats(
    tasksDueToday: 5,
    tasksOverdue: 2,
    focusMinutesToday: 210,
    focusScore: 82,
    currentStreak: 14,
    weeklyFocusMinutes: [42, 65, 30, 80, 55, 70, 48],
    xp: 2340,
    level: 8,
    userName: 'Pradeep',
  );
}

/// Provider for today's mood check-in.
/// null = not yet logged today.
final todayMoodProvider = StateProvider<int?>((ref) => null); // index of MoodType
