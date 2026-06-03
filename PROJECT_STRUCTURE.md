# StudySpark — Project Structure & Architecture Guide

```
studyspark/
│
├── lib/
│   │
│   ├── main.dart                          ← App entry point; bootstraps Isar, notifications,
│   │                                         SharedPreferences, and mounts ProviderScope
│   │
│   ├── core/                              ← App-wide, feature-agnostic infrastructure
│   │   ├── theme/
│   │   │   └── app_theme.dart             ← ALL design tokens: colors, typography, spacing,
│   │   │                                     shadows, shapes, animation durations, and full
│   │   │                                     Material 3 ThemeData for light + dark modes
│   │   │
│   │   ├── router/
│   │   │   ├── app_router.dart            ← GoRouter config: all routes, shell branches,
│   │   │   │                                 redirect guards, transition builders
│   │   │   └── app_router.g.dart          ← [generated] Riverpod @riverpod code-gen output
│   │   │
│   │   ├── constants/
│   │   │   ├── app_constants.dart         ← App-wide magic numbers (Pomodoro durations,
│   │   │   │                                 max subtasks, API timeouts, etc.)
│   │   │   └── assets_constants.dart      ← Type-safe asset path strings
│   │   │
│   │   └── utils/
│   │       ├── date_utils.dart            ← Date formatting helpers (intl)
│   │       ├── validators.dart            ← Form validation functions
│   │       ├── color_utils.dart           ← Hex ↔ Color converters, subject color picker
│   │       └── logger.dart               ← Configured Logger instance (pretty-print)
│   │
│   ├── features/                          ← Vertical feature slices (one folder per screen group)
│   │   │
│   │   ├── dashboard/                     ← Home screen with overview stats
│   │   │   ├── data/
│   │   │   │   └── repositories/
│   │   │   │       └── dashboard_repository.dart   ← Aggregates data from other features
│   │   │   └── presentation/
│   │   │       ├── screens/
│   │   │       │   ├── splash_screen.dart           ← Animated brand splash + routing logic
│   │   │       │   ├── onboarding_screen.dart       ← 3-step PageView onboarding
│   │   │       │   └── dashboard_screen.dart        ← Stats cards, today's tasks, schedule,
│   │   │       │                                       AI study tip, progress chart
│   │   │       ├── widgets/
│   │   │       │   ├── stats_card.dart              ← Animated metric card (tasks/focus/streak)
│   │   │       │   ├── progress_ring.dart           ← Circular daily goal indicator
│   │   │       │   ├── today_tasks_list.dart        ← Compact task preview list
│   │   │       │   ├── upcoming_events_strip.dart   ← Horizontal schedule preview
│   │   │       │   └── ai_tip_card.dart             ← AI study tip with HF placeholder
│   │   │       └── providers/
│   │   │           └── dashboard_provider.dart      ← Aggregated async state
│   │   │
│   │   ├── tasks/                         ← Full task management (CRUD + subtasks + reminders)
│   │   │   ├── data/
│   │   │   │   ├── models/
│   │   │   │   │   ├── task_model.dart              ← Isar @collection (TaskModel)
│   │   │   │   │   └── task_model.g.dart            ← [generated]
│   │   │   │   └── repositories/
│   │   │   │       └── task_repository.dart         ← Isar CRUD + stream queries + search
│   │   │   └── presentation/
│   │   │       ├── screens/
│   │   │       │   ├── tasks_screen.dart            ← Filterable task list with Kanban/List view
│   │   │       │   └── task_detail_screen.dart      ← Full task view + subtask checklist + timer
│   │   │       ├── widgets/
│   │   │       │   ├── task_card.dart               ← Swipeable card (complete/delete)
│   │   │       │   ├── task_filter_bar.dart         ← Priority/status/subject chips
│   │   │       │   ├── add_task_sheet.dart          ← Bottom sheet form (ReactiveForm)
│   │   │       │   ├── subtask_list.dart            ← Reorderable checklist
│   │   │       │   └── priority_badge.dart          ← Color-coded priority indicator
│   │   │       └── providers/
│   │   │           ├── tasks_provider.dart          ← Stream of tasks from Isar
│   │   │           └── task_filter_provider.dart    ← Filter/sort state notifier
│   │   │
│   │   ├── schedule/                      ← Weekly calendar + event management
│   │   │   ├── data/
│   │   │   │   ├── models/
│   │   │   │   │   ├── schedule_event_model.dart    ← Isar @collection (ScheduleEventModel)
│   │   │   │   │   └── schedule_event_model.g.dart  ← [generated]
│   │   │   │   └── repositories/
│   │   │   │       └── schedule_repository.dart     ← Isar queries by date range
│   │   │   └── presentation/
│   │   │       ├── screens/
│   │   │       │   └── schedule_screen.dart         ← Horizontal week strip + timeline view
│   │   │       ├── widgets/
│   │   │       │   ├── week_strip.dart              ← Scrollable day selector
│   │   │       │   ├── event_timeline.dart          ← Hour-by-hour event display
│   │   │       │   ├── event_card.dart              ← Color-coded event chip
│   │   │       │   └── add_event_sheet.dart         ← Event creation bottom sheet
│   │   │       └── providers/
│   │   │           └── schedule_provider.dart       ← Selected date + events for day
│   │   │
│   │   ├── focus/                         ← Pomodoro + deep-work focus timer
│   │   │   ├── data/
│   │   │   │   ├── models/
│   │   │   │   │   ├── focus_session_model.dart     ← Isar @collection (FocusSessionModel)
│   │   │   │   │   └── focus_session_model.g.dart   ← [generated]
│   │   │   │   └── repositories/
│   │   │   │       └── focus_repository.dart        ← Save/query sessions; compute streaks
│   │   │   └── presentation/
│   │   │       ├── screens/
│   │   │       │   └── focus_screen.dart            ← Animated ring timer + mode selector
│   │   │       ├── widgets/
│   │   │       │   ├── focus_ring.dart              ← Animated circular progress arc
│   │   │       │   ├── mode_selector.dart           ← Pomodoro / Short / Deep Work chips
│   │   │       │   ├── session_stats_card.dart      ← Today's session count & total minutes
│   │   │       │   └── focus_history_chart.dart     ← fl_chart bar chart (last 7 days)
│   │   │       └── providers/
│   │   │           ├── focus_timer_provider.dart    ← CountdownTimer state machine
│   │   │           └── focus_history_provider.dart  ← Weekly session analytics
│   │   │
│   │   ├── notes/                         ← Rich-text note-taking with AI summarization
│   │   │   ├── data/
│   │   │   │   ├── models/
│   │   │   │   │   ├── note_model.dart              ← Isar @collection (NoteModel)
│   │   │   │   │   └── note_model.g.dart            ← [generated]
│   │   │   │   └── repositories/
│   │   │   │       └── note_repository.dart         ← Isar CRUD + full-text search
│   │   │   └── presentation/
│   │   │       ├── screens/
│   │   │       │   ├── notes_screen.dart            ← Masonry grid of note cards
│   │   │       │   └── note_editor_screen.dart      ← Rich-text editor + AI summary button
│   │   │       ├── widgets/
│   │   │       │   ├── note_card.dart               ← Colored card with preview text
│   │   │       │   ├── ai_summary_sheet.dart        ← Bottom sheet showing HF summary
│   │   │       │   └── tag_input.dart               ← Chip-based tag input field
│   │   │       └── providers/
│   │   │           ├── notes_provider.dart          ← Stream of notes
│   │   │           └── note_editor_provider.dart    ← Draft state for the editor
│   │   │
│   │   └── profile/                       ← User profile, stats, settings, theme toggle
│   │       ├── data/
│   │       │   ├── models/
│   │       │   │   ├── user_profile_model.dart      ← Isar @collection (UserProfileModel)
│   │       │   │   └── user_profile_model.g.dart    ← [generated]
│   │       │   └── repositories/
│   │       │       └── profile_repository.dart      ← Read/write singleton profile record
│   │       └── presentation/
│   │           ├── screens/
│   │           │   └── profile_screen.dart          ← Avatar, stats, settings, theme toggle
│   │           ├── widgets/
│   │           │   ├── achievement_badge.dart       ← Gamification badge widget
│   │           │   ├── stats_overview.dart          ← Focus minutes / tasks / streak cards
│   │           │   └── settings_section.dart        ← Grouped settings list tiles
│   │           └── providers/
│   │               └── profile_provider.dart        ← UserProfile async notifier
│   │
│   └── shared/                            ← Cross-feature widgets and providers
│       ├── widgets/
│       │   ├── main_shell.dart            ← Bottom nav scaffold (StatefulShellRoute)
│       │   ├── app_card.dart              ← Styled Card wrapper with consistent shadow/radius
│       │   ├── gradient_button.dart       ← Branded gradient FilledButton
│       │   ├── subject_tag.dart           ← Colored subject chip with dot indicator
│       │   ├── empty_state.dart           ← Illustration + message for empty lists
│       │   ├── loading_shimmer.dart       ← Shimmer skeleton for async loading states
│       │   ├── confirmation_dialog.dart   ← Reusable yes/no dialog
│       │   └── spark_text_field.dart      ← Styled TextFormField with validation
│       │
│       └── providers/
│           ├── isar_provider.dart         ← Isar singleton (overridden in ProviderScope)
│           ├── theme_provider.dart        ← ThemeMode notifier + isDarkMode helper
│           └── notifications_provider.dart ← NotificationService + plugin provider
│
├── assets/
│   ├── images/                            ← PNG illustrations (onboarding, empty states)
│   ├── icons/                             ← SVG icons for subjects and custom ui
│   └── animations/                        ← Lottie JSON (focus complete, streak, confetti)
│
├── test/
│   ├── unit/                              ← Repository and provider unit tests
│   ├── widget/                            ← Widget tests for key UI components
│   └── integration/                       ← End-to-end integration tests
│
├── pubspec.yaml                           ← All dependencies (see comments for rationale)
└── analysis_options.yaml                  ← Strict lint rules (flutter_lints + extras)
```

