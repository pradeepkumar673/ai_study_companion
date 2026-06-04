// lib/shared/providers/isar_provider.dart
//
// StudySpark ΓÇö Isar singleton provider.
//
// Opens (or re-uses) the single Isar database instance for the app.
// Every Isar @Collection schema MUST be listed in the [schemas] list below;
// omitting one causes Isar to silently ignore that collection.
//
// Usage in repositories:
//   final isar = ref.watch(isarProvider);
//   isar.taskModels.where()ΓÇª
// ΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇ

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ΓöÇΓöÇ Model imports ΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇ
import '../../features/profile/data/models/user_model.dart';
import '../../features/profile/data/models/badge_model.dart';
import '../../features/tasks/data/models/task_model.dart';
import '../../features/tasks/data/models/subtask_model.dart';
import '../../features/schedule/data/models/subject_model.dart';
import '../../features/schedule/data/models/attendance_model.dart';
import '../../features/notes/data/models/note_model.dart';
import '../../features/focus/data/models/pomodoro_session_model.dart';
import '../../features/mood/data/models/mood_entry_model.dart';
import '../../features/flashcards/data/models/flashcard_model.dart';
import '../../features/flashcards/data/models/quiz_model.dart';
import '../../features/goals/data/models/goal_model.dart';
import '../../features/analytics/data/models/gpa_entry_model.dart';

// Generated schema imports are automatically included via their parent models.

// ΓöÇΓöÇΓöÇ Schema Registry ΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇ

/// Complete list of Isar collection schemas.
/// ΓÜá∩╕Å  Add every new @Collection class here or it will NOT be persisted.
const List<CollectionSchema<dynamic>> isarSchemas = [
  // Profile
  UserModelSchema,
  BadgeModelSchema,

  // Tasks
  TaskModelSchema,
  // SubtaskModel is @embedded ΓÇö no top-level schema needed.

  // Schedule / Subjects
  SubjectModelSchema,
  AttendanceModelSchema,

  // Notes
  NoteModelSchema,

  // Focus
  PomodoroSessionModelSchema,

  // Mood
  MoodEntryModelSchema,

  // Flashcards & Quizzes
  FlashcardModelSchema,
  FlashcardDeckModelSchema,
  QuizModelSchema,
  QuizQuestionModelSchema,
  QuizAttemptModelSchema,

  // Goals
  GoalModelSchema,

  // Analytics
  GpaEntryModelSchema,
];

// ΓöÇΓöÇΓöÇ Provider ΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇ

/// Holds the open [Isar] instance.  Overridden in [ProviderScope] by
/// [main.dart] after the async [openIsar] call completes.
///
/// Do NOT watch this in widget code ΓÇö it is set once and never changes.
final isarProvider = Provider<Isar>((ref) {
  throw UnimplementedError(
    'isarProvider must be overridden in ProviderScope with an open Isar instance. '
    'See main.dart bootstrapIsar().',
  );
});

/// Holds the open [SharedPreferences] instance.  Overridden in [ProviderScope]
/// by [main.dart] during application startup.
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(
    'sharedPreferencesProvider must be overridden in ProviderScope. '
    'See main.dart.',
  );
});

// ΓöÇΓöÇΓöÇ Bootstrap helper (called from main.dart) ΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇΓöÇ

/// Opens the Isar database, registering all known collection schemas.
/// Call this once during app startup before mounting [ProviderScope].
///
/// ```dart
/// final isar = await bootstrapIsar();
/// runApp(ProviderScope(
///   overrides: [isarProvider.overrideWithValue(isar)],
///   child: const StudySparkApp(),
/// ));
/// ```
Future<Isar> bootstrapIsar() async {
  final dir = await getApplicationDocumentsDirectory();

  // Return existing instance if already open (e.g. hot-restart in debug).
  if (Isar.instanceNames.contains('studyspark')) {
    return Isar.getInstance('studyspark')!;
  }

  return Isar.open(
    isarSchemas,
    directory: dir.path,
    name: 'studyspark',
    inspector: true, // Set to false for production builds.
  );
}
