// lib/features/dashboard/presentation/screens/onboarding_screen.dart
//
// StudySpark — Premium 4-slide onboarding.
// Beautiful illustrated slides, smooth transitions, and smart routing.

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/providers/isar_provider.dart';

// ─── Onboarding Page Data ─────────────────────────────────────────────────────

class _OnboardingData {
  const _OnboardingData({
    required this.icon,
    required this.illustrationIcons,
    required this.title,
    required this.subtitle,
    required this.accentColor,
    required this.secondaryColor,
    required this.badge,
  });

  final IconData icon;
  final List<_FloatingIcon> illustrationIcons;
  final String title;
  final String subtitle;
  final Color accentColor;
  final Color secondaryColor;
  final String badge;
}

class _FloatingIcon {
  const _FloatingIcon({
    required this.icon,
    required this.x,
    required this.y,
    required this.size,
    required this.opacity,
  });
  final IconData icon;
  final double x; // -1 to 1 relative
  final double y;
  final double size;
  final double opacity;
}

const _pages = [
  _OnboardingData(
    icon: Icons.auto_awesome_rounded,
    illustrationIcons: [
      _FloatingIcon(icon: Icons.task_alt_rounded, x: -0.6, y: -0.2, size: 36, opacity: 0.9),
      _FloatingIcon(icon: Icons.calendar_today_rounded, x: 0.55, y: -0.35, size: 28, opacity: 0.7),
      _FloatingIcon(icon: Icons.sticky_note_2_rounded, x: -0.5, y: 0.35, size: 30, opacity: 0.75),
      _FloatingIcon(icon: Icons.timer_rounded, x: 0.6, y: 0.2, size: 32, opacity: 0.8),
      _FloatingIcon(icon: Icons.bar_chart_rounded, x: 0.1, y: 0.45, size: 24, opacity: 0.6),
    ],
    title: 'All-in-One\nStudy Hub',
    subtitle: 'Tasks, schedules, notes, focus timer, and analytics — beautifully unified in one place.',
    accentColor: Color(0xFF6C4FF8),
    secondaryColor: Color(0xFF9B7FFA),
    badge: '✨ Everything you need',
  ),
  _OnboardingData(
    icon: Icons.timer_rounded,
    illustrationIcons: [
      _FloatingIcon(icon: Icons.play_circle_rounded, x: -0.55, y: -0.3, size: 40, opacity: 0.85),
      _FloatingIcon(icon: Icons.coffee_rounded, x: 0.6, y: -0.2, size: 30, opacity: 0.7),
      _FloatingIcon(icon: Icons.whatshot_rounded, x: -0.4, y: 0.3, size: 28, opacity: 0.8),
      _FloatingIcon(icon: Icons.local_fire_department_rounded, x: 0.5, y: 0.35, size: 34, opacity: 0.75),
      _FloatingIcon(icon: Icons.bolt_rounded, x: 0.0, y: -0.45, size: 26, opacity: 0.65),
    ],
    title: 'Deep Focus\nMode',
    subtitle: 'Pomodoro timers, distraction blocking, and streak tracking to keep you in the zone.',
    accentColor: Color(0xFF00BFAE),
    secondaryColor: Color(0xFF00E5D3),
    badge: '🔥 Build daily habits',
  ),
  _OnboardingData(
    icon: Icons.psychology_rounded,
    illustrationIcons: [
      _FloatingIcon(icon: Icons.auto_stories_rounded, x: -0.6, y: -0.25, size: 34, opacity: 0.85),
      _FloatingIcon(icon: Icons.quiz_rounded, x: 0.55, y: -0.3, size: 30, opacity: 0.75),
      _FloatingIcon(icon: Icons.lightbulb_rounded, x: -0.45, y: 0.3, size: 32, opacity: 0.8),
      _FloatingIcon(icon: Icons.chat_bubble_rounded, x: 0.55, y: 0.25, size: 28, opacity: 0.7),
      _FloatingIcon(icon: Icons.school_rounded, x: 0.05, y: 0.45, size: 26, opacity: 0.6),
    ],
    title: 'AI Study\nAssistant',
    subtitle: 'Smart summaries, auto-generated quizzes, and personalized study plans powered by AI.',
    accentColor: Color(0xFFFF6B3D),
    secondaryColor: Color(0xFFFF9B6B),
    badge: '🤖 Powered by AI',
  ),
  _OnboardingData(
    icon: Icons.emoji_events_rounded,
    illustrationIcons: [
      _FloatingIcon(icon: Icons.workspace_premium_rounded, x: -0.55, y: -0.3, size: 36, opacity: 0.9),
      _FloatingIcon(icon: Icons.military_tech_rounded, x: 0.55, y: -0.25, size: 32, opacity: 0.8),
      _FloatingIcon(icon: Icons.trending_up_rounded, x: -0.4, y: 0.3, size: 28, opacity: 0.75),
      _FloatingIcon(icon: Icons.stars_rounded, x: 0.55, y: 0.35, size: 30, opacity: 0.7),
      _FloatingIcon(icon: Icons.celebration_rounded, x: 0.05, y: -0.45, size: 24, opacity: 0.65),
    ],
    title: 'Level Up &\nEarn Rewards',
    subtitle: 'Gamified XP system, achievement badges, and leaderboards to make studying addictive.',
    accentColor: Color(0xFFFFB547),
    secondaryColor: Color(0xFFFF9800),
    badge: '🏆 Gamified learning',
  ),
];

