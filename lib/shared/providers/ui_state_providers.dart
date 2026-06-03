// lib/shared/providers/ui_state_providers.dart
//
// StudySpark — UI / Ephemeral State Providers
//
// These providers manage short-lived UI state that does NOT need to be
// persisted to Isar (filter chips, editor drafts, search queries, etc.).
//
// They live in shared/providers because multiple screens may share the same
// ephemeral state (e.g. the task search query is shared between the list and
// the FAB bottom sheet).
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/enums/app_enums.dart';
import '../../features/flashcards/data/models/flashcard_model.dart';
import '../../features/tasks/data/models/task_model.dart';

// =============================================================================
// TASKS
// =============================================================================

// ── Task search ───────────────────────────────────────────────────────────────

/// Current search query on the tasks screen.
final taskSearchQueryProvider = StateProvider<String>((ref) => '');

// ── Add/Edit task draft ───────────────────────────────────────────────────────

/// Holds the in-progress task form data while the bottom sheet is open.
/// Cleared when the sheet is dismissed.
class TaskDraft {
  const TaskDraft({
    this.title = '',
    this.description = '',
    this.priority = Priority.medium,
    this.subjectId,
    this.deadline,
    this.repeatFrequency = RepeatFrequency.none,
    this.tags = const [],
  });

  final String title;
  final String description;
  final Priority priority;
  final String? subjectId;
  final DateTime? deadline;
  final RepeatFrequency repeatFrequency;
  final List<String> tags;

  TaskDraft copyWith({
    String? title,
    String? description,
    Priority? priority,
    String? subjectId,
    DateTime? deadline,
    RepeatFrequency? repeatFrequency,
    List<String>? tags,
  }) =>
      TaskDraft(
        title: title ?? this.title,
        description: description ?? this.description,
        priority: priority ?? this.priority,
        subjectId: subjectId ?? this.subjectId,
        deadline: deadline ?? this.deadline,
        repeatFrequency: repeatFrequency ?? this.repeatFrequency,
        tags: tags ?? this.tags,
      );

  bool get isValid => title.trim().isNotEmpty;
}

class _TaskDraftNotifier extends Notifier<TaskDraft> {
  @override
  TaskDraft build() => const TaskDraft();

  void setTitle(String v) => state = state.copyWith(title: v);
  void setDescription(String v) => state = state.copyWith(description: v);
  void setPriority(Priority v) => state = state.copyWith(priority: v);
  void setSubject(String? id) => state = state.copyWith(subjectId: id);
  void setDeadline(DateTime? d) => state = state.copyWith(deadline: d);
  void setRepeat(RepeatFrequency r) => state = state.copyWith(repeatFrequency: r);
  void addTag(String tag) => state = state.copyWith(tags: [...state.tags, tag]);
  void removeTag(String tag) =>
      state = state.copyWith(tags: state.tags.where((t) => t != tag).toList());

  /// Pre-populate the draft for an edit operation.
  void loadFromTask(TaskModel task) {
    state = TaskDraft(
      title: task.title,
      description: task.description,
      priority: task.priority,
      subjectId: task.subjectId.isEmpty ? null : task.subjectId,
      deadline: task.deadline,
      repeatFrequency: task.repeatFrequency,
      tags: List.from(task.tags),
    );
  }

  void reset() => state = const TaskDraft();
}

final taskDraftProvider =
    NotifierProvider<_TaskDraftNotifier, TaskDraft>(_TaskDraftNotifier.new);

// =============================================================================
// NOTES
// =============================================================================

// ── Note editor draft ─────────────────────────────────────────────────────────

/// Tracks whether the note editor has unsaved changes.
final noteEditorHasChangesProvider = StateProvider<bool>((ref) => false);

/// The UUID of the note currently open in the editor (null = new note).
final activeNoteIdProvider = StateProvider<String?>((ref) => null);

/// The note search query on the notes grid screen.
final noteSearchQueryProvider = StateProvider<String>((ref) => '');

