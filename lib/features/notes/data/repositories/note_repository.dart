// lib/features/notes/data/repositories/note_repository.dart
//
// StudySpark — Note Repository
//
// Handles all persistence for [NoteModel] (rich-text Quill Delta notes).
// Full-text search uses Isar's word index on [plainTextPreview].
// AI summary is written back to the record by [AiService] after a
// Hugging Face summarisation call completes.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

import '../models/note_model.dart';

// ─── NoteRepository ───────────────────────────────────────────────────────────

class NoteRepository {
  const NoteRepository(this._isar);

  final Isar _isar;
  static const _uuid = Uuid();

  // ── CREATE ────────────────────────────────────────────────────────────────

  /// Creates and persists a new note, returning the saved record.
  ///
  /// [content] should be a serialised Quill Delta JSON string.
  /// [plainTextPreview] is the stripped plain-text version for search & cards.
  Future<NoteModel> createNote({
    required String title,
    required String content,
    required String plainTextPreview,
    String subjectId = '',
    List<String> tags = const [],
    String colorHex = '#FFFFFF',
    bool isPinned = false,
  }) async {
    final now = DateTime.now().toUtc();
    final note = NoteModel(
      uuid: _uuid.v4(),
      title: title,
      content: content,
      plainTextPreview: plainTextPreview,
      subjectId: subjectId,
      tags: tags,
      colorHex: colorHex,
      isPinned: isPinned,
      createdAt: now,
      updatedAt: now,
    );

    await _isar.writeTxn(() async {
      note.id = await _isar.noteModels.put(note);
    });
    return note;
  }

  // ── READ ──────────────────────────────────────────────────────────────────

  /// Reactive stream — pinned notes first, then by last-updated descending.
  Stream<List<NoteModel>> watchAllNotes() {
    return _isar.noteModels
        .filter()
        .isArchivedEqualTo(false)
        .sortByIsPinnedDesc()
        .thenByUpdatedAtDesc()
        .watch(fireImmediately: true);
  }

  /// Reactive stream filtered to a subject.
  Stream<List<NoteModel>> watchNotesBySubject(String subjectId) {
    return _isar.noteModels
        .filter()
        .subjectIdEqualTo(subjectId)
        .isArchivedEqualTo(false)
        .sortByIsPinnedDesc()
        .thenByUpdatedAtDesc()
        .watch(fireImmediately: true);
  }

  /// Reactive stream of notes matching a tag.
  Stream<List<NoteModel>> watchNotesByTag(String tag) {
    return _isar.noteModels
        .filter()
        .tagsElementEqualTo(tag)
        .isArchivedEqualTo(false)
        .watch(fireImmediately: true);
  }

  /// Returns the note with the given [uuid], or `null`.
  Future<NoteModel?> getNoteByUuid(String uuid) =>
      _isar.noteModels.filter().uuidEqualTo(uuid).findFirst();

  /// Full-text search on [plainTextPreview] and [title].
  Future<List<NoteModel>> searchNotes(String query) {
    if (query.trim().isEmpty) return Future.value([]);
    return _isar.noteModels
        .filter()
        .plainTextPreviewContains(query, caseSensitive: false)
        .or()
        .titleContains(query, caseSensitive: false)
        .isArchivedEqualTo(false)
        .findAll();
  }

  // ── UPDATE ────────────────────────────────────────────────────────────────

  /// Overwrites the stored note record.
  Future<void> updateNote(NoteModel updated) async {
    updated.updatedAt = DateTime.now().toUtc();
    await _isar.writeTxn(() => _isar.noteModels.put(updated));
  }

  /// Writes back the AI summary string returned by Hugging Face.
  ///
  /// Called from [AiService] after the summarisation call resolves.
  Future<void> saveAiSummary(String uuid, String summary) async {
    final note = await getNoteByUuid(uuid);
    if (note == null) return;
    note.aiSummary = summary;
    note.updatedAt = DateTime.now().toUtc();
    await _isar.writeTxn(() => _isar.noteModels.put(note));
  }

  /// Toggles the pinned state of a note.
  Future<void> togglePin(String uuid) async {
    final note = await getNoteByUuid(uuid);
    if (note == null) return;
    note.isPinned = !note.isPinned;
    note.updatedAt = DateTime.now().toUtc();
    await _isar.writeTxn(() => _isar.noteModels.put(note));
  }

  /// Soft-deletes a note by setting [isArchived] = true.
  Future<void> archiveNote(String uuid) async {
    final note = await getNoteByUuid(uuid);
    if (note == null) return;
    note.isArchived = true;
    note.updatedAt = DateTime.now().toUtc();
    await _isar.writeTxn(() => _isar.noteModels.put(note));
  }

  // ── DELETE ────────────────────────────────────────────────────────────────

  /// Permanently removes the note from the database.
  Future<bool> deleteNote(String uuid) async {
    final note = await getNoteByUuid(uuid);
    if (note == null) return false;
    return _isar.writeTxn(() => _isar.noteModels.delete(note.id));
  }
}
