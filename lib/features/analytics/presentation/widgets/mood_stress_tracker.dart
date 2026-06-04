// lib/features/analytics/presentation/widgets/mood_stress_tracker.dart
//
// StudySpark — Mood & Stress Tracker Widget
//
// Shows last 14 days of mood/stress/energy on a fl_chart line chart, plus a
// log-today button that opens a bottom sheet for quick check-in.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import '../../../../core/enums/app_enums.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/providers/repository_providers.dart';
import '../../../mood/data/models/mood_entry_model.dart';
import '../../data/repositories/analytics_repository.dart';
import '../providers/analytics_providers.dart';

final _dateFmt = DateFormat('yyyy-MM-dd');
final _shortDay = DateFormat('E');

class MoodStressTracker extends ConsumerWidget {
  const MoodStressTracker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final moodAsync = ref.watch(recentMoodEntriesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Log Today Button ─────────────────────────────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Last 14 Days',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: cs.onSurfaceVariant),
            ),
            FilledButton.tonal(
              onPressed: () => _showLogSheet(context, ref),
              child: const Text('Log Today'),
            ),
          ],
        ),
        const Gap(16),

        // ── Chart ────────────────────────────────────────────────────
        moodAsync.when(
          loading: () =>
              const SizedBox(height: 200, child: Center(child: CircularProgressIndicator())),
          error: (_, __) => const SizedBox.shrink(),
          data: (rawEntries) {
            final entries = rawEntries.cast<MoodEntryModel>();
            if (entries.isEmpty) {
              return _EmptyMood(cs: cs);
            }
            return _MoodChart(
                entries: entries, cs: cs, isDark: isDark);
          },
        ),

        const Gap(20),

        // ── Correlation section ───────────────────────────────────────
        _MoodCorrelationSection(cs: cs),
      ],
    );
  }

  void _showLogSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => _MoodLogSheet(onSaved: () {
        ref.invalidate(recentMoodEntriesProvider);
        ref.invalidate(moodCorrelationsProvider);
        ref.invalidate(weeklyReportProvider);
        ref.invalidate(dailyReportProvider);
      }),
    );
  }
}

// ─── Mood Chart (Line Chart) ──────────────────────────────────────────────────

class _MoodChart extends StatelessWidget {
  const _MoodChart(
      {required this.entries, required this.cs, required this.isDark});

  final List<MoodEntryModel> entries;
  final ColorScheme cs;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    // Build 14-day data aligned to calendar days
    final today = DateTime.now();
    final days = List.generate(14, (i) => today.subtract(Duration(days: 13 - i)));
    final byKey = {for (final e in entries) e.localDateKey: e};

    final moodSpots = <FlSpot>[];
    final stressSpots = <FlSpot>[];
    final energySpots = <FlSpot>[];

    for (int i = 0; i < days.length; i++) {
      final key = _dateFmt.format(days[i]);
      final entry = byKey[key];
      if (entry != null) {
        moodSpots.add(FlSpot(i.toDouble(), entry.moodScore.toDouble()));
        stressSpots.add(FlSpot(i.toDouble(), entry.stressLevel.toDouble()));
        energySpots.add(FlSpot(i.toDouble(), entry.energyLevel.toDouble()));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Legend
        Row(
          children: [
            _LineLegend(color: AppColors.chartGreen, label: 'Mood'),
            const Gap(16),
            _LineLegend(color: AppColors.chartPink, label: 'Stress'),
            const Gap(16),
            _LineLegend(color: AppColors.chartBlue, label: 'Energy'),
          ],
        ),
        const Gap(12),
        SizedBox(
          height: 220,
          child: LineChart(
            LineChartData(
              minX: 0,
              maxX: 13,
              minY: 0,
              maxY: 5,
              clipData: const FlClipData.all(),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: 1,
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
                    interval: 2,
                    getTitlesWidget: (value, meta) {
                      final i = value.toInt();
                      if (i < 0 || i >= days.length) {
                        return const SizedBox.shrink();
                      }
                      return Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          _shortDay.format(days[i]),
                          style: TextStyle(
                              fontSize: 10, color: cs.onSurfaceVariant),
                        ),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 22,
                    interval: 1,
                    getTitlesWidget: (v, _) {
                      final labels = ['', '😞', '😕', '😐', '😊', '😄'];
                      final i = v.toInt();
                      if (i < 0 || i >= labels.length) {
                        return const SizedBox.shrink();
                      }
                      return Text(labels[i], style: const TextStyle(fontSize: 11));
                    },
                  ),
                ),
                topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false)),
              ),
              lineBarsData: [
                _buildLine(moodSpots, AppColors.chartGreen),
                _buildLine(stressSpots, AppColors.chartPink),
                _buildLine(energySpots, AppColors.chartBlue),
              ],
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipItems: (spots) {
                    return spots.map((s) {
                      final labels = ['Mood', 'Stress', 'Energy'];
                      return LineTooltipItem(
                        '${labels[s.barIndex]}: ${s.y.toStringAsFixed(1)}',
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
        ),
      ],
    );
  }

  LineChartBarData _buildLine(List<FlSpot> spots, Color color) =>
      LineChartBarData(
        spots: spots,
        isCurved: true,
        color: color,
        barWidth: 2.5,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
          getDotPainter: (spot, _, __, ___) => FlDotCirclePainter(
            radius: 3,
            color: color,
            strokeColor: Colors.white,
            strokeWidth: 1.5,
          ),
        ),
        belowBarData: BarAreaData(
          show: true,
          color: color.withOpacity(0.06),
        ),
      );
}

