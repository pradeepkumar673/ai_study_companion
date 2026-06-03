// lib/features/profile/presentation/widgets/career_guidance_card.dart
//
// StudySpark — Career Guidance + Alerts Card
//
// Displays:
//   • Top 3 career matches based on the user's study subjects (mock)
//   • Active career alerts (internships, hackathons, scholarship deadlines)
//   • "Explore Careers" sheet with full listings
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';

// ── Mock Data ──────────────────────────────────────────────────────────────────

class CareerAlert {
  const CareerAlert({
    required this.id,
    required this.title,
    required this.company,
    required this.type,
    required this.deadline,
    required this.emoji,
    required this.stipend,
    required this.isNew,
    required this.url,
  });

  final String id;
  final String title;
  final String company;
  final String type; // 'Internship' | 'Hackathon' | 'Scholarship' | 'Job'
  final String deadline;
  final String emoji;
  final String stipend;
  final bool isNew;
  final String url;

  Color get typeColor {
    switch (type) {
      case 'Internship':
        return AppColors.primary;
      case 'Hackathon':
        return AppColors.tertiary;
      case 'Scholarship':
        return const Color(0xFFFFD600);
      case 'Job':
        return AppColors.secondary;
      default:
        return AppColors.primary;
    }
  }
}

class CareerMatch {
  const CareerMatch({
    required this.title,
    required this.emoji,
    required this.matchPercent,
    required this.skills,
    required this.avgSalary,
  });

  final String title;
  final String emoji;
  final int matchPercent;
  final List<String> skills;
  final String avgSalary;
}

final _mockCareerAlerts = [
  const CareerAlert(
    id: 'ca1',
    title: 'Software Engineering Intern',
    company: 'Google',
    type: 'Internship',
    deadline: 'Jun 15, 2026',
    emoji: '🏢',
    stipend: '₹80,000/mo',
    isNew: true,
    url: 'https://careers.google.com',
  ),
  const CareerAlert(
    id: 'ca2',
    title: 'Smart India Hackathon 2026',
    company: 'Govt. of India',
    type: 'Hackathon',
    deadline: 'Jun 30, 2026',
    emoji: '🏆',
    stipend: '₹1,00,000 prize',
    isNew: true,
    url: 'https://sih.gov.in',
  ),
  const CareerAlert(
    id: 'ca3',
    title: 'INSPIRE Scholarship',
    company: 'DST India',
    type: 'Scholarship',
    deadline: 'Jul 10, 2026',
    emoji: '🎓',
    stipend: '₹80,000/year',
    isNew: false,
    url: 'https://online-inspire.gov.in',
  ),
  const CareerAlert(
    id: 'ca4',
    title: 'Data Science Intern',
    company: 'Flipkart',
    type: 'Internship',
    deadline: 'Jun 20, 2026',
    emoji: '📊',
    stipend: '₹50,000/mo',
    isNew: false,
    url: 'https://flipkart.com/careers',
  ),
  const CareerAlert(
    id: 'ca5',
    title: 'ML Research Intern',
    company: 'Microsoft Research',
    type: 'Internship',
    deadline: 'Jul 1, 2026',
    emoji: '🤖',
    stipend: '₹90,000/mo',
    isNew: true,
    url: 'https://microsoft.com/research',
  ),
];

final _mockCareerMatches = [
  const CareerMatch(
    title: 'Software Engineer',
    emoji: '👨‍💻',
    matchPercent: 94,
    skills: ['Algorithms', 'Data Structures', 'System Design'],
    avgSalary: '₹12–25 LPA',
  ),
  const CareerMatch(
    title: 'Data Scientist',
    emoji: '🧑‍🔬',
    matchPercent: 82,
    skills: ['Statistics', 'ML', 'Python'],
    avgSalary: '₹10–20 LPA',
  ),
  const CareerMatch(
    title: 'Product Manager',
    emoji: '🎯',
    matchPercent: 71,
    skills: ['Analytics', 'Communication', 'Strategy'],
    avgSalary: '₹15–30 LPA',
  ),
];

