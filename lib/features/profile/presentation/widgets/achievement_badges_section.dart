// lib/features/profile/presentation/widgets/achievement_badges_section.dart
//
// StudySpark — Achievement Badges Section
//
// Displays ALL badges (locked + unlocked) in a scrollable grid.
// Unlocked badges show with full colour + a shimmer glow; locked badges
// appear greyed-out with a lock icon overlay.
// Tapping any badge shows a detail bottom-sheet.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';

// ── Mock badge data ───────────────────────────────────────────────────────────

enum BadgeTier { bronze, silver, gold, platinum }

class BadgeData {
  const BadgeData({
    required this.key,
    required this.name,
    required this.description,
    required this.emoji,
    required this.category,
    required this.tier,
    required this.xpReward,
    this.isUnlocked = false,
    this.progress = 0,
    this.target = 1,
    this.unlockedAt,
  });

  final String key;
  final String name;
  final String description;
  final String emoji;
  final String category;
  final BadgeTier tier;
  final int xpReward;
  final bool isUnlocked;
  final int progress;
  final int target;
  final DateTime? unlockedAt;

  Color get tierColor {
    switch (tier) {
      case BadgeTier.bronze:
        return const Color(0xFFCD7F32);
      case BadgeTier.silver:
        return const Color(0xFFC0C0C0);
      case BadgeTier.gold:
        return const Color(0xFFFFD700);
      case BadgeTier.platinum:
        return const Color(0xFF00CFCF);
    }
  }
}

// Mock badge catalog
final _mockBadges = [
  // Streak
  const BadgeData(
    key: 'streak_3',
    name: '3-Day Spark',
    description: 'Study for 3 days in a row',
    emoji: '🔥',
    category: 'Streak',
    tier: BadgeTier.bronze,
    xpReward: 30,
    isUnlocked: true,
    progress: 3,
    target: 3,
  ),
  const BadgeData(
    key: 'streak_7',
    name: 'Week Warrior',
    description: 'Maintain a 7-day study streak',
    emoji: '⚡',
    category: 'Streak',
    tier: BadgeTier.silver,
    xpReward: 100,
    isUnlocked: true,
    progress: 7,
    target: 7,
  ),
  const BadgeData(
    key: 'streak_30',
    name: 'Monthly Master',
    description: 'Study every day for 30 days',
    emoji: '🌟',
    category: 'Streak',
    tier: BadgeTier.gold,
    xpReward: 300,
    isUnlocked: false,
    progress: 7,
    target: 30,
  ),
  const BadgeData(
    key: 'streak_100',
    name: 'Century Scholar',
    description: '100-day unbroken streak',
    emoji: '💎',
    category: 'Streak',
    tier: BadgeTier.platinum,
    xpReward: 1000,
    isUnlocked: false,
    progress: 7,
    target: 100,
  ),
  // Tasks
  const BadgeData(
    key: 'first_task',
    name: 'First Step',
    description: 'Complete your first task',
    emoji: '✅',
    category: 'Tasks',
    tier: BadgeTier.bronze,
    xpReward: 20,
    isUnlocked: true,
    progress: 1,
    target: 1,
  ),
  const BadgeData(
    key: 'tasks_10',
    name: 'Task Ninja',
    description: 'Complete 10 tasks',
    emoji: '🥷',
    category: 'Tasks',
    tier: BadgeTier.bronze,
    xpReward: 50,
    isUnlocked: true,
    progress: 10,
    target: 10,
  ),
  const BadgeData(
    key: 'tasks_50',
    name: 'Productivity Pro',
    description: 'Complete 50 tasks',
    emoji: '🚀',
    category: 'Tasks',
    tier: BadgeTier.silver,
    xpReward: 150,
    isUnlocked: false,
    progress: 10,
    target: 50,
  ),
  const BadgeData(
    key: 'tasks_100',
    name: 'Century Completer',
    description: 'Complete 100 tasks',
    emoji: '🏆',
    category: 'Tasks',
    tier: BadgeTier.gold,
    xpReward: 400,
    isUnlocked: false,
    progress: 10,
    target: 100,
  ),
  // Focus
  const BadgeData(
    key: 'first_pomodoro',
    name: 'Tomato Timer',
    description: 'Complete your first Pomodoro session',
    emoji: '🍅',
    category: 'Focus',
    tier: BadgeTier.bronze,
    xpReward: 20,
    isUnlocked: true,
    progress: 1,
    target: 1,
  ),
  const BadgeData(
    key: 'focus_1h',
    name: 'Deep Diver',
    description: 'Accumulate 1 hour of focus time',
    emoji: '🌊',
    category: 'Focus',
    tier: BadgeTier.bronze,
    xpReward: 40,
    isUnlocked: true,
    progress: 60,
    target: 60,
  ),
  const BadgeData(
    key: 'focus_10h',
    name: 'Flow State',
    description: 'Accumulate 10 hours of focus time',
    emoji: '🧠',
    category: 'Focus',
    tier: BadgeTier.silver,
    xpReward: 200,
    isUnlocked: false,
    progress: 90,
    target: 600,
  ),
  const BadgeData(
    key: 'focus_100h',
    name: 'Iron Mind',
    description: 'Accumulate 100 hours of focus time',
    emoji: '⚙️',
    category: 'Focus',
    tier: BadgeTier.gold,
    xpReward: 1500,
    isUnlocked: false,
    progress: 90,
    target: 6000,
  ),
  // Notes
  const BadgeData(
    key: 'first_note',
    name: 'Note Taker',
    description: 'Create your first note',
    emoji: '📝',
    category: 'Notes',
    tier: BadgeTier.bronze,
    xpReward: 15,
    isUnlocked: true,
    progress: 1,
    target: 1,
  ),
  const BadgeData(
    key: 'notes_20',
    name: 'Knowledge Keeper',
    description: 'Create 20 notes',
    emoji: '📚',
    category: 'Notes',
    tier: BadgeTier.silver,
    xpReward: 120,
    isUnlocked: false,
    progress: 5,
    target: 20,
  ),
  // Social
  const BadgeData(
    key: 'join_group',
    name: 'Team Player',
    description: 'Join your first study group',
    emoji: '🤝',
    category: 'Social',
    tier: BadgeTier.bronze,
    xpReward: 30,
    isUnlocked: true,
    progress: 1,
    target: 1,
  ),
  const BadgeData(
    key: 'group_helper',
    name: 'Study Hero',
    description: 'Help 5 group members with resources',
    emoji: '🦸',
    category: 'Social',
    tier: BadgeTier.silver,
    xpReward: 100,
    isUnlocked: false,
    progress: 2,
    target: 5,
  ),
];

