# StudySpark — Step 3: Repositories, Providers & Services

> Generated files for the repository layer, Riverpod state management, and service classes.

---

## What was built

### Repositories (`features/<feature>/data/repositories/`)

| File | Repository class(es) | Key methods |
|---|---|---|
| `task_repository.dart` | `TaskRepository` | `createTask`, `watchAllTasks`, `watchTasksByStatus/Priority/Subject`, `watchTasksDueToday`, `searchTasks`, `toggleComplete`, `toggleSubtask`, `archiveTask`, `deleteAllCompleted` |
| `note_repository.dart` | `NoteRepository` | `createNote`, `watchAllNotes`, `watchNotesByTag`, `searchNotes`, `saveAiSummary`, `togglePin`, `archiveNote` |
| `focus_repository.dart` | `FocusRepository` | `saveSession`, `watchSessionsForDay`, `getWeeklyFocusSummary`, `computeCurrentStreak`, `todayTotalMinutes` |
| `schedule_repository.dart` | `SubjectRepository` `AttendanceRepository` `ScheduleEventRepository` | Full CRUD + `getAttendancePercent`, `getEventsInRange`, `upsertAttendance` |
| `flashcard_repository.dart` | `FlashcardRepository` `QuizRepository` | SM-2 `recordReview`, `getDueCards`, `watchTotalDueCardCount`, `_syncDeckCardCount`, quiz attempts |
| `other_repositories.dart` | `GoalRepository` `MoodRepository` `ProfileRepository` | `incrementProgress`, `completeMilestone`, `logMood`, `getOrCreateProfile`, `addXp`, `unlockBadge`, `updateBadgeProgress` |

---

### Services (`core/services/`)

| File | Class | Responsibilities |
|---|---|---|
| `notification_service.dart` | `NotificationService` | Wraps `flutter_local_notifications`. `scheduleReminder`, `showPomodoroComplete`, `scheduleTimerEnd`, `cancelTimerNotification`, `scheduleDailyStreakReminder`. Static `generateId()`. Deep-link tap routing stub. |
| `pomodoro_service.dart` | `PomodoroNotifier` + `PomodoroState` | Full Pomodoro state machine. `start/pause/resume/stop/skipPhase/logDistraction`. Auto-persists sessions via `FocusRepository`. Awards XP via `ProfileRepository`. Fires notifications via `NotificationService`. Configurable via `refreshPreferences`. |
| `gamification_service.dart` | `GamificationService` + `XpRewards` + `BadgeKeys` | Centralised XP logic for every user action. Badge unlock/progress for tasks, focus hours, streaks, flashcards, goals. |

---

### Providers (`shared/providers/`)

| File | Contains |
|---|---|
| `repository_providers.dart` | **Section 1** — one `Provider<T>` per repository. **Section 2** — service providers (`notificationServiceProvider`, `pomodoroProvider`, `gamificationServiceProvider`). **Section 3** — feature `StreamProvider`s and `FutureProvider`s. **Section 4** — `DashboardStats` aggregate provider. |
| `ui_state_providers.dart` | Ephemeral UI state: `TaskDraft`, `taskFilterProvider`, `taskSearchQueryProvider`, `flashcardReviewProvider`, `noteEditorHasChangesProvider`, `selectedScheduleDateProvider`, `scheduleViewModeProvider`, `activeNavIndexProvider`. |

---

## File placement guide

```
lib/
├── core/
│   └── services/
│       ├── notification_service.dart    ← NEW
│       ├── pomodoro_service.dart        ← NEW
│       └── gamification_service.dart   ← NEW
│
├── features/
│   ├── tasks/data/repositories/
│   │   └── task_repository.dart        ← NEW
│   ├── notes/data/repositories/
│   │   └── note_repository.dart        ← NEW
│   ├── focus/data/repositories/
│   │   └── focus_repository.dart       ← NEW
│   ├── schedule/data/repositories/
│   │   └── schedule_repository.dart    ← NEW (3 repos bundled)
│   ├── flashcards/data/repositories/
│   │   └── flashcard_repository.dart   ← NEW (2 repos bundled)
│   ├── goals/data/repositories/
│   │   └── goal_repository.dart        ← split from other_repositories.dart
│   ├── mood/data/repositories/
│   │   └── mood_repository.dart        ← split from other_repositories.dart
│   └── profile/data/repositories/
│       └── profile_repository.dart     ← split from other_repositories.dart
│
└── shared/
    └── providers/
        ├── isar_provider.dart          ← existing
        ├── theme_provider.dart         ← existing
        ├── notifications_provider.dart ← existing (keep or replace with service)
        ├── repository_providers.dart   ← NEW
        └── ui_state_providers.dart     ← NEW
```

> **Note:** `other_repositories.dart` bundles GoalRepository + MoodRepository + ProfileRepository
> for convenience. Split them into their respective `data/repositories/` folders
> before running build_runner.

---

## Bootstrap changes — `main.dart`

Replace your existing `main.dart` with `main_updated.dart`.  Key additions:

1. `NotificationService.init()` called before `runApp`.
2. `notificationServiceProvider` overridden in `ProviderScope`.
3. `_onAppStart()` runs after first frame:
   - `getOrCreateProfile()` — seeds the user record.
   - `onStreakUpdated()` — refreshes streak counter.
   - `scheduleDailyStreakReminder()` — sets the daily push notification.

---

## Design decisions

### Why repositories don't call `GamificationService` directly
Repositories are pure data-access — they know nothing about XP or badges.
Callers (providers / services) compose both layers:
```dart
await taskRepo.updateTask(task);
await gamificationService.onTaskCompleted(...);
```

### Why `PomodoroNotifier` is a `Notifier` not `AsyncNotifier`
The timer state itself is fully synchronous (a countdown integer).
Background work (save session, award XP) is fire-and-forget via `unawaited`
to avoid blocking the 1-second tick loop.

### `TaskFilter` lives in providers, not repositories
Repositories return raw Isar streams.  Filter composition is a UI concern owned
by `_TaskFilterNotifier`.  This keeps repositories testable without UI deps.

### `DailyFocusSummary` lives in `FocusRepository`
It is computed from raw Isar data and has no UI imports — the chart widget
receives it as a plain Dart object.  Moving it to the provider layer would
introduce an unnecessary indirection.