// ── Providers ─────────────────────────────────────────────────────────────────

final dismissedAlertsProvider = StateProvider<Set<String>>((ref) => {});

// ─────────────────────────────────────────────────────────────────────────────
// WIDGET
// ─────────────────────────────────────────────────────────────────────────────

class CareerGuidanceCard extends ConsumerWidget {
  const CareerGuidanceCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dismissed = ref.watch(dismissedAlertsProvider);
    final activeAlerts = _mockCareerAlerts
        .where((a) => !dismissed.contains(a.id))
        .take(3)
        .toList();
    final newCount = activeAlerts.where((a) => a.isNew).length;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.secondary.withOpacity(isDark ? 0.2 : 0.07),
            AppColors.secondary.withOpacity(isDark ? 0.06 : 0.02),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppShapes.r16,
        border: Border.all(
            color: AppColors.secondary.withOpacity(0.25), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text('🚀', style: TextStyle(fontSize: 20)),
                  const SizedBox(width: 8),
                  Text(
                    'Career Guidance',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  if (newCount > 0) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: AppShapes.r8,
                      ),
                      child: Text(
                        '$newCount new',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ],
                ],
              ),
              TextButton(
                onPressed: () => _openCareerSheet(context, ref),
                child: const Text('Explore →',
                    style: TextStyle(fontSize: 12)),
              ),
            ],
          ).animate().fadeIn(delay: 100.ms),

          // Career matches row
          const SizedBox(height: 12),
          _CareerMatchesRow(matches: _mockCareerMatches),

          const SizedBox(height: 14),
          Divider(
              height: 1,
              color: cs.outlineVariant.withOpacity(0.25)),
          const SizedBox(height: 12),

          // Alerts header
          Row(
            children: [
              Icon(Icons.notifications_active_rounded,
                  size: 14, color: AppColors.secondary),
              const SizedBox(width: 6),
              Text(
                'Active Alerts  (${activeAlerts.length})',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.secondary),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Alert tiles
          ...activeAlerts.asMap().entries.map((e) {
            final alert = e.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _AlertTile(
                alert: alert,
                index: e.key,
                onDismiss: () => ref
                    .read(dismissedAlertsProvider.notifier)
                    .state = {
                  ...ref.read(dismissedAlertsProvider),
                  alert.id,
                },
              ),
            );
          }),

          // See more
          if (dismissed.isEmpty &&
              _mockCareerAlerts.length > 3)
            Center(
              child: TextButton(
                onPressed: () => _openCareerSheet(context, ref),
                child: Text(
                  'See ${_mockCareerAlerts.length - 3} more alerts',
                  style: TextStyle(
                      color: AppColors.secondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
        ],
      ),
    ).animate().fadeIn(delay: 100.ms);
  }

  void _openCareerSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ProviderScope(
        parent: ProviderScope.containerOf(context),
        child: _FullCareerSheet(),
      ),
    );
  }
}

// ── Career Matches Row ────────────────────────────────────────────────────────

class _CareerMatchesRow extends StatelessWidget {
  const _CareerMatchesRow({required this.matches});
  final List<CareerMatch> matches;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: matches.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, i) {
          final m = matches[i];
          final cs = Theme.of(context).colorScheme;
          return Container(
            width: 110,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.secondary.withOpacity(0.08),
              borderRadius: AppShapes.r12,
              border: Border.all(
                  color: AppColors.secondary.withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(m.emoji,
                    style: const TextStyle(fontSize: 22)),
                const Spacer(),
                Text(
                  m.title,
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w700),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Container(
                      width: 28,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.secondary
                            .withOpacity(m.matchPercent / 100),
                        borderRadius: AppShapes.r8,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${m.matchPercent}%',
                      style: TextStyle(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w800,
                          fontSize: 9),
                    ),
                  ],
                ),
              ],
            ),
          ).animate(delay: Duration(milliseconds: 60 * i)).fadeIn();
        },
      ),
    );
  }
}

