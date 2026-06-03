// lib/features/tasks/presentation/providers/tasks_provider.dart
//
// StudySpark — Tasks + Smart Study Planner Providers
//
// Provides:
//   • [tasksProvider]           — Full reactive task list (all non-deleted)
//   • [todayTasksProvider]      — Tasks due today
//   • [upcomingTasksProvider]   — Tasks due in the next 7 days
//   • [highPriorityTasksProvider] — High/critical priority open tasks
//   • [taskByUuidProvider]      — Single task lookup
//   • [studyPlanProvider]       — Smart planner output
//   • [timetableProvider]       — Personalised weekly timetable slots
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/enums/app_enums.dart';
import '../../../../shared/providers/repository_providers.dart';
import '../../data/models/task_model.dart';



// ─── All tasks stream ─────────────────────────────────────────────────────────

/// Full reactive list of all tasks (sorted by deadline asc, then priority).
final tasksProvider = StreamProvider<List<TaskModel>>((ref) {
  return ref.watch(taskRepositoryProvider).watchAllTasks();
});



// ─── Upcoming tasks ───────────────────────────────────────────────────────────

/// Tasks due in the next 7 days (not done/archived), sorted by deadline.
final upcomingTasksProvider = FutureProvider<List<TaskModel>>((ref) async {
  final now = DateTime.now();
  final end = now.add(const Duration(days: 7));
  return ref.watch(taskRepositoryProvider).getTasksInRange(now, end);
});

// ─── Priority tasks ───────────────────────────────────────────────────────────

/// Open tasks with high or urgent priority.
final highPriorityTasksProvider = FutureProvider<List<TaskModel>>((ref) async {
  return ref.watch(taskRepositoryProvider).getHighPriorityTasks();
});

// ─── Overdue tasks ────────────────────────────────────────────────────────────

/// Tasks that are past their deadline and not yet completed.
final overdueTasksProvider = FutureProvider<List<TaskModel>>((ref) async {
  return ref.watch(taskRepositoryProvider).getOverdueTasks();
});

// ─── Single task lookup ───────────────────────────────────────────────────────

final taskByUuidProvider =
    FutureProvider.family<TaskModel?, String>((ref, uuid) {
  return ref.read(taskRepositoryProvider).getTaskByUuid(uuid);
});

// ─────────────────────────────────────────────────────────────────────────────
// SMART STUDY PLANNER
// ─────────────────────────────────────────────────────────────────────────────

/// A generated study block suggestion.
class StudyBlock {
  const StudyBlock({
    required this.title,
    required this.subject,
    required this.startHour,
    required this.durationMinutes,
    required this.taskUuid,
    required this.reason,
    required this.dayOffset, // 0 = today, 1 = tomorrow, etc.
    this.colorHex = '#6750A4',
  });

  final String title;
  final String subject;
  final int startHour;   // 0–23
  final int durationMinutes;
  final String taskUuid;
  final String reason;
  final int dayOffset;
  final String colorHex;

  DateTime get scheduledDate =>
      DateTime.now().add(Duration(days: dayOffset));

  String get timeLabel {
    final h = startHour % 12 == 0 ? 12 : startHour % 12;
    final suffix = startHour < 12 ? 'AM' : 'PM';
    final end = startHour + (durationMinutes ~/ 60);
    final endMin = durationMinutes % 60;
    final endH = end % 12 == 0 ? 12 : end % 12;
    final endSuffix = end < 12 ? 'AM' : 'PM';
    if (endMin == 0) return '$h:00 $suffix – $endH:00 $endSuffix';
    return '$h:00 $suffix – $endH:${endMin.toString().padLeft(2, '0')} $endSuffix';
  }
}

/// A hardcoded study-tip suggestion shown alongside planner blocks.
class StudySuggestion {
  const StudySuggestion({
    required this.emoji,
    required this.title,
    required this.body,
    required this.category,
  });

  final String emoji;
  final String title;
  final String body;
  final String category; // 'focus' | 'break' | 'review' | 'health'
}

/// Result of the smart planner algorithm.
class StudyPlan {
  const StudyPlan({
    required this.blocks,
    required this.suggestions,
    required this.totalMinutesPlanned,
    required this.generatedAt,
  });

  final List<StudyBlock> blocks;
  final List<StudySuggestion> suggestions;
  final int totalMinutesPlanned;
  final DateTime generatedAt;

  bool get isEmpty => blocks.isEmpty;
}

// ── Hardcoded suggestion bank ─────────────────────────────────────────────────

