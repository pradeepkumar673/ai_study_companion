// lib/features/analytics/presentation/widgets/cgpa_tracker.dart
//
// StudySpark — CGPA Tracker
//
// Displays the overall CGPA, a line chart of SGPA over semesters, and a list
// of all saved semesters with their breakdown.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../../core/theme/app_theme.dart';
import '../providers/analytics_providers.dart';

class CgpaTracker extends ConsumerWidget {
  const CgpaTracker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cgpaAsync = ref.watch(cgpaProvider);
    final breakdownAsync = ref.watch(semesterBreakdownProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Overall CGPA Card ───────────────────────────────────────
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: cs.primary,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: cs.primary.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.school_rounded, color: Colors.white, size: 28),
              ),
              const Gap(16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Overall CGPA',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70,
                    ),
                  ),
                  cgpaAsync.when(
                    loading: () => const Text('...',
                        style: TextStyle(fontSize: 32, color: Colors.white)),
                    error: (_, __) => const Text('Err',
                        style: TextStyle(fontSize: 32, color: Colors.white)),
                    data: (cgpa) => Text(
                      cgpa.toStringAsFixed(2),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -1,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ).animate().fadeIn(duration: 400.ms),
        const Gap(24),

        // ── SGPA Trend Chart ─────────────────────────────────────────
        breakdownAsync.when(
          loading: () => const SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (_, __) => const SizedBox.shrink(),
          data: (semesters) {
            if (semesters.isEmpty) return const SizedBox.shrink();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SGPA Trend',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                const Gap(16),
                _SgpaChart(semesters: semesters, cs: cs, isDark: isDark)
                    .animate()
                    .fadeIn()
                    .slideY(begin: 0.04),
                const Gap(24),
                Text(
                  'Semester History',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                const Gap(12),
                ...semesters.map((s) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _SemesterCard(semester: s, cs: cs, isDark: isDark),
                    )),
              ],
            );
          },
        ),
      ],
    );
  }
}

// ─── SGPA Chart ───────────────────────────────────────────────────────────────

class _SgpaChart extends StatelessWidget {
  const _SgpaChart({
    required this.semesters,
    required this.cs,
    required this.isDark,
  });

  final List<dynamic> semesters;
  final ColorScheme cs;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    if (semesters.length < 2) {
      return Container(
        height: 120,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: AppShadows.sm(Colors.black),
        ),
        child: Text(
          'Add at least 2 semesters to see the trend.',
          style: TextStyle(color: cs.onSurfaceVariant, fontSize: 13),
        ),
      );
    }

    final spots = semesters.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value.sgpa);
    }).toList();

    return Container(
      height: 220,
      padding: const EdgeInsets.only(right: 20, top: 20, bottom: 10),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppShadows.sm(Colors.black),
      ),
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: (semesters.length - 1).toDouble(),
          minY: 0,
          maxY: 10, // Assuming 10-point scale for the chart axis; scales automatically for 4-point if max is low
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 2,
            getDrawingHorizontalLine: (v) => FlLine(
              color: cs.outlineVariant.withOpacity(0.2),
              strokeWidth: 1,
            ),
          ),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 28,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  final i = value.toInt();
                  if (i < 0 || i >= semesters.length) {
                    return const SizedBox.shrink();
                  }
                  final label = semesters[i].semesterLabel;
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      label.length > 5 ? label.substring(0, 5) : label,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 32,
                interval: 2,
                getTitlesWidget: (v, _) => Text(
                  v.toInt().toString(),
                  style: TextStyle(fontSize: 10, color: cs.onSurfaceVariant),
                ),
              ),
            ),
            topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: cs.primary,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, _, __, ___) => FlDotCirclePainter(
                  radius: 4,
                  color: cs.primary,
                  strokeColor: Colors.white,
                  strokeWidth: 2,
                ),
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    cs.primary.withOpacity(0.2),
                    cs.primary.withOpacity(0.0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((s) {
                  return LineTooltipItem(
                    '${semesters[s.x.toInt()].semesterLabel}\n'
                    'SGPA: ${s.y.toStringAsFixed(2)}',
                    const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Semester Card ────────────────────────────────────────────────────────────

class _SemesterCard extends StatelessWidget {
  const _SemesterCard({
    required this.semester,
    required this.cs,
    required this.isDark,
  });

  final dynamic semester;
  final ColorScheme cs;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.outlineVariant.withOpacity(0.3)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            semester.semesterLabel,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
          ),
          subtitle: Text(
            '${semester.totalCredits} Credits',
            style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
          ),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              semester.sgpa.toStringAsFixed(2),
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: cs.primary,
                fontSize: 14,
              ),
            ),
          ),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          children: [
            const Divider(height: 1),
            const Gap(12),
            ...semester.subjects.map<Widget>((subj) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        subj.subjectName,
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text(
                      '${subj.credits} Cr',
                      style: TextStyle(
                          fontSize: 12, color: cs.onSurfaceVariant),
                    ),
                    const Gap(16),
                    SizedBox(
                      width: 40,
                      child: Text(
                        subj.letterGrade,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: cs.primary,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
