// lib/features/dashboard/presentation/screens/onboarding_screen.dart
//
// StudySpark — 3-step onboarding carousel.
// On completion, sets 'has_onboarded' in SharedPreferences and routes to dashboard.

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/providers/isar_provider.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _controller = PageController();
  int _currentPage = 0;

  static const _pages = [
    _OnboardingPage(
      emoji: '📚',
      title: 'Master Your Studies',
      subtitle: 'Organize tasks, notes, and deadlines in one\nbeautiful, distraction-free space.',
      gradient: [Color(0xFF6C4FF8), Color(0xFF9B7FFA)],
    ),
    _OnboardingPage(
      emoji: '⏱️',
      title: 'Deep Focus Mode',
      subtitle: 'Pomodoro timers and focus sessions designed\nto keep you in the zone.',
      gradient: [Color(0xFF00BFAE), Color(0xFF00E5D3)],
    ),
    _OnboardingPage(
      emoji: '🤖',
      title: 'AI Study Assistant',
      subtitle: 'Get smart summaries, quiz generation, and\npersonalized study plans powered by AI.',
      gradient: [Color(0xFFFF6B3D), Color(0xFFFF9B6B)],
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _complete() async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setBool('has_onboarded', true);
    if (mounted) context.go(AppPaths.dashboard);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isLast = _currentPage == _pages.length - 1;

    return Scaffold(
      body: Stack(
        children: [
          // ── Page View ─────────────────────────────────────────────────────
          PageView.builder(
            controller: _controller,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemCount: _pages.length,
            itemBuilder: (context, i) => _OnboardingPageView(page: _pages[i]),
          ),

          // ── Controls overlay ──────────────────────────────────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  // Skip button
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: _complete,
                      child: Text('Skip', style: TextStyle(color: Colors.white.withOpacity(0.8))),
                    ),
                  ),

                  const Spacer(),

                  // Page indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_pages.length, (i) {
                      final active = i == _currentPage;
                      return AnimatedContainer(
                        duration: AppDurations.normal,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: active ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: active ? Colors.white : Colors.white38,
                          borderRadius: AppShapes.r12,
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 32),

                  // Next / Get Started button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: cs.primary,
                        shape: AppShapes.extraLarge,
                      ),
                      onPressed: isLast
                          ? _complete
                          : () => _controller.nextPage(
                                duration: AppDurations.normal,
                                curve: Curves.easeInOut,
                              ),
                      child: Text(
                        isLast ? 'Get Started 🚀' : 'Next',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingPage {
  const _OnboardingPage({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.gradient,
  });
  final String emoji;
  final String title;
  final String subtitle;
  final List<Color> gradient;
}

class _OnboardingPageView extends StatelessWidget {
  const _OnboardingPageView({required this.page});
  final _OnboardingPage page;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: page.gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(page.emoji, style: const TextStyle(fontSize: 80))
                  .animate()
                  .scale(duration: 600.ms, curve: Curves.easeOutBack),
              const SizedBox(height: 40),
              Text(
                page.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ).animate(delay: 150.ms).fadeIn().slideY(begin: 0.2, end: 0),
              const SizedBox(height: 16),
              Text(
                page.subtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.white.withOpacity(0.85),
                  height: 1.6,
                ),
              ).animate(delay: 250.ms).fadeIn().slideY(begin: 0.2, end: 0),
            ],
          ),
        ),
      ),
    );
  }
}
