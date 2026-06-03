// lib/features/tasks/presentation/widgets/task_card.dart
//
// StudySpark — Task Card (Step 5)
//
// • Swipe right → complete
// • Swipe left  → delete
// • Tap         → open detail/edit sheet
// • Progress bar for subtasks
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/enums/app_enums.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/providers/repository_providers.dart';
import '../../data/models/task_model.dart';
import 'add_edit_task_sheet.dart';

class TaskCard extends ConsumerWidget {
  const TaskCard({super.key, required this.task});

  final TaskModel task;

  Color _priorityColor(Priority p, ColorScheme cs) => switch (p) {
        Priority.critical => cs.error,
        Priority.high   => const Color(0xFFE65100),
        Priority.medium => cs.primary,
        Priority.low    => cs.tertiary,
      };

  IconData _priorityIcon(Priority p) => switch (p) {
        Priority.critical => Icons.priority_high_rounded,
        Priority.high   => Icons.keyboard_arrow_up_rounded,
        Priority.medium => Icons.remove_rounded,
        Priority.low    => Icons.keyboard_arrow_down_rounded,
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final isCompleted = task.isCompleted;
    final pColor = _priorityColor(task.priority, cs);

    return Dismissible(
      key: ValueKey(task.uuid),
      background: _SwipeBackground(
        color: cs.primaryContainer,
        icon: Icons.check_circle_rounded,
        iconColor: cs.onPrimaryContainer,
        alignment: Alignment.centerLeft,
        label: 'Complete',
        labelColor: cs.onPrimaryContainer,
      ),
      secondaryBackground: _SwipeBackground(
        color: cs.errorContainer,
        icon: Icons.delete_rounded,
        iconColor: cs.onErrorContainer,
        alignment: Alignment.centerRight,
        label: 'Delete',
        labelColor: cs.onErrorContainer,
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          await ref.read(taskRepositoryProvider).completeTask(task.uuid);
          return false; // don't remove from list, Isar stream handles it
        } else {
          return await _confirmDelete(context, ref);
        }
      },
      child: GestureDetector(
        onTap: () => _openEdit(context, ref),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          decoration: BoxDecoration(
            color: isCompleted
                ? cs.surfaceContainerHighest.withOpacity(0.5)
                : cs.surfaceContainer,
            borderRadius: AppShapes.r16,
            border: Border(
              left: BorderSide(
                color: isCompleted ? cs.outlineVariant : pColor,
                width: 4,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row 1: Priority badge + title + status icon
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Priority icon
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: pColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(_priorityIcon(task.priority),
                          color: pColor, size: 14),
                    ),
                    const SizedBox(width: 10),

                    // Title
                    Expanded(
                      child: Text(
                        task.title,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600,
                              decoration: isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                              color: isCompleted
                                  ? cs.onSurfaceVariant
                                  : cs.onSurface,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Completion checkbox
                    GestureDetector(
                      onTap: () => ref
                          .read(taskRepositoryProvider)
                          .completeTask(task.uuid),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isCompleted ? cs.primary : Colors.transparent,
                          border: Border.all(
                            color: isCompleted ? cs.primary : cs.outline,
                            width: 2,
                          ),
                        ),
                        child: isCompleted
                            ? Icon(Icons.check_rounded,
                                color: cs.onPrimary, size: 14)
                            : null,
                      ),
                    ),
                  ],
                ),

                // Description (if any)
                if (task.description.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.only(left: 34),
                    child: Text(
                      task.description,
                      style: Theme.of(context).textTheme.bodySmall!
                          .copyWith(color: cs.onSurfaceVariant),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],

                // Subtask progress
                if (task.subtasks.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 34),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${task.completedSubtaskCount}/${task.subtasks.length} subtasks',
                              style: Theme.of(context).textTheme.labelSmall!
                                  .copyWith(color: cs.onSurfaceVariant),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: LinearProgressIndicator(
                            value: task.subtaskProgress,
                            minHeight: 4,
                            backgroundColor: cs.surfaceContainerHighest,
                            color: pColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                // Row 2: Deadline + tags
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 34),
                  child: Row(
                    children: [
                      if (task.deadline != null) ...[
                        Icon(
                          Icons.schedule_rounded,
                          size: 13,
                          color: task.isOverdue ? cs.error : cs.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          DateFormat('d MMM, h:mm a')
                              .format(task.deadline!.toLocal()),
                          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                color: task.isOverdue
                                    ? cs.error
                                    : cs.onSurfaceVariant,
                                fontWeight: task.isOverdue
                                    ? FontWeight.w700
                                    : FontWeight.w400,
                              ),
                        ),
                        if (task.isOverdue) ...[
                          const SizedBox(width: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 1),
                            decoration: BoxDecoration(
                              color: cs.errorContainer,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'OVERDUE',
                              style: TextStyle(
                                color: cs.onErrorContainer,
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ],

                      const Spacer(),

                      // Est. time chip
                      if (task.estimatedMinutes > 0) ...[
                        Icon(Icons.timer_outlined,
                            size: 12, color: cs.onSurfaceVariant),
                        const SizedBox(width: 3),
                        Text(
                          '${task.estimatedMinutes}m',
                          style: Theme.of(context).textTheme.labelSmall!
                              .copyWith(color: cs.onSurfaceVariant),
                        ),
                        const SizedBox(width: 8),
                      ],

                      // Repeat badge
                      if (task.repeatFrequency != RepeatFrequency.none)
                        Icon(Icons.repeat_rounded,
                            size: 14, color: cs.onSurfaceVariant),
                    ],
                  ),
                ),

                // Tags row
                if (task.tags.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 34),
                    child: Wrap(
                      spacing: 6,
                      children: task.tags
                          .take(3)
                          .map((tag) => Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: cs.secondaryContainer,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  '#$tag',
                                  style: TextStyle(
                                    color: cs.onSecondaryContainer,
                                    fontSize: 11,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Task?'),
        content: Text('Delete "${task.title}"? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (result == true) {
      await ref.read(taskRepositoryProvider).deleteTask(task.uuid);
    }
    return false;
  }

  void _openEdit(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => AddEditTaskSheet(existingTask: task),
    );
  }
}

// ─── Swipe background ─────────────────────────────────────────────────────────

class _SwipeBackground extends StatelessWidget {
  const _SwipeBackground({
    required this.color,
    required this.icon,
    required this.iconColor,
    required this.alignment,
    required this.label,
    required this.labelColor,
  });

  final Color color;
  final IconData icon;
  final Color iconColor;
  final Alignment alignment;
  final String label;
  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: AppShapes.r16,
      ),
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: alignment == Alignment.centerLeft
            ? [
                Icon(icon, color: iconColor),
                const SizedBox(width: 8),
                Text(label,
                    style: TextStyle(
                        color: labelColor, fontWeight: FontWeight.w600)),
              ]
            : [
                Text(label,
                    style: TextStyle(
                        color: labelColor, fontWeight: FontWeight.w600)),
                const SizedBox(width: 8),
                Icon(icon, color: iconColor),
              ],
      ),
    );
  }
}
