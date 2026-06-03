// lib/features/analytics/presentation/screens/analytics_screen.dart
//
// StudySpark — Analytics Screen
// Displays focus time, task completion trends, mood charts, and streak data.
// TODO: Wire up fl_chart bar/line charts to FocusRepository & TaskRepository.

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_theme.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: cs.surface,
      body: CustomScrollView(
        slivers: [
          // ── App Bar ──────────────────────────────────────────────────────
          SliverAppBar.large(
            floating: true,
            pinned: true,
            backgroundColor: cs.surface,
            surfaceTintColor: Colors.transparent,
            title: Text(
              'Analytics',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w700,
                color: cs.onSurface,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.date_range_rounded),
                tooltip: 'Select date range',
                onPressed: () {},
              ),
              const SizedBox(width: 8),
            ],
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
            sliver: SliverList.list(
              children: [
                // ── Weekly Overview Cards ──────────────────────────────────
                _SectionHeader(title: 'This Week', cs: cs),
                const SizedBox(height: 12),
                _WeeklyStatsRow(cs: cs, isDark: isDark),
                const SizedBox(height: 28),

                // ── Focus Time Chart ──────────────────────────────────────
                _SectionHeader(title: 'Focus Time', cs: cs),
                const SizedBox(height: 12),
                _ChartPlaceholder(
                  title: 'Daily Focus Minutes',
                  icon: Icons.timer_rounded,
                  color: AppColors.primary,
                  cs: cs,
                  isDark: isDark,
                ),
                const SizedBox(height: 24),

                // ── Task Completion Chart ─────────────────────────────────
                _SectionHeader(title: 'Task Completion', cs: cs),
                const SizedBox(height: 12),
                _ChartPlaceholder(
                  title: 'Tasks Completed per Day',
                  icon: Icons.task_alt_rounded,
                  color: AppColors.secondary,
                  cs: cs,
                  isDark: isDark,
                ),
                const SizedBox(height: 24),

                // ── Streak Card ───────────────────────────────────────────
                _SectionHeader(title: 'Study Streak', cs: cs),
                const SizedBox(height: 12),
                _StreakCard(cs: cs, isDark: isDark),
                const SizedBox(height: 24),

                // ── Subject Breakdown ─────────────────────────────────────
                _SectionHeader(title: 'Subject Breakdown', cs: cs),
                const SizedBox(height: 12),
                _SubjectBreakdown(cs: cs, isDark: isDark),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Section Header ───────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.cs});
  final String title;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
        color: cs.onSurface,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

// ─── Weekly Stats Row ─────────────────────────────────────────────────────────

class _WeeklyStatsRow extends StatelessWidget {
  const _WeeklyStatsRow({required this.cs, required this.isDark});
  final ColorScheme cs;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final stats = [
      (value: '4h 20m', label: 'Focus Time', icon: Icons.timer_rounded, color: AppColors.primary),
      (value: '12', label: 'Tasks Done', icon: Icons.check_circle_rounded, color: AppColors.secondary),
      (value: '7', label: 'Day Streak', icon: Icons.local_fire_department_rounded, color: AppColors.tertiary),
    ];

    return Row(
      children: stats.asMap().entries.map((e) {
        final stat = e.value;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: e.key == 0 ? 0 : 6,
              right: e.key == stats.length - 1 ? 0 : 6,
            ),
            child: _StatCard(
              value: stat.value,
              label: stat.label,
              icon: stat.icon,
              color: stat.color,
              cs: cs,
              isDark: isDark,
            ).animate(delay: Duration(milliseconds: 80 * e.key))
                .fadeIn()
                .slideY(begin: 0.2, end: 0),
          ),
        );
      }).toList(),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
    required this.cs,
    required this.isDark,
  });

  final String value;
  final String label;
  final IconData icon;
  final Color color;
  final ColorScheme cs;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.neutral20 : cs.surface,
        borderRadius: AppShapes.r16,
        border: Border.all(color: cs.outlineVariant.withOpacity(0.4)),
        boxShadow: AppShadows.sm(isDark ? Colors.black : cs.shadow),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: AppShapes.r8,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w800,
              color: cs.onSurface,
            ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: cs.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Chart Placeholder ────────────────────────────────────────────────────────