// ── Category filter provider ───────────────────────────────────────────────────

final badgeCategoryFilterProvider = StateProvider<String?>((ref) => null);

// ─────────────────────────────────────────────────────────────────────────────
// WIDGET
// ─────────────────────────────────────────────────────────────────────────────

class AchievementBadgesSection extends ConsumerWidget {
  const AchievementBadgesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final selectedCategory = ref.watch(badgeCategoryFilterProvider);

    final unlockedCount = _mockBadges.where((b) => b.isUnlocked).length;

    final categories = ['All', 'Streak', 'Tasks', 'Focus', 'Notes', 'Social'];
    final displayBadges = selectedCategory == null || selectedCategory == 'All'
        ? _mockBadges
        : _mockBadges
            .where((b) => b.category == selectedCategory)
            .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Text('🏅', style: TextStyle(fontSize: 20)),
                const SizedBox(width: 8),
                Text(
                  'Achievements',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.12),
                borderRadius: AppShapes.r8,
              ),
              child: Text(
                '$unlockedCount / ${_mockBadges.length}',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ).animate().fadeIn(delay: 100.ms),
        const SizedBox(height: 12),

        // Category filter chips
        SizedBox(
          height: 34,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, i) {
              final cat = categories[i];
              final isSelected = cat == (selectedCategory ?? 'All');
              return GestureDetector(
                onTap: () => ref
                    .read(badgeCategoryFilterProvider.notifier)
                    .state = cat == 'All' ? null : cat,
                child: AnimatedContainer(
                  duration: 200.ms,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 7),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary
                        : (isDark
                            ? AppColors.neutral20
                            : cs.surfaceContainerHighest),
                    borderRadius: AppShapes.r16,
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary
                          : cs.outlineVariant.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    cat,
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : cs.onSurface,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                      fontSize: 12,
                    ),
                  ),
                ),
              );
            },
          ),
        ).animate().fadeIn(delay: 150.ms),
        const SizedBox(height: 14),

        // Badge Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.8,
          ),
          itemCount: displayBadges.length,
          itemBuilder: (context, i) {
            final badge = displayBadges[i];
            return _BadgeTile(
              badge: badge,
              index: i,
              isDark: isDark,
              cs: cs,
              onTap: () => _showBadgeDetail(context, badge),
            );
          },
        ),
      ],
    );
  }

  void _showBadgeDetail(BuildContext context, BadgeData badge) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _BadgeDetailSheet(badge: badge),
    );
  }
}

// ── Badge Tile ────────────────────────────────────────────────────────────────

