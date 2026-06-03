// lib/shared/models/models.dart
//
// StudySpark — Central barrel export for all Isar model classes.
// Import this single file wherever you need multiple models.
//
// Usage:
//   import 'package:studyspark/shared/models/models.dart';
// ─────────────────────────────────────────────────────────────────────────────

// ── Enums ─────────────────────────────────────────────────────────────────────
export '../../core/enums/app_enums.dart';

// ── Profile ───────────────────────────────────────────────────────────────────
export '../../features/profile/data/models/user_model.dart';
export '../../features/profile/data/models/badge_model.dart';

// ── Tasks ─────────────────────────────────────────────────────────────────────
export '../../features/tasks/data/models/subtask_model.dart';
export '../../features/tasks/data/models/task_model.dart';

// ── Schedule / Subjects ───────────────────────────────────────────────────────
export '../../features/schedule/data/models/subject_model.dart';
export '../../features/schedule/data/models/attendance_model.dart';

// ── Notes ─────────────────────────────────────────────────────────────────────
export '../../features/notes/data/models/note_model.dart';

// ── Focus ─────────────────────────────────────────────────────────────────────
export '../../features/focus/data/models/pomodoro_session_model.dart';

// ── Mood ──────────────────────────────────────────────────────────────────────
export '../../features/mood/data/models/mood_entry_model.dart';

// ── Flashcards & Quizzes ──────────────────────────────────────────────────────
export '../../features/flashcards/data/models/flashcard_model.dart';
export '../../features/flashcards/data/models/quiz_model.dart';

// ── Goals ─────────────────────────────────────────────────────────────────────
export '../../features/goals/data/models/goal_model.dart';
