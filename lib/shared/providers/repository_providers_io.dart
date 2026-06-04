// lib/shared/providers/repository_providers.dart
//
// StudySpark ΓÇö Repository & Service Providers
//
// Single source-of-truth for all Riverpod providers:
//   Section 1 ΓÇö Repository providers (one per data class)
//   Section 2 ΓÇö Service providers (NotificationService, PomodoroService, etc.)
//   Section 3 ΓÇö Feature state providers (tasks stream, notes stream, etc.)
//   Section 4 ΓÇö Dashboard / analytics aggregate providers
//
// Convention:
//   ΓÇó [Provider<T>]              ΓÇö synchronous singleton (repositories)
//   ΓÇó [StreamProvider<T>]        ΓÇö reactive Isar query
//   ΓÇó [FutureProvider<T>]        ΓÇö one-shot async read
//   ΓÇó [NotifierProvider<N, S>]   ΓÇö mutable UI state with methods
//   ΓÇó [AsyncNotifierProvider]    ΓÇö mutable async state (profile, etc.)
// ΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇ

import 'package:flutter_riverpod/flutter_riverpod.dart';

// ΓöÇΓöÇ Core models / enums ΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇ
import '../../core/enums/app_enums.dart';

// ΓöÇΓöÇ Repository imports ΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇ
import '../../features/tasks/data/repositories/task_repository.dart';
import '../../features/notes/data/repositories/note_repository.dart';
import '../../features/focus/data/repositories/focus_repository.dart';
import '../../features/schedule/data/repositories/schedule_repository.dart';
import '../../features/flashcards/data/repositories/flashcard_repository.dart';
import '../../features/goals/data/repositories/goal_repository.dart';
import '../../features/mood/data/repositories/mood_repository.dart';
import '../../features/profile/data/repositories/profile_repository.dart';
import '../../features/analytics/data/repositories/analytics_repository.dart';

// ΓöÇΓöÇ Service imports ΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇ
import '../../core/services/notification_service.dart';
import '../../core/services/pomodoro_service.dart';
import '../../core/services/gamification_service.dart';

// ΓöÇΓöÇ Model imports ΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇ
import '../../features/tasks/data/models/task_model.dart';
import '../../features/notes/data/models/note_model.dart';
import '../../features/focus/data/models/pomodoro_session_model.dart';
import '../../features/schedule/data/models/schedule_event_model.dart';
import '../../features/schedule/data/models/subject_model.dart';
import '../../features/flashcards/data/models/flashcard_model.dart';
import '../../features/goals/data/models/goal_model.dart';
import '../../features/mood/data/models/mood_entry_model.dart';
import '../../features/profile/data/models/user_model.dart';
import '../../features/profile/data/models/badge_model.dart';

// ΓöÇΓöÇ Shared provider ΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇ
import 'isar_provider.dart';

// =============================================================================
// SECTION 1 ΓÇö REPOSITORY PROVIDERS
// =============================================================================

// ΓöÇΓöÇ Tasks ΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇ

/// Provides the [TaskRepository] singleton.
/// Reads [isarProvider] which is overridden at startup.
final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepository(ref.read(isarProvider));
});

// ΓöÇΓöÇ Notes ΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇ

final noteRepositoryProvider = Provider<NoteRepository>((ref) {
  return NoteRepository(ref.read(isarProvider));
});

// ΓöÇΓöÇ Focus ΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇ

final focusRepositoryProvider = Provider<FocusRepository>((ref) {
  return FocusRepository(ref.read(isarProvider));
});

// ΓöÇΓöÇ Schedule ΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇ

final subjectRepositoryProvider = Provider<SubjectRepository>((ref) {
  return SubjectRepository(ref.read(isarProvider));
});

final attendanceRepositoryProvider = Provider<AttendanceRepository>((ref) {
  return AttendanceRepository(ref.read(isarProvider));
});

final scheduleEventRepositoryProvider = Provider<ScheduleEventRepository>((ref) {
  return ScheduleEventRepository(ref.read(isarProvider));
});

// ΓöÇΓöÇ Flashcards ΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇ

final flashcardRepositoryProvider = Provider<FlashcardRepository>((ref) {
  return FlashcardRepository(ref.read(isarProvider));
});

final quizRepositoryProvider = Provider<QuizRepository>((ref) {
  return QuizRepository(ref.read(isarProvider));
});

// ΓöÇΓöÇ Goals ΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇ

final goalRepositoryProvider = Provider<GoalRepository>((ref) {
  return GoalRepository(ref.read(isarProvider));
});

// ΓöÇΓöÇ Mood ΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇ

final moodRepositoryProvider = Provider<MoodRepository>((ref) {
  return MoodRepository(ref.read(isarProvider));
});

