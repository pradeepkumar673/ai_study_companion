// lib/core/router/app_router.dart
//
// StudySpark — Declarative routing (GoRouter 14).
//
// Route architecture:
//   /                 → SplashScreen          (checks onboarding flag)
//   /onboarding       → OnboardingScreen      (first-launch only)
//   /dashboard        → DashboardScreen       ┐
//   /tasks            → TasksScreen           │  StatefulShellRoute
//   /tasks/:taskId    → TaskDetailScreen      │  (indexed stack,
//   /notes            → NotesScreen           │   keeps tab state)
//   /notes/editor     → NoteEditorScreen      │
//   /analytics        → AnalyticsScreen       │
//   /profile          → ProfileScreen         ┘
//
// All sub-routes (detail screens, editors) live inside their branch so the
// back button restores the correct tab context.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// ── Shell / Navigation ──────────────────────────────────────────────────────
import '../../shared/widgets/main_shell.dart';

// ── Splash & Onboarding ─────────────────────────────────────────────────────
import '../../features/dashboard/presentation/screens/splash_screen.dart';
import '../../features/dashboard/presentation/screens/onboarding_screen.dart';

// ── Dashboard (Home tab) ────────────────────────────────────────────────────
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';

// ── Tasks tab ───────────────────────────────────────────────────────────────
import '../../features/tasks/presentation/screens/tasks_screen.dart';
import '../../features/tasks/presentation/screens/task_detail_screen.dart';

// ── Notes tab ───────────────────────────────────────────────────────────────
import '../../features/notes/presentation/screens/notes_screen.dart';
import '../../features/notes/presentation/screens/note_editor_screen.dart';
import '../../features/notes/presentation/screens/pdf_viewer_screen.dart';

// ── Focus sub-screens (Step 5) ──────────────────────────────────────────────
import '../../features/focus/presentation/screens/pomodoro_timer_screen.dart';
import '../../features/focus/presentation/screens/focus_mode_screen.dart';

// ── Analytics tab ───────────────────────────────────────────────────────────
import '../../features/analytics/presentation/screens/analytics_screen.dart';

// ── Profile tab ─────────────────────────────────────────────────────────────
import '../../features/profile/presentation/screens/profile_screen.dart';

part 'app_router.g.dart';

// ─── Route Name Constants ─────────────────────────────────────────────────────

abstract final class AppRoutes {
  // Top-level (outside shell)
  static const splash     = 'splash';
  static const onboarding = 'onboarding';

  // Shell tabs (branch roots)
  static const dashboard  = 'dashboard';
  static const tasks      = 'tasks';
  static const notes      = 'notes';
  static const analytics  = 'analytics';
  static const profile    = 'profile';

  // Sub-routes (nested within their branch)
  static const taskDetail = 'task-detail';
  static const noteEditor = 'note-editor';
}

// ─── Route Path Constants ─────────────────────────────────────────────────────

abstract final class AppPaths {
  // Top-level
  static const splash     = '/';
  static const onboarding = '/onboarding';

  // Shell tab roots
  static const dashboard  = '/dashboard';
  static const tasks      = '/tasks';
  static const notes      = '/notes';
  static const analytics  = '/analytics';
  static const profile    = '/profile';

  // Sub-routes (deep-linkable)
  static const taskDetail = '/tasks/:taskId';   // → /tasks/abc-123
  static const noteEditor = '/notes/editor';    // query: ?noteId=xyz (edit) | none (create)

  // Helper for programmatic navigation
  static String taskDetailPath(String taskId) => '/tasks/$taskId';
  static String noteEditorPath({String? noteId}) =>
      noteId != null ? '/notes/editor?noteId=$noteId' : '/notes/editor';
}

// ─── Router Provider ──────────────────────────────────────────────────────────

