// lib/features/tasks/presentation/screens/study_planner_screen.dart
//
// StudySpark — Smart Study Planner Screen (Step 5)
//
// Displays AI-style generated study blocks for the next 3 days,
// personalised suggestions, and total study time overview.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';
import '../providers/tasks_provider.dart';

class StudyPlannerScreen extends ConsumerWidget {
  const StudyPlannerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final planAsync = ref.watch(studyPlanProvider);

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        title: const Text('Smart Study Planner'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => ref.invalidate(studyPlanProvider),
            tooltip: 'Regenerate',
          ),
        ],
      ),
      body: planAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (plan) {
          if (plan.isEmpty) {
            return _EmptyPlan();
          }
          return CustomScrollView(
            slivers: [
              // ── Header card ──
              SliverToBoxAdapter(
                child: _HeaderCard(plan: plan).animate().fadeIn(delay: 100.ms),
              ),

              // ── Suggestions ──
              SliverToBoxAdapter(
                child: _SuggestionsSection(suggestions: plan.suggestions)
                    .animate()
                    .fadeIn(delay: 200.ms),
              ),

              // ── Day groups ──
              ..._buildDayGroups(context, plan, cs),

              const SliverPadding(padding: EdgeInsets.only(bottom: 80)),
            ],
          );
        },
      ),
    );
  }

  List<Widget> _buildDayGroups(
      BuildContext context, StudyPlan plan, ColorScheme cs) {
    final grouped = <int, List<StudyBlock>>{};
    for (final b in plan.blocks) {
      grouped.putIfAbsent(b.dayOffset, () => []).add(b);
    }

    final widgets = <Widget>[];
    final sortedEntries = grouped.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    for (final entry in sortedEntries) {
      final dayLabel = entry.key == 0
          ? 'Today'
          : entry.key == 1
              ? 'Tomorrow'
              : DateFormat('EEEE, d MMM')
                  .format(DateTime.now().add(Duration(days: entry.key)));

      widgets.add(SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: cs.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  dayLabel,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: cs.onPrimaryContainer,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${entry.value.length} block${entry.value.length > 1 ? 's' : ''}',
                style: Theme.of(context).textTheme.bodySmall!
                    .copyWith(color: cs.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ));

      for (var i = 0; i < entry.value.length; i++) {
        final block = entry.value[i];
        widgets.add(SliverToBoxAdapter(
          child: _StudyBlockCard(block: block)
              .animate(delay: Duration(milliseconds: 100 + i * 80))
              .fadeIn()
              .slideX(begin: 0.05),
        ));
      }
    }
    return widgets;
  }
}

// ─── Header card ──────────────────────────────────────────────────────────────

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({required this.plan});
  final StudyPlan plan;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final hours = plan.totalMinutesPlanned ~/ 60;
    final mins = plan.totalMinutesPlanned % 60;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [cs.primary, cs.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppShapes.r20,
        boxShadow: [
          BoxShadow(
            color: cs.primary.withOpacity(0.3),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🧠', style: TextStyle(fontSize: 28)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Study Plan',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    Text(
                      'Personalised for the next 3 days',
                      style: Theme.of(context).textTheme.bodySmall!
                          .copyWith(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _StatChip(
                  icon: '⏱️',
                  label: hours > 0 ? '${hours}h ${mins}m' : '${mins}m',
                  sub: 'Total planned'),
              const SizedBox(width: 12),
              _StatChip(
                  icon: '📚',
                  label: '${plan.blocks.length}',
                  sub: 'Study blocks'),
              const SizedBox(width: 12),
              _StatChip(
                  icon: '💡',
                  label: '${plan.suggestions.length}',
                  sub: 'Tips for you'),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.icon, required this.label, required this.sub});
  final String icon;
  final String label;
  final String sub;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: AppShapes.r12,
        ),
        child: Column(
          children: [
            Text(icon, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 2),
            Text(label,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 16)),
            Text(sub,
                style: const TextStyle(color: Colors.white70, fontSize: 10),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

// ─── Suggestions ─────────────────────────────────────────────────────────────

class _SuggestionsSection extends StatelessWidget {
  const _SuggestionsSection({required this.suggestions});
  final List<StudySuggestion> suggestions;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
          child: Text('Study Tips',
              style: Theme.of(context).textTheme.titleMedium!
                  .copyWith(fontWeight: FontWeight.w700)),
        ),
        SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 16, right: 8),
            itemCount: suggestions.length,
            itemBuilder: (ctx, i) =>
                _SuggestionCard(suggestion: suggestions[i])
                    .animate(delay: Duration(milliseconds: i * 100))
                    .fadeIn()
                    .slideX(begin: 0.1),
          ),
        ),
      ],
    );
  }
}

class _SuggestionCard extends StatelessWidget {
  const _SuggestionCard({required this.suggestion});
  final StudySuggestion suggestion;

  Color _catColor(String cat, ColorScheme cs) => switch (cat) {
        'focus'  => cs.primary,
        'break'  => cs.tertiary,
        'review' => cs.secondary,
        'health' => const Color(0xFF2E7D32),
        _        => cs.outline,
      };

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final color = _catColor(suggestion.category, cs);
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 12, bottom: 4),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: AppShapes.r16,
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(suggestion.emoji,
                  style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  suggestion.title,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.w700, color: color),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              suggestion.body,
              style: Theme.of(context).textTheme.bodySmall!
                  .copyWith(color: cs.onSurfaceVariant),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Study block card ─────────────────────────────────────────────────────────

class _StudyBlockCard extends StatelessWidget {
  const _StudyBlockCard({required this.block});
  final StudyBlock block;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    Color blockColor;
    try {
      blockColor = Color(
          int.parse(block.colorHex.replaceFirst('#', '0xFF')));
    } catch (_) {
      blockColor = cs.primary;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: AppShapes.r16,
        border: Border(
          left: BorderSide(color: blockColor, width: 4),
        ),
      ),
      child: Row(
        children: [
          // Time column
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: blockColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  block.timeLabel,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: blockColor,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${block.durationMinutes} min',
                style: Theme.of(context).textTheme.labelSmall!
                    .copyWith(color: cs.onSurfaceVariant),
              ),
            ],
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  block.title,
                  style: Theme.of(context).textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.lightbulb_outline_rounded,
                        size: 12, color: cs.onSurfaceVariant),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        block.reason,
                        style: Theme.of(context).textTheme.bodySmall!
                            .copyWith(color: cs.onSurfaceVariant),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Timer start icon
          IconButton(
            icon: Icon(Icons.play_circle_outline_rounded,
                color: blockColor, size: 28),
            tooltip: 'Start focus session',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      'Starting focus session for "${block.title}"'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ─── Empty state ──────────────────────────────────────────────────────────────

class _EmptyPlan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('🎯', style: TextStyle(fontSize: 64)),
            const SizedBox(height: 20),
            Text(
              'No Study Plan Yet',
              style: Theme.of(context).textTheme.titleLarge!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            Text(
              'Add tasks with deadlines and the Smart Planner will automatically build a personalised study schedule for you.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!
                  .copyWith(color: cs.onSurfaceVariant),
            ),
          ],
        ),
      ),
    ).animate().fadeIn();
  }
}