class _BadgeTile extends StatelessWidget {
  const _BadgeTile({
    required this.badge,
    required this.index,
    required this.isDark,
    required this.cs,
    required this.onTap,
  });

  final BadgeData badge;
  final int index;
  final bool isDark;
  final ColorScheme cs;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isUnlocked = badge.isUnlocked;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Badge icon container
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isUnlocked
                      ? badge.tierColor.withOpacity(0.15)
                      : (isDark
                          ? Colors.white.withOpacity(0.06)
                          : Colors.black.withOpacity(0.04)),
                  border: Border.all(
                    color: isUnlocked
                        ? badge.tierColor.withOpacity(0.6)
                        : cs.outlineVariant.withOpacity(0.3),
                    width: isUnlocked ? 2 : 1,
                  ),
                  boxShadow: isUnlocked
                      ? [
                          BoxShadow(
                            color: badge.tierColor.withOpacity(0.25),
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: isUnlocked
                      ? Text(
                          badge.emoji,
                          style: const TextStyle(fontSize: 24),
                        )
                      : Stack(
                          children: [
                            Center(
                              child: Text(
                                badge.emoji,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey.withOpacity(0.3),
                                ),
                              ),
                            ),
                            Center(
                              child: Icon(
                                Icons.lock_rounded,
                                color: cs.onSurface.withOpacity(0.25),
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            badge.name,
            style: TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.w600,
              color: isUnlocked
                  ? cs.onSurface
                  : cs.onSurface.withOpacity(0.45),
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      )
          .animate(delay: Duration(milliseconds: 50 * index))
          .fadeIn(duration: 400.ms)
          .scale(begin: const Offset(0.7, 0.7), curve: Curves.easeOutBack),
    );
  }
}

// ── Badge Detail Bottom Sheet ─────────────────────────────────────────────────

class _BadgeDetailSheet extends StatelessWidget {
  const _BadgeDetailSheet({required this.badge});
  final BadgeData badge;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final progress =
        badge.target == 0 ? 1.0 : badge.progress / badge.target;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 32),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: AppShapes.r24,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 40,
              offset: const Offset(0, -4)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: cs.onSurface.withOpacity(0.2),
              borderRadius: AppShapes.r8,
            ),
          ),
          const SizedBox(height: 24),

          // Badge icon
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: badge.tierColor.withOpacity(badge.isUnlocked ? 0.15 : 0.06),
              border: Border.all(
                color: badge.tierColor.withOpacity(badge.isUnlocked ? 0.7 : 0.2),
                width: 2.5,
              ),
              boxShadow: badge.isUnlocked
                  ? [
                      BoxShadow(
                        color: badge.tierColor.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 4,
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: Text(badge.emoji,
                  style: TextStyle(
                      fontSize: badge.isUnlocked ? 40 : 32)),
            ),
          )
              .animate()
              .scale(duration: 500.ms, curve: Curves.easeOutBack),

          const SizedBox(height: 16),

          // Tier chip
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: badge.tierColor.withOpacity(0.15),
              borderRadius: AppShapes.r8,
              border: Border.all(
                  color: badge.tierColor.withOpacity(0.4)),
            ),
            child: Text(
              badge.tier.name.toUpperCase(),
              style: TextStyle(
                color: badge.tierColor,
                fontWeight: FontWeight.w800,
                fontSize: 11,
                letterSpacing: 1.2,
              ),
            ),
          ),

          const SizedBox(height: 10),

          Text(
            badge.name,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              badge.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: cs.onSurface.withOpacity(0.7)),
            ),
          ),

          const SizedBox(height: 20),

          // Progress bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      badge.isUnlocked ? '✅ Unlocked!' : 'Progress',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: badge.isUnlocked
                            ? AppColors.secondary
                            : cs.onSurface,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      '${badge.progress} / ${badge.target}',
                      style: TextStyle(
                          color: cs.onSurfaceVariant, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: AppShapes.r8,
                  child: LinearProgressIndicator(
                    value: progress.clamp(0.0, 1.0),
                    minHeight: 8,
                    backgroundColor: cs.outlineVariant.withOpacity(0.25),
                    valueColor: AlwaysStoppedAnimation(
                      badge.isUnlocked ? badge.tierColor : AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // XP reward
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              borderRadius: AppShapes.r12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('⭐', style: TextStyle(fontSize: 18)),
                const SizedBox(width: 8),
                Text(
                  '+${badge.xpReward} XP',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                Text(
                  badge.isUnlocked ? ' earned!' : ' upon completion',
                  style: TextStyle(
                    color: cs.onSurface.withOpacity(0.7),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
        ],
      ),
    );
  }
}