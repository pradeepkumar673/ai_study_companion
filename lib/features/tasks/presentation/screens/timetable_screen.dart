// lib/features/tasks/presentation/screens/timetable_screen.dart
//
// StudySpark — Personalised Timetable Screen (Step 5)
//
// Displays a colour-coded weekly timetable grid:
//   Rows   = hours (0–23)
//   Columns = weekdays (Mon–Sun)
//
// Slots are loaded from [timetableProvider] (hardcoded wellness +
// study blocks + from SubjectModel.scheduleSlots if wired up).
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../providers/tasks_provider.dart';

class TimetableScreen extends ConsumerStatefulWidget {
  const TimetableScreen({super.key});

  @override
  ConsumerState<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends ConsumerState<TimetableScreen> {
  int _selectedDay = DateTime.now().weekday; // 1=Mon … 7=Sun

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final slotsAsync = ref.watch(timetableProvider);

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        title: const Text('Weekly Timetable'),
        actions: [
          IconButton(
            icon: const Icon(Icons.today_rounded),
            tooltip: 'Jump to today',
            onPressed: () =>
                setState(() => _selectedDay = DateTime.now().weekday),
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Day selector strip ──
          _DayStrip(
            selected: _selectedDay,
            onSelected: (d) => setState(() => _selectedDay = d),
          ),

          // ── Timetable for selected day ──
          Expanded(
            child: slotsAsync.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (slots) {
                final daySlots = slots
                    .where((s) => s.weekday == _selectedDay)
                    .toList()
                  ..sort((a, b) => a.startHour.compareTo(b.startHour));

                if (daySlots.isEmpty) {
                  return _EmptyDay();
                }

                return _DayTimeline(slots: daySlots);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Day selector strip ───────────────────────────────────────────────────────

class _DayStrip extends StatelessWidget {
  const _DayStrip({required this.selected, required this.onSelected});

  final int selected;
  final ValueChanged<int> onSelected;

  static const _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final today = DateTime.now().weekday;

    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        boxShadow: [
          BoxShadow(
            color: cs.shadow.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(7, (i) {
          final day = i + 1;
          final isSelected = day == selected;
          final isToday = day == today;
          return GestureDetector(
            onTap: () => onSelected(day),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 44,
              decoration: BoxDecoration(
                color: isSelected ? cs.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _days[i],
                    style: TextStyle(
                      fontSize: 11,
                      color: isSelected
                          ? cs.onPrimary
                          : cs.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  if (isToday && !isSelected)
                    Container(
                      width: 5, height: 5,
                      decoration: BoxDecoration(
                        color: cs.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ─── Day timeline ─────────────────────────────────────────────────────────────

class _DayTimeline extends StatelessWidget {
  const _DayTimeline({required this.slots});
  final List<TimetableSlot> slots;

  static Color _typeColor(String type, ColorScheme cs) => switch (type) {
        'sleep'  => const Color(0xFF5C6BC0),
        'study'  => cs.primary,
        'class'  => cs.secondary,
        'break'  => cs.tertiary,
        _        => cs.outline,
      };

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: slots.length,
      itemBuilder: (ctx, i) {
        final slot = slots[i];
        final color = _typeColor(slot.type, cs);
        final duration = slot.endHour - slot.startHour;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Time gutter
            Spacer(
              flex: 0,
            ),
            SizedBox(
              width: 56,
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  _formatHour(slot.startHour),
                  style: Theme.of(context).textTheme.labelSmall!
                      .copyWith(color: cs.onSurfaceVariant),
                  textAlign: TextAlign.right,
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Timeline line + dot
            Column(
              children: [
                Container(
                  width: 12, height: 12,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  width: 2,
                  height: (duration * 40.0).clamp(20, 120),
                  color: color.withOpacity(0.3),
                ),
              ],
            ),

            const SizedBox(width: 12),

            // Slot card
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: AppShapes.r12,
                  border: Border.all(
                      color: color.withOpacity(0.25), width: 1),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            slot.label,
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            slot.timeLabel,
                            style: Theme.of(context).textTheme.bodySmall!
                                .copyWith(color: cs.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${duration}h',
                        style: TextStyle(
                          color: color,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ).animate(delay: Duration(milliseconds: i * 30)).fadeIn().slideX(begin: 0.05),
            ),
          ],
        );
      },
    );
  }

  String _formatHour(int h) {
    if (h == 0) return '12 AM';
    if (h < 12) return '$h AM';
    if (h == 12) return '12 PM';
    return '${h - 12} PM';
  }
}

// ─── Empty day ────────────────────────────────────────────────────────────────

class _EmptyDay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('📅', style: TextStyle(fontSize: 56)),
          const SizedBox(height: 16),
          Text('Nothing scheduled',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text(
            'This day is free — enjoy it!',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
