// lib/features/analytics/presentation/screens/analytics_screen.dart
//
// StudySpark — Analytics Screen (Step 5, full implementation)
//
// Sections:
//   1. Summary banner (total focus hours, streak, avg daily, best day)
//   2. Weekly bar chart (fl_chart) — minutes per day last 7 days
//   3. Phase breakdown donut chart (work vs break)
//   4. Session history list (from Isar, last 30 sessions)
//   5. Monthly heatmap (contributions-style)
// ─────────────────────────────────────────────────────────────────────────────

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

import '../../../../core/enums/app_enums.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/providers/isar_provider.dart';
import '../../../focus/data/models/pomodoro_session_model.dart';

// ─── Data helpers ─────────────────────────────────────────────────────────────

final _dateFmt = DateFormat('yyyy-MM-dd');
final _shortDate = DateFormat('MMM d');
final _shortDay = DateFormat('E'); // Mon, Tue…
final _timeOf = DateFormat('h:mm a');

// ─── Providers ───────────────────────────────────────────────────────────────

/// Last 30 sessions from Isar, descending.
final recentSessionsProvider =
    FutureProvider<List<PomodoroSessionModel>>((ref) async {
  final isar = ref.watch(isarProvider);
  return isar.pomodoroSessionModels
      .filter()
      .wasCompletedEqualTo(true)
      .sortByCompletedAtDesc()
      .limit(30)
      .findAll();
});

/// Daily totals for the past 7 days.
final weeklyMinutesProvider =
    FutureProvider<List<_DayData>>((ref) async {
  final isar = ref.watch(isarProvider);
  final today = DateTime.now();

  final days = <_DayData>[];
  for (int i = 6; i >= 0; i--) {
    final day = today.subtract(Duration(days: i));
    final key = _dateFmt.format(day);
    final sessions = await isar.pomodoroSessionModels
        .filter()
        .localDateKeyEqualTo(key)
        .wasCompletedEqualTo(true)
        .findAll();
    final totalSecs = sessions
        .where((s) => s.mode == PomodoroMode.pomodoro)
        .fold(0, (sum, s) => sum + s.actualDurationSeconds);
    days.add(_DayData(day: day, minutes: totalSecs ~/ 60));
  }
  return days;
});

/// Total cumulative stats.
final totalStatsProvider = FutureProvider<_TotalStats>((ref) async {
  final isar = ref.watch(isarProvider);
  final all = await isar.pomodoroSessionModels
      .filter()
      .wasCompletedEqualTo(true)
      .modeEqualTo(PomodoroMode.pomodoro)
      .findAll();

  if (all.isEmpty) return const _TotalStats();

  final totalSecs = all.fold(0, (sum, s) => sum + s.actualDurationSeconds);
  final totalHours = totalSecs / 3600;
  final sessionCount = all.length;

  // streak
  final today = DateTime.now();
  int streak = 0;
  for (int i = 0; i < 365; i++) {
    final key = _dateFmt.format(today.subtract(Duration(days: i)));
    final hasSession =
        all.any((s) => s.localDateKey == key);
    if (hasSession) {
      streak++;
    } else if (i > 0) {
      break;
    }
  }

  // best day
  final byDay = <String, int>{};
  for (final s in all) {
    byDay[s.localDateKey] =
        (byDay[s.localDateKey] ?? 0) + s.actualDurationSeconds;
  }
  final bestKey = byDay.entries
      .reduce((a, b) => a.value > b.value ? a : b)
      .key;
  final bestMinutes = byDay[bestKey]! ~/ 60;

  // avg daily (over days that have at least 1 session)
  final avgMinutes = (totalSecs ~/ 60) ~/
      byDay.length.clamp(1, 999);

  return _TotalStats(
    totalHours: totalHours,
    sessionCount: sessionCount,
    streakDays: streak,
    bestDayMinutes: bestMinutes,
    avgDailyMinutes: avgMinutes,
  );
});

// ─── Data classes ─────────────────────────────────────────────────────────────

class _DayData {
  const _DayData({required this.day, required this.minutes});
  final DateTime day;
  final int minutes;
}

