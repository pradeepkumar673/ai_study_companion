// lib/features/analytics/presentation/widgets/productivity_dashboard.dart
//
// StudySpark — Productivity Dashboard
//
// Displays the composite productivity score for today/this week and a phase
// breakdown (Pomodoro vs Break).
// ─────────────────────────────────────────────────────────────────────────────

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../core/theme/app_theme.dart';
import '../providers/analytics_providers.dart';

class ProductivityDashboard extends ConsumerWidget {
  const ProductivityDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dailyAsync = ref.watch(dailyReportProvider);

    return dailyAsync.when(
      loading: () => const SizedBox(
        height: 160,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (_, __) => const SizedBox.shrink(),
      data: (report) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today\'s Productivity',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            const Gap(16),
            Row(
              children: [
                // ── Circular Score ──────────────────────────────────
                _ScoreRing(score: report.productivityScore, cs: cs),
                const Gap(24),

                // ── Breakdown Metrics ───────────────────────────────
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _MetricRow(
                        icon: Icons.timer_rounded,
                        label: 'Focus',
                        value: '${report.focusMinutes}m',
                        target: '/ 120m',
                        color: AppColors.chartAmber,
                      ),
                      const Gap(12),
                      _MetricRow(
                        icon: Icons.check_circle_outline_rounded,
                        label: 'Tasks',
                        value: '${report.tasksCompleted}',
                        target: '/ 5',
                        color: AppColors.chartGreen,
                      ),
                      const Gap(12),
                      _MetricRow(
                        icon: Icons.mood_rounded,
                        label: 'Mood',
                        value: report.moodEntry?.mood.label ?? 'None',
                        target: '',
                        color: AppColors.chartBlue,
                      ),
                    ],
                  ),
                ),
              ],
            ).animate().fadeIn(duration: 400.ms),
          ],
        );
      },
    );
  }
}

class _ScoreRing extends StatelessWidget {
  const _ScoreRing({required this.score, required this.cs});
  final double score;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    final color = score >= 80
        ? AppColors.chartGreen
        : score >= 50
            ? AppColors.chartBlue
            : AppColors.error;

    return CircularPercentIndicator(
      radius: 56,
      lineWidth: 12,
      percent: (score / 100).clamp(0.0, 1.0),
      circularStrokeCap: CircularStrokeCap.round,
      backgroundColor: color.withOpacity(0.15),
      progressColor: color,
      animation: true,
      animationDuration: 1200,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            score.round().toString(),
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: color,
              height: 1.1,
            ),
          ),
          Text(
            'Score',
            style: TextStyle(
              fontSize: 10,
              color: cs.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.target,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final String target;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const Gap(8),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
                fontSize: 13,
                color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
        ),
        Text(
          value,
          style: TextStyle(
              fontSize: 13, fontWeight: FontWeight.w700, color: color),
        ),
        if (target.isNotEmpty) ...[
          const Gap(4),
          Text(
            target,
            style: TextStyle(
                fontSize: 11,
                color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
        ]
      ],
    );
  }
}
