// lib/core/router/app_router.dart
//
// StudySpark — Declarative routing with GoRouter 14.
// Shell-route wraps the bottom-nav scaffold; feature routes are nested under it.
// Deep-link paths documented with each route.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Screens — Shell (scaffold with bottom nav)
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/tasks/presentation/screens/tasks_screen.dart';
import '../../features/tasks/presentation/screens/task_detail_screen.dart';
import '../../features/schedule/presentation/screens/schedule_screen.dart';
import '../../features/focus/presentation/screens/focus_screen.dart';
import '../../features/notes/presentation/screens/notes_screen.dart';
import '../../features/notes/presentation/screens/note_editor_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../shared/widgets/main_shell.dart';

// Onboarding / Auth screens
import '../../features/dashboard/presentation/screens/onboarding_screen.dart';
import '../../features/dashboard/presentation/screens/splash_screen.dart';

part 'app_router.g.dart';

// ─── Route Name Constants ─────────────────────────────────────────────────────
abstract final class AppRoutes {
  // Top-level
  static const splash      = 'splash';
  static const onboarding  = 'onboarding';

  // Shell tabs
  static const dashboard   = 'dashboard';
  static const tasks       = 'tasks';
  static const schedule    = 'schedule';
  static const focus       = 'focus';
  static const notes       = 'notes';
  static const profile     = 'profile';

  // Sub-routes
  static const taskDetail  = 'task-detail';
  static const noteEditor  = 'note-editor';
}

// ─── Route Path Constants ─────────────────────────────────────────────────────
abstract final class AppPaths {
  static const splash      = '/';
  static const onboarding  = '/onboarding';
  static const dashboard   = '/dashboard';
  static const tasks       = '/tasks';
  static const taskDetail  = '/tasks/:taskId';      // deep-link: /tasks/abc-123
  static const schedule    = '/schedule';
  static const focus       = '/focus';
  static const notes       = '/notes';
  static const noteEditor  = '/notes/editor';       // query: ?noteId=xyz (edit) or none (create)
  static const profile     = '/profile';
}

/// Riverpod provider that exposes the router instance.
/// Using [@riverpod] keeps the router alive for the app lifetime.
@Riverpod(keepAlive: true)
GoRouter appRouter(AppRouterRef ref) {
  // TODO: inject auth state provider here for redirect guards
  // final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: AppPaths.splash,
    debugLogDiagnostics: true,   // set false in production

    // ── Global redirect guard ──────────────────────────────────────────────
    redirect: (BuildContext context, GoRouterState state) {
      // TODO: redirect unauthenticated users to onboarding
      // if (!authState.isLoggedIn && state.uri.path != AppPaths.onboarding) {
      //   return AppPaths.onboarding;
      // }
      return null; // no redirect — allow all for now
    },

    // ── Error screen ──────────────────────────────────────────────────────
    errorBuilder: (context, state) => _ErrorScreen(error: state.error),

    routes: [
      // ── 1. Splash ────────────────────────────────────────────────────────
      GoRoute(
        name: AppRoutes.splash,
        path: AppPaths.splash,
        builder: (context, state) => const SplashScreen(),
      ),

      // ── 2. Onboarding ────────────────────────────────────────────────────
      GoRoute(
        name: AppRoutes.onboarding,
        path: AppPaths.onboarding,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const OnboardingScreen(),
          transitionsBuilder: _fadeSlideTransition,
        ),
      ),

      // ── 3. Shell (bottom navigation scaffold) ────────────────────────────
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => MainShell(
          navigationShell: navigationShell,
        ),
        branches: [
          // Branch 0 — Dashboard
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRoutes.dashboard,
                path: AppPaths.dashboard,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const DashboardScreen(),
                ),
              ),
            ],
          ),

          // Branch 1 — Tasks
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
                  // Sub-route: task detail /tasks/:taskId
                  GoRoute(
                    name: AppRoutes.taskDetail,
                    path: ':taskId',
                    pageBuilder: (context, state) {
                      final taskId = state.pathParameters['taskId']!;
                      return CustomTransitionPage(
                        key: state.pageKey,
                        child: TaskDetailScreen(taskId: taskId),
                        transitionsBuilder: _fadeSlideTransition,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),

          // Branch 2 — Schedule
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRoutes.schedule,
                path: AppPaths.schedule,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const ScheduleScreen(),
                ),
              ),
            ],
          ),

          // Branch 3 — Focus Timer
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRoutes.focus,
                path: AppPaths.focus,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const FocusScreen(),
                ),
              ),
            ],
          ),

          // Branch 4 — Notes
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
                  // Sub-route: note editor /notes/editor?noteId=...
                  GoRoute(
                    name: AppRoutes.noteEditor,
                    path: 'editor',
                    pageBuilder: (context, state) {
                      final noteId = state.uri.queryParameters['noteId'];
                      return CustomTransitionPage(
                        key: state.pageKey,
                        child: NoteEditorScreen(noteId: noteId),
                        transitionsBuilder: _fadeSlideTransition,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),

          // Branch 5 — Profile
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

// ─── Transition Builders ──────────────────────────────────────────────────────

/// Fade + upward slide — used for detail/editor screens.
Widget _fadeSlideTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  const begin = Offset(0, 0.04);
  const end   = Offset.zero;
  const curve = Curves.easeOutCubic;

  return FadeTransition(
    opacity: CurvedAnimation(parent: animation, curve: curve),
    child: SlideTransition(
      position: Tween(begin: begin, end: end).animate(
        CurvedAnimation(parent: animation, curve: curve),
      ),
      child: child,
    ),
  );
}

// ─── Fallback Error Screen ────────────────────────────────────────────────────
class _ErrorScreen extends StatelessWidget {
  final Exception? error;
  const _ErrorScreen({this.error});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: cs.errorContainer,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline_rounded, size: 64, color: cs.error),
              const SizedBox(height: 16),
              Text(
                'Page Not Found',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: cs.onErrorContainer,
                ),
              ),
              if (error != null) ...[
                const SizedBox(height: 8),
                Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: cs.onErrorContainer.withOpacity(0.7),
                  ),
                ),
              ],
              const SizedBox(height: 24),
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
