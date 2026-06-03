// lib/features/tasks/data/models/subtask_model.dart
//
// StudySpark — Embedded subtask object stored inside [TaskModel].
// Isar embedded objects do NOT get their own collection —
// they are serialised inline within the parent document.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:isar/isar.dart';

part 'subtask_model.g.dart';

// ─── Subtask ─────────────────────────────────────────────────────────────────

/// A single checklist item nested inside a [TaskModel].
///
/// Fields are kept intentionally minimal: each subtask has a unique [id]
/// (UUID string), a [title], and a [isCompleted] flag.
/// The [position] field drives re-ordering in the UI without a sort query.
@embedded
class SubtaskModel {
  SubtaskModel({
    this.id = '',
    this.title = '',
    this.isCompleted = false,
    this.position = 0,
    this.createdAt,
    this.completedAt,
  });

  /// RFC 4122 UUID — generated with the `uuid` package on creation.
  String id;

  /// Human-readable subtask title (max ~120 chars recommended).
  String title;

  /// Whether the subtask has been ticked off.
  bool isCompleted;

  /// Zero-based display order (for drag-to-reorder).
  int position;

  /// When this subtask was added.
  DateTime? createdAt;

  /// When [isCompleted] was last set to `true`; null if still open.
  DateTime? completedAt;
}
