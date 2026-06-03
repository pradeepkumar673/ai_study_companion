// lib/features/notes/presentation/screens/note_editor_screen.dart
//
// StudySpark — Note Editor Screen
// Create / Edit a note with voice input, handwriting scanner,
// color picker, tag input, pin toggle and save.
// ─────────────────────────────────────────────────────────────────────────────

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/enums/app_enums.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/providers/repository_providers.dart';
import '../../data/models/note_model.dart';
import '../providers/notes_provider.dart';
import '../widgets/handwriting_scanner_sheet.dart';
import '../widgets/tag_input.dart';
import '../widgets/voice_to_notes_sheet.dart';

// ─── Color map for note cards ─────────────────────────────────────────────────

Color _colorForEnum(NoteColor nc) {
  const Map<NoteColor, Color> map = {
    NoteColor.white: Color(0xFFFFFFFF),
    NoteColor.yellow: Color(0xFFFFF9C4),
    NoteColor.blue: Color(0xFFBBDEFB),
    NoteColor.green: Color(0xFFC8E6C9),
    NoteColor.pink: Color(0xFFF8BBD9),
    NoteColor.purple: Color(0xFFE1BEE7),
    NoteColor.orange: Color(0xFFFFE0B2),
    NoteColor.teal: Color(0xFFB2EBF2),
  };
  return map[nc] ?? Colors.white;
}

// ─── NoteEditorScreen ─────────────────────────────────────────────────────────

class NoteEditorScreen extends ConsumerStatefulWidget {
  const NoteEditorScreen({super.key, this.noteId});

  /// UUID of an existing note to edit; null = create new.
  final String? noteId;

  @override
  ConsumerState<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends ConsumerState<NoteEditorScreen> {
  late final TextEditingController _titleCtrl;
  late final TextEditingController _contentCtrl;
  NoteModel? _existing;
  bool _loaded = false;
  bool _showToolbar = false;

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController();
    _contentCtrl = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadNote());
  }

  Future<void> _loadNote() async {
    if (widget.noteId != null && widget.noteId != 'new') {
      final repo = ref.read(noteRepositoryProvider);
      final note = await repo.getNoteByUuid(widget.noteId!);
      if (note != null && mounted) {
        _existing = note;
        ref.read(noteEditorProvider.notifier).loadFromNote(note);
        _titleCtrl.text = note.title;
        _contentCtrl.text = note.plainTextPreview;
      }
    } else {
      ref.read(noteEditorProvider.notifier).reset();
    }
    if (mounted) setState(() => _loaded = true);
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _contentCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final notifier = ref.read(noteEditorProvider.notifier);
    notifier.setTitle(_titleCtrl.text);
    notifier.setContent(_contentCtrl.text);

    try {
      if (_existing != null) {
        await notifier.saveExisting(ref, _existing!);
      } else {
        await notifier.saveNew(ref);
      }
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving note: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _openVoice() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => VoiceToNotesSheet(
        initialText: _contentCtrl.text,
      ),
    );
    if (result != null && result.isNotEmpty) {
      setState(() => _contentCtrl.text = result);
      ref.read(noteEditorProvider.notifier).setContent(result);
    }
  }

  Future<void> _openScanner() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const HandwritingScannerSheet(),
    );
    if (result != null && result.isNotEmpty) {
      final current = _contentCtrl.text;
      final appended =
          current.isEmpty ? result : '$current\n\n$result';
      setState(() => _contentCtrl.text = appended);
      ref.read(noteEditorProvider.notifier).setContent(appended);
    }
  }

  @override
  Widget build(BuildContext context) {
    final editor = ref.watch(noteEditorProvider);
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (!_loaded) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final bgColor = isDark
        ? cs.surface
        : _colorForEnum(editor.color).withOpacity(0.4);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: _buildAppBar(context, cs, tt, editor),
      body: Column(
        children: [
          // ── Title field ───────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: TextField(
              controller: _titleCtrl,
              onChanged: (_) {}, // state saved on _save()
              style: tt.headlineSmall!
                  .copyWith(fontWeight: FontWeight.w700),
              decoration: InputDecoration(
                hintText: 'Note title…',
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: cs.onSurfaceVariant.withOpacity(0.45),
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                ),
              ),
            ),
          )
              .animate()
              .fadeIn(duration: 250.ms)
              .slideY(begin: -0.05),

          const Divider(height: 1, indent: 20, endIndent: 20),

          // ── Content field ─────────────────────────────────────────────────
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _contentCtrl,
                maxLines: null,
                expands: true,
                onChanged: (_) {},
                onTap: () => setState(() => _showToolbar = true),
                style: tt.bodyLarge!.copyWith(height: 1.75),
                decoration: InputDecoration(
                  hintText: 'Start writing…',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: cs.onSurfaceVariant.withOpacity(0.4),
                  ),
                ),
              ),
            ),
          )
              .animate()
              .fadeIn(duration: 300.ms, delay: 80.ms),

          // ── Bottom toolbar ────────────────────────────────────────────────
          _BottomToolbar(
            editor: editor,
            onVoice: _openVoice,
            onScan: _openScanner,
            onColorPick: () => _showColorPicker(context, editor),
            onTagsExpand: () => _showTagsSheet(context, editor),
          ),

          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, ColorScheme cs, TextTheme tt,
      NoteEditorState editor) {
    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
        onPressed: () => context.pop(),
      ),
      actions: [
        // Pin toggle
        IconButton(
          icon: Icon(
            editor.isPinned
                ? Icons.push_pin_rounded
                : Icons.push_pin_outlined,
            color: editor.isPinned ? AppColors.primary : null,
          ),
          onPressed: () =>
              ref.read(noteEditorProvider.notifier).togglePin(),
          tooltip: editor.isPinned ? 'Unpin' : 'Pin',
        ),

        // AI summary button
        IconButton(
          icon: const Icon(Icons.auto_awesome_rounded),
          tooltip: 'AI Summary',
          onPressed: () {
            context.push('/ai/summarizer', extra: {
              'text': _contentCtrl.text,
              'title': _titleCtrl.text,
            });
          },
        ),

        // Save button
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: editor.isSaving
              ? const SizedBox(
                  width: 36,
                  height: 36,
                  child: Center(
                      child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2))),
                )
              : FilledButton(
                  onPressed: _save,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text('Save'),
                ),
        ),
      ],
    );
  }

  void _showColorPicker(BuildContext context, NoteEditorState editor) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _ColorPickerSheet(
        current: editor.color,
        onSelect: (c) {
          ref.read(noteEditorProvider.notifier).setColor(c);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showTagsSheet(BuildContext context, NoteEditorState editor) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _TagsSheet(editor: editor),
    );
  }
}