// =============================================================================
// FOCUS / POMODORO
// =============================================================================

// ── Mode selector ─────────────────────────────────────────────────────────────

/// The mode selected in the Focus screen chip row.
final selectedPomodoroModeProvider =
    StateProvider<PomodoroMode>((ref) => PomodoroMode.pomodoro);

/// Whether to show the session history panel (toggled by a button).
final showFocusHistoryProvider = StateProvider<bool>((ref) => false);

// =============================================================================
// SCHEDULE
// =============================================================================

/// Whether the schedule is in "week" or "day" view mode.
enum ScheduleViewMode { week, day }

final scheduleViewModeProvider =
    StateProvider<ScheduleViewMode>((ref) => ScheduleViewMode.week);

// =============================================================================
// FLASHCARD REVIEW SESSION
// =============================================================================

/// Manages the state of an active flashcard review session for one deck.
class FlashcardReviewSession {
  const FlashcardReviewSession({
    this.cards = const [],
    this.currentIndex = 0,
    this.isFlipped = false,
    this.reviewedCount = 0,
    this.isComplete = false,
  });

  final List<FlashcardModel> cards;
  final int currentIndex;
  final bool isFlipped;
  final int reviewedCount;
  final bool isComplete;

  FlashcardModel? get currentCard =>
      cards.isEmpty || currentIndex >= cards.length
          ? null
          : cards[currentIndex];

  double get progress =>
      cards.isEmpty ? 0.0 : reviewedCount / cards.length;

  FlashcardReviewSession copyWith({
    List<FlashcardModel>? cards,
    int? currentIndex,
    bool? isFlipped,
    int? reviewedCount,
    bool? isComplete,
  }) =>
      FlashcardReviewSession(
        cards: cards ?? this.cards,
        currentIndex: currentIndex ?? this.currentIndex,
        isFlipped: isFlipped ?? this.isFlipped,
        reviewedCount: reviewedCount ?? this.reviewedCount,
        isComplete: isComplete ?? this.isComplete,
      );
}

class _FlashcardReviewNotifier extends Notifier<FlashcardReviewSession> {
  @override
  FlashcardReviewSession build() => const FlashcardReviewSession();

  /// Initialises a new review session with [cards] shuffled or in order.
  void startSession(List<FlashcardModel> cards, {bool shuffle = true}) {
    final ordered = shuffle ? (List.of(cards)..shuffle()) : List.of(cards);
    state = FlashcardReviewSession(cards: ordered);
  }

  /// Flips the current card to reveal the answer.
  void flip() => state = state.copyWith(isFlipped: !state.isFlipped);

  /// Records the user's [difficulty] rating and advances to the next card.
  void rateAndAdvance(FlashcardDifficulty difficulty) {
    // Actual SM-2 persistence is done by the repository via the provider:
    // ref.read(flashcardRepositoryProvider).recordReview(cardUuid, difficulty)
    // The caller (widget / controller) handles that async call.

    final next = state.currentIndex + 1;
    final done = next >= state.cards.length;

    state = state.copyWith(
      currentIndex: done ? state.currentIndex : next,
      isFlipped: false,
      reviewedCount: state.reviewedCount + 1,
      isComplete: done,
    );
  }

  void reset() => state = const FlashcardReviewSession();
}

final flashcardReviewProvider =
    NotifierProvider<_FlashcardReviewNotifier, FlashcardReviewSession>(
  _FlashcardReviewNotifier.new,
);

// =============================================================================
// GLOBAL APP STATE
// =============================================================================

/// Whether the app is currently performing a background operation
/// (e.g. AI summary generation).  Drives a top-level loading indicator.
final isBackgroundLoadingProvider = StateProvider<bool>((ref) => false);

/// Controls the currently active bottom-nav tab index.
/// Updated by [MainShell] and readable by any widget needing to switch tabs.
final activeNavIndexProvider = StateProvider<int>((ref) => 0);
