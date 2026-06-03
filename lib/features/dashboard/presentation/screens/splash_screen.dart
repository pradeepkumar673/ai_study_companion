// lib/features/dashboard/presentation/screens/splash_screen.dart
//
// StudySpark — Animated splash screen.
// Shown at app start; navigates to dashboard (or onboarding on first launch).

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/providers/isar_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    // Minimum splash duration for branding
    await Future.delayed(const Duration(milliseconds: 2200));

    if (!mounted) return;

    final prefs = ref.read(sharedPreferencesProvider);
    final hasOnboarded = prefs.getBool('has_onboarded') ?? false;

    if (hasOnboarded) {
      context.go(AppPaths.dashboard);
    } else {
      context.go(AppPaths.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: cs.surface,
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.surfaceGradient(cs, isDark: isDark)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── App Icon ─────────────────────────────────────────────────
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient(cs),
                  borderRadius: AppShapes.r24,
                  boxShadow: AppShadows.glow(cs.primary),
                ),
                child: const Icon(
                  Icons.bolt_rounded,
                  color: Colors.white,
                  size: 52,
                ),
              )
              .animate()
              .scale(
                begin: const Offset(0.6, 0.6),
                duration: 600.ms,
                curve: Curves.easeOutBack,
              )
              .fadeIn(duration: 400.ms),

              const SizedBox(height: 24),

              // ── Brand Name ────────────────────────────────────────────────
              Text(
                'StudySpark',
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: cs.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              )
              .animate(delay: 300.ms)
              .fadeIn(duration: 500.ms)
              .slideY(begin: 0.2, end: 0),

              const SizedBox(height: 8),

              Text(
                'Smart Student Productivity',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: cs.onSurfaceVariant,
                ),
              )
              .animate(delay: 500.ms)
              .fadeIn(duration: 500.ms),

              const SizedBox(height: 64),

              // ── Loading Indicator ─────────────────────────────────────────
              SizedBox(
                width: 140,
                child: LinearProgressIndicator(
                  borderRadius: AppShapes.r12,
                  backgroundColor: cs.primaryContainer,
                  valueColor: AlwaysStoppedAnimation(cs.primary),
                ),
              )
              .animate(delay: 800.ms)
              .fadeIn(duration: 400.ms),
            ],
          ),
        ),
      ),
    );
  }
}