// ── Alert Tile ────────────────────────────────────────────────────────────────

class _AlertTile extends StatelessWidget {
  const _AlertTile({
    required this.alert,
    required this.index,
    required this.onDismiss,
  });

  final CareerAlert alert;
  final int index;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Dismissible(
      key: Key(alert.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDismiss(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: AppShapes.r12,
        ),
        child: const Icon(Icons.delete_outline_rounded,
            color: Colors.red),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: alert.typeColor.withOpacity(0.06),
          borderRadius: AppShapes.r12,
          border: Border.all(
              color: alert.typeColor.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Text(alert.emoji,
                style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          alert.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (alert.isNew)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 1),
                          decoration: BoxDecoration(
                            color: alert.typeColor,
                            borderRadius: AppShapes.r8,
                          ),
                          child: const Text('NEW',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.5)),
                        ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: alert.typeColor.withOpacity(0.15),
                          borderRadius: AppShapes.r8,
                        ),
                        child: Text(
                          alert.type,
                          style: TextStyle(
                              color: alert.typeColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 9),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        alert.company,
                        style: TextStyle(
                            color: cs.onSurfaceVariant,
                            fontSize: 10),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Icon(Icons.calendar_today_rounded,
                          size: 10,
                          color: cs.onSurfaceVariant),
                      const SizedBox(width: 3),
                      Text(
                        'Deadline: ${alert.deadline}',
                        style: TextStyle(
                            color: cs.onSurfaceVariant,
                            fontSize: 10),
                      ),
                      const Spacer(),
                      Text(
                        alert.stipend,
                        style: TextStyle(
                          color: alert.typeColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )
          .animate(delay: Duration(milliseconds: 60 * index))
          .fadeIn()
          .slideX(begin: 0.05, end: 0),
    );
  }
}

// ── Full Career Sheet ─────────────────────────────────────────────────────────

class _FullCareerSheet extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final dismissed = ref.watch(dismissedAlertsProvider);
    final allAlerts =
        _mockCareerAlerts.where((a) => !dismissed.contains(a.id)).toList();

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius:
              const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                  color: cs.onSurface.withOpacity(0.2),
                  borderRadius: AppShapes.r8),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Career Guidance',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 4),
                  Text(
                    'Based on your CS & Math profile',
                    style: TextStyle(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                controller: controller,
                padding: const EdgeInsets.all(16),
                children: [
                  // Career paths section
                  Text('Your Career Matches',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 10),
                  ..._mockCareerMatches.map((m) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _CareerMatchCard(match: m),
                      )),
                  const SizedBox(height: 16),

                  // All alerts
                  Text('All Active Opportunities',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 10),
                  ...allAlerts.asMap().entries.map((e) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _AlertTile(
                          alert: e.value,
                          index: e.key,
                          onDismiss: () => ref
                              .read(dismissedAlertsProvider.notifier)
                              .state = {
                            ...ref.read(dismissedAlertsProvider),
                            e.value.id,
                          },
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CareerMatchCard extends StatelessWidget {
  const _CareerMatchCard({required this.match});
  final CareerMatch match;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.07),
        borderRadius: AppShapes.r16,
        border: Border.all(
            color: AppColors.secondary.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Text(match.emoji, style: const TextStyle(fontSize: 32)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      match.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: AppShapes.r8,
                      ),
                      child: Text(
                        '${match.matchPercent}% match',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  match.avgSalary,
                  style: TextStyle(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 12),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: match.skills
                      .map((s) => Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: cs.surfaceContainerHighest,
                              borderRadius: AppShapes.r8,
                            ),
                            child: Text(s,
                                style: const TextStyle(fontSize: 10)),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}