/// Riverpod provider that creates and exposes the GoRouter singleton.
/// `keepAlive: true` ensures the router lives for the entire app lifetime.
@Riverpod(keepAlive: true)
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    initialLocation: AppPaths.splash,
    debugLogDiagnostics: true, // set false before production build

    // ── Global redirect guard ────────────────────────────────────────────
    redirect: (BuildContext context, GoRouterState state) {
      // TODO: uncomment when auth layer is implemented
      // final isAuthed = ref.read(authStateProvider).isAuthenticated;
      // final isOnboarding = state.uri.path == AppPaths.onboarding;
      // final isSplash = state.uri.path == AppPaths.splash;
      //
      // if (!isAuthed && !isOnboarding && !isSplash) {
      //   return AppPaths.onboarding;
      // }
      return null; // allow all — guarded by SplashScreen routing logic
    },

    // ── 404 Error screen ─────────────────────────────────────────────────
    errorBuilder: (context, state) => _RouteErrorScreen(error: state.error),

    routes: [
      // ── 1. Splash (initial route) ──────────────────────────────────────
      GoRoute(
        name: AppRoutes.splash,
        path: AppPaths.splash,
        builder: (context, state) => const SplashScreen(),
      ),

      // ── 2. Onboarding ──────────────────────────────────────────────────
      GoRoute(
        name: AppRoutes.onboarding,
        path: AppPaths.onboarding,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const OnboardingScreen(),
          transitionsBuilder: _fadeSlideTransition,
        ),
      ),

      // ── 3. Shell — indexed tab stack ───────────────────────────────────
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainShell(navigationShell: navigationShell),

        branches: [
          // ── Branch 0: Dashboard (Home) ─────────────────────────────────
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRoutes.dashboard,
                path: AppPaths.dashboard,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const DashboardScreen(),
                ),
                routes: [
                  // ── Step 5: Pomodoro Timer (/dashboard → /focus/timer) ──
                  GoRoute(
                    path: 'focus/timer',
                    name: 'pomodoroTimer',
                    builder: (context, state) => const PomodoroTimerScreen(),
                  ),
                  // ── Step 5: Focus Mode (/dashboard → /focus/mode) ───────
                  GoRoute(
                    path: 'focus/mode',
                    name: 'focusMode',
                    pageBuilder: (context, state) => NoTransitionPage(
                      key: state.pageKey,
                      child: const FocusModeScreen(),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // ── Branch 1: Tasks ────────────────────────────────────────────
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRoutes.tasks,
                path: AppPaths.tasks,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const TasksScreen(),
                ),
                routes: [
                  // Detail: /tasks/:taskId
                  GoRoute(
                    name: AppRoutes.taskDetail,
                    path: ':taskId',
                    pageBuilder: (context, state) {
                      final taskId = state.pathParameters['taskId']!;
                      return CustomTransitionPage(
                        key: state.pageKey,
                        child: TaskDetailScreen(taskId: taskId),
                        transitionsBuilder: _slideUpTransition,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),

          // ── Branch 2: Notes ────────────────────────────────────────────
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRoutes.notes,
                path: AppPaths.notes,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const NotesScreen(),
                ),
                routes: [
                  // Editor: /notes/editor?noteId=xyz (optional)
                  GoRoute(
                    name: AppRoutes.noteEditor,
                    path: 'editor',
                    pageBuilder: (context, state) {
                      final noteId = state.uri.queryParameters['noteId'];
                      return CustomTransitionPage(
                        key: state.pageKey,
                        child: NoteEditorScreen(noteId: noteId),
                        transitionsBuilder: _slideUpTransition,
                      );
                    },
                  ),
                  // New in Step 5 Notes Feature
                  GoRoute(
                    path: 'new',
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const NoteEditorScreen(),
                      transitionsBuilder: _slideUpTransition,
                    ),
                  ),
                  GoRoute(
                    path: 'pdf',
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const PdfViewerScreen(),
                      transitionsBuilder: _slideUpTransition,
                    ),
                  ),
                  GoRoute(
                    path: ':noteId',
                    pageBuilder: (context, state) {
                      final noteId = state.pathParameters['noteId'];
                      return CustomTransitionPage(
                        key: state.pageKey,
                        child: NoteEditorScreen(noteId: noteId),
                        transitionsBuilder: _slideUpTransition,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),

          // ── Branch 3: Analytics ────────────────────────────────────────
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRoutes.analytics,
                path: AppPaths.analytics,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const AnalyticsScreen(),
                ),
              ),
            ],
          ),

          // ── Branch 4: Profile ──────────────────────────────────────────
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRoutes.profile,
                path: AppPaths.profile,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const ProfileScreen(),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

// ─── Custom Page Transitions ──────────────────────────────────────────────────

/// Fade + slight upward slide — used for onboarding and full-screen modals.
Widget _fadeSlideTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return FadeTransition(
    opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
    child: SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.05),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
      child: child,
    ),
  );
}

/// Slide up — used for detail screens and editors.
Widget _slideUpTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
    child: FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: const Interval(0, 0.5, curve: Curves.easeOut),
      ),
      child: child,
    ),
  );
}

// ─── 404 Error Screen ─────────────────────────────────────────────────────────

class _RouteErrorScreen extends StatelessWidget {
  const _RouteErrorScreen({required this.error});
  final Exception? error;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: cs.errorContainer,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Icon(
                  Icons.link_off_rounded,
                  color: cs.error,
                  size: 40,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Page Not Found',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: cs.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "The route you're looking for doesn't exist.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: cs.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: () => context.go(AppPaths.dashboard),
                icon: const Icon(Icons.home_rounded),
                label: const Text('Go Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