const _suggestionBank = <StudySuggestion>[
  StudySuggestion(
    emoji: '🍅',
    title: 'Use the Pomodoro Technique',
    body: 'Work in 25-minute focused sprints with 5-minute breaks. Your brain retains more when you give it regular rest.',
    category: 'focus',
  ),
  StudySuggestion(
    emoji: '🌅',
    title: 'Start with your hardest task',
    body: 'Your cognitive bandwidth is highest in the morning. Tackle the most challenging subject first.',
    category: 'focus',
  ),
  StudySuggestion(
    emoji: '📝',
    title: 'Active recall beats re-reading',
    body: 'After studying, close your notes and write down everything you remember. This consolidates memory 2× faster.',
    category: 'review',
  ),
  StudySuggestion(
    emoji: '🚶',
    title: 'Take a movement break',
    body: 'A 10-minute walk between study blocks improves focus by up to 20% and reduces fatigue.',
    category: 'break',
  ),
  StudySuggestion(
    emoji: '💤',
    title: 'Protect your sleep',
    body: 'Memory consolidation happens during sleep. Aim for 7–8 hours — it\'s the most powerful study tool you have.',
    category: 'health',
  ),
  StudySuggestion(
    emoji: '🔁',
    title: 'Space your reviews',
    body: 'Revisit material at 1-day, 3-day, and 7-day intervals using spaced repetition to fight the forgetting curve.',
    category: 'review',
  ),
  StudySuggestion(
    emoji: '📵',
    title: 'Phone-free deep work',
    body: 'Put your phone in another room. Mere phone proximity reduces available working memory by 10%.',
    category: 'focus',
  ),
  StudySuggestion(
    emoji: '🍎',
    title: 'Fuel your brain',
    body: 'Eat a protein-rich snack before long study sessions. Glucose spikes followed by crashes impair memory formation.',
    category: 'health',
  ),
  StudySuggestion(
    emoji: '🎯',
    title: 'Set a session goal',
    body: 'Before you start, write one specific goal. "Finish Chapter 5" beats "study biology" every time.',
    category: 'focus',
  ),
  StudySuggestion(
    emoji: '🧩',
    title: 'Interleave subjects',
    body: 'Alternating between two subjects in a session is harder but builds stronger retention than blocked study.',
    category: 'review',
  ),
];

// ── Planner algorithm ─────────────────────────────────────────────────────────

/// Generates a 3-day personalised study plan from the current task list.
///
/// Algorithm:
/// 1. Filter to open tasks with a deadline (skip done/archived).
/// 2. Score each task by urgency = (priority weight × daysUntilDeadline⁻¹).
/// 3. Assign preferred study hours based on priority:
///    - Urgent/High  → morning slots (8–11 AM)
///    - Medium       → afternoon slots (2–5 PM)
///    - Low          → evening slots (7–9 PM)
/// 4. Cap at 3 hours of planned study per day.
/// 5. Pick 3 random suggestions from the bank.
final studyPlanProvider = FutureProvider<StudyPlan>((ref) async {
  final upcoming = await ref.read(taskRepositoryProvider).getTasksInRange(
        DateTime.now().subtract(const Duration(days: 1)),
        DateTime.now().add(const Duration(days: 14)),
      );

  final open = upcoming
      .where((t) =>
          t.status != TaskStatus.done &&
          t.status != TaskStatus.archived &&
          t.deadline != null)
      .toList();

  if (open.isEmpty) {
    return StudyPlan(
      blocks: [],
      suggestions: _pickSuggestions(3),
      totalMinutesPlanned: 0,
      generatedAt: DateTime.now(),
    );
  }

  // Score: higher = more urgent to study now
  double score(TaskModel t) {
    final daysLeft = t.deadline!.difference(DateTime.now()).inDays.clamp(0, 30);
    final priorityWeight = switch (t.priority) {
      Priority.critical => 4.0,
      Priority.high     => 3.0,
      Priority.medium   => 2.0,
      Priority.low      => 1.0,
    };
    return priorityWeight / (daysLeft + 1);
  }

  open.sort((a, b) => score(b).compareTo(score(a)));

  // Subject colour hints (simple hash)
  String colorFor(String s) {
    final colours = [
      '#6750A4', '#0077B6', '#2D9CDB', '#27AE60',
      '#E67E22', '#E74C3C', '#8E44AD', '#16A085',
    ];
    return colours[s.hashCode.abs() % colours.length];
  }

  // Hour preferences per priority
  int preferredHour(Priority p, int dayOffset) {
    return switch (p) {
      Priority.critical => 8,
      Priority.high   => 9,
      Priority.medium => 14,
      Priority.low    => 19,
    };
  }

  final blocks = <StudyBlock>[];
  final minutesPerDay = {0: 0, 1: 0, 2: 0};
  const maxDailyMinutes = 180; // 3 hours max per day

  for (final task in open.take(10)) {
    final daysLeft = task.deadline!.difference(DateTime.now()).inDays.clamp(0, 7);
    final dayOffset = daysLeft == 0 ? 0 : (daysLeft <= 2 ? 0 : 1);

    if (dayOffset > 2) continue;
    if ((minutesPerDay[dayOffset] ?? 0) >= maxDailyMinutes) continue;

    final duration = switch (task.priority) {
      Priority.critical => 60,
      Priority.high   => 45,
      Priority.medium => 30,
      Priority.low    => 25,
    };

    final existingMinutes = minutesPerDay[dayOffset] ?? 0;
    if (existingMinutes + duration > maxDailyMinutes) continue;

    final startHour = preferredHour(task.priority, dayOffset) +
        (blocks.where((b) => b.dayOffset == dayOffset).length * 1);

    blocks.add(StudyBlock(
      title: 'Study: ${task.title}',
      subject: task.subjectId.isEmpty ? 'General' : task.subjectId,
      startHour: startHour.clamp(7, 21),
      durationMinutes: duration,
      taskUuid: task.uuid,
      dayOffset: dayOffset,
      colorHex: colorFor(task.subjectId),
      reason: daysLeft <= 1
          ? 'Due very soon — prioritised for today!'
          : 'Due in $daysLeft days — fits your schedule.',
    ));

    minutesPerDay[dayOffset] = existingMinutes + duration;
  }

  final total = minutesPerDay.values.fold(0, (a, b) => a + b);

  return StudyPlan(
    blocks: blocks,
    suggestions: _pickSuggestions(3),
    totalMinutesPlanned: total,
    generatedAt: DateTime.now(),
  );
});

