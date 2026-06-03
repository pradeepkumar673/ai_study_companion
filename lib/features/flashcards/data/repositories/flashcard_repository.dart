// lib/features/flashcards/data/repositories/flashcard_repository.dart
//
// StudySpark — Flashcard & Quiz Repository
//
// Two repository classes bundled together since the quiz feature tightly
// depends on flashcard decks:
//
//   • [FlashcardRepository]  — CRUD for cards and decks; SM-2 review.
//   • [QuizRepository]       — CRUD for quizzes and attempts.
//
// SM-2 logic lives in [FlashcardModel.updateSm2].  The repository's job is
// purely to persist the result and update the deck's cached counters.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/enums/app_enums.dart';
import '../models/flashcard_model.dart';
import '../models/quiz_model.dart';

const _uuid = Uuid();

// ─── FlashcardRepository ──────────────────────────────────────────────────────

class FlashcardRepository {
  const FlashcardRepository(this._isar);

  final Isar _isar;

  // ── Deck CRUD ─────────────────────────────────────────────────────────────

  Future<FlashcardDeckModel> createDeck({
    required String title,
    String description = '',
    String subjectId = '',
    String colorHex = '#6750A4',
    String coverEmoji = '📚',
    List<String> tags = const [],
  }) async {
    final now = DateTime.now().toUtc();
    final deck = FlashcardDeckModel(
      uuid: _uuid.v4(),
      title: title,
      description: description,
      subjectId: subjectId,
      colorHex: colorHex,
      coverEmoji: coverEmoji,
      tags: tags,
      createdAt: now,
      updatedAt: now,
    );
    await _isar.writeTxn(() async {
      deck.id = await _isar.flashcardDeckModels.put(deck);
    });
    return deck;
  }

  /// Reactive stream of all non-archived decks.
  Stream<List<FlashcardDeckModel>> watchAllDecks() {
    return _isar.flashcardDeckModels
        .filter()
        .isArchivedEqualTo(false)
        .sortByTitle()
        .watch(fireImmediately: true);
  }

  /// Decks filtered by subject.
  Stream<List<FlashcardDeckModel>> watchDecksBySubject(String subjectId) {
    return _isar.flashcardDeckModels
        .filter()
        .subjectIdEqualTo(subjectId)
        .isArchivedEqualTo(false)
        .watch(fireImmediately: true);
  }

  Future<FlashcardDeckModel?> getDeckByUuid(String uuid) =>
      _isar.flashcardDeckModels.filter().uuidEqualTo(uuid).findFirst();

  Future<void> updateDeck(FlashcardDeckModel deck) async {
    deck.updatedAt = DateTime.now().toUtc();
    await _isar.writeTxn(() => _isar.flashcardDeckModels.put(deck));
  }

  Future<void> archiveDeck(String uuid) async {
    final deck = await getDeckByUuid(uuid);
    if (deck == null) return;
    deck.isArchived = true;
    deck.updatedAt = DateTime.now().toUtc();
    await _isar.writeTxn(() => _isar.flashcardDeckModels.put(deck));
  }

  Future<bool> deleteDeck(String uuid) async {
    final deck = await getDeckByUuid(uuid);
    if (deck == null) return false;

    // Cascade-delete all cards in this deck.
    final cards = await getCardsForDeck(uuid);
    await _isar.writeTxn(() async {
      for (final c in cards) {
        await _isar.flashcardModels.delete(c.id);
      }
      await _isar.flashcardDeckModels.delete(deck.id);
    });
    return true;
  }

  // ── Card CRUD ─────────────────────────────────────────────────────────────

  Future<FlashcardModel> createCard({
    required String deckId,
    required String front,
    required String back,
    String subjectId = '',
    String hint = '',
    List<String> tags = const [],
    String frontImagePath = '',
    String backImagePath = '',
  }) async {
    final now = DateTime.now().toUtc();
    final card = FlashcardModel(
      uuid: _uuid.v4(),
      deckId: deckId,
      subjectId: subjectId,
      front: front,
      back: back,
      hint: hint,
      tags: tags,
      frontImagePath: frontImagePath,
      backImagePath: backImagePath,
      // Schedule first review for today.
      nextReviewAt: now,
      createdAt: now,
      updatedAt: now,
    );
    await _isar.writeTxn(() async {
      card.id = await _isar.flashcardModels.put(card);
    });
    // Update cached count on the deck.
    await _syncDeckCardCount(deckId);
    return card;
  }

  Future<List<FlashcardModel>> getCardsForDeck(String deckId) =>
      _isar.flashcardModels
          .filter()
          .deckIdEqualTo(deckId)
          .isSuspendedEqualTo(false)
          .findAll();

  /// Returns cards that are due for review today (nextReviewAt ≤ now).
  Future<List<FlashcardModel>> getDueCards(String deckId) {
    final now = DateTime.now().toUtc();
    return _isar.flashcardModels
        .filter()
        .deckIdEqualTo(deckId)
        .isSuspendedEqualTo(false)
        .nextReviewAtLessThan(now)
        .sortByNextReviewAt()
        .findAll();
  }

  /// Reactive stream of due card count across all decks (dashboard badge).
  Stream<int> watchTotalDueCardCount() {
    final now = DateTime.now().toUtc();
    return _isar.flashcardModels
        .filter()
        .isSuspendedEqualTo(false)
        .nextReviewAtLessThan(now)
        .watch(fireImmediately: true)
        .map((cards) => cards.length);
  }

