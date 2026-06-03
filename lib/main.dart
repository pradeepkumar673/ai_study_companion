// lib/main.dart
//
// StudySpark — App entry point (Step 3 updated)
//
// Bootstrap order:
//   1. Flutter bindings
//   2. Isar database           → bootstrapIsar()
//   3. NotificationService     → NotificationService.init()
//   4. SharedPreferences       → SharedPreferences.getInstance()
//   5. Mount ProviderScope with provider overrides
//   6. Kick off one-time startup tasks (streak refresh, badge seed)
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/services/notification_service.dart';
import 'shared/providers/isar_provider.dart';
import 'shared/providers/repository_providers.dart';
import 'shared/providers/theme_provider.dart';

// ─── Entry point ──────────────────────────────────────────────────────────────

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Open Isar database.
  final isar = await bootstrapIsar();

  // 2. Initialise local notifications plugin.
  final notificationService = await NotificationService.init();

  // 3. Load SharedPreferences (used by ThemeModeNotifier).
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        // ── Required overrides ────────────────────────────────────────────
        isarProvider.overrideWithValue(isar),
        notificationServiceProvider.overrideWithValue(notificationService),
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const StudySparkApp(),
    ),
  );
}

// ─── Root Widget ──────────────────────────────────────────────────────────────

class StudySparkApp extends ConsumerStatefulWidget {
  const StudySparkApp({super.key});

  @override
  ConsumerState<StudySparkApp> createState() => _StudySparkAppState();
}

class _StudySparkAppState extends ConsumerState<StudySparkApp> {
  @override
  void initState() {
    super.initState();
    // Run one-time startup tasks after the first frame renders so the
    // ProviderScope is fully mounted before reading providers.
    WidgetsBinding.instance.addPostFrameCallback((_) => _onAppStart());
  }

  Future<void> _onAppStart() async {
    // Ensure the user profile record exists (creates with defaults if new).
    final profile = ref.read(profileRepositoryProvider);
    await profile.getOrCreateProfile();

    // Refresh the study streak counter.
    final gamification = ref.read(gamificationServiceProvider);
    await gamification.onStreakUpdated();

    // Seed default badge records if the collection is empty.
    // TODO: call BadgeSeedService.seed(ref) once implemented.

    // Schedule the daily streak reminder notification.
    final notif = ref.read(notificationServiceProvider);
    await notif.scheduleDailyStreakReminder(hour: 20, minute: 0);
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'StudySpark',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