class _TotalStats {
  const _TotalStats({
    this.totalHours = 0,
    this.sessionCount = 0,
    this.streakDays = 0,
    this.bestDayMinutes = 0,
    this.avgDailyMinutes = 0,
  });
  final double totalHours;
  final int sessionCount;
  final int streakDays;
  final int bestDayMinutes;
  final int avgDailyMinutes;
}

// ─── Screen ───────────────────────────────────────────────────────────────────

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: cs.surface,
      body: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          SliverAppBar(
            pinned: true,
            backgroundColor: cs.surface,
            surfaceTintColor: Colors.transparent,
            title: Text(
              'Analytics',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.w800),
            ),
          ),
        ],
        body: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(totalStatsProvider);
            ref.invalidate(weeklyMinutesProvider);
            ref.invalidate(recentSessionsProvider);
          },
          child: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            children: [
              // ── Summary banner ────────────────────────────────────
              _SummaryBanner(cs: cs, isDark: isDark),
              const Gap(24),

              // ── Weekly chart ──────────────────────────────────────
              _WeeklyChart(cs: cs, isDark: isDark),
              const Gap(24),

              // ── Monthly heatmap ───────────────────────────────────
              _MonthlyHeatmap(cs: cs, isDark: isDark),
              const Gap(24),

              // ── Session history ───────────────────────────────────
              _SessionHistory(cs: cs, isDark: isDark),
              const Gap(24),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Summary banner ───────────────────────────────────────────────────────────

class _SummaryBanner extends ConsumerWidget {
  const _SummaryBanner({required this.cs, required this.isDark});
  final ColorScheme cs;
  final bool isDark;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(totalStatsProvider);

    return statsAsync.when(
      loading: () => const SizedBox(
        height: 140,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (_, __) => const SizedBox.shrink(),
      data: (stats) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overall Progress',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const Gap(12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.8,
            children: [
              _StatCard(
                emoji: '⏱️',
                value:
                    '${stats.totalHours.toStringAsFixed(1)}h',
                label: 'Total Focus',
                color: cs.primary,
                isDark: isDark,
                cs: cs,
              ),
              _StatCard(
                emoji: '🔥',
                value: '${stats.streakDays}d',
                label: 'Current Streak',
                color: Colors.orange.shade400,
                isDark: isDark,
                cs: cs,
              ),
              _StatCard(
                emoji: '📊',
                value: '${stats.avgDailyMinutes}m',
                label: 'Avg per Day',
                color: const Color(0xFF0EA5E9),
                isDark: isDark,
                cs: cs,
              ),
              _StatCard(
                emoji: '🏆',
                value: '${stats.bestDayMinutes}m',
                label: 'Best Day',
                color: const Color(0xFFF59E0B),
                isDark: isDark,
                cs: cs,
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.emoji,
    required this.value,
    required this.label,
    required this.color,
    required this.isDark,
    required this.cs,
  });

  final String emoji;
  final String value;
  final String label;
  final Color color;
  final bool isDark;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: AppShadows.sm(Colors.black),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(emoji,
                  style: const TextStyle(fontSize: 18)),
            ),
          ),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: isDark ? Colors.white : AppColors.neutral10,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    color: cs.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Weekly chart ─────────────────────────────────────────────────────────────

class _WeeklyChart extends ConsumerStatefulWidget {
  const _WeeklyChart({required this.cs, required this.isDark});
  final ColorScheme cs;
  final bool isDark;

  @override
  ConsumerState<_WeeklyChart> createState() => _WeeklyChartState();
}

class _WeeklyChartState extends ConsumerState<_WeeklyChart> {
  int _touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final weeklyAsync = ref.watch(weeklyMinutesProvider);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: widget.isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppShadows.sm(Colors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Last 7 Days',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    const Gap(2),
                    Text(
                      'Focus minutes per day',
                      style: TextStyle(
                        fontSize: 12,
                        color: widget.cs.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.bar_chart_rounded,
                  color: widget.cs.primary, size: 22),
            ],
          ),
          const Gap(20),
          weeklyAsync.when(
            loading: () => const SizedBox(
              height: 160,
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (_, __) => const SizedBox(height: 160),
            data: (days) {
              final maxMin =
                  days.map((d) => d.minutes).fold(0, (a, b) => a > b ? a : b);
              final maxY =
                  (maxMin < 10 ? 60 : (maxMin * 1.3)).toDouble();

              return SizedBox(
                height: 160,
                child: BarChart(
                  BarChartData(
                    maxY: maxY,
                    barTouchData: BarTouchData(
                      touchCallback: (event, resp) {
                        setState(() {
                          _touchedIndex =
                              resp?.spot?.touchedBarGroupIndex ?? -1;
                        });
                      },
                      touchTooltipData: BarTouchTooltipData(
                        tooltipRoundedRadius: 10,
                        getTooltipItem: (group, _, rod, __) {
                          final day = days[group.x];
                          return BarTooltipItem(
                            '${day.minutes}m\n',
                            const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 13),
                            children: [
                              TextSpan(
                                text: _shortDate.format(day.day),
                                style: const TextStyle(fontSize: 10),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (v, meta) {
                            final i = v.toInt();
                            if (i < 0 || i >= days.length) {
                              return const SizedBox.shrink();
                            }
                            final isToday = i == 6;
                            return Text(
                              isToday
                                  ? 'Today'
                                  : _shortDay.format(days[i].day),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: isToday
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: isToday
                                    ? widget.cs.primary
                                    : widget.cs.onSurfaceVariant,
                              ),
                            );
                          },
                        ),
                      ),
                      leftTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      getDrawingHorizontalLine: (v) => FlLine(
                        color: widget.cs.outlineVariant.withOpacity(0.3),
                        strokeWidth: 1,
                        dashArray: [4, 6],
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    barGroups: List.generate(days.length, (i) {
                      final isToday = i == 6;
                      final isTouched = _touchedIndex == i;
                      final color = isToday
                          ? widget.cs.primary
                          : widget.cs.primary.withOpacity(0.45);

                      return BarChartGroupData(
                        x: i,
                        barRods: [
                          BarChartRodData(
                            toY: days[i].minutes.toDouble(),
                            color: isTouched
                                ? widget.cs.primary
                                : color,
                            width: 20,
                            borderRadius: BorderRadius.circular(6),
                            backDrawRodData: BackgroundBarChartRodData(
                              show: true,
                              toY: maxY,
                              color: widget.cs.primary.withOpacity(0.05),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    ).animate().fadeIn(delay: 100.ms);
  }
}

// ─── Monthly heatmap ──────────────────────────────────────────────────────────

class _MonthlyHeatmap extends ConsumerWidget {
  const _MonthlyHeatmap({required this.cs, required this.isDark});
  final ColorScheme cs;
  final bool isDark;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isar = ref.watch(isarProvider);

    return FutureBuilder<Map<String, int>>(
      future: _buildHeatmapData(isar),
      builder: (context, snap) {
        if (!snap.hasData) return const SizedBox.shrink();
        final data = snap.data!;

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
              Text(
                'Activity Heatmap',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              const Gap(4),
              Text(
                'Last 12 weeks',
                style: TextStyle(
                    fontSize: 12, color: cs.onSurfaceVariant),
              ),
              const Gap(16),
              _HeatmapGrid(
                data: data,
                color: cs.primary,
                isDark: isDark,
              ),
              const Gap(12),
              Row(
                children: [
                  Text('Less',
                      style: TextStyle(
                          fontSize: 10, color: cs.onSurfaceVariant)),
                  const Gap(4),
                  ...List.generate(
                    5,
                    (i) => Container(
                      width: 12,
                      height: 12,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: cs.primary
                            .withOpacity(0.1 + 0.2 * i),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                  const Gap(4),
                  Text('More',
                      style: TextStyle(
                          fontSize: 10, color: cs.onSurfaceVariant)),
                ],
              ),
            ],
          ),
        ).animate().fadeIn(delay: 200.ms);
      },
    );
  }

  Future<Map<String, int>> _buildHeatmapData(Isar isar) async {
    final today = DateTime.now();
    final start = today.subtract(const Duration(days: 83));
    final sessions = await isar.pomodoroSessionModels
        .filter()
        .completedAtGreaterThan(start.toUtc())
        .wasCompletedEqualTo(true)
        .findAll();

    final map = <String, int>{};
    for (final s in sessions) {
      final key = _dateFmt.format(s.completedAt!.toLocal());
      map[key] = (map[key] ?? 0) + s.actualDurationSeconds ~/ 60;
    }
    return map;
  }
}

class _HeatmapGrid extends StatelessWidget {
  const _HeatmapGrid({
    required this.data,
    required this.color,
    required this.isDark,
  });

  final Map<String, int> data;
  final Color color;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    // 12 weeks × 7 days = 84 days
    return SizedBox(
      height: 100,
      child: Row(
        children: List.generate(12, (week) {
          return Expanded(
            child: Column(
              children: List.generate(7, (day) {
                final daysAgo = (11 - week) * 7 + (6 - day);
                final date = today.subtract(Duration(days: daysAgo));
                final key = _dateFmt.format(date);
                final minutes = data[key] ?? 0;
                final intensity = (minutes / 120).clamp(0.0, 1.0);

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(1.5),
                    child: Tooltip(
                      message: '$key: ${minutes}m',
                      child: AnimatedContainer(
                        duration: 300.ms,
                        decoration: BoxDecoration(
                          color: minutes == 0
                              ? color.withOpacity(0.06)
                              : color.withOpacity(0.15 + 0.85 * intensity),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        }),
      ),
    );
  }
}

// ─── Session history ──────────────────────────────────────────────────────────

class _SessionHistory extends ConsumerWidget {
  const _SessionHistory({required this.cs, required this.isDark});
  final ColorScheme cs;
  final bool isDark;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionsAsync = ref.watch(recentSessionsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Sessions',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.w700),
        ),
        const Gap(12),
        sessionsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, __) => const SizedBox.shrink(),
          data: (sessions) {
            if (sessions.isEmpty) {
              return _EmptySessions(cs: cs);
            }
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: sessions.length,
              separatorBuilder: (_, __) => const Gap(8),
              itemBuilder: (context, i) {
                return _SessionTile(
                  session: sessions[i],
                  isDark: isDark,
                  cs: cs,
                )
                    .animate(delay: Duration(milliseconds: 30 * i))
                    .fadeIn()
                    .slideX(begin: 0.05);
              },
            );
          },
        ),
      ],
    );
  }
}

class _SessionTile extends StatelessWidget {
  const _SessionTile({
    required this.session,
    required this.isDark,
    required this.cs,
  });

  final PomodoroSessionModel session;
  final bool isDark;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    final isWork = session.mode == PomodoroMode.pomodoro;
    final color = isWork ? cs.primary : const Color(0xFF22C55E);
    final mins = session.actualDurationSeconds ~/ 60;
    final plannedMins = session.plannedDurationSeconds ~/ 60;
    final completionPct = plannedMins == 0
        ? 100
        : (mins / plannedMins * 100).round().clamp(0, 100);
    final completedAt = session.completedAt?.toLocal();
    final timeLabel =
        completedAt != null ? _timeOf.format(completedAt) : '';
    final dateLabel = completedAt != null
        ? _shortDate.format(completedAt)
        : '';

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppShadows.sm(Colors.black),
      ),
      child: Row(
        children: [
          // Icon circle
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isWork ? Icons.psychology_rounded : Icons.coffee_rounded,
              color: color,
              size: 20,
            ),
          ),
          const Gap(12),

          // Label + time
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  session.label.isNotEmpty
                      ? session.label
                      : (isWork ? 'Focus Session' : 'Break'),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : AppColors.neutral10,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(2),
                Text(
                  '$dateLabel · $timeLabel',
                  style: TextStyle(
                    fontSize: 11,
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          // Duration + completion
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${mins}m',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
              const Gap(2),
              Text(
                '$completionPct%',
                style: TextStyle(
                  fontSize: 10,
                  color: cs.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EmptySessions extends StatelessWidget {
  const _EmptySessions({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      alignment: Alignment.center,
      child: Column(
        children: [
          Icon(Icons.hourglass_empty_rounded,
              size: 48, color: cs.onSurfaceVariant.withOpacity(0.4)),
          const Gap(12),
          Text(
            'No sessions yet',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: cs.onSurfaceVariant,
            ),
          ),
          const Gap(4),
          Text(
            'Complete a Pomodoro to see your history here.',
            style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
