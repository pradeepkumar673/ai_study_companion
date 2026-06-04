// lib/features/notes/presentation/providers/notes_provider.dart
//
// StudySpark — Notes feature Riverpod providers
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../shared/providers/repository_providers.dart';
import '../../../../core/enums/app_enums.dart';
import '../../data/models/note_model.dart';

part 'notes_provider.g.dart';

// ─── Notes list stream ────────────────────────────────────────────────────────

@riverpod
Stream<List<NoteModel>> notesStream(NotesStreamRef ref) {
  final repo = ref.watch(noteRepositoryProvider);
  return repo.watchAllNotes();
}

// ─── Search query state ───────────────────────────────────────────────────────

@riverpod
class NoteSearchQuery extends _$NoteSearchQuery {
  @override
  String build() => '';

  void update(String q) => state = q;
  void clear() => state = '';
}

// ─── Selected folder/tag filter ───────────────────────────────────────────────

@riverpod
class NoteTagFilter extends _$NoteTagFilter {
  @override
  String? build() => null; // null = All

  void select(String? tag) => state = tag;
}

// ─── View mode (grid / list) ──────────────────────────────────────────────────

@riverpod
class NotesViewMode extends _$NotesViewMode {
  @override
  bool build() => true; // true = grid

  void toggle() => state = !state;
}

// ─── Filtered notes ──────────────────────────────────────────────────────────

@riverpod
Future<List<NoteModel>> filteredNotes(FilteredNotesRef ref) async {
  final query = ref.watch(noteSearchQueryProvider);
  final tag = ref.watch(noteTagFilterProvider);
  final repo = ref.watch(noteRepositoryProvider);

  if (query.isNotEmpty) {
    return repo.searchNotes(query);
  }
  if (tag != null) {
    // one-shot fetch for tag filter
    return repo.watchNotesByTag(tag).first;
  }
  return repo.watchAllNotes().first;
}

// ─── All unique tags ──────────────────────────────────────────────────────────

@riverpod
List<String> allNoteTags(AllNoteTagsRef ref) {
  final notesAsync = ref.watch(notesStreamProvider);
  return notesAsync.maybeWhen(
    data: (notes) {
      final tags = <String>{};
      for (final n in notes) {
        tags.addAll(n.tags);
      }
      return tags.toList()..sort();
    },
    orElse: () => [],
  );
}

// ─── Note editor draft state ──────────────────────────────────────────────────

class NoteEditorState {
  const NoteEditorState({
    this.title = '',
    this.content = '',
    this.tags = const [],
    this.color = NoteColor.white,
    this.isPinned = false,
    this.isSaving = false,
  });

  final String title;
  final String content;
  final List<String> tags;
  final NoteColor color;
  final bool isPinned;
  final bool isSaving;

  NoteEditorState copyWith({
    String? title,
    String? content,
    List<String>? tags,
    NoteColor? color,
    bool? isPinned,
    bool? isSaving,
  }) =>
      NoteEditorState(
        title: title ?? this.title,
        content: content ?? this.content,
        tags: tags ?? this.tags,
        color: color ?? this.color,
        isPinned: isPinned ?? this.isPinned,
        isSaving: isSaving ?? this.isSaving,
      );
}

@riverpod
class NoteEditor extends _$NoteEditor {
  @override
  NoteEditorState build() => const NoteEditorState();

  void loadFromNote(NoteModel note) {
    state = NoteEditorState(
      title: note.title,
      content: note.plainTextPreview, // plain text for editing
      tags: List.from(note.tags),
      color: note.color,
      isPinned: note.isPinned,
    );
  }

  void setTitle(String t) => state = state.copyWith(title: t);
  void setContent(String c) => state = state.copyWith(content: c);
  void setColor(NoteColor c) => state = state.copyWith(color: c);
  void togglePin() => state = state.copyWith(isPinned: !state.isPinned);

  void addTag(String tag) {
    if (tag.trim().isEmpty || state.tags.contains(tag.trim())) return;
    state = state.copyWith(tags: [...state.tags, tag.trim()]);
  }

  void removeTag(String tag) {
    state = state.copyWith(tags: state.tags.where((t) => t != tag).toList());
  }

  void setSaving(bool v) => state = state.copyWith(isSaving: v);

  void reset() => state = const NoteEditorState();

  Future<NoteModel> saveNew(ref) async {
    state = state.copyWith(isSaving: true);
    final repo = ref.read(noteRepositoryProvider);
    final note = await repo.createNote(
      title: state.title.trim().isEmpty ? 'Untitled' : state.title.trim(),
      content: state.content,
      plainTextPreview: state.content.length > 200
          ? state.content.substring(0, 200)
          : state.content,
      tags: state.tags,
      isPinned: state.isPinned,
    );
    state = state.copyWith(isSaving: false);
    return note;
  }

  Future<void> saveExisting(ref, NoteModel existing) async {
    state = state.copyWith(isSaving: true);
    final repo = ref.read(noteRepositoryProvider);
    existing.title = state.title.trim().isEmpty ? 'Untitled' : state.title.trim();
    existing.content = state.content;
    existing.plainTextPreview = state.content.length > 200
        ? state.content.substring(0, 200)
        : state.content;
    existing.tags = state.tags;
    existing.color = state.color;
    existing.isPinned = state.isPinned;
    existing.wordCount = state.content.split(RegExp(r'\s+')).length;
    await repo.updateNote(existing);
    state = state.copyWith(isSaving: false);
  }
}
