// lib/features/dashboard/presentation/screens/splash_screen.dart
//
// StudySpark — Premium animated splash screen.
// Features: morphing gradient background, staggered logo reveal,
// pulsing glow ring, animated tagline, and smart routing.

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/providers/isar_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final AnimationController _orbitController;
  late final AnimationController _progressController;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // Start progress bar after logo appears
    Future.delayed(const Duration(milliseconds: 700), () {
      if (mounted) _progressController.forward();
    });

    _navigate();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _orbitController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(milliseconds: 2800));
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
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── Animated gradient background ──────────────────────────────────
          _AnimatedBackground(isDark: isDark, cs: cs),

          // ── Orbiting decorative dots ──────────────────────────────────────
          ..._buildOrbitingDots(size, cs),

          // ── Main content ──────────────────────────────────────────────────
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),

                // ── Pulsing glow ring + Logo ────────────────────────────────
                _buildLogoSection(cs),

                const SizedBox(height: 32),

                // ── Brand name ──────────────────────────────────────────────
                Text(
                  'StudySpark',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: isDark ? Colors.white : AppColors.neutral10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1,
                  ),
                )
                    .animate(delay: 400.ms)
                    .fadeIn(duration: 600.ms)
                    .slideY(begin: 0.3, end: 0, curve: Curves.easeOutCubic),

                const SizedBox(height: 10),

                // ── Tagline ─────────────────────────────────────────────────
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary],
                  ).createShader(bounds),
                  child: Text(
                    'Smart Student Productivity',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                )
                    .animate(delay: 600.ms)
                    .fadeIn(duration: 500.ms)
                    .slideY(begin: 0.2, end: 0),

                const Spacer(flex: 2),

                // ── Progress bar ────────────────────────────────────────────
                _buildProgressSection(cs)
                    .animate(delay: 700.ms)
                    .fadeIn(duration: 400.ms),

                const SizedBox(height: 48),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoSection(ColorScheme cs) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        final pulse = _pulseController.value;
        return Stack(
          alignment: Alignment.center,
          children: [
            // Outer glow ring
            Container(
              width: 140 + pulse * 20,
              height: 140 + pulse * 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.15 + pulse * 0.1),
                    AppColors.primary.withOpacity(0),
                  ],
                ),
              ),
            ),
            // Mid ring
            Container(
              width: 116 + pulse * 8,
              height: 116 + pulse * 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.2 + pulse * 0.15),
                  width: 1.5,
                ),
              ),
            ),
            // Logo container
            child!,
          ],
        );
      },
      child: Container(
        width: 96,
        height: 96,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, const Color(0xFF9B7FFA)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: AppShapes.r28,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.45),
              blurRadius: 30,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: const Icon(
          Icons.bolt_rounded,
          color: Colors.white,
          size: 52,
        ),
      )
          .animate()
          .scale(
            begin: const Offset(0.5, 0.5),
            duration: 700.ms,
            curve: Curves.easeOutBack,
          )
          .fadeIn(duration: 400.ms),
    );
  }

  Widget _buildProgressSection(ColorScheme cs) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 64),
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _progressController,
            builder: (context, _) {
              return ClipRRect(
                borderRadius: AppShapes.r8,
                child: LinearProgressIndicator(
                  value: _progressController.value,
                  minHeight: 3,
                  backgroundColor: AppColors.primary.withOpacity(0.15),
                  valueColor: AlwaysStoppedAnimation(AppColors.primary),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Preparing your workspace…',
            style: TextStyle(
              color: cs.onSurfaceVariant.withOpacity(0.6),
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildOrbitingDots(Size size, ColorScheme cs) {
    final dots = [
      (radius: 130.0, angle: 0.0, dotSize: 8.0, color: AppColors.primary),
      (radius: 160.0, angle: math.pi * 0.7, dotSize: 6.0, color: AppColors.secondary),
      (radius: 110.0, angle: math.pi * 1.3, dotSize: 5.0, color: AppColors.tertiary),
      (radius: 180.0, angle: math.pi * 1.8, dotSize: 4.0, color: AppColors.primary),
    ];

    return dots.map((dot) {
      return AnimatedBuilder(
        animation: _orbitController,
        builder: (context, _) {
          final angle = dot.angle + _orbitController.value * math.pi * 2;
          final centerX = size.width / 2 + math.cos(angle) * dot.radius;
          final centerY = size.height / 2 + math.sin(angle) * dot.radius;

          return Positioned(
            left: centerX - dot.dotSize / 2,
            top: centerY - dot.dotSize / 2,
            child: Container(
              width: dot.dotSize,
              height: dot.dotSize,
              decoration: BoxDecoration(
                color: dot.color.withOpacity(0.35),
                shape: BoxShape.circle,
              ),
            ),
          );
        },
      );
    }).toList();
  }
}

// ─── Animated Gradient Background ────────────────────────────────────────────

class _AnimatedBackground extends StatefulWidget {
  const _AnimatedBackground({required this.isDark, required this.cs});
  final bool isDark;
  final ColorScheme cs;

  @override
  State<_AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<_AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.lerp(
                Alignment.topLeft,
                Alignment.topRight,
                _ctrl.value,
              )!,
              end: Alignment.lerp(
                Alignment.bottomRight,
                Alignment.bottomLeft,
                _ctrl.value,
              )!,
              colors: widget.isDark
                  ? [
                      AppColors.backgroundDark,
                      Color.lerp(
                        AppColors.surfaceDark,
                        AppColors.neutral20,
                        _ctrl.value * 0.3,
                      )!,
                    ]
                  : [
                      AppColors.backgroundLight,
                      Color.lerp(
                        AppColors.surfaceLight,
                        AppColors.primaryContainer,
                        _ctrl.value * 0.25,
                      )!,
                    ],
            ),
          ),
        );
      },
    );
  }
}