// ─── Main Onboarding Screen ───────────────────────────────────────────────────

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen>
    with TickerProviderStateMixin {
  final _pageController = PageController();
  int _currentPage = 0;

  late final AnimationController _floatController;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  Future<void> _complete() async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setBool('has_onboarded', true);
    if (mounted) context.go(AppPaths.dashboard);
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLast = _currentPage == _pages.length - 1;
    final page = _pages[_currentPage];

    return Scaffold(
      body: Stack(
        children: [
          // ── Background with animated color transition ───────────────────
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  page.accentColor,
                  page.secondaryColor,
                  page.accentColor.withOpacity(0.75),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // ── Subtle mesh overlay ────────────────────────────────────────
          Positioned.fill(
            child: CustomPaint(painter: _MeshPainter(color: Colors.white)),
          ),

          // ── PageView ───────────────────────────────────────────────────
          PageView.builder(
            controller: _pageController,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemCount: _pages.length,
            itemBuilder: (context, i) => _OnboardingPageView(
              page: _pages[i],
              floatController: _floatController,
            ),
          ),

          // ── Controls overlay ───────────────────────────────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Skip button
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: TextButton(
                        onPressed: _complete,
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white.withOpacity(0.85),
                          backgroundColor: Colors.white.withOpacity(0.12),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8,
                          ),
                          shape: const StadiumBorder(),
                        ),
                        child: const Text(
                          'Skip',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  // ── Dot indicators ───────────────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_pages.length, (i) {
                      final active = i == _currentPage;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: active ? 28 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: active
                              ? Colors.white
                              : Colors.white.withOpacity(0.35),
                          borderRadius: AppShapes.r12,
                          boxShadow: active
                              ? [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.5),
                                    blurRadius: 8,
                                  )
                                ]
                              : null,
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 28),

                  // ── Primary action button ─────────────────────────────────
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: isLast
                        ? _GetStartedButton(onPressed: _complete)
                        : _NextButton(onPressed: _nextPage),
                  ),

                  const SizedBox(height: 16),

                  // ── Terms note on last page ───────────────────────────────
                  if (isLast)
                    Text(
                      'By continuing, you agree to our Terms of Service & Privacy Policy',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 11,
                      ),
                    ).animate().fadeIn(delay: 200.ms),

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

// ─── Individual Page View ─────────────────────────────────────────────────────

class _OnboardingPageView extends StatelessWidget {
  const _OnboardingPageView({
    required this.page,
    required this.floatController,
  });

