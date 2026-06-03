// lib/features/analytics/presentation/widgets/reports_section.dart
//
// StudySpark — Daily & Weekly Reports Section
//
// Contains a segmented control to switch between Daily and Weekly views.
// Renders the stats from `dailyReportProvider` or `weeklyReportProvider`.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';
import '../providers/analytics_providers.dart';

final _dateFmtLong = DateFormat('EEEE, MMMM d');
final _dateFmtShort = DateFormat('MMM d');

class ReportsSection extends ConsumerStatefulWidget {
  const ReportsSection({super.key});

  @override
  ConsumerState<ReportsSection> createState() => _ReportsSectionState();
}

class _ReportsSectionState extends ConsumerState<ReportsSection> {
  int _tabIndex = 0; // 0 = Daily, 1 = Weekly

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppShadows.sm(Colors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header + Tabs
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Reports',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              SegmentedButton<int>(
                segments: const [
                  ButtonSegment(value: 0, label: Text('Daily')),
                  ButtonSegment(value: 1, label: Text('Weekly')),
                ],
                selected: {_tabIndex},
                onSelectionChanged: (set) =>
                    setState(() => _tabIndex = set.first),
                style: SegmentedButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                  textStyle: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
          const Gap(20),

          // Content
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _tabIndex == 0
                ? _DailyReportView(cs: cs)
                : _WeeklyReportView(cs: cs),
          ),
        ],
      ),
    );
  }
}

// ─── Daily ────────────────────────────────────────────────────────────────────

class _DailyReportView extends ConsumerWidget {
  const _DailyReportView({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailyAsync = ref.watch(dailyReportProvider);

    return dailyAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const SizedBox.shrink(),
      data: (report) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _dateFmtLong.format(report.date),
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: cs.onSurfaceVariant),
            ),
            const Gap(16),
            _ReportStat(
              icon: Icons.timer_rounded,
              label: 'Total Focus',
              value: '${report.focusMinutes} minutes',
              color: AppColors.chartAmber,
            ),
            const Gap(12),
            _ReportStat(
              icon: Icons.check_circle_outline_rounded,
              label: 'Tasks Completed',
              value: '${report.tasksCompleted} tasks',
              color: AppColors.chartGreen,
            ),
            const Gap(12),
            _ReportStat(
              icon: Icons.psychology_rounded,
              label: 'Sessions Done',
              value: '${report.sessionsCompleted} sessions',
              color: AppColors.chartBlue,
            ),
          ],
        );
      },
    );
  }
}

// ─── Weekly ───────────────────────────────────────────────────────────────────

class _WeeklyReportView extends ConsumerWidget {
  const _WeeklyReportView({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weeklyAsync = ref.watch(weeklyReportProvider);

    return weeklyAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const SizedBox.shrink(),
      data: (report) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${_dateFmtShort.format(report.weekStart)} - ${_dateFmtShort.format(report.weekEnd)}',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: cs.onSurfaceVariant),
            ),
            const Gap(16),
            _ReportStat(
              icon: Icons.timer_rounded,
              label: 'Total Focus',
              value: '${(report.totalFocusMinutes / 60).toStringAsFixed(1)} hours',
              color: AppColors.chartAmber,
            ),
            const Gap(12),
            _ReportStat(
              icon: Icons.check_circle_outline_rounded,
              label: 'Tasks Completed',
              value: '${report.tasksCompleted} tasks',
              color: AppColors.chartGreen,
            ),
            const Gap(12),
            _ReportStat(
              icon: Icons.trending_up_rounded,
              label: 'Productivity Score',
              value: '${report.productivityScore.round()}/100 avg',
              color: cs.primary,
            ),
          ],
        );
      },
    );
  }
}

class _ReportStat extends StatelessWidget {
  const _ReportStat({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: color),
        ),
        const Gap(12),
        Expanded(
          child: Text(label,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        ),
        Text(value,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
      ],
    );
  }
}
