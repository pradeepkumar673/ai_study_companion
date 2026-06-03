// lib/core/widgets/empty_state_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.actionLabel,
    this.onAction,
    this.iconColor,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;
  final Color? iconColor;

  // ── Named constructors for common empty states ─────────────────────────────

  factory EmptyStateWidget.tasks({VoidCallback? onAdd}) => EmptyStateWidget(
        icon: Icons.task_alt_rounded,
        title: 'No tasks yet',
        subtitle: 'Tap the + button to create your first task.',
        actionLabel: onAdd != null ? 'Add task' : null,
        onAction: onAdd,
      );

  factory EmptyStateWidget.notes({VoidCallback? onAdd}) => EmptyStateWidget(
        icon: Icons.sticky_note_2_outlined,
        title: 'No notes yet',
        subtitle: 'Create a note to start capturing your ideas.',
        actionLabel: onAdd != null ? 'New note' : null,
        onAction: onAdd,
      );

  factory EmptyStateWidget.flashcards({VoidCallback? onAdd}) => EmptyStateWidget(
        icon: Icons.style_outlined,
        title: 'No flashcard decks',
        subtitle: 'Create a deck or generate one with AI.',
        actionLabel: onAdd != null ? 'Create deck' : null,
        onAction: onAdd,
      );

  factory EmptyStateWidget.search() => const EmptyStateWidget(
        icon: Icons.search_off_rounded,
        title: 'No results',
        subtitle: 'Try different search terms or clear your filter.',
      );

  factory EmptyStateWidget.goals({VoidCallback? onAdd}) => EmptyStateWidget(
        icon: Icons.flag_outlined,
        title: 'No goals set',
        subtitle: 'Set a goal to stay motivated and track progress.',
        actionLabel: onAdd != null ? 'Add goal' : null,
        onAction: onAdd,
      );

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 72,
              color: (iconColor ?? cs.primary).withOpacity(0.25),
            )
                .animate()
                .scale(
                  begin: const Offset(0.7, 0.7),
                  duration: 500.ms,
                  curve: Curves.easeOutBack,
                )
                .fadeIn(duration: 400.ms),
            const Gap(20),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface,
                  ),
              textAlign: TextAlign.center,
            ).animate(delay: 100.ms).fadeIn(),
            const Gap(8),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: cs.onSurfaceVariant,
                    height: 1.5,
                  ),
              textAlign: TextAlign.center,
            ).animate(delay: 150.ms).fadeIn(),
            if (onAction != null && actionLabel != null) ...[
              const Gap(24),
              FilledButton.tonalIcon(
                onPressed: onAction,
                icon: const Icon(Icons.add_rounded, size: 18),
                label: Text(actionLabel!),
              ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.2, end: 0),
            ],
          ],
        ),
      ),
    );
  }
}