// ΓöÇΓöÇ Profile ΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇ

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository(ref.read(isarProvider));
});

final analyticsRepositoryProvider = Provider<AnalyticsRepository>((ref) {
  return AnalyticsRepository(ref.read(isarProvider));
});

// =============================================================================
// SECTION 2 ΓÇö SERVICE PROVIDERS
// =============================================================================

// ΓöÇΓöÇ NotificationService ΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇ

/// The [NotificationService] instance is created in [main.dart] and injected
/// here via [ProviderScope.overrides] ΓÇö same pattern as [isarProvider].
///
/// Fallback throws to catch missing override early in development.
final notificationServiceProvider = Provider<NotificationService>((ref) {
  throw UnimplementedError(
    'notificationServiceProvider must be overridden with an initialised '
    'NotificationService instance. See main.dart.',
  );
});

// ΓöÇΓöÇ PomodoroService ΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇ

/// Stateful Pomodoro timer.  All UI widgets watch this provider.
final pomodoroProvider = NotifierProvider<PomodoroNotifier, PomodoroState>(
  PomodoroNotifier.new,
);

// ΓöÇΓöÇ GamificationService ΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇ

final gamificationServiceProvider = Provider<GamificationService>((ref) {
  return GamificationService(
    profileRepo: ref.read(profileRepositoryProvider),
    focusRepo: ref.read(focusRepositoryProvider),
    taskRepo: ref.read(taskRepositoryProvider),
  );
});

// =============================================================================
// SECTION 3 ΓÇö FEATURE STATE PROVIDERS (reactive streams & mutable state)
// =============================================================================

// ΓöÇΓöÇ Tasks ΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇ

/// Tasks due today (used on the dashboard).
final todayTasksProvider = FutureProvider<List<TaskModel>>((ref) async {
  return ref.watch(taskRepositoryProvider).getTasksForDay(_todayKey());
});

// ΓöÇΓöÇ Task filter notifier ΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇ

/// Simple value object holding the current filter state.
class TaskFilter {
  const TaskFilter({this.status, this.priority, this.subjectId});
  final TaskStatus? status;
  final Priority? priority;
  final String? subjectId;

  TaskFilter copyWith({
    TaskStatus? status,
    Priority? priority,
    String? subjectId,
    bool clearStatus = false,
    bool clearPriority = false,
    bool clearSubject = false,
  }) {
    return TaskFilter(
      status: clearStatus ? null : (status ?? this.status),
      priority: clearPriority ? null : (priority ?? this.priority),
      subjectId: clearSubject ? null : (subjectId ?? this.subjectId),
    );
  }

  bool get isActive => status != null || priority != null || subjectId != null;
}

class _TaskFilterNotifier extends Notifier<TaskFilter> {
  @override
  TaskFilter build() => const TaskFilter();

  void filterByStatus(TaskStatus? status) =>
      state = state.copyWith(status: status, clearStatus: status == null);

  void filterByPriority(Priority? priority) =>
      state = state.copyWith(priority: priority, clearPriority: priority == null);

  void filterBySubject(String? subjectId) =>
      state = state.copyWith(subjectId: subjectId, clearSubject: subjectId == null);

  void clearAll() => state = const TaskFilter();
}

final taskFilterProvider = NotifierProvider<_TaskFilterNotifier, TaskFilter>(
  _TaskFilterNotifier.new,
);

// ΓöÇΓöÇ Notes ΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇ

final allNotesProvider = StreamProvider<List<NoteModel>>((ref) {
  return ref.watch(noteRepositoryProvider).watchAllNotes();
});

/// Notes filtered by tag (set by [noteTagFilterProvider]).
final filteredNotesProvider = StreamProvider<List<NoteModel>>((ref) {
  final tag = ref.watch(noteTagFilterProvider);
  final repo = ref.watch(noteRepositoryProvider);
  if (tag != null) return repo.watchNotesByTag(tag);
  return repo.watchAllNotes();
});

/// Currently selected tag filter for the notes screen.
final noteTagFilterProvider = StateProvider<String?>((ref) => null);

// ΓöÇΓöÇ Focus ΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇ

/// Today's focus sessions ΓÇö reactive stream.
final todayFocusSessionsProvider = StreamProvider<List<PomodoroSessionModel>>((ref) {
  final dateKey = _todayKey();
  return ref.watch(focusRepositoryProvider).watchSessionsForDay(dateKey);
});

/// Today's total focus minutes (one-shot, refreshed by invalidation).
final todayFocusMinutesProvider = FutureProvider<int>((ref) {
  return ref.watch(focusRepositoryProvider).todayTotalMinutes();
});

/// Weekly summary for the analytics chart.
final weeklyFocusSummaryProvider = FutureProvider<List<DailyFocusSummary>>((ref) {
  return ref.watch(focusRepositoryProvider).getWeeklyFocusSummary();
});

