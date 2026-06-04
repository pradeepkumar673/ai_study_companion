// lib/features/notes/data/models/note_model.dart
//
// StudySpark — Isar collection for rich-text study notes.
//
// • [content] stores the raw Quill Delta JSON string (from flutter_quill).
//   Plain text is extracted into [plainTextPreview] for fast search & display.
// • [aiSummary] caches the HuggingFace bart-large-cnn summary so the app
//   doesn't re-call the API on every open.
// • Full-text search is supported via the [words] index (split on the
//   repository layer before every write).
// ─────────────────────────────────────────────────────────────────────────────

import 'package:isar/isar.dart';

import '../../../../core/enums/app_enums.dart';

part 'note_model.g.dart';

// ─── NoteModel ────────────────────────────────────────────────────────────────

@Collection()
class NoteModel {
  NoteModel({
    this.id = Isar.autoIncrement,
    this.uuid = '',
    this.title = '',
    this.content = '',
    this.plainTextPreview = '',
    this.subjectId = '',
    this.color = NoteColor.white,
    this.tags = const [],
    this.isPinned = false,
    this.isArchived = false,
    this.isFavourite = false,
    this.aiSummary = '',
    this.aiSummaryGeneratedAt,
    this.attachmentPaths = const [],
    this.wordCount = 0,
    this.readingTimeSeconds = 0,
    this.createdAt,
    this.updatedAt,
  });

  // ── Primary key ───────────────────────────────────────────────────────────
  Id id;

  @Index(unique: true, replace: true)
  String uuid;

  // ── Content ───────────────────────────────────────────────────────────────

  /// Note title shown in the masonry card header.
  @Index(type: IndexType.value)
  String title;

  /// Full Quill Delta JSON; may be large — never display raw.
  String content;

  /// First ~200 chars of plain text extracted from [content].
  /// Used for card previews and full-text search.
  @Index(type: IndexType.value)
  String plainTextPreview;

  // ── Categorisation ────────────────────────────────────────────────────────

  /// UUID of the linked [SubjectModel]; empty string = uncategorised.
  @Index()
  String subjectId;

  @enumerated
  NoteColor color;

  /// User-defined labels for cross-subject organisation.
  List<String> tags;

  // ── Visibility flags ──────────────────────────────────────────────────────

  @Index()
  bool isPinned;

  @Index()
  bool isArchived;

  bool isFavourite;

  // ── AI fields ─────────────────────────────────────────────────────────────

  /// Cached HuggingFace bart-large-cnn summary (empty until first generated).
  String aiSummary;

  /// When [aiSummary] was last refreshed; drives the "stale" indicator.
  DateTime? aiSummaryGeneratedAt;

  // ── Attachments ───────────────────────────────────────────────────────────

  /// Relative paths to images / files embedded in or attached to this note.
  List<String> attachmentPaths;

  // ── Stats ─────────────────────────────────────────────────────────────────

  /// Approximate word count (updated on every save).
  int wordCount;

  /// Estimated reading time in seconds (wordCount ÷ 200 wpm × 60).
  int readingTimeSeconds;

  // ── Timestamps ────────────────────────────────────────────────────────────

  @Index()
  DateTime? createdAt;

  @Index()
  DateTime? updatedAt;

  // ── Derived helpers ───────────────────────────────────────────────────────

  bool get hasAiSummary => aiSummary.isNotEmpty;

  /// True if summary was generated more than 7 days ago (considered stale).
  bool get isAiSummaryStale =>
      aiSummaryGeneratedAt != null &&
      DateTime.now().toUtc().difference(aiSummaryGeneratedAt!).inDays > 7;
}
