// lib/main.dart
//
// StudySpark — Application entry point.
//
// Responsibilities:
//  1. Bootstrap Isar database
//  2. Initialize shared preferences & timezone data
//  3. Configure Flutter local notifications
//  4. Wrap the widget tree with ProviderScope (Riverpod)
//  5. Mount StudySparkApp which wires GoRouter + Material 3 themes

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'shared/providers/isar_provider.dart';
import 'shared/providers/theme_provider.dart';
import 'shared/providers/notifications_provider.dart';

// ── Isar schema imports (add each model here after isar_generator runs) ─────
import 'features/tasks/data/models/task_model.dart';
import 'features/notes/data/models/note_model.dart';
import 'features/schedule/data/models/schedule_event_model.dart';
import 'features/focus/data/models/focus_session_model.dart';
import 'features/profile/data/models/user_profile_model.dart';

// ─── Notification plugin singleton ───────────────────────────────────────────
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// ─── App Entry Point ──────────────────────────────────────────────────────────
void main() async {
  // Ensure bindings are initialized before any platform channel calls.
  WidgetsFlutterBinding.ensureInitialized();

  // ── System UI Chrome ──────────────────────────────────────────────────────
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark, // overridden per-theme later
  ));

  // ── Parallel async init ────────────────────────────────────────────────────
  final (isar, prefs) = await (
    _initIsar(),
    SharedPreferences.getInstance(),
  ).wait;

  // ── Timezone ──────────────────────────────────────────────────────────────
  tz.initializeTimeZones();
  // TODO: detect device local timezone via flutter_timezone package
  // final localTz = await FlutterTimezone.getLocalTimezone();
  // tz.setLocalLocation(tz.getLocation(localTz));

  // ── Local Notifications ───────────────────────────────────────────────────
  await _initNotifications();

  // ── Launch App ────────────────────────────────────────────────────────────
  runApp(
    ProviderScope(
      overrides: [
        // Inject bootstrapped singletons into Riverpod
        isarProvider.overrideWithValue(isar),
        sharedPreferencesProvider.overrideWithValue(prefs),
        notificationsPluginProvider.overrideWithValue(
          flutterLocalNotificationsPlugin,
        ),
      ],
      child: const StudySparkApp(),
    ),
  );
}

// ─── Isar Initialization ─────────────────────────────────────────────────────
Future<Isar> _initIsar() async {
  final dir = await getApplicationDocumentsDirectory();
  return Isar.open(
    [
      // Register all collection schemas here
      TaskModelSchema,
      NoteModelSchema,
      ScheduleEventModelSchema,
      FocusSessionModelSchema,
      UserProfileModelSchema,
    ],
    directory: dir.path,
    name: 'studyspark_db',
    inspector: true, // set false for production builds
  );
}

// ─── Notification Initialization ─────────────────────────────────────────────
Future<void> _initNotifications() async {
  const androidSettings = AndroidInitializationSettings(
    '@mipmap/ic_launcher', // use a custom monochrome icon in production
  );
  const darwinSettings = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );
  const initSettings = InitializationSettings(
    android: androidSettings,
    iOS: darwinSettings,
    macOS: darwinSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initSettings,
    onDidReceiveNotificationResponse: _onNotificationTap,
    onDidReceiveBackgroundNotificationResponse: _onNotificationTap,
  );
}

/// Called when user taps a local notification.
/// Uses the payload to deep-link into the app.
@pragma('vm:entry-point')
void _onNotificationTap(NotificationResponse response) {
  // TODO: parse response.payload and navigate via GoRouter
  // e.g. payload = 'task:abc-123' → navigate to task detail
  debugPrint('[Notification] tapped: ${response.payload}');
}

// ─── Root Widget ─────────────────────────────────────────────────────────────
class StudySparkApp extends ConsumerWidget {
  const StudySparkApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to theme mode preference stored in SharedPreferences
    final themeMode = ref.watch(themeModeProvider);

    // GoRouter instance from Riverpod
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      // ── Identity ──────────────────────────────────────────────────────────
      title: 'StudySpark',
      debugShowCheckedModeBanner: false,

      // ── Routing ───────────────────────────────────────────────────────────
      routerConfig: router,

      // ── Theming ───────────────────────────────────────────────────────────
      theme:      AppTheme.light,
      darkTheme:  AppTheme.dark,
      themeMode:  themeMode,

      // ── Localizations (add arb files for i18n later) ───────────────────
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
      // supportedLocales: AppLocalizations.supportedLocales,

      // ── Builder: set system overlay style based on resolved theme ─────
      builder: (context, child) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        SystemChrome.setSystemUIOverlayStyle(
          isDark
              ? SystemUiOverlayStyle.light.copyWith(
                  statusBarColor: Colors.transparent,
                  systemNavigationBarColor: AppColors.surfaceDark,
                )
              : SystemUiOverlayStyle.dark.copyWith(
                  statusBarColor: Colors.transparent,
                  systemNavigationBarColor: AppColors.surfaceLight,
                ),
        );

        // MediaQuery text-scale clamping: prevents layout breakage on large fonts
        final mediaQuery = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQuery.copyWith(
            textScaler: TextScaler.linear(
              mediaQuery.textScaleFactor.clamp(0.8, 1.3),
            ),
          ),
          child: child!,
        );
      },
    );
  }
}
