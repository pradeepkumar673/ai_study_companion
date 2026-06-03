// lib/features/tasks/presentation/screens/tasks_screen.dart
//
// StudySpark — Tasks Screen (Step 5)
//
// Tabs: Today | Upcoming | Priority | All
// Features:
//   • Swipe-to-complete / swipe-to-delete task cards
//   • Filter bar (status + priority chips)
//   • Search bar
//   • FAB → Add Task bottom sheet
//   • Overdue banner
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/enums/app_enums.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/shimmer_widgets.dart';
import '../../../../core/widgets/async_error_widget.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/router/app_router.dart';
import '../../../../shared/providers/repository_providers.dart';
import '../../../../shared/providers/ui_state_providers.dart';
import '../../data/models/task_model.dart';
import '../providers/tasks_provider.dart';
import '../widgets/add_edit_task_sheet.dart';
import '../widgets/task_card.dart';

// ─── Tab definition ───────────────────────────────────────────────────────────

enum _TaskTab { today, upcoming, priority, all }

extension on _TaskTab {
  String get label => switch (this) {
        _TaskTab.today    => 'Today',
        _TaskTab.upcoming => 'Upcoming',
        _TaskTab.priority => 'Priority',
        _TaskTab.all      => 'All',
      };
  IconData get icon => switch (this) {
        _TaskTab.today    => Icons.today_rounded,
        _TaskTab.upcoming => Icons.event_rounded,
        _TaskTab.priority => Icons.local_fire_department_rounded,
        _TaskTab.all      => Icons.list_rounded,
      };
}

// ─── Screen ───────────────────────────────────────────────────────────────────

class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({super.key});

  @override
  ConsumerState<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<TasksScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final _searchCtrl = TextEditingController();
  bool _showSearch = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _TaskTab.values.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  void _openAddSheet([TaskModel? taskToEdit]) {
    if (taskToEdit != null) {
      ref.read(taskDraftProvider.notifier).loadFromTask(taskToEdit);
    } else {
      ref.read(taskDraftProvider.notifier).reset();
    }
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => AddEditTaskSheet(existingTask: taskToEdit),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final query = ref.watch(taskSearchQueryProvider);

    return Scaffold(
      backgroundColor: cs.surface,
      body: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          _buildAppBar(cs, query),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            _TaskTabView(tab: _TaskTab.today, searchQuery: query),
            _TaskTabView(tab: _TaskTab.upcoming, searchQuery: query),
            _TaskTabView(tab: _TaskTab.priority, searchQuery: query),
            _TaskTabView(tab: _TaskTab.all, searchQuery: query),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddSheet,
        icon: const Icon(Icons.add_rounded),
        label: const Text('New Task'),
      ).animate().scale(delay: 300.ms, curve: Curves.easeOutBack),
    );
  }

  SliverAppBar _buildAppBar(ColorScheme cs, String query) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      expandedHeight: _showSearch ? 120 : 100,
      title: _showSearch
          ? TextField(
              controller: _searchCtrl,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Search tasks…',
                border: InputBorder.none,
                hintStyle: TextStyle(color: cs.onSurfaceVariant),
              ),
              style: Theme.of(context).textTheme.bodyLarge,
              onChanged: (v) =>
                  ref.read(taskSearchQueryProvider.notifier).state = v,
            )
          : const Text('Tasks'),
      actions: [
        IconButton(
          icon: Icon(_showSearch ? Icons.close_rounded : Icons.search_rounded),
          onPressed: () {
            setState(() => _showSearch = !_showSearch);
            if (!_showSearch) {
              _searchCtrl.clear();
              ref.read(taskSearchQueryProvider.notifier).state = '';
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.calendar_view_week_rounded),
          tooltip: 'Timetable',
          onPressed: () => context.push('/tasks/timetable'),
        ),
        IconButton(
          icon: const Icon(Icons.auto_awesome_rounded),
          tooltip: 'Smart Planner',
          onPressed: () => context.push('/tasks/planner'),
        ),
      ],
      bottom: TabBar(
        controller: _tabController,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        dividerColor: Colors.transparent,
        tabs: _TaskTab.values
            .map((t) => Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(t.icon, size: 16),
                      const SizedBox(width: 6),
                      Text(t.label),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}

// ─── Individual tab view ──────────────────────────────────────────────────────

class _TaskTabView extends ConsumerWidget {
  const _TaskTabView({required this.tab, required this.searchQuery});

  final _TaskTab tab;
  final String searchQuery;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (tab) {
      _TaskTab.today    => _TodayTab(searchQuery: searchQuery),
      _TaskTab.upcoming => _UpcomingTab(searchQuery: searchQuery),
      _TaskTab.priority => _PriorityTab(searchQuery: searchQuery),
      _TaskTab.all      => _AllTasksTab(searchQuery: searchQuery),
    };
  }
}

// ─── Today tab ────────────────────────────────────────────────────────────────

class _TodayTab extends ConsumerWidget {
  const _TodayTab({required this.searchQuery});
  final String searchQuery;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayAsync = ref.watch(todayTasksProvider);
    final overdueAsync = ref.watch(overdueTasksProvider);

    return todayAsync.when(
      loading: () => const ShimmerList(itemCount: 5),
      error: (e, _) => AsyncErrorWidget(
        error: e,
        onRetry: () => ref.invalidate(todayTasksProvider),
      ),
      data: (today) {
        final filtered = _applySearch(today, searchQuery);
        return overdueAsync.when(
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const SizedBox.shrink(),
          data: (overdue) {
            return CustomScrollView(
              slivers: [
                // Overdue banner
                if (overdue.isNotEmpty)
                  SliverToBoxAdapter(
                    child: _OverdueBanner(count: overdue.length)
                        .animate()
                        .slideY(begin: -0.3),
                  ),
                // Today's date header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                    child: Row(
                      children: [
                        Text(
                          DateFormat('EEEE, d MMMM').format(DateTime.now()),
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        _CompletionBadge(
                          done: filtered
                              .where((t) => t.status == TaskStatus.done)
                              .length,
                          total: filtered.length,
                        ),
                      ],
                    ),
                  ),
                ),
                // Task list
                if (filtered.isEmpty)
                  SliverFillRemaining(
                    child: EmptyStateWidget.tasks(
                      onAdd: () => context.push(AppPaths.taskCreate),
                    ),
                  )
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (ctx, i) => TaskCard(task: filtered[i])
                          .animate(delay: Duration(milliseconds: i * 40))
                          .fadeIn()
                          .slideX(begin: -0.05),
                      childCount: filtered.length,
                    ),
                  ),
                const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
              ],
            );
          },
        );
      },
    );
  }
}