// ─── Bottom toolbar ───────────────────────────────────────────────────────────

class _BottomToolbar extends StatelessWidget {
  const _BottomToolbar({
    required this.editor,
    required this.onVoice,
    required this.onScan,
    required this.onColorPick,
    required this.onTagsExpand,
  });

  final NoteEditorState editor;
  final VoidCallback onVoice;
  final VoidCallback onScan;
  final VoidCallback onColorPick;
  final VoidCallback onTagsExpand;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final dotColor = _colorForEnum(editor.color);

    return Container(
      decoration: BoxDecoration(
        color: cs.surface.withOpacity(0.9),
        border: Border(top: BorderSide(color: cs.outline.withOpacity(0.15))),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            children: [
              // Voice to text
              _ToolbarBtn(
                icon: Icons.mic_rounded,
                label: 'Voice',
                color: AppColors.primary,
                onTap: onVoice,
              ),
              // Handwriting scan
              _ToolbarBtn(
                icon: Icons.document_scanner_rounded,
                label: 'Scan',
                color: AppColors.tertiary,
                onTap: onScan,
              ),
              // Tags
              _ToolbarBtn(
                icon: Icons.tag_rounded,
                label: editor.tags.isEmpty
                    ? 'Tags'
                    : '${editor.tags.length} tag${editor.tags.length == 1 ? '' : 's'}',
                color: AppColors.secondary,
                onTap: onTagsExpand,
              ),
              // Color
              GestureDetector(
                onTap: onColorPick,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: dotColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: cs.outline.withOpacity(0.4),
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Color',
                        style: TextStyle(
                          fontSize: 10,
                          color: cs.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ToolbarBtn extends StatelessWidget {
  const _ToolbarBtn({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: AppShapes.r8,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 22, color: color),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: cs.onSurface.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Color picker sheet ───────────────────────────────────────────────────────

class _ColorPickerSheet extends StatelessWidget {
  const _ColorPickerSheet({required this.current, required this.onSelect});

  final NoteColor current;
  final void Function(NoteColor) onSelect;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: cs.onSurface.withOpacity(0.2),
                borderRadius: AppShapes.r8,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text('Note color',
              style: tt.titleMedium!.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 14,
            runSpacing: 12,
            children: NoteColor.values.map((nc) {
              final isSelected = nc == current;
              return GestureDetector(
                onTap: () => onSelect(nc),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: _colorForEnum(nc),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary
                          : cs.outline.withOpacity(0.3),
                      width: isSelected ? 2.5 : 1,
                    ),
                    boxShadow: isSelected
                        ? AppShadows.glow(AppColors.primary)
                        : null,
                  ),
                  child: isSelected
                      ? const Icon(Icons.check_rounded,
                          size: 20, color: Colors.black54)
                      : null,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// ─── Tags sheet ───────────────────────────────────────────────────────────────

class _TagsSheet extends ConsumerWidget {
  const _TagsSheet({required this.editor});
  final NoteEditorState editor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final notifier = ref.read(noteEditorProvider.notifier);
    final current = ref.watch(noteEditorProvider);

    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius:
              const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: cs.onSurface.withOpacity(0.2),
                  borderRadius: AppShapes.r8,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('Tags',
                style:
                    tt.titleMedium!.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 14),
            TagInputField(
              tags: current.tags,
              onAdd: notifier.addTag,
              onRemove: notifier.removeTag,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Done'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
