// lib/features/profile/presentation/widgets/study_groups_preview.dart
//
// StudySpark — Study Groups Preview Card on Profile
//
// Shows the user's groups with member count, activity, and quick-join.
// Tapping "View All" opens the full StudyGroupsScreen.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';

// ── Mock Data ──────────────────────────────────────────────────────────────────

class StudyGroupData {
  const StudyGroupData({
    required this.id,
    required this.name,
    required this.subject,
    required this.memberCount,
    required this.maxMembers,
    required this.emoji,
    required this.colorHex,
    required this.lastActivity,
    required this.isJoined,
    required this.unreadMessages,
    required this.nextSession,
  });

  final String id;
  final String name;
  final String subject;
  final int memberCount;
  final int maxMembers;
  final String emoji;
  final Color colorHex;
  final String lastActivity;
  final bool isJoined;
  final int unreadMessages;
  final String? nextSession;
}

final _mockGroups = [
  const StudyGroupData(
    id: 'g1',
    name: 'CS301 Algorithms',
    subject: 'Computer Science',
    memberCount: 8,
    maxMembers: 10,
    emoji: '💻',
    colorHex: Color(0xFF1A73E8),
    lastActivity: '2m ago',
    isJoined: true,
    unreadMessages: 3,
    nextSession: 'Today 6:00 PM',
  ),
  const StudyGroupData(
    id: 'g2',
    name: 'Organic Chem Study',
    subject: 'Chemistry',
    memberCount: 5,
    maxMembers: 8,
    emoji: '🧪',
    colorHex: Color(0xFF0F9D58),
    lastActivity: '1h ago',
    isJoined: true,
    unreadMessages: 0,
    nextSession: 'Tomorrow 4:00 PM',
  ),
  const StudyGroupData(
    id: 'g3',
    name: 'Calculus Warriors',
    subject: 'Mathematics',
    memberCount: 12,
    maxMembers: 15,
    emoji: '📐',
    colorHex: Color(0xFFDB4437),
    lastActivity: '3h ago',
    isJoined: false,
    unreadMessages: 0,
    nextSession: 'Fri 5:00 PM',
  ),
];

// ── Provider ──────────────────────────────────────────────────────────────────

final studyGroupsProvider = StateProvider<List<StudyGroupData>>(
    (ref) => _mockGroups);

// ─────────────────────────────────────────────────────────────────────────────
// WIDGET
// ─────────────────────────────────────────────────────────────────────────────

class StudyGroupsPreview extends ConsumerWidget {
  const StudyGroupsPreview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(studyGroupsProvider);
    final joinedGroups = groups.where((g) => g.isJoined).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Text('👥', style: TextStyle(fontSize: 20)),
                const SizedBox(width: 8),
                Text(
                  'Study Groups',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
            TextButton(
              onPressed: () =>
                  _openStudyGroupsSheet(context, ref, groups),
              child: const Text('View All →',
                  style: TextStyle(fontSize: 12)),
            ),
          ],
        ).animate().fadeIn(delay: 100.ms),
        const SizedBox(height: 10),

        // Groups list
        ...joinedGroups.asMap().entries.map((e) {
          final group = e.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _GroupCard(
              group: group,
              index: e.key,
              onLeave: () {
                final updated = groups.map((g) {
                  if (g.id == group.id) {
                    return StudyGroupData(
                      id: g.id,
                      name: g.name,
                      subject: g.subject,
                      memberCount: g.memberCount - 1,
                      maxMembers: g.maxMembers,
                      emoji: g.emoji,
                      colorHex: g.colorHex,
                      lastActivity: g.lastActivity,
                      isJoined: false,
                      unreadMessages: 0,
                      nextSession: g.nextSession,
                    );
                  }
                  return g;
                }).toList();
                ref.read(studyGroupsProvider.notifier).state = updated;
              },
            ),
          );
        }),

        // Discover new groups CTA
        GestureDetector(
          onTap: () => _openStudyGroupsSheet(context, ref, groups),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              border: Border.all(
                  color: AppColors.primary.withOpacity(0.3),
                  style: BorderStyle.solid),
              borderRadius: AppShapes.r12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_rounded,
                    color: AppColors.primary, size: 18),
                const SizedBox(width: 8),
                Text(
                  'Discover & join more groups',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ).animate().fadeIn(delay: 300.ms),
      ],
    );
  }

  void _openStudyGroupsSheet(
      BuildContext context, WidgetRef ref, List<StudyGroupData> groups) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ProviderScope(
        parent: ProviderScope.containerOf(context),
        child: _StudyGroupsSheet(groups: groups),
      ),
    );
  }
}

// ── Group Card ────────────────────────────────────────────────────────────────

class _GroupCard extends StatelessWidget {
  const _GroupCard({
    required this.group,
    required this.index,
    required this.onLeave,
  });