class _ChartPlaceholder extends StatelessWidget {
  const _ChartPlaceholder({
    required this.title,
    required this.icon,
    required this.color,
    required this.cs,
    required this.isDark,
  });

  final String title;
  final IconData icon;
  final Color color;
  final ColorScheme cs;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    // Fake bar heights for visual skeleton
    final bars = [0.4, 0.65, 0.5, 0.8, 0.6, 0.9, 0.55];
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.neutral20 : cs.surface,
        borderRadius: AppShapes.r16,
        border: Border.all(color: cs.outlineVariant.withOpacity(0.4)),
        boxShadow: AppShadows.sm(isDark ? Colors.black : cs.shadow),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: cs.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: bars.asMap().entries.map((e) {
                final isToday = e.key == 5; // Saturday highlighted
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: FractionallySizedBox(
                            heightFactor: e.value,
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 400 + e.key * 60),
                              curve: Curves.easeOutCubic,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: isToday
                                      ? [color, color.withOpacity(0.7)]
                                      : [
                                          color.withOpacity(0.35),
                                          color.withOpacity(0.2),
                                        ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(6),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          days[e.key],
                          style: TextStyle(
                            fontSize: 10,
                            color: isToday ? color : cs.onSurfaceVariant,
                            fontWeight: isToday ? FontWeight.w700 : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              'Connect your data to see live charts',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: cs.onSurfaceVariant.withOpacity(0.6),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1, end: 0);
  }
}

// ─── Streak Card ──────────────────────────────────────────────────────────────

class _StreakCard extends StatelessWidget {
  const _StreakCard({required this.cs, required this.isDark});
  final ColorScheme cs;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.tertiary, const Color(0xFFFF9B6B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppShapes.r16,
        boxShadow: [
          BoxShadow(
            color: AppColors.tertiary.withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          const Text('🔥', style: TextStyle(fontSize: 48)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '7-Day Streak!',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'Keep studying every day to maintain your streak',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.white.withOpacity(0.85),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1, end: 0);
  }
}

// ─── Subject Breakdown ────────────────────────────────────────────────────────

class _SubjectBreakdown extends StatelessWidget {
  const _SubjectBreakdown({required this.cs, required this.isDark});
  final ColorScheme cs;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final subjects = [
      (name: 'Computer Science', pct: 0.42, color: AppColors.primary),
      (name: 'Mathematics', pct: 0.28, color: AppColors.secondary),
      (name: 'Physics', pct: 0.18, color: AppColors.tertiary),
      (name: 'Other', pct: 0.12, color: AppColors.chartPink),
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.neutral20 : cs.surface,
        borderRadius: AppShapes.r16,
        border: Border.all(color: cs.outlineVariant.withOpacity(0.4)),
        boxShadow: AppShadows.sm(isDark ? Colors.black : cs.shadow),
      ),
      child: Column(
        children: subjects.asMap().entries.map((e) {
          final s = e.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: s.color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          s.name,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: cs.onSurface,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${(s.pct * 100).round()}%',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: cs.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: AppShapes.r8,
                  child: LinearProgressIndicator(
                    value: s.pct,
                    minHeight: 6,
                    backgroundColor: s.color.withOpacity(0.12),
                    valueColor: AlwaysStoppedAnimation(s.color),
                  ),
                ),
              ],
            ).animate(delay: Duration(milliseconds: 80 * e.key)).fadeIn().slideX(begin: 0.1, end: 0),
          );
        }).toList(),
      ),
    ).animate().fadeIn(delay: 300.ms);
  }
}