// ─── Upcoming tab ─────────────────────────────────────────────────────────────

class _UpcomingTab extends ConsumerWidget {
  const _UpcomingTab({required this.searchQuery});
  final String searchQuery;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(upcomingTasksProvider);
    return async.when(
      loading: () => const ShimmerList(itemCount: 5),
      error: (e, _) => AsyncErrorWidget(
        error: e,
        onRetry: () => ref.invalidate(upcomingTasksProvider),
      ),
      data: (tasks) {
        final filtered = _applySearch(tasks, searchQuery);
        if (filtered.isEmpty) {
          return EmptyStateWidget.tasks(
            onAdd: () => context.push(AppPaths.taskCreate),
          );
        }
        // Group by date
        final groups = <String, List<TaskModel>>{};
        for (final t in filtered) {
          final key = t.deadline != null
              ? DateFormat('EEE, d MMM').format(t.deadline!.toLocal())
              : 'No Deadline';
          groups.putIfAbsent(key, () => []).add(t);
        }
        return ListView(
          padding: const EdgeInsets.only(bottom: 100),
          children: [
            for (final entry in groups.entries) ...[
              _DateHeader(label: entry.key),
              for (final t in entry.value)
                TaskCard(task: t)
                    .animate()
                    .fadeIn()
                    .slideX(begin: -0.05),
            ],
          ],
        );
      },
    );
  }
}

// ─── Priority tab ─────────────────────────────────────────────────────────────

class _PriorityTab extends ConsumerWidget {
  const _PriorityTab({required this.searchQuery});
  final String searchQuery;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(highPriorityTasksProvider);
    return async.when(
      loading: () => const ShimmerList(itemCount: 5),
      error: (e, _) => AsyncErrorWidget(
        error: e,
        onRetry: () => ref.invalidate(highPriorityTasksProvider),
      ),
      data: (tasks) {
        final filtered = _applySearch(tasks, searchQuery);
        if (filtered.isEmpty) {
          return EmptyStateWidget.tasks(
            onAdd: () => context.push(AppPaths.taskCreate),
          );
        }
        // Group by priority
        final groups = <Priority, List<TaskModel>>{};
        for (final p in [Priority.critical, Priority.high]) {
          final pts = filtered.where((t) => t.priority == p).toList();
          if (pts.isNotEmpty) groups[p] = pts;
        }
        return ListView(
          padding: const EdgeInsets.only(bottom: 100),
          children: [
            for (final entry in groups.entries) ...[
              _PriorityHeader(priority: entry.key),
              for (final t in entry.value)
                TaskCard(task: t)
                    .animate()
                    .fadeIn()
                    .slideX(begin: -0.05),
            ],
          ],
        );
      },
    );
  }
}

// ─── All tasks tab ────────────────────────────────────────────────────────────

class _AllTasksTab extends ConsumerWidget {
  const _AllTasksTab({required this.searchQuery});
  final String searchQuery;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(tasksProvider);
    final filter = ref.watch(taskFilterProvider);