  final StudyGroupData group;
  final int index;
  final VoidCallback onLeave;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.neutral20 : cs.surface,
        borderRadius: AppShapes.r16,
        border: Border.all(
            color: group.colorHex.withOpacity(0.25), width: 1.5),
      ),
      child: Row(
        children: [
          // Emoji avatar
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: group.colorHex.withOpacity(0.12),
              borderRadius: AppShapes.r12,
            ),
            child: Center(
              child: Text(group.emoji,
                  style: const TextStyle(fontSize: 22)),
            ),
          ),
          const SizedBox(width: 12),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        group.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 13),
                      ),
                    ),
                    if (group.unreadMessages > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: group.colorHex,
                          borderRadius: AppShapes.r8,
                        ),
                        child: Text(
                          '${group.unreadMessages}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  '${group.memberCount}/${group.maxMembers} members · ${group.lastActivity}',
                  style: TextStyle(
                      color: cs.onSurfaceVariant, fontSize: 11),
                ),
                if (group.nextSession != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    '📅 ${group.nextSession}',
                    style: TextStyle(
                        color: group.colorHex,
                        fontWeight: FontWeight.w600,
                        fontSize: 11),
                  ),
                ],
              ],
            ),
          ),

          // Leave button
          IconButton(
            icon: const Icon(Icons.more_vert_rounded, size: 18),
            onPressed: () => _showGroupOptions(context),
            color: cs.onSurfaceVariant,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    )
        .animate(delay: Duration(milliseconds: 80 * index))
        .fadeIn()
        .slideX(begin: 0.05, end: 0);
  }

  void _showGroupOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 32),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: AppShapes.r24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withOpacity(0.2),
                borderRadius: AppShapes.r8,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.message_outlined),
              title: const Text('Open Chat'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.people_outline),
              title: const Text('View Members'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app_rounded,
                  color: Colors.red),
              title: const Text('Leave Group',
                  style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                onLeave();
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

// ── Full Groups Sheet ─────────────────────────────────────────────────────────

class _StudyGroupsSheet extends ConsumerStatefulWidget {
  const _StudyGroupsSheet({required this.groups});
  final List<StudyGroupData> groups;

  @override
  ConsumerState<_StudyGroupsSheet> createState() =>
      _StudyGroupsSheetState();
}

class _StudyGroupsSheetState extends ConsumerState<_StudyGroupsSheet> {
  bool _showDiscover = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final groups = ref.watch(studyGroupsProvider);

    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                  color: cs.onSurface.withOpacity(0.2),
                  borderRadius: AppShapes.r8),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Study Groups',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.w800)),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () =>
                            setState(() => _showDiscover = !_showDiscover),
                        child: Text(
                            _showDiscover ? 'My Groups' : 'Discover'),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_rounded),
                        onPressed: () => _showCreateGroup(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(height: 16),
            Expanded(
              child: ListView(
                controller: controller,
                padding: const EdgeInsets.all(16),
                children: _showDiscover
                    ? groups
                        .where((g) => !g.isJoined)
                        .map((g) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _DiscoverGroupCard(group: g),
                            ))
                        .toList()
                    : groups
                        .where((g) => g.isJoined)
                        .map((g) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _FullGroupCard(group: g),
                            ))
                        .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateGroup(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text('Create group feature coming soon!'),
      ),
    );
  }
}

class _FullGroupCard extends StatelessWidget {
  const _FullGroupCard({required this.group});
  final StudyGroupData group;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: group.colorHex.withOpacity(0.07),
        borderRadius: AppShapes.r16,
        border: Border.all(color: group.colorHex.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(group.emoji,
                  style: const TextStyle(fontSize: 28)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(group.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 15)),
                    Text(group.subject,
                        style: TextStyle(
                            color: group.colorHex,
                            fontWeight: FontWeight.w500,
                            fontSize: 12)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: group.colorHex,
                  borderRadius: AppShapes.r8,
                ),
                child: const Text('Open Chat',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.people_outline, size: 14, color: cs.onSurfaceVariant),
              const SizedBox(width: 4),
              Text('${group.memberCount}/${group.maxMembers} members',
                  style: TextStyle(
                      color: cs.onSurfaceVariant, fontSize: 12)),
              const SizedBox(width: 16),
              Icon(Icons.access_time_rounded,
                  size: 14, color: cs.onSurfaceVariant),
              const SizedBox(width: 4),
              Text('Active ${group.lastActivity}',
                  style: TextStyle(
                      color: cs.onSurfaceVariant, fontSize: 12)),
            ],
          ),
          if (group.nextSession != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: group.colorHex.withOpacity(0.12),
                borderRadius: AppShapes.r8,
              ),
              child: Text(
                '📅 Next session: ${group.nextSession}',
                style: TextStyle(
                    color: group.colorHex,
                    fontWeight: FontWeight.w600,
                    fontSize: 12),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _DiscoverGroupCard extends ConsumerWidget {
  const _DiscoverGroupCard({required this.group});
  final StudyGroupData group;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: AppShapes.r16,
        border: Border.all(color: group.colorHex.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Text(group.emoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(group.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 14)),
                Text(
                    '${group.memberCount}/${group.maxMembers} members',
                    style: TextStyle(
                        color: group.colorHex, fontSize: 12)),
              ],
            ),
          ),
          FilledButton(
            onPressed: () {
              final groups = ref.read(studyGroupsProvider);
              final updated = groups.map((g) {
                if (g.id == group.id) {
                  return StudyGroupData(
                    id: g.id,
                    name: g.name,
                    subject: g.subject,
                    memberCount: g.memberCount + 1,
                    maxMembers: g.maxMembers,
                    emoji: g.emoji,
                    colorHex: g.colorHex,
                    lastActivity: g.lastActivity,
                    isJoined: true,
                    unreadMessages: 0,
                    nextSession: g.nextSession,
                  );
                }
                return g;
              }).toList();
              ref.read(studyGroupsProvider.notifier).state = updated;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text('Joined ${group.name}! 🎉'),
                ),
              );
            },
            style: FilledButton.styleFrom(
              backgroundColor: group.colorHex,
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 8),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text('Join',
                style:
                    TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}