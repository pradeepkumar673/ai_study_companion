// lib/features/notes/presentation/widgets/tag_input.dart
//
// StudySpark — Chip-based tag input widget.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class TagInputField extends StatefulWidget {
  const TagInputField({
    super.key,
    required this.tags,
    required this.onAdd,
    required this.onRemove,
  });

  final List<String> tags;
  final void Function(String) onAdd;
  final void Function(String) onRemove;

  @override
  State<TagInputField> createState() => _TagInputFieldState();
}

class _TagInputFieldState extends State<TagInputField> {
  final TextEditingController _ctrl = TextEditingController();

  void _submit() {
    final tag = _ctrl.text.trim();
    if (tag.isNotEmpty) {
      widget.onAdd(tag);
      _ctrl.clear();
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Chips row
        if (widget.tags.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: widget.tags.map((tag) {
                return Chip(
                  label: Text('#$tag', style: tt.labelSmall),
                  deleteIcon: const Icon(Icons.close_rounded, size: 14),
                  onDeleted: () => widget.onRemove(tag),
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  side: BorderSide(color: AppColors.primary.withOpacity(0.25)),
                  labelStyle: TextStyle(color: AppColors.primary),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  visualDensity: VisualDensity.compact,
                );
              }).toList(),
            ),
          ),

        // Input row
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _ctrl,
                style: tt.bodySmall,
                decoration: InputDecoration(
                  hintText: 'Add tag…',
                  hintStyle: tt.bodySmall!.copyWith(
                      color: cs.onSurface.withOpacity(0.4)),
                  prefixIcon: const Icon(Icons.tag_rounded, size: 16),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: AppShapes.r8,
                    borderSide:
                        BorderSide(color: cs.outline.withOpacity(0.4)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: AppShapes.r8,
                    borderSide:
                        BorderSide(color: cs.outline.withOpacity(0.3)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: AppShapes.r8,
                    borderSide:
                        BorderSide(color: AppColors.primary, width: 1.5),
                  ),
                ),
                onSubmitted: (_) => _submit(),
                textInputAction: TextInputAction.done,
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: _submit,
              icon: Icon(Icons.add_circle_rounded,
                  color: AppColors.primary, size: 28),
              style: IconButton.styleFrom(
                padding: const EdgeInsets.all(4),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
