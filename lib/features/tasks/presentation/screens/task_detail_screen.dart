// lib/features/tasks/presentation/screens/task_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({super.key, required this.taskId});
  final String taskId;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Task Details',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.edit_rounded), onPressed: () {}),
          IconButton(icon: const Icon(Icons.delete_outline_rounded), onPressed: () {}),
          const SizedBox(width: 8),
        ],
      ),
      body: Center(
        child: Text(
          'Task ID: $taskId',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