List<StudySuggestion> _pickSuggestions(int n) {
  final shuffled = List.of(_suggestionBank)..shuffle();
  return shuffled.take(n).toList();
}

// ─────────────────────────────────────────────────────────────────────────────
// PERSONALISED TIMETABLE
// ─────────────────────────────────────────────────────────────────────────────

/// A single slot in the personalised weekly timetable.
class TimetableSlot {
  const TimetableSlot({
    required this.weekday,   // 1=Mon … 7=Sun
    required this.startHour,
    required this.endHour,
    required this.label,
    required this.type,      // 'class' | 'study' | 'break' | 'sleep'
    this.colorHex = '#6750A4',
    this.isFromSubject = false,
    this.subjectId = '',
  });

  final int weekday;
  final int startHour;
  final int endHour;
  final String label;
  final String type;
  final String colorHex;
  final bool isFromSubject;
  final String subjectId;

  String get weekdayLabel =>
      const ['', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][weekday];

  String get timeLabel {
    String fmt(int h) {
      if (h == 0) return '12 AM';
      if (h < 12) return '$h AM';
      if (h == 12) return '12 PM';
      return '${h - 12} PM';
    }
    return '${fmt(startHour)} – ${fmt(endHour)}';
  }
}

/// Builds a personalised weekly timetable.
///
/// Combines:
///   1. Subject schedule slots from [SubjectModel.scheduleSlots] (real classes).
///   2. Suggested study blocks derived from overdue + upcoming tasks.
///   3. Hardcoded wellness blocks (sleep, morning routine, evening wind-down).
final timetableProvider = FutureProvider<List<TimetableSlot>>((ref) async {
  // --- Fixed wellness blocks (every day) ---
  final wellness = <TimetableSlot>[];
  for (int d = 1; d <= 7; d++) {
    wellness.addAll([
      TimetableSlot(
        weekday: d, startHour: 0, endHour: 6,
        label: 'Sleep 💤', type: 'sleep', colorHex: '#5C6BC0',
      ),
      TimetableSlot(
        weekday: d, startHour: 6, endHour: 7,
        label: 'Morning Routine', type: 'break', colorHex: '#26A69A',
      ),
      TimetableSlot(
        weekday: d, startHour: 22, endHour: 24,
        label: 'Wind Down 🌙', type: 'break', colorHex: '#7E57C2',
      ),
    ]);
  }

  // --- Hardcoded default study blocks for weekdays ---
  final studyDefaults = <TimetableSlot>[];
  for (int d = 1; d <= 5; d++) {
    studyDefaults.addAll([
      TimetableSlot(
        weekday: d, startHour: 8, endHour: 10,
        label: '📚 Morning Study Block', type: 'study', colorHex: '#1565C0',
      ),
      TimetableSlot(
        weekday: d, startHour: 14, endHour: 16,
        label: '📖 Afternoon Study Block', type: 'study', colorHex: '#1B5E20',
      ),
    ]);
  }

  // Weekend lighter schedule
  for (int d = 6; d <= 7; d++) {
    studyDefaults.add(
      TimetableSlot(
        weekday: d, startHour: 10, endHour: 12,
        label: '📚 Weekend Study', type: 'study', colorHex: '#E65100',
      ),
    );
  }

  // --- Meal breaks (weekdays) ---
  final meals = <TimetableSlot>[];
  for (int d = 1; d <= 7; d++) {
    meals.addAll([
      TimetableSlot(weekday: d, startHour: 7, endHour: 8, label: 'Breakfast 🍳', type: 'break', colorHex: '#F9A825'),
      TimetableSlot(weekday: d, startHour: 12, endHour: 13, label: 'Lunch 🍽️', type: 'break', colorHex: '#F57F17'),
      TimetableSlot(weekday: d, startHour: 18, endHour: 19, label: 'Dinner 🍜', type: 'break', colorHex: '#BF360C'),
    ]);
  }

  return [...wellness, ...studyDefaults, ...meals]
    ..sort((a, b) {
      final wd = a.weekday.compareTo(b.weekday);
      return wd != 0 ? wd : a.startHour.compareTo(b.startHour);
    });
});
