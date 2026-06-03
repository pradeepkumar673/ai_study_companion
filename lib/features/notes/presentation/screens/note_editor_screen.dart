// lib/features/notes/presentation/screens/note_editor_screen.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NoteEditorScreen extends StatelessWidget {
  const NoteEditorScreen({super.key, this.noteId});
  final String? noteId;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isEditing = noteId != null;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.pop(),
        ),
        title: Text(
          isEditing ? 'Edit Note' : 'New Note',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          if (isEditing)
            IconButton(
              icon: const Icon(Icons.auto_awesome_rounded),
              tooltip: 'AI Summary',
              onPressed: () {},
            ),
          FilledButton(
            onPressed: () => context.pop(),
            child: const Text('Save'),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Note title…',
                border: InputBorder.none,
                hintStyle: TextStyle(color: cs.onSurfaceVariant.withOpacity(0.5)),
              ),
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const Divider(),
            Expanded(
              child: TextField(
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  hintText: 'Start writing…',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: cs.onSurfaceVariant.withOpacity(0.5)),
                ),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  height: 1.7,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
