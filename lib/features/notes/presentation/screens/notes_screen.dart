// lib/features/notes/presentation/screens/notes_screen.dart
//
// StudySpark — Notes Screen
// Masonry grid + search + tag sidebar + empty state
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/shimmer_widgets.dart';
import '../../../../core/widgets/async_error_widget.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../data/models/note_model.dart';
import '../providers/notes_provider.dart';
import '../widgets/note_card.dart';

// ─── NotesScreen ──────────────────────────────────────────────────────────────

class NotesScreen extends ConsumerStatefulWidget {
  const NotesScreen({super.key});

  @override
  ConsumerState<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends ConsumerState<NotesScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchCtrl = TextEditingController();
  bool _searchActive = false;
  late AnimationController _searchAnimCtrl;

  @override
  void initState() {
    super.initState();
    _searchAnimCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _searchAnimCtrl.dispose();
    super.dispose();
  }

  void _openSearch() {
    setState(() => _searchActive = true);
    _searchAnimCtrl.forward();
  }

  void _closeSearch() {
    setState(() => _searchActive = false);
    _searchAnimCtrl.reverse();
    _searchCtrl.clear();
    ref.read(noteSearchQueryProvider.notifier).clear();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final isGrid = ref.watch(notesViewModeProvider);
    final selectedTag = ref.watch(noteTagFilterProvider);
    final tags = ref.watch(allNoteTagsProvider);
    final notesAsync = ref.watch(notesStreamProvider);

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: _buildAppBar(context, cs, tt, isGrid, selectedTag),
      body: Column(
        children: [
          // ── Tag filter strip ──────────────────────────────────────────────
          if (tags.isNotEmpty)
            _TagFilterStrip(
              tags: tags,
              selected: selectedTag,
              onSelect: (t) =>
                  ref.read(noteTagFilterProvider.notifier).select(t),
            ),

          // ── Note grid / list ──────────────────────────────────────────────
          Expanded(
            child: notesAsync.when(
              loading: () => const ShimmerList(itemCount: 6),
              error: (e, st) => AsyncErrorWidget(
                error: e,
                onRetry: () => ref.invalidate(notesStreamProvider),
              ),
              data: (allNotes) {
                final query =
                    ref.watch(noteSearchQueryProvider).toLowerCase();
                List<NoteModel> notes = allNotes;

                // Apply search filter
                if (query.isNotEmpty) {
                  notes = allNotes
                      .where((n) =>
                          n.title.toLowerCase().contains(query) ||
                          n.plainTextPreview.toLowerCase().contains(query) ||
                          n.tags.any((t) =>
                              t.toLowerCase().contains(query)))
                      .toList();
                }

                // Apply tag filter
                if (selectedTag != null) {
                  notes = notes
                      .where((n) => n.tags.contains(selectedTag))
                      .toList();
                }

                if (notes.isEmpty) {
                  if (query.isNotEmpty || selectedTag != null) {
                    return EmptyStateWidget.search();
                  } else {
                    return EmptyStateWidget.notes(
                      onAdd: () => context.push('/notes/new'),
                    );
                  }
                }

                return isGrid
                    ? _NotesGrid(notes: notes)
                    : _NotesList(notes: notes);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: _buildFab(context),
    );
  }

  AppBar _buildAppBar(BuildContext context, ColorScheme cs, TextTheme tt,
      bool isGrid, String? selectedTag) {
    return AppBar(
      backgroundColor: cs.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      title: _searchActive
          ? SlideTransition(
              position: Tween<Offset>(
                      begin: const Offset(0.3, 0), end: Offset.zero)
                  .animate(CurvedAnimation(
                      parent: _searchAnimCtrl,
                      curve: Curves.easeOut)),
              child: TextField(
                controller: _searchCtrl,
                autofocus: true,
                style: tt.bodyLarge,
                decoration: InputDecoration(
                  hintText: 'Search notes…',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                      color: cs.onSurfaceVariant.withOpacity(0.5)),
                ),
                onChanged: (v) =>
                    ref.read(noteSearchQueryProvider.notifier).update(v),
              ),
            )
          : Text(
              'Notes',
              style: tt.headlineSmall!.copyWith(fontWeight: FontWeight.w700),
            ),
      actions: [
        if (!_searchActive) ...[
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: _openSearch,
          ),
          IconButton(
            icon: Icon(isGrid
                ? Icons.view_list_rounded
                : Icons.grid_view_rounded),
            onPressed: () =>
                ref.read(notesViewModeProvider.notifier).toggle(),
          ),
          _PdfViewerButton(),
          const SizedBox(width: 4),
        ] else ...[
          IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: _closeSearch,
          ),
        ],
      ],
    );
  }

  Widget _buildFab(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => context.push('/notes/new'),
      icon: const Icon(Icons.add_rounded),
      label: const Text('New Note'),
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
    )
        .animate()
        .scale(
            duration: 400.ms,
            delay: 300.ms,
            curve: Curves.easeOutBack);
  }
}

// ─── Tag filter strip ─────────────────────────────────────────────────────────

class _TagFilterStrip extends StatelessWidget {
  const _TagFilterStrip({
    required this.tags,
    required this.selected,
    required this.onSelect,
  });

  final List<String> tags;
  final String? selected;
  final void Function(String?) onSelect;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          // "All" chip
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: FilterChip(
              label: const Text('All'),
              selected: selected == null,
              onSelected: (_) => onSelect(null),
              visualDensity: VisualDensity.compact,
              selectedColor: AppColors.primary.withOpacity(0.15),
              checkmarkColor: AppColors.primary,
              labelStyle: TextStyle(
                color: selected == null
                    ? AppColors.primary
                    : cs.onSurface,
                fontWeight: selected == null
                    ? FontWeight.w600
                    : FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ),
          ...tags.map((tag) {
            final isSel = selected == tag;
            return Padding(
              padding: const EdgeInsets.only(right: 6),
              child: FilterChip(
                label: Text('#$tag'),
                selected: isSel,
                onSelected: (_) => onSelect(isSel ? null : tag),
                visualDensity: VisualDensity.compact,
                selectedColor: AppColors.primary.withOpacity(0.15),
                checkmarkColor: AppColors.primary,
                labelStyle: TextStyle(
                  color: isSel ? AppColors.primary : cs.onSurface,
                  fontWeight:
                      isSel ? FontWeight.w600 : FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ─── Notes masonry grid ───────────────────────────────────────────────────────

class _NotesGrid extends StatelessWidget {
  const _NotesGrid({required this.notes});
  final List<NoteModel> notes;

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 100),
      itemCount: notes.length,
      itemBuilder: (_, i) => NoteCard(
        note: notes[i],
        index: i,
        onTap: () => context.push('/notes/${notes[i].uuid}'),
      ),
    );
  }
}

// ─── Notes list ───────────────────────────────────────────────────────────────

class _NotesList extends StatelessWidget {
  const _NotesList({required this.notes});
  final List<NoteModel> notes;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 100),
      itemCount: notes.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, i) {
        final note = notes[i];
        return NoteCard(
          note: note,
          index: i,
          onTap: () => context.push('/notes/${note.uuid}'),
        );
      },
    );
  }
}

// ─── PDF viewer launch button ─────────────────────────────────────────────────

class _PdfViewerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.picture_as_pdf_rounded),
      tooltip: 'PDF Viewer',
      onPressed: () => context.push('/notes/pdf'),
    );
  }
}