---

## Architecture Decision Notes

### State Management (Riverpod 2 + code-gen)
- Every feature has its own `providers/` folder — no global god-state
- Async data (Isar streams) uses `StreamProvider` / `AsyncNotifierProvider`
- UI-only ephemeral state (e.g. selected filter tab) uses `StateProvider`
- `@riverpod` annotation generates boilerplate; run `build_runner` after changes

### Navigation (GoRouter 14)
- `StatefulShellRoute.indexedStack` keeps all tab states alive simultaneously
- Sub-routes (task detail, note editor) live *inside* the branch for correct back-stack
- `redirect` guard in `app_router.dart` enforces onboarding before dashboard access
- Route names as constants in `AppRoutes` prevent magic-string typos

### Database (Isar 3)
- One collection per domain model — no shared tables
- All queries return `Stream<T>` so UI rebuilds reactively on data changes
- `uuid` field on every model enables deep-linking and notification payload parsing

### AI Integration (Hugging Face — placeholder)
- All AI features are stubbed with `// TODO: HuggingFace [model]` comments
- Network calls go through a `HuggingFaceService` (Dio + Retrofit) in `core/`
- AI results are cached in the Isar model (e.g. `NoteModel.aiSummary`)
- Models to integrate: `facebook/bart-large-cnn` (summarize), `deepset/roberta-base-squad2` (Q&A), `sentence-transformers/all-MiniLM-L6-v2` (semantic search)

### Theming
- `AppTheme.light` / `AppTheme.dark` are the single source of truth
- All raw hex values live in `AppColors` — never hardcode colors elsewhere
- Component overrides centralized in `_applyComponentThemes()` — one place to update
- `ThemeModeNotifier` persists choice to `SharedPreferences` and exposes `.toggle()`