    return async.when(
      loading: () => const ShimmerList(itemCount: 5),
      error: (e, _) => AsyncErrorWidget(
        error: e,
        onRetry: () => ref.invalidate(tasksProvider),
      ),
      data: (all) {
        var tasks = all;
        if (filter.status != null) {
          tasks = tasks.where((t) => t.status == filter.status).toList();
        }
        if (filter.priority != null) {
          tasks = tasks.where((t) => t.priority == filter.priority).toList();
        }
        if (filter.subjectId != null) {
          tasks = tasks.where((t) => t.subjectId == filter.subjectId).toList();
        }
        final filtered = _applySearch(tasks, searchQuery);

        return Column(
          children: [
            _FilterBar(),
            Expanded(
              child: filtered.isEmpty
                  ? EmptyStateWidget.tasks(
                      onAdd: () => context.push(AppPaths.taskCreate),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 100),
                      itemCount: filtered.length,
                      itemBuilder: (ctx, i) => TaskCard(task: filtered[i])
                          .animate(delay: Duration(milliseconds: i * 30))
                          .fadeIn(),
                    ),
            ),
          ],
        );
      },
    );
  }
}

// ─── Filter bar ───────────────────────────────────────────────────────────────

class _FilterBar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(taskFilterProvider);
    final notifier = ref.read(taskFilterProvider.notifier);
    final cs = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Status filters
          for (final s in [TaskStatus.todo, TaskStatus.inProgress, TaskStatus.done])
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(s.label),
                selected: filter.status == s,
                onSelected: (v) =>
                    notifier.filterByStatus(v ? s : null),
              ),
            ),
          const SizedBox(width: 8),
          // Priority filters
          for (final p in Priority.values)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8, height: 8,
                      decoration: BoxDecoration(
                        color: _priorityColor(p, cs),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(p.label),
                  ],
                ),
                selected: filter.priority == p,
                onSelected: (v) =>
                    notifier.filterByPriority(v ? p : null),
              ),
            ),
          if (filter.isActive)
            TextButton.icon(
              onPressed: notifier.clearAll,
              icon: const Icon(Icons.clear_all_rounded, size: 16),
              label: const Text('Clear'),
            ),
        ],
      ),
    );
  }
}

// ─── Sub-widgets ──────────────────────────────────────────────────────────────

class _OverdueBanner extends StatelessWidget {
  const _OverdueBanner({required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: cs.errorContainer,
        borderRadius: AppShapes.r12,
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: cs.onErrorContainer, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '$count task${count > 1 ? 's are' : ' is'} overdue!',
              style: Theme.of(context).textTheme.bodyMedium!
                  .copyWith(color: cs.onErrorContainer, fontWeight: FontWeight.w600),
            ),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(foregroundColor: cs.onErrorContainer),
            child: const Text('View'),
          ),
        ],
      ),
    );
  }
}

class _DateHeader extends StatelessWidget {
  const _DateHeader({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 6),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

class _PriorityHeader extends StatelessWidget {
  const _PriorityHeader({required this.priority});
  final Priority priority;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final color = _priorityColor(priority, cs);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 6),
      child: Row(
        children: [
          Container(
            width: 10, height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(
            '${priority.label} Priority',
            style: Theme.of(context).textTheme.labelLarge!
                .copyWith(color: color, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _CompletionBadge extends StatelessWidget {
  const _CompletionBadge({required this.done, required this.total});
  final int done;
  final int total;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    if (total == 0) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: cs.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '$done / $total',
        style: Theme.of(context).textTheme.labelSmall!
            .copyWith(color: cs.onPrimaryContainer, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.tab});
  final _TaskTab tab;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final (emoji, title, body) = switch (tab) {
      _TaskTab.today    => ('🎉', 'All clear today!', 'No tasks due today. Time to plan ahead or take a break.'),
      _TaskTab.upcoming => ('📅', 'Nothing coming up', 'Add tasks with deadlines to see them here.'),
      _TaskTab.priority => ('✅', 'No urgent tasks', 'You\'re on top of everything. Keep it up!'),
      _TaskTab.all      => ('📋', 'No tasks yet', 'Tap the + button to create your first task.'),
    };
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 56)),
          const SizedBox(height: 16),
          Text(title,
              style: Theme.of(context).textTheme.titleMedium!
                  .copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text(body,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!
                  .copyWith(color: cs.onSurfaceVariant)),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms);
  }
}

class _TasksShimmer extends StatelessWidget {
  const _TasksShimmer();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (_, i) => Container(
        height: 80,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: AppShapes.r12,
        ),
      ).animate(onPlay: (c) => c.repeat(reverse: true))
          .shimmer(duration: 1500.ms),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Error: $message',
          style: TextStyle(color: Theme.of(context).colorScheme.error)),
    );
  }
}

// ─── Helpers ──────────────────────────────────────────────────────────────────

List<TaskModel> _applySearch(List<TaskModel> tasks, String q) {
  if (q.trim().isEmpty) return tasks;
  final lower = q.toLowerCase();
  return tasks
      .where((t) =>
          t.title.toLowerCase().contains(lower) ||
          t.description.toLowerCase().contains(lower) ||
          t.tags.any((tag) => tag.toLowerCase().contains(lower)))
      .toList();
}

Color _priorityColor(Priority p, ColorScheme cs) => switch (p) {
      Priority.critical => cs.error,
      Priority.high   => const Color(0xFFE65100),
      Priority.medium => cs.primary,
      Priority.low    => cs.tertiary,
    };