  Future<void> updateCard(FlashcardModel card) async {
    card.updatedAt = DateTime.now().toUtc();
    await _isar.writeTxn(() => _isar.flashcardModels.put(card));
  }

  Future<bool> deleteCard(String uuid) async {
    final card =
        await _isar.flashcardModels.filter().uuidEqualTo(uuid).findFirst();
    if (card == null) return false;
    final deckId = card.deckId;
    await _isar.writeTxn(() => _isar.flashcardModels.delete(card.id));
    await _syncDeckCardCount(deckId);
    return true;
  }

  // ── SM-2 Review ───────────────────────────────────────────────────────────

  /// Applies the SM-2 update for [difficulty], persists the card, and
  /// refreshes the deck's mastered-card count.
  Future<void> recordReview(String cardUuid, FlashcardDifficulty difficulty) async {
    final card =
        await _isar.flashcardModels.filter().uuidEqualTo(cardUuid).findFirst();
    if (card == null) return;

    // SM-2 logic lives in the model.
    card.updateSm2(difficulty);

    await _isar.writeTxn(() => _isar.flashcardModels.put(card));
    await _syncDeckCardCount(card.deckId);
  }

  /// Updates the deck's [lastStudiedAt] timestamp (call after a review session).
  Future<void> markDeckStudied(String deckId) async {
    final deck = await getDeckByUuid(deckId);
    if (deck == null) return;
    deck.lastStudiedAt = DateTime.now().toUtc();
    deck.updatedAt = DateTime.now().toUtc();
    await _isar.writeTxn(() => _isar.flashcardDeckModels.put(deck));
  }

  // ── Private helpers ───────────────────────────────────────────────────────

  /// Recomputes and writes [totalCards] + [masteredCards] on the deck.
  ///
  /// A card is "mastered" when accuracy > 0.8 and interval > 21 days.
  Future<void> _syncDeckCardCount(String deckId) async {
    final deck = await getDeckByUuid(deckId);
    if (deck == null) return;

    final allCards = await _isar.flashcardModels
        .filter()
        .deckIdEqualTo(deckId)
        .findAll();

    final mastered = allCards
        .where((c) => c.accuracy > 0.8 && c.interval > 21)
        .length;

    deck.totalCards = allCards.length;
    deck.masteredCards = mastered;
    deck.updatedAt = DateTime.now().toUtc();
    await _isar.writeTxn(() => _isar.flashcardDeckModels.put(deck));
  }
}

// ─── QuizRepository ───────────────────────────────────────────────────────────

class QuizRepository {
  const QuizRepository(this._isar);

  final Isar _isar;

  // ── Quiz CRUD ─────────────────────────────────────────────────────────────

  Future<QuizModel> createQuiz({
    required String title,
    String subjectId = '',
    String deckId = '',
    bool isAiGenerated = false,
    List<QuizQuestionModel> questions = const [],
  }) async {
    final now = DateTime.now().toUtc();
    final quiz = QuizModel(
      uuid: _uuid.v4(),
      title: title,
      subjectId: subjectId,
      deckId: deckId,
      isAiGenerated: isAiGenerated,
      questions: questions,
      totalQuestions: questions.length,
      createdAt: now,
      updatedAt: now,
    );
    await _isar.writeTxn(() async {
      quiz.id = await _isar.quizModels.put(quiz);
    });
    return quiz;
  }

  Stream<List<QuizModel>> watchAllQuizzes() {
    return _isar.quizModels
        .filter()
        .sortByCreatedAtDesc()
        .watch(fireImmediately: true);
  }

  Future<QuizModel?> getQuizByUuid(String uuid) =>
      _isar.quizModels.filter().uuidEqualTo(uuid).findFirst();

  Future<void> updateQuiz(QuizModel quiz) async {
    quiz.updatedAt = DateTime.now().toUtc();
    await _isar.writeTxn(() => _isar.quizModels.put(quiz));
  }

  Future<bool> deleteQuiz(String uuid) async {
    final quiz = await getQuizByUuid(uuid);
    if (quiz == null) return false;
    return _isar.writeTxn(() => _isar.quizModels.delete(quiz.id));
  }

  // ── Quiz Attempts ─────────────────────────────────────────────────────────

  /// Saves a completed quiz attempt.
  Future<QuizAttemptModel> saveAttempt({
    required String quizId,
    required int score,
    required int totalQuestions,
    required int durationSeconds,
    Map<String, String>? answers,
  }) async {
    final now = DateTime.now().toUtc();
    final attempt = QuizAttemptModel(
      uuid: _uuid.v4(),
      quizId: quizId,
      score: score,
      totalQuestions: totalQuestions,
      durationSeconds: durationSeconds,
      completedAt: now,
      createdAt: now,
    );
    await _isar.writeTxn(() async {
      attempt.id = await _isar.quizAttemptModels.put(attempt);
    });
    return attempt;
  }

  /// All attempts for a quiz, newest first.
  Future<List<QuizAttemptModel>> getAttemptsForQuiz(String quizId) =>
      _isar.quizAttemptModels
          .filter()
          .quizIdEqualTo(quizId)
          .sortByCompletedAtDesc()
          .findAll();

  /// Best score for a quiz (returns 0 if never attempted).
  Future<int> getBestScore(String quizId) async {
    final attempts = await getAttemptsForQuiz(quizId);
    if (attempts.isEmpty) return 0;
    return attempts.map((a) => a.score).reduce((a, b) => a > b ? a : b);
  }
}
