// lib/features/dashboard/presentation/widgets/focus_history_chart.dart
//
// Mini weekly focus bar chart for the dashboard.
// Uses fl_chart BarChart with themed colours.

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../../core/theme/app_theme.dart';

class FocusHistoryChart extends StatefulWidget {
  const FocusHistoryChart({
    super.key,
    required this.weeklyMinutes,
  });

  /// Focus minutes per day, index 0 = Monday, 6 = Sunday.
  final List<double> weeklyMinutes;

  @override
  State<FocusHistoryChart> createState() => _FocusHistoryChartState();
}

class _FocusHistoryChartState extends State<FocusHistoryChart> {
  int _touchedIndex = -1;

  static const _weekDays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  int get _todayIndex => DateTime.now().weekday - 1; // 0=Mon … 6=Sun

  double get _totalMinutes =>
      widget.weeklyMinutes.fold(0.0, (s, v) => s + v);

  String _formatMinutes(double mins) {
    final h = mins.round() ~/ 60;
    final m = mins.round() % 60;
    return h > 0 ? '${h}h ${m}m' : '${m}m';
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final maxY = (widget.weeklyMinutes.reduce((a, b) => a > b ? a : b) * 1.25)
        .clamp(30.0, 300.0);

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
          // ── Header ───────────────────────────────────────────────────
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _formatMinutes(_totalMinutes),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : AppColors.neutral10,
                    ),
                  ),
                  Text(
                    'Focus this week',
                    style: TextStyle(
                      fontSize: 12,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Sparkline overview
              SizedBox(
                width: 80,
                height: 36,
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: false),
                    titlesData: const FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                    lineTouchData: const LineTouchData(enabled: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: widget.weeklyMinutes
                            .asMap()
                            .entries
                            .map((e) => FlSpot(e.key.toDouble(), e.value))
                            .toList(),
                        isCurved: true,
                        color: AppColors.primary,
                        barWidth: 2,
                        dotData: const FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          color: AppColors.primary.withOpacity(0.1),
                        ),
                      ),
                    ],
                    minY: 0,
                    maxY: maxY,
                  ),
                ),
              ),
            ],
          ),
          const Gap(20),

          // ── Bar Chart ─────────────────────────────────────────────────
          SizedBox(
            height: 130,
            child: BarChart(
              swapAnimationDuration: const Duration(milliseconds: 600),
              swapAnimationCurve: Curves.easeOutCubic,
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: maxY,
                barTouchData: BarTouchData(
                  touchCallback: (event, response) {
                    setState(() {
                      if (event is FlTapUpEvent || event is FlPanEndEvent) {
                        _touchedIndex =
                            response?.spot?.touchedBarGroupIndex ?? -1;
                      }
                    });
                  },
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (_) => AppColors.neutral10,
                    tooltipRoundedRadius: 8,
                    getTooltipItem: (group, _, rod, __) => BarTooltipItem(
                      _formatMinutes(rod.toY),
                      const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 24,
                      getTitlesWidget: (value, _) {
                        final idx = value.toInt();
                        final isToday = idx == _todayIndex;
                        return Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            _weekDays[idx],
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: isToday
                                  ? FontWeight.w800
                                  : FontWeight.w500,
                              color: isToday
                                  ? AppColors.primary
                                  : cs.onSurfaceVariant,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: maxY / 4,
                  getDrawingHorizontalLine: (_) => FlLine(
                    color: cs.outlineVariant.withOpacity(0.3),
                    strokeWidth: 1,
                    dashArray: [4, 4],
                  ),
                ),
                barGroups:
                    widget.weeklyMinutes.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final value = entry.value;
                  final isTouched = idx == _touchedIndex;
                  final isToday = idx == _todayIndex;

                  final barColor = isToday
                      ? AppColors.primary
                      : isTouched
                          ? AppColors.secondary
                          : (isDark
                              ? AppColors.neutral30
                              : const Color(0xFFE8E5F0));

                  return BarChartGroupData(
                    x: idx,
                    barRods: [
                      BarChartRodData(
                        toY: value,
                        color: barColor,
                        width: 22,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(8),
                          bottom: Radius.circular(4),
                        ),
                        backDrawRodData: BackgroundBarChartRodData(
                          show: true,
                          toY: maxY,
                          color: isDark
                              ? Colors.white.withOpacity(0.04)
                              : Colors.black.withOpacity(0.03),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
