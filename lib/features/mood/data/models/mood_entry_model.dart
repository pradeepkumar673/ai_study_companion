// lib/features/mood/data/models/mood_entry_model.dart
//
// StudySpark — Isar collection for daily mood / energy check-in entries.
//
// Mood data is surfaced on the dashboard and correlated with study
// performance in the analytics view (e.g. "you focus best on 'Good' days").
// ─────────────────────────────────────────────────────────────────────────────

import 'package:isar/isar.dart';

import '../../../../core/enums/app_enums.dart';

part 'mood_entry_model.g.dart';

// ─── MoodEntryModel ───────────────────────────────────────────────────────────

@Collection()
class MoodEntryModel {
  MoodEntryModel({
    this.id = Isar.autoIncrement,
    this.uuid = '',
    this.mood = MoodType.neutral,
    this.energyLevel = 3,
    this.stressLevel = 3,
    this.sleepHours = 0.0,
    this.note = '',
    this.factors = const [],
    this.localDateKey = '',
    this.loggedAt,
  });

  // ── Primary key ───────────────────────────────────────────────────────────
  Id id;

  @Index(unique: true, replace: true)
  String uuid;

  // ── Mood data ─────────────────────────────────────────────────────────────

  @enumerated
  MoodType mood;

  /// Self-rated energy (1–5).
  int energyLevel;

  /// Self-rated stress (1–5; higher = more stressed).
  int stressLevel;

  /// Hours of sleep last night (0.0 = not logged).
  double sleepHours;

  /// Optional free-text reflection.
  String note;

  /// User-selected contextual factors, e.g. ["exercise", "caffeine", "exam"].
  List<String> factors;

  // ── Timestamps ────────────────────────────────────────────────────────────

  /// "yyyy-MM-dd" UTC date key; ensures at most one entry per day enforced
  /// by the repository (not a unique index to allow multiple daily logs if
  /// the feature evolves).
  @Index()
  String localDateKey;

  /// Exact time the check-in was recorded.
  @Index()
  DateTime? loggedAt;

  // ── Derived helpers ───────────────────────────────────────────────────────

  int get moodScore => mood.score;

  bool get hasSleepData => sleepHours > 0;
}
