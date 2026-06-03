# StudySpark UI — Step 4 Delivery
## Splash · Onboarding · Bottom Nav · GoRouter

---

## 📁 Files Generated

```
lib/
├── core/router/
│   └── app_router.dart              ← ✅ REPLACE (full GoRouter config)
│
├── features/
│   ├── dashboard/presentation/screens/
│   │   ├── splash_screen.dart       ← ✅ REPLACE (premium animated splash)
│   │   ├── onboarding_screen.dart   ← ✅ REPLACE (4-slide illustrated onboarding)
│   │   └── dashboard_screen.dart   ← ✅ NEW placeholder (wire up in Step 5)
│   │
│   ├── tasks/presentation/screens/
│   │   ├── tasks_screen.dart        ← ✅ NEW placeholder
│   │   └── task_detail_screen.dart  ← ✅ NEW placeholder
│   │
│   ├── notes/presentation/screens/
│   │   ├── notes_screen.dart        ← ✅ NEW placeholder
│   │   └── note_editor_screen.dart  ← ✅ NEW placeholder
│   │
│   ├── analytics/presentation/
│   │   └── screens/
│   │       └── analytics_screen.dart ← ✅ NEW (full analytics UI with charts)
│   │
│   └── profile/presentation/screens/
│       └── profile_screen.dart      ← ✅ NEW (full profile UI)
│
└── shared/widgets/
    └── main_shell.dart              ← ✅ REPLACE (glassmorphism nav bar)
```

---

## 🆕 New Feature: Analytics Tab

The router now uses **5 tabs** (Home · Tasks · Notes · **Analytics** · Profile)
instead of the previous 6 (which included Schedule and Focus as separate tabs).

> If you prefer to restore Schedule / Focus as separate tabs, update `_navItems` in
> `main_shell.dart` and add branches in `app_router.dart` following the same pattern.

---

## 🔗 Integration Checklist

### 1. Add the `analytics` feature folder
```
lib/features/analytics/
└── presentation/
    └── screens/
        └── analytics_screen.dart   ← provided
```

### 2. Update `app_router.dart` imports
The new router imports `analytics_screen.dart`. Make sure the path exists.

### 3. Update `sharedPreferencesProvider`
Both `splash_screen.dart` and `onboarding_screen.dart` read:
```dart
final prefs = ref.read(sharedPreferencesProvider);
```
This provider already exists in your `lib/shared/providers/isar_provider.dart`.

### 4. Run build_runner after replacing `app_router.dart`
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```
This regenerates `app_router.g.dart` (the `@riverpod` code-gen output).

### 5. `extendBody: true` in MainShell
The new `MainShell` sets `extendBody: true` so content flows under the
glassmorphism nav bar. Add bottom padding (`100px`) to any `ListView` / 
`CustomScrollView` in tab screens to prevent content from being hidden.

---

## 🎨 Design Highlights

### Splash Screen
- **Animated gradient background** — subtle shifting warm/cool gradient
- **Orbiting particle dots** — 4 dots orbit the center logo continuously  
- **Pulsing glow ring** — soft breathing effect around the logo icon
- **Staggered text reveal** — logo → brand name → tagline → progress bar
- **Animated progress bar** — fills over 2s; routes after 2.8s

### Onboarding (4 Slides)
| Slide | Theme | Accent |
|---|---|---|
| 1 | All-in-One Study Hub | Electric Violet `#6C4FF8` |
| 2 | Deep Focus Mode | Sky Teal `#00BFAE` |
| 3 | AI Study Assistant | Sunset Orange `#FF6B3D` |
| 4 | Level Up & Earn Rewards | Amber `#FFB547` |

- **Floating icon illustrations** — each slide has 5 orbiting feature icons
- **Animated background** — color transitions between slides
- **Grid mesh overlay** — subtle texture layer
- **Page indicator pills** — active pill expands with glow
- **Skip button** — pill-shaped, always visible

### Bottom Navigation Bar
- **Glassmorphism** — `BackdropFilter` blur + semi-transparent surface
- **Animated pill indicator** — active item gets a `primaryContainer` pill
- **Scale press animation** — each item bounces on tap
- **Context-aware FAB** — appears only on Tasks (+ Add Task) and Notes (+ New Note)
- **`extendBody: true`** — content flows under the translucent bar

### GoRouter
- **5 branches**: Dashboard · Tasks · Notes · Analytics · Profile
- **Sub-routes**: `/tasks/:taskId`, `/notes/editor?noteId=`
- **Custom transitions**: `_fadeSlideTransition` (onboarding), `_slideUpTransition` (detail screens)
- **No-transition** on tab switches (instantaneous feel)
- **404 screen** with branded error UI and "Go Home" button
- **Helper methods**: `AppPaths.taskDetailPath(id)`, `AppPaths.noteEditorPath(noteId: id)`

---

## 🚀 Next Steps (Step 5)

Wire up the placeholder screens to real Isar data:

1. **DashboardScreen** — `DashboardRepository`, streak widget, today's tasks strip
2. **TasksScreen** — `watchAllTasks()` stream, filter bar, swipeable task cards
3. **NotesScreen** — `watchAllNotes()` stream, masonry grid, search
4. **AnalyticsScreen** — Replace skeleton bars with `fl_chart` connected to `FocusRepository`
5. **ProfileScreen** — Connect `profileRepositoryProvider`, theme toggle, badge grid
