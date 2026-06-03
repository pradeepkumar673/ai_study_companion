// lib/features/analytics/presentation/widgets/subject_performance_chart.dart
//
// StudySpark — Subject-wise Performance Chart
//
// Renders a horizontal grouped bar chart (fl_chart) showing per-subject GPA,
// task completion rate, and focus time. Tapping a bar shows detail.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../../core/theme/app_theme.dart';
import '../../data/repositories/analytics_repository.dart';
import '../providers/analytics_providers.dart';

class SubjectPerformanceChart extends ConsumerStatefulWidget {
  const SubjectPerformanceChart({super.key});

  @override
  ConsumerState<SubjectPerformanceChart> createState() =>
      _SubjectPerformanceChartState();
}

class _SubjectPerformanceChartState
    extends ConsumerState<SubjectPerformanceChart> {
  int _touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final performancesAsync = ref.watch(subjectPerformancesProvider);

    return performancesAsync.when(
      loading: () => const SizedBox(
        height: 240,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (_, __) => const SizedBox.shrink(),
      data: (performances) {
        if (performances.isEmpty) {
          return _EmptySubjects(cs: cs);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Legend ──────────────────────────────────────────────
            Row(
              children: [
                _LegendDot(color: AppColors.chartBlue, label: 'GPA Score'),
                const Gap(16),
                _LegendDot(color: AppColors.chartGreen, label: 'Tasks Done %'),
                const Gap(16),
                _LegendDot(color: AppColors.chartAmber, label: 'Focus (hrs)'),
              ],
            ),
            const Gap(16),

            // ── Grouped Bar Chart ────────────────────────────────────
            SizedBox(
              height: 260,
              child: BarChart(
                BarChartData(
                  maxY: 10,
                  barTouchData: BarTouchData(
                    touchCallback: (event, response) {
                      if (response?.spot != null &&
                          event is FlTapUpEvent) {
                        setState(() {
                          _touchedIndex =
                              response!.spot!.touchedBarGroupIndex;
                        });
                      }
                    },
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final subj = performances[group.x];
                        final labels = ['GPA', 'Task %×10', 'Focus (hrs)'];
                        return BarTooltipItem(
                          '${subj.subjectCode.isEmpty ? subj.subjectName : subj.subjectCode}\n'
                          '${labels[rodIndex]}: ${rod.toY.toStringAsFixed(1)}',
                          const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 36,
                        getTitlesWidget: (value, meta) {
                          final i = value.toInt();
                          if (i < 0 || i >= performances.length) {
                            return const SizedBox.shrink();
                          }
                          final subj = performances[i];
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              subj.subjectCode.isNotEmpty
                                  ? subj.subjectCode
                                  : subj.subjectName.length > 6
                                      ? '${subj.subjectName.substring(0, 6)}…'
                                      : subj.subjectName,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: cs.onSurfaceVariant,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        getTitlesWidget: (value, meta) {
                          if (value % 2 != 0) return const SizedBox.shrink();
                          return Text(
                            value.toInt().toString(),
                            style: TextStyle(
                                fontSize: 10, color: cs.onSurfaceVariant),
                          );
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 2,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: cs.outlineVariant.withOpacity(0.3),
                      strokeWidth: 1,
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: performances.asMap().entries.map((entry) {
                    final i = entry.key;
                    final subj = entry.value;
                    final isTouched = i == _touchedIndex;
                    final opacity = isTouched ? 1.0 : 0.85;

                    return BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: subj.gpa.clamp(0, 10),
                          color:
                              AppColors.chartBlue.withOpacity(opacity),
                          width: 8,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(4)),
                        ),
                        BarChartRodData(
                          toY: (subj.taskCompletionRate * 10).clamp(0, 10),
                          color: AppColors.chartGreen.withOpacity(opacity),
                          width: 8,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(4)),
                        ),
                        BarChartRodData(
                          toY: (subj.focusMinutes / 60).clamp(0, 10),
                          color:
                              AppColors.chartAmber.withOpacity(opacity),
                          width: 8,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(4)),
                        ),
                      ],
                      groupVertically: false,
                      barsSpace: 3,
                    );
                  }).toList(),
                ),
              ),
            ),

            // ── Touched subject detail card ──────────────────────────
            if (_touchedIndex >= 0 &&
                _touchedIndex < performances.length) ...[
              const Gap(16),
              _SubjectDetailCard(
                performance: performances[_touchedIndex],
                cs: cs,
                isDark: isDark,
              ).animate().fadeIn().slideY(begin: 0.08),
            ],
          ],
        );
      },
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.label});
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const Gap(4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _SubjectDetailCard extends StatelessWidget {
  const _SubjectDetailCard({
    required this.performance,
    required this.cs,
    required this.isDark,
  });

  final SubjectPerformance performance;
  final ColorScheme cs;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    Color subjectColor;
    try {
      subjectColor = Color(
          int.parse(performance.colorHex.replaceFirst('#', '0xFF')));
    } catch (_) {
      subjectColor = AppColors.primary;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: subjectColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: subjectColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: subjectColor.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.school_rounded, color: subjectColor, size: 22),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  performance.subjectName,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 14),
                ),
                if (performance.semesterLabel.isNotEmpty)
                  Text(
                    performance.semesterLabel,
                    style: TextStyle(
                        fontSize: 11, color: cs.onSurfaceVariant),
                  ),
              ],
            ),
          ),
          _InfoChip(
            label: 'GPA',
            value: performance.gpa.toStringAsFixed(1),
            color: AppColors.chartBlue,
          ),
          const Gap(8),
          _InfoChip(
            label: 'Tasks',
            value:
                '${performance.completedTasks}/${performance.totalTasks}',
            color: AppColors.chartGreen,
          ),
          const Gap(8),
          _InfoChip(
            label: 'Focus',
            value: '${(performance.focusMinutes / 60).toStringAsFixed(1)}h',
            color: AppColors.chartAmber,
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip(
      {required this.label, required this.value, required this.color});
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: TextStyle(
                fontSize: 13, fontWeight: FontWeight.w700, color: color)),
        Text(label,
            style: TextStyle(
                fontSize: 9,
                color: Theme.of(context).colorScheme.onSurfaceVariant)),
      ],
    );
  }
}

class _EmptySubjects extends StatelessWidget {
  const _EmptySubjects({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bar_chart_rounded,
              size: 48, color: cs.onSurfaceVariant.withOpacity(0.35)),
          const Gap(12),
          Text(
            'No subjects yet',
            style: TextStyle(
                fontWeight: FontWeight.w600, color: cs.onSurfaceVariant),
          ),
          const Gap(4),
          Text(
            'Add subjects in the Schedule tab to see performance data.',
            style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
