// lib/features/tasks/presentation/screens/tasks_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_theme.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Tasks',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.filter_list_rounded), onPressed: () {}),
          IconButton(icon: const Icon(Icons.search_rounded), onPressed: () {}),
          const SizedBox(width: 8),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('✅', style: TextStyle(fontSize: 64))
                .animate().scale(duration: 600.ms, curve: Curves.easeOutBack),
            const SizedBox(height: 16),
            Text(
              'No tasks yet',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ).animate(delay: 200.ms).fadeIn(),
            const SizedBox(height: 8),
            Text(
              'Tap the + button to add your first task',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: cs.onSurfaceVariant,
              ),
            ).animate(delay: 300.ms).fadeIn(),
            const SizedBox(height: 120), // FAB clearance
          ],
        ),
      ),
    );
  }
}
