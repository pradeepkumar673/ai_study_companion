// lib/features/profile/presentation/widgets/xp_progress_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_theme.dart';

class XpProgressCard extends StatelessWidget {
  const XpProgressCard({super.key});

  // Mock data — replace with real profile provider values
  static const int _currentXp = 1240;
  static const int _levelXp = 1000;
  static const int _nextLevelXp = 2000;
  static const int _level = 3;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final progress =
        (_currentXp - _levelXp) / (_nextLevelXp - _levelXp);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(isDark ? 0.25 : 0.08),
            AppColors.primary.withOpacity(isDark ? 0.1 : 0.03),
          ],
        ),
        borderRadius: AppShapes.r16,
        border: Border.all(
            color: AppColors.primary.withOpacity(0.25), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: AppShapes.r8,
                        ),
                        child: Text(
                          'LVL $_level',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Scholar',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$_currentXp XP  •  ${_nextLevelXp - _currentXp} XP to next level',
                    style: TextStyle(
                        color: cs.onSurface.withOpacity(0.65),
                        fontSize: 11),
                  ),
                ],
              ),
              // XP ring
              SizedBox(
                width: 52,
                height: 52,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 5,
                      backgroundColor:
                          AppColors.primary.withOpacity(0.15),
                      valueColor:
                          AlwaysStoppedAnimation(AppColors.primary),
                    ),
                    Text(
                      '⭐',
                      style: const TextStyle(fontSize: 22),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Progress bar
          ClipRRect(
            borderRadius: AppShapes.r8,
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: AppColors.primary.withOpacity(0.12),
              valueColor:
                  AlwaysStoppedAnimation(AppColors.primary),
            ),
          ).animate().scaleX(
              begin: 0, duration: 800.ms, curve: Curves.easeOutCubic),
          const SizedBox(height: 8),
          // Milestone labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$_levelXp XP',
                style: TextStyle(
                    fontSize: 10,
                    color: cs.onSurface.withOpacity(0.45)),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.tertiary.withOpacity(0.15),
                  borderRadius: AppShapes.r8,
                ),
                child: Text(
                  '🎯 ${(progress * 100).round()}% to Level ${_level + 1}',
                  style: TextStyle(
                    color: AppColors.tertiary,
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                  ),
                ),
              ),
              Text(
                '$_nextLevelXp XP',
                style: TextStyle(
                    fontSize: 10,
                    color: cs.onSurface.withOpacity(0.45)),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: 50.ms);
  }
}