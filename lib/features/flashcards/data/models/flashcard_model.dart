// lib/features/flashcards/data/models/flashcard_model.dart
//
// StudySpark — Isar collection for spaced-repetition flashcards.
//
// Uses a simplified SM-2 algorithm:
//   • [easeFactor]   — starts at 2.5, updated after each review
//   • [interval]     — days until next review (starts at 1)
//   • [repetitions]  — consecutive correct answers
//   • [nextReviewAt] — derived from [interval] after each review
//
// The repository calls [updateSm2] with the user's [FlashcardDifficulty]
// rating after every review session.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:isar/isar.dart';

import '../../../../core/enums/app_enums.dart';

part 'flashcard_model.g.dart';

// ─── FlashcardModel ───────────────────────────────────────────────────────────

@Collection()
class FlashcardModel {
  FlashcardModel({
    this.id = Isar.autoIncrement,
    this.uuid = '',
    this.deckId = '',
    this.subjectId = '',
    this.front = '',
    this.back = '',
    this.hint = '',
    this.frontImagePath = '',
    this.backImagePath = '',
    this.tags = const [],
    this.easeFactor = 2.5,
    this.interval = 1,
    this.repetitions = 0,
    this.totalReviews = 0,
    this.correctReviews = 0,
    this.isSuspended = false,
    this.nextReviewAt,
    this.lastReviewedAt,
    this.createdAt,
    this.updatedAt,
  });

  // ── Primary key ───────────────────────────────────────────────────────────
  Id id;

  @Index(unique: true, replace: true)
  String uuid;

  // ── Deck / subject ────────────────────────────────────────────────────────

  /// UUID of the parent [FlashcardDeckModel].
  @Index()
  String deckId;

  /// UUID of the linked [SubjectModel]; can differ from deck's subject.
  @Index()
  String subjectId;

  // ── Card content ──────────────────────────────────────────────────────────

  /// Question / front side text.
  @Index(type: IndexType.words)
  String front;

  /// Answer / back side text.
  @Index(type: IndexType.words)
  String back;

  /// Optional hint shown before flipping.
  String hint;

  /// Relative path to an image on the front (empty = text only).
  String frontImagePath;

  /// Relative path to an image on the back (empty = text only).
  String backImagePath;

  List<String> tags;

  // ── SM-2 scheduling fields ────────────────────────────────────────────────

  /// SM-2 ease factor (min 1.3).  Represents retention difficulty.
  double easeFactor;

  /// Days until next review.
  int interval;

  /// Number of consecutive correct responses.
  int repetitions;

  // ── Stats ─────────────────────────────────────────────────────────────────

  int totalReviews;
  int correctReviews;

  double get accuracy =>
      totalReviews == 0 ? 0.0 : correctReviews / totalReviews;

  // ── Control ───────────────────────────────────────────────────────────────

  /// Suspended cards are skipped during review sessions.
  bool isSuspended;

  // ── Timestamps ────────────────────────────────────────────────────────────

  /// When this card is next due (UTC).
  @Index()
  DateTime? nextReviewAt;

  DateTime? lastReviewedAt;

  @Index()
  DateTime? createdAt;

  DateTime? updatedAt;

  // ── SM-2 update logic ─────────────────────────────────────────────────────

  /// Applies a simplified SM-2 algorithm based on [difficulty] and returns
  /// an updated copy of the card. Mutates the current instance in place.
  void updateSm2(FlashcardDifficulty difficulty) {
    final q = difficulty.sm2Quality;
    totalReviews++;

    if (q >= 3) {
      // Correct response
      correctReviews++;
      if (repetitions == 0) {
        interval = 1;
      } else if (repetitions == 1) {
        interval = 6;
      } else {
        interval = (interval * easeFactor).round();
      }
      repetitions++;
    } else {
      // Incorrect response — reset
      repetitions = 0;
      interval = 1;
    }

    // Update ease factor (clamp to minimum 1.3)
    easeFactor = (easeFactor + 0.1 - (5 - q) * (0.08 + (5 - q) * 0.02))
        .clamp(1.3, double.infinity);

    lastReviewedAt = DateTime.now().toUtc();
    nextReviewAt =
        DateTime.now().toUtc().add(Duration(days: interval));
    updatedAt = DateTime.now().toUtc();
  }

  bool get isDueToday =>
      nextReviewAt != null &&
      !nextReviewAt!.isAfter(DateTime.now().toUtc());
}

// ─── FlashcardDeckModel ──────────────────────────────────────────────────────

/// A named collection of [FlashcardModel] documents.
@Collection()
class FlashcardDeckModel {
  FlashcardDeckModel({
    this.id = Isar.autoIncrement,
    this.uuid = '',
    this.title = '',
    this.description = '',
    this.subjectId = '',
    this.colorHex = '#6750A4',
    this.coverEmoji = '📚',
    this.tags = const [],
    this.totalCards = 0,
    this.masteredCards = 0,
    this.isArchived = false,
    this.lastStudiedAt,
    this.createdAt,
    this.updatedAt,
  });

  Id id;

  @Index(unique: true, replace: true)
  String uuid;

  @Index(type: IndexType.value)
  String title;

  String description;

  @Index()
  String subjectId;

  String colorHex;

  /// Emoji displayed as the deck cover art.
  String coverEmoji;

  List<String> tags;

  // ── Cached counts (updated by repository after each review) ──────────────
  int totalCards;

  /// Cards with accuracy > 80% and interval > 21 days are considered mastered.
  int masteredCards;

  double get masteryPercent =>
      totalCards == 0 ? 0.0 : masteredCards / totalCards;

  @Index()
  bool isArchived;

  DateTime? lastStudiedAt;

  @Index()
  DateTime? createdAt;

  DateTime? updatedAt;
}
