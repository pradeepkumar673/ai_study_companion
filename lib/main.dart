// lib/main.dart
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/bootstrap/app_bootstrap.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'shared/providers/repository_providers.dart';
import 'shared/providers/theme_provider.dart';

// ─── Riverpod Observer ────────────────────────────────────────────────────────

class StudySparkObserver extends ProviderObserver {
  @override
  void providerDidFail(
    ProviderBase provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    debugPrint('Provider [${provider.name ?? provider.runtimeType}] failed: $error\n$stackTrace');
  }
}

// ─── Entry point ──────────────────────────────────────────────────────────────

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Catch rendering errors and display a clean text fallback.
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Rendering error in ${details.context ?? "widget"}',
            style: const TextStyle(color: Colors.red, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  };

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
  };

  await runZonedGuarded(
    () async {
      if (!kIsWeb) {
        await SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
      }

      final overrides = await buildProviderOverrides();

      runApp(
        ProviderScope(
          observers: [StudySparkObserver()],
          overrides: overrides,
          child: const StudySparkApp(),
        ),
      );
    },
    (error, stack) {
      debugPrint('Unhandled zone error: $error\n$stack');
    },
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
    WidgetsBinding.instance.addPostFrameCallback((_) => _onAppStart());
  }

  Future<void> _onAppStart() async {
    try {
      final profile = ref.read(profileRepositoryProvider);
      await profile.getOrCreateProfile();

      final gamification = ref.read(gamificationServiceProvider);
      await gamification.onStreakUpdated();

      final notif = ref.read(notificationServiceProvider);
      await notif.scheduleDailyStreakReminder(hour: 20, minute: 0);
    } catch (e, st) {
      // Non-fatal — app continues even if startup tasks fail.
      debugPrint('_onAppStart error (non-fatal): $e\n$st');
    }
  }

  @override
  Widget build(BuildContext context) {
    final router    = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'StudySpark',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