/// Current streak day count.
final focusStreakProvider = FutureProvider<int>((ref) {
  return ref.watch(focusRepositoryProvider).computeCurrentStreak();
});

// ΓöÇΓöÇ Schedule ΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇ

/// Currently selected date on the schedule screen.
final selectedScheduleDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

/// Events for the selected schedule date.
final selectedDayEventsProvider = StreamProvider<List<ScheduleEventModel>>((ref) {
  final date = ref.watch(selectedScheduleDateProvider);
  final dateKey = _dateKey(date);
  return ref.watch(scheduleEventRepositoryProvider).watchEventsForDay(dateKey);
});

/// All active subjects ΓÇö used in dropdowns across the app.
final activeSubjectsProvider = StreamProvider<List<SubjectModel>>((ref) {
  return ref.watch(subjectRepositoryProvider).watchActiveSubjects();
});

// ΓöÇΓöÇ Flashcards ΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇ

final allDecksProvider = StreamProvider<List<FlashcardDeckModel>>((ref) {
  return ref.watch(flashcardRepositoryProvider).watchAllDecks();
});

final totalDueCardsProvider = StreamProvider<int>((ref) {
  return ref.watch(flashcardRepositoryProvider).watchTotalDueCardCount();
});

/// Cards for the currently open deck review session.
final deckCardsProvider = FutureProvider.family<List<FlashcardModel>, String>(
  (ref, deckId) => ref.read(flashcardRepositoryProvider).getCardsForDeck(deckId),
);

/// Due cards for a specific deck (review mode).
final dueCardsProvider = FutureProvider.family<List<FlashcardModel>, String>(
  (ref, deckId) => ref.read(flashcardRepositoryProvider).getDueCards(deckId),
);

// ΓöÇΓöÇ Goals ΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇ

final activeGoalsProvider = StreamProvider<List<GoalModel>>((ref) {
  return ref.watch(goalRepositoryProvider).watchActiveGoals();
});

final allGoalsProvider = StreamProvider<List<GoalModel>>((ref) {
  return ref.watch(goalRepositoryProvider).watchAllGoals();
});

// ΓöÇΓöÇ Mood ΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇ

final recentMoodEntriesProvider = StreamProvider<List<MoodEntryModel>>((ref) {
  return ref.watch(moodRepositoryProvider).watchRecentEntries();
});

final todayMoodProvider = FutureProvider<MoodEntryModel?>((ref) {
  return ref.watch(moodRepositoryProvider).getEntryForDay(_todayKey());
});

// ΓöÇΓöÇ Profile ΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇ

final userProfileProvider = StreamProvider<UserModel?>((ref) {
  return ref.watch(profileRepositoryProvider).watchProfile();
});

final badgesProvider = StreamProvider<List<BadgeModel>>((ref) {
  return ref.watch(profileRepositoryProvider).watchBadges();
});

// =============================================================================
// SECTION 4 ΓÇö DASHBOARD AGGREGATE PROVIDERS
// =============================================================================

/// Aggregates the key stats displayed on the dashboard home screen.
class DashboardStats {
  const DashboardStats({
    required this.todayTaskCount,
    required this.completedTaskCount,
    required this.focusMinutesToday,
    required this.streakDays,
    required this.dueFlashcards,
  });

  final int todayTaskCount;
  final int completedTaskCount;
  final int focusMinutesToday;
  final int streakDays;
  final int dueFlashcards;

  /// Fraction of today's tasks completed (0.0ΓÇô1.0).
  double get taskCompletionRate =>
      todayTaskCount == 0 ? 0.0 : completedTaskCount / todayTaskCount;
}

/// Combines several async providers into a single [DashboardStats] object.
///
/// The UI only needs to watch this one provider instead of four.
final dashboardStatsProvider = FutureProvider<DashboardStats>((ref) async {
  final focusMinutes = await ref.watch(todayFocusMinutesProvider.future);
  final streak = await ref.watch(focusStreakProvider.future);
  final dueCards = await ref.watch(totalDueCardsProvider.future);
  final todayTasks = await ref.watch(todayTasksProvider.future);

  final completed = todayTasks
      .where((t) => t.status == TaskStatus.done)
      .length;

  return DashboardStats(
    todayTaskCount: todayTasks.length,
    completedTaskCount: completed,
    focusMinutesToday: focusMinutes,
    streakDays: streak,
    dueFlashcards: dueCards,
  );
});

// =============================================================================
// HELPERS
// =============================================================================

String _todayKey() {
  final now = DateTime.now().toLocal();
  return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
}

String _dateKey(DateTime date) {
  final d = date.toLocal();
  return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}