  final _OnboardingData page;
  final AnimationController floatController;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final illustrationSize = size.width * 0.72;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 100), // below skip button

          // ── Illustration area ──────────────────────────────────────────
          SizedBox(
            width: illustrationSize,
            height: illustrationSize,
            child: _FloatingIllustration(
              page: page,
              floatController: floatController,
            ),
          ),

          const SizedBox(height: 40),

          // ── Badge pill ────────────────────────────────────────────────
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: AppShapes.r32,
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: Text(
              page.badge,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.3, end: 0),

          const SizedBox(height: 20),

          // ── Title ─────────────────────────────────────────────────────
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 38,
              fontWeight: FontWeight.w800,
              height: 1.15,
              letterSpacing: -1,
            ),
          ).animate(delay: 150.ms).fadeIn(duration: 500.ms).slideY(begin: 0.25, end: 0),

          const SizedBox(height: 16),

          // ── Subtitle ──────────────────────────────────────────────────
          Text(
            page.subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.82),
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 1.65,
            ),
          ).animate(delay: 250.ms).fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0),

          const SizedBox(height: 140), // reserve space for bottom controls
        ],
      ),
    );
  }
}

// ─── Floating Illustration ────────────────────────────────────────────────────

class _FloatingIllustration extends StatelessWidget {
  const _FloatingIllustration({required this.page, required this.floatController});

  final _OnboardingData page;
  final AnimationController floatController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Glow background circle
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.12),
          ),
        ),

        // Center icon
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.22),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.35), width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 32,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Icon(page.icon, color: Colors.white, size: 56),
        )
            .animate()
            .scale(
              begin: const Offset(0.7, 0.7),
              duration: 600.ms,
              curve: Curves.easeOutBack,
            )
            .fadeIn(duration: 400.ms),

        // Orbiting floating icons
        ...page.illustrationIcons.asMap().entries.map((entry) {
          final i = entry.key;
          final floatIcon = entry.value;
          return AnimatedBuilder(
            animation: floatController,
            builder: (context, _) {
              final offset = floatController.value * 8 - 4;
              final size = MediaQuery.sizeOf(context).width * 0.72;
              return Positioned(
                left: size / 2 + floatIcon.x * size / 2 - floatIcon.size / 2,
                top: size / 2 +
                    floatIcon.y * size / 2 -
                    floatIcon.size / 2 +
                    (i.isEven ? offset : -offset),
                child: Container(
                  width: floatIcon.size + 16,
                  height: floatIcon.size + 16,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: AppShapes.r12,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.35),
                    ),
                  ),
                  child: Icon(
                    floatIcon.icon,
                    color: Colors.white.withOpacity(floatIcon.opacity),
                    size: floatIcon.size * 0.65,
                  ),
                )
                    .animate(delay: Duration(milliseconds: 100 * i))
                    .scale(
                      begin: const Offset(0, 0),
                      duration: 500.ms,
                      curve: Curves.easeOutBack,
                    )
                    .fadeIn(),
              );
            },
          );
        }),
      ],
    );
  }
}

// ─── Buttons ──────────────────────────────────────────────────────────────────

class _NextButton extends StatelessWidget {
  const _NextButton({required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      child: FilledButton(
        key: const ValueKey('next'),
        style: FilledButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.primary,
          shape: AppShapes.extraLarge,
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Continue',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_rounded, size: 20),
          ],
        ),
      ),
    );
  }
}

class _GetStartedButton extends StatelessWidget {
  const _GetStartedButton({required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      child: FilledButton(
        key: const ValueKey('getStarted'),
        style: FilledButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.primary,
          shape: AppShapes.extraLarge,
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Get Started',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 8),
            const Text('🚀', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    )
        .animate()
        .shimmer(duration: 1200.ms, delay: 400.ms, color: AppColors.primary.withOpacity(0.2));
  }
}

// ─── Custom Painter: Mesh overlay ────────────────────────────────────────────

class _MeshPainter extends CustomPainter {
  const _MeshPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.04)
      ..strokeWidth = 1;

    const step = 60.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_MeshPainter old) => false;
}
