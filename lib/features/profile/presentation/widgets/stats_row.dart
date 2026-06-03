// lib/features/profile/presentation/widgets/stats_row.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_theme.dart';

class ProfileStatsRow extends StatelessWidget {
  const ProfileStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final stats = [
      (label: 'Tasks Done', value: '48', icon: Icons.check_circle_rounded, color: AppColors.secondary, sub: 'This month'),
      (label: 'Focus Hrs', value: '23h', icon: Icons.timer_rounded, color: AppColors.primary, sub: 'Total'),
      (label: 'Day Streak', value: '7', icon: Icons.local_fire_department_rounded, color: Colors.deepOrange, sub: 'Current'),
      (label: 'Notes', value: '12', icon: Icons.sticky_note_2_rounded, color: AppColors.tertiary, sub: 'Created'),
    ];

    return Row(
      children: stats.asMap().entries.map((e) {
        final s = e.value;
        final isFirst = e.key == 0;
        final isLast = e.key == stats.length - 1;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: isFirst ? 0 : 5,
              right: isLast ? 0 : 5,
            ),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
              decoration: BoxDecoration(
                color: isDark ? AppColors.neutral20 : cs.surface,
                borderRadius: AppShapes.r16,
                border: Border.all(
                    color: s.color.withOpacity(0.2), width: 1),
                boxShadow: [
                  BoxShadow(
                    color: s.color.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(s.icon, color: s.color, size: 20),
                  const SizedBox(height: 5),
                  Text(
                    s.value,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w800, color: s.color),
                  ),
                  Text(
                    s.label,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(
                            color: cs.onSurface,
                            fontWeight: FontWeight.w600,
                            fontSize: 9.5),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    s.sub,
                    style: TextStyle(
                        fontSize: 9,
                        color: cs.onSurfaceVariant.withOpacity(0.7)),
                  ),
                ],
              ),
            )
                .animate(
                    delay: Duration(milliseconds: 60 * e.key))
                .fadeIn(duration: 350.ms)
                .slideY(begin: 0.3, end: 0, curve: Curves.easeOut),
          ),
        );
      }).toList(),
    );
  }
}