class _LineLegend extends StatelessWidget {
  const _LineLegend({required this.color, required this.label});
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 16, height: 3, color: color,
            margin: const EdgeInsets.only(right: 4)),
        Text(label,
            style: TextStyle(
                fontSize: 11,
                color: Theme.of(context).colorScheme.onSurfaceVariant)),
      ],
    );
  }
}

// ─── Mood Correlation Section ─────────────────────────────────────────────────

class _MoodCorrelationSection extends ConsumerWidget {
  const _MoodCorrelationSection({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final corrAsync = ref.watch(moodCorrelationsProvider);
    return corrAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (correlations) {
        if (correlations.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mood vs Productivity',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            const Gap(8),
            Text(
              'Average focus minutes and tasks completed on each mood day.',
              style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
            ),
            const Gap(12),
            ...correlations.map((c) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _CorrelationRow(corr: c, cs: cs)
                      .animate()
                      .fadeIn()
                      .slideX(begin: 0.04),
                )),
          ],
        );
      },
    );
  }
}

class _CorrelationRow extends StatelessWidget {
  const _CorrelationRow({required this.corr, required this.cs});
  final MoodCorrelation corr;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(corr.moodType.emoji, style: const TextStyle(fontSize: 22)),
        const Gap(8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(corr.moodType.label,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600)),
              Text('${corr.sampleCount} days logged',
                  style: TextStyle(fontSize: 10, color: cs.onSurfaceVariant)),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${corr.avgFocusMinutes.toStringAsFixed(0)}m focus',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
            Text(
              '${corr.avgTasksCompleted.toStringAsFixed(1)} tasks',
              style: TextStyle(fontSize: 10, color: cs.onSurfaceVariant),
            ),
          ],
        ),
      ],
    );
  }
}

// ─── Mood Log Bottom Sheet ────────────────────────────────────────────────────

class _MoodLogSheet extends ConsumerStatefulWidget {
  const _MoodLogSheet({required this.onSaved});
  final VoidCallback onSaved;

  @override
  ConsumerState<_MoodLogSheet> createState() => _MoodLogSheetState();
}

class _MoodLogSheetState extends ConsumerState<_MoodLogSheet> {
  MoodType _mood = MoodType.neutral;
  int _energy = 3;
  int _stress = 3;
  double _sleep = 7;
  final _noteController = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    final repo = ref.read(moodRepositoryProvider);
    await repo.logMood(
      mood: _mood,
      energyLevel: _energy,
      stressLevel: _stress,
      sleepHours: _sleep,
      note: _noteController.text.trim(),
    );
    setState(() => _saving = false);
    widget.onSaved();
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.fromLTRB(
          24, 20, 24, MediaQuery.of(context).viewInsets.bottom + 24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: cs.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const Gap(20),
            Text(
              'How are you feeling today?',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            const Gap(20),

            // Mood picker
            Text('Mood',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: cs.onSurfaceVariant,
                    fontSize: 13)),
            const Gap(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: MoodType.values.map((m) {
                final selected = m == _mood;
                return GestureDetector(
                  onTap: () => setState(() => _mood = m),
                  child: AnimatedContainer(
                    duration: 200.ms,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: selected
                          ? cs.primaryContainer
                          : cs.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                      border: selected
                          ? Border.all(color: cs.primary, width: 2)
                          : null,
                    ),
                    child: Column(
                      children: [
                        Text(m.emoji, style: const TextStyle(fontSize: 24)),
                        const Gap(2),
                        Text(m.label,
                            style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                                color: selected
                                    ? cs.primary
                                    : cs.onSurfaceVariant)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const Gap(20),

            // Energy slider
            _buildSlider('Energy Level', _energy, 1, 5, (v) {
              setState(() => _energy = v.round());
            }, cs, '⚡'),
            const Gap(16),

            // Stress slider
            _buildSlider('Stress Level', _stress, 1, 5, (v) {
              setState(() => _stress = v.round());
            }, cs, '😤'),
            const Gap(16),

            // Sleep slider
            _buildSleepSlider(cs),
            const Gap(16),

            // Note
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(
                labelText: 'Note (optional)',
                hintText: 'What influenced your mood today?',
              ),
              maxLines: 2,
            ),
            const Gap(24),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _saving ? null : _save,
                child: _saving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Log Mood'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlider(String label, int value, int min, int max,
      ValueChanged<double> onChanged, ColorScheme cs, String emoji) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 16)),
            const Gap(6),
            Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: cs.onSurfaceVariant)),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: cs.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text('$value / $max',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: cs.primary)),
            ),
          ],
        ),
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 4,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
          ),
          child: Slider(
            value: value.toDouble(),
            min: min.toDouble(),
            max: max.toDouble(),
            divisions: max - min,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildSleepSlider(ColorScheme cs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('🌙', style: TextStyle(fontSize: 16)),
            const Gap(6),
            Text('Sleep Hours',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: cs.onSurfaceVariant)),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: cs.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text('${_sleep.toStringAsFixed(1)}h',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: cs.primary)),
            ),
          ],
        ),
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 4,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
          ),
          child: Slider(
            value: _sleep,
            min: 0,
            max: 12,
            divisions: 24,
            onChanged: (v) => setState(() => _sleep = v),
          ),
        ),
      ],
    );
  }
}

// ─── Empty state ──────────────────────────────────────────────────────────────

class _EmptyMood extends StatelessWidget {
  const _EmptyMood({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.mood_rounded,
              size: 40, color: cs.onSurfaceVariant.withOpacity(0.35)),
          const Gap(8),
          Text('No mood logs yet',
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: cs.onSurfaceVariant)),
          const Gap(4),
          Text('Tap "Log Today" to start tracking.',
              style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant)),
        ],
      ),
    );
  }
}
