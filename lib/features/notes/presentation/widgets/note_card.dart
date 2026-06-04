// lib/features/notes/presentation/widgets/note_card.dart
//
// StudySpark — Colored note card with preview text, tags and action menu.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/enums/app_enums.dart';
import '../../../../shared/providers/repository_providers.dart';
import '../../data/models/note_model.dart';

// ─── Helpers ─────────────────────────────────────────────────────────────────

Color _noteCardColor(NoteColor nc, bool isDark) {
  if (isDark) {
    // Darker tinted versions for dark mode
    const Map<NoteColor, Color> dark = {
      NoteColor.white: Color(0xFF232136),
      NoteColor.yellow: Color(0xFF3A2F00),
      NoteColor.blue: Color(0xFF0A2A4A),
      NoteColor.green: Color(0xFF0A2A1A),
      NoteColor.pink: Color(0xFF3A0A1A),
      NoteColor.purple: Color(0xFF2A0A3A),
      NoteColor.orange: Color(0xFF3A1A00),
      NoteColor.teal: Color(0xFF002A2A),
    };
    return dark[nc] ?? const Color(0xFF232136);
  }
  const Map<NoteColor, Color> light = {
    NoteColor.white: Color(0xFFFFFFFF),
    NoteColor.yellow: Color(0xFFFFF9C4),
    NoteColor.blue: Color(0xFFBBDEFB),
    NoteColor.green: Color(0xFFC8E6C9),
    NoteColor.pink: Color(0xFFF8BBD9),
    NoteColor.purple: Color(0xFFE1BEE7),
    NoteColor.orange: Color(0xFFFFE0B2),
    NoteColor.teal: Color(0xFFB2EBF2),
  };
  return light[nc] ?? Colors.white;
}

Color _noteAccentColor(NoteColor nc) {
  const Map<NoteColor, Color> accent = {
    NoteColor.white: AppColors.primary,
    NoteColor.yellow: Color(0xFFF9A825),
    NoteColor.blue: Color(0xFF1565C0),
    NoteColor.green: Color(0xFF2E7D32),
    NoteColor.pink: Color(0xFFC2185B),
    NoteColor.purple: Color(0xFF6A1B9A),
    NoteColor.orange: Color(0xFFE65100),
    NoteColor.teal: Color(0xFF00695C),
  };
  return accent[nc] ?? AppColors.primary;
}

// ─── NoteCard ─────────────────────────────────────────────────────────────────

class NoteCard extends ConsumerWidget {
  const NoteCard({
    super.key,
    required this.note,
    required this.onTap,
    this.index = 0,
  });

  final NoteModel note;
  final VoidCallback onTap;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final cardColor = _noteCardColor(note.color, isDark);
    final accentColor = _noteAccentColor(note.color);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: AppShapes.r16,
          border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(0.06)
                : Colors.black.withOpacity(0.06),
          ),
          boxShadow: AppShadows.sm(accentColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Accent bar + pin ──────────────────────────────────────────
            if (note.isPinned)
              Container(
                height: 3,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
              ),

            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 6, 0),
              child: Row(
                children: [
                  // Title
                  Expanded(
                    child: Text(
                      note.title.isEmpty ? 'Untitled' : note.title,
                      style: tt.titleSmall!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  _NoteCardMenu(note: note),
                ],
              ),
            ),

            // ── Preview text ──────────────────────────────────────────────
            if (note.plainTextPreview.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 6, 14, 0),
                child: Text(
                  note.plainTextPreview,
                  style: tt.bodySmall!.copyWith(
                    color: (isDark ? Colors.white : Colors.black87)
                        .withOpacity(0.65),
                    height: 1.5,
                  ),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

            // ── Tags ──────────────────────────────────────────────────────
            if (note.tags.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                child: Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: note.tags.take(3).map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: accentColor.withOpacity(0.12),
                        borderRadius: AppShapes.r8,
                      ),
                      child: Text(
                        '#$tag',
                        style: tt.labelSmall!.copyWith(
                          color: accentColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

            // ── Date + word count ─────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 6, 14, 12),
              child: Row(
                children: [
                  Icon(Icons.access_time_rounded,
                      size: 11,
                      color: (isDark ? Colors.white : Colors.black87)
                          .withOpacity(0.4)),
                  const SizedBox(width: 3),
                  Text(
                    note.updatedAt != null
                        ? DateFormat('MMM d').format(
                            note.updatedAt!.toLocal())
                        : '',
                    style: tt.labelSmall!.copyWith(
                      color: (isDark ? Colors.white : Colors.black87)
                          .withOpacity(0.4),
                    ),
                  ),
                  if (note.wordCount > 0) ...[
                    Text(
                      '  ·  ${note.wordCount}w',
                      style: tt.labelSmall!.copyWith(
                        color: (isDark ? Colors.white : Colors.black87)
                            .withOpacity(0.4),
                      ),
                    ),
                  ],
                  if (note.hasAiSummary) ...[
                    const SizedBox(width: 4),
                    Icon(Icons.auto_awesome_rounded,
                        size: 11, color: AppColors.primary),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    )
        .animate(delay: Duration(milliseconds: 40 * index))
        .fadeIn(duration: 300.ms)
        .slideY(begin: 0.1, end: 0, duration: 300.ms, curve: Curves.easeOut);
  }
}

// ─── Note card context menu ───────────────────────────────────────────────────

class _NoteCardMenu extends ConsumerWidget {
  const _NoteCardMenu({required this.note});
  final NoteModel note;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert_rounded,
          size: 18,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
      iconSize: 18,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: AppShapes.r12),
      itemBuilder: (_) => [
        PopupMenuItem(
          value: 'pin',
          child: Row(children: [
            Icon(note.isPinned
                ? Icons.push_pin_rounded
                : Icons.push_pin_outlined),
            const SizedBox(width: 10),
            Text(note.isPinned ? 'Unpin' : 'Pin'),
          ]),
        ),
        const PopupMenuItem(
          value: 'archive',
          child: Row(children: [
            Icon(Icons.archive_outlined),
            SizedBox(width: 10),
            Text('Archive'),
          ]),
        ),
        const PopupMenuItem(
          value: 'delete',
          child: Row(children: [
            Icon(Icons.delete_outline_rounded, color: Colors.red),
            SizedBox(width: 10),
            Text('Delete', style: TextStyle(color: Colors.red)),
          ]),
        ),
      ],
      onSelected: (v) async {
        final repo = ref.read(noteRepositoryProvider);
        switch (v) {
          case 'pin':
            await repo.togglePin(note.uuid);
            break;
          case 'archive':
            await repo.archiveNote(note.uuid);
            break;
          case 'delete':
            final confirmed = await showDialog<bool>(
              context: context,
              builder: (_) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: AppShapes.r16),
                title: const Text('Delete note?'),
                content: const Text(
                    'This action cannot be undone.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancel'),
                  ),
                  FilledButton(
                    style: FilledButton.styleFrom(
                        backgroundColor: Colors.red),
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Delete'),
                  ),
                ],
              ),
            );
            if (confirmed == true) await repo.deleteNote(note.uuid);
            break;
        }
      },
    );
  }
}
