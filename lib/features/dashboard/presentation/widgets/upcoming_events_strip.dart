// lib/features/dashboard/presentation/widgets/upcoming_events_strip.dart
//
// Horizontal scrollable timetable strip for the dashboard.

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../core/theme/app_theme.dart';

/// A single timetable event data object (lightweight, no Isar dependency).
class TimetableSlot {
  const TimetableSlot({
    required this.subject,
    required this.timeRange,
    required this.room,
    required this.color,
    this.isNow = false,
    this.isNext = false,
  });

  final String subject;
  final String timeRange;
  final String room;
  final Color color;
  final bool isNow;
  final bool isNext;
}

class UpcomingEventsStrip extends StatelessWidget {
  const UpcomingEventsStrip({
    super.key,
    required this.slots,
    this.onViewAll,
  });

  final List<TimetableSlot> slots;
  final VoidCallback? onViewAll;

  @override
  Widget build(BuildContext context) {
    if (slots.isEmpty) {
      return _NoClassesCard();
    }
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemCount: slots.length + (onViewAll != null ? 1 : 0),
        separatorBuilder: (_, __) => const Gap(12),
        itemBuilder: (context, index) {
          if (index == slots.length) {
            return _ViewAllCard(onTap: onViewAll);
          }
          return _SlotCard(slot: slots[index]);
        },
      ),
    );
  }
}

class _NoClassesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppShadows.sm(Colors.black),
      ),
      child: Row(
        children: [
          Icon(Icons.free_cancellation_rounded,
              color: cs.onSurfaceVariant, size: 28),
          const Gap(12),
          Text(
            'No classes today — enjoy the day!',
            style: TextStyle(
              color: cs.onSurfaceVariant,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _SlotCard extends StatelessWidget {
  const _SlotCard({required this.slot});
  final TimetableSlot slot;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 150,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: slot.isNow
            ? slot.color
            : (isDark ? AppColors.surfaceDark : Colors.white),
        borderRadius: BorderRadius.circular(18),
        border: slot.isNow
            ? null
            : Border.all(color: slot.color.withOpacity(0.2), width: 1.5),
        boxShadow: slot.isNow
            ? AppShadows.glow(slot.color)
            : AppShadows.sm(Colors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status indicator row
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: slot.isNow ? Colors.white : slot.color,
                  shape: BoxShape.circle,
                ),
              ),
              if (slot.isNow) ...[
                const Gap(6),
                _Chip(label: 'NOW', color: Colors.white),
              ] else if (slot.isNext) ...[
                const Gap(6),
                _Chip(label: 'NEXT', color: slot.color),
              ],
            ],
          ),
          const Spacer(),
          Text(
            slot.subject,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: slot.isNow ? Colors.white : cs.onSurface,
              height: 1.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Gap(4),
          Text(
            slot.timeRange,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: slot.isNow ? Colors.white70 : cs.onSurfaceVariant,
            ),
          ),
          const Gap(2),
          Row(
            children: [
              Icon(Icons.location_on_rounded,
                  size: 10,
                  color: slot.isNow ? Colors.white60 : slot.color),
              const Gap(2),
              Text(
                slot.room,
                style: TextStyle(
                  fontSize: 10,
                  color: slot.isNow ? Colors.white60 : slot.color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.18),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 9,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _ViewAllCard extends StatelessWidget {
  const _ViewAllCard({this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 72,
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: cs.outlineVariant.withOpacity(0.3),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chevron_right_rounded, color: cs.primary, size: 28),
            const Gap(4),
            Text(
              'All',
              style: TextStyle(
                fontSize: 11,
                color: cs.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
