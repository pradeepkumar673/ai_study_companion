# StudySpark — Isar Data Models

> Generated as part of Step 2 of the StudySpark Flutter build.

---

## Quick Start — Code Generation

After adding or modifying any model file, regenerate the Isar `.g.dart`
schemas and any other build_runner outputs:

```bash
# One-time generation
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (re-runs on file save)
flutter pub run build_runner watch --delete-conflicting-outputs
```

This produces `*.g.dart` files next to each model.  **Never edit `.g.dart`
files manually** — they are overwritten on every build.

---

## Model Map

| File | Isar Collection(s) | Key Fields |
|---|---|---|
| `core/enums/app_enums.dart` | *(enums only — no collection)* | `Priority`, `TaskStatus`, `MoodType`, `FlashcardDifficulty`, `GoalStatus`, `BadgeCategory`, … |
| `profile/data/models/user_model.dart` | `UserModel` | Singleton profile, XP/level, streak, Pomodoro prefs |
| `profile/data/models/badge_model.dart` | `BadgeModel` | `badgeKey`, `tier`, `isUnlocked`, `currentProgress` |
| `tasks/data/models/subtask_model.dart` | `SubtaskModel` *(embedded)* | Checklist items inside `TaskModel` |
| `tasks/data/models/task_model.dart` | `TaskModel` | `priority`, `status`, `deadline`, `subtasks`, `repeatFrequency` |
| `schedule/data/models/subject_model.dart` | `SubjectModel` | `colorHex`, `scheduleSlots`, `targetAttendancePercent` |
| `schedule/data/models/attendance_model.dart` | `AttendanceModel` | `attendanceStatus`, `subjectId`, `localDateKey` |
| `notes/data/models/note_model.dart` | `NoteModel` | Quill Delta `content`, `plainTextPreview`, `aiSummary` |
| `focus/data/models/pomodoro_session_model.dart` | `PomodoroSessionModel` | `mode`, `actualDurationSeconds`, `localDateKey` |
| `mood/data/models/mood_entry_model.dart` | `MoodEntryModel` | `mood`, `energyLevel`, `stressLevel`, `sleepHours` |
| `flashcards/data/models/flashcard_model.dart` | `FlashcardModel`, `FlashcardDeckModel` | SM-2 fields: `easeFactor`, `interval`, `repetitions`, `nextReviewAt` |
| `flashcards/data/models/quiz_model.dart` | `QuizModel`, `QuizQuestionModel`, `QuizAttemptModel` | `options` (embedded), `score`, `isAiGenerated` |
| `goals/data/models/goal_model.dart` | `GoalModel` | `targetValue`, `currentValue`, `milestones` (embedded), `streakDays` |

---

## Design Conventions

### UUIDs vs Isar IDs
Every model has both:
- `id` — Isar auto-increment integer primary key (fast index).
- `uuid` — RFC 4122 UUID string generated with the `uuid` package.

Always use `uuid` for cross-collection references and notification payloads
(deep links survive database migrations).  Use `id` for Isar queries only.

### Foreign Key Pattern
Isar has no relational FK constraints.  Relationships are modelled as:
```dart
// In TaskModel:
String subjectId; // stores SubjectModel.uuid
```
The repository layer resolves references:
```dart
final subject = await isar.subjectModels
    .filter()
    .uuidEqualTo(task.subjectId)
    .findFirst();
```

### Embedded vs Collection
| Strategy | Use when |
|---|---|
| `@embedded` | Data is always fetched with the parent (subtasks, milestones, quiz options, schedule slots) |
| `@Collection` | Data may be queried independently (sessions, attendance records, quiz attempts) |

### Timestamps
All `DateTime` values are stored as **UTC** and converted to local time in
the presentation layer using `intl` formatters.

### `localDateKey`
Models that need fast daily aggregation (sessions, attendance, mood) store a
`"yyyy-MM-dd"` string alongside the full `DateTime`.  This allows simple
equality queries without date-range arithmetic:

```dart
// Fast — uses string index
isar.pomodoroSessionModels
    .filter()
    .localDateKeyEqualTo('2025-01-15')
    .findAll();
```

---

## Isar Provider Bootstrap

`lib/shared/providers/isar_provider.dart` exposes:

```dart
// Open DB once in main.dart:
final isar = await bootstrapIsar();

// Override provider:
runApp(ProviderScope(
  overrides: [isarProvider.overrideWithValue(isar)],
  child: const StudySparkApp(),
));
```

`isarSchemas` in `isar_provider.dart` lists every `CollectionSchema` — add
new collections there too or they will be silently ignored by Isar.

---

## File Structure

```
lib/
├── core/
│   └── enums/
│       └── app_enums.dart                  ← All enums
│
├── features/
│   ├── profile/data/models/
│   │   ├── user_model.dart
│   │   ├── user_model.g.dart               ← [generated]
│   │   ├── badge_model.dart
│   │   └── badge_model.g.dart
│   │
│   ├── tasks/data/models/
│   │   ├── subtask_model.dart
│   │   ├── subtask_model.g.dart
│   │   ├── task_model.dart
│   │   └── task_model.g.dart
│   │
│   ├── schedule/data/models/
│   │   ├── subject_model.dart
│   │   ├── subject_model.g.dart
│   │   ├── attendance_model.dart
│   │   └── attendance_model.g.dart
│   │
│   ├── notes/data/models/
│   │   ├── note_model.dart
│   │   └── note_model.g.dart
│   │
│   ├── focus/data/models/
│   │   ├── pomodoro_session_model.dart
│   │   └── pomodoro_session_model.g.dart
│   │
│   ├── mood/data/models/
│   │   ├── mood_entry_model.dart
│   │   └── mood_entry_model.g.dart
│   │
│   ├── flashcards/data/models/
│   │   ├── flashcard_model.dart            ← FlashcardModel + FlashcardDeckModel
│   │   ├── flashcard_model.g.dart
│   │   ├── quiz_model.dart                 ← QuizModel + QuizQuestionModel + QuizAttemptModel
│   │   └── quiz_model.g.dart
│   │
│   └── goals/data/models/
│       ├── goal_model.dart
│       └── goal_model.g.dart
│
└── shared/
    ├── models/
    │   └── models.dart                     ← Barrel export
    └── providers/
        └── isar_provider.dart              ← DB bootstrap + isarProvider
```
