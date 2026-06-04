// lib/features/mood/data/repositories/mood_repository.dart
//
// StudySpark — Mood Repository
// ─────────────────────────────────────────────────────────────────────────────

import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/enums/app_enums.dart';
import '../models/mood_entry_model.dart';

final _moodDateFmt = DateFormat('yyyy-MM-dd');
const _moodUuid = Uuid();

class MoodRepository {
  const MoodRepository(this._isar);

  final Isar _isar;

  // ── CREATE ────────────────────────────────────────────────────────────────

  /// Logs a new mood entry. Only one entry per day is recommended; the UI
  /// should call [getEntryForDay] first and update if one already exists.
  Future<MoodEntryModel> logMood({
    required MoodType mood,
    int energyLevel = 3,
    int stressLevel = 3,
    double sleepHours = 7.0,
    String note = '',
    List<String> factors = const [],
  }) async {
    final now = DateTime.now().toUtc();
    final entry = MoodEntryModel(
      uuid: _moodUuid.v4(),
      mood: mood,
      energyLevel: energyLevel,
      stressLevel: stressLevel,
      sleepHours: sleepHours,
      note: note,
      factors: factors,
      localDateKey: _moodDateFmt.format(now.toLocal()),
      loggedAt: now,
    );
    await _isar.writeTxn(() async {
      entry.id = await _isar.moodEntryModels.put(entry);
    });
    return entry;
  }

  // ── READ ──────────────────────────────────────────────────────────────────

  /// The mood entry for a given date key, or null if not logged.
  Future<MoodEntryModel?> getEntryForDay(String dateKey) =>
      _isar.moodEntryModels
          .filter()
          .localDateKeyEqualTo(dateKey)
          .findFirst();

  /// Reactive stream of the last [days] entries (for the mood trend chart).
  Stream<List<MoodEntryModel>> watchRecentEntries({int days = 14}) {
    final cutoff = DateTime.now().toUtc().subtract(Duration(days: days));
    return _isar.moodEntryModels
        .filter()
        .loggedAtGreaterThan(cutoff)
        .sortByLoggedAt()
        .watch(fireImmediately: true);
  }

  Future<void> updateEntry(MoodEntryModel entry) async {
    await _isar.writeTxn(() => _isar.moodEntryModels.put(entry));
  }

  Future<bool> deleteEntry(String uuid) async {
    final entry = await _isar.moodEntryModels
        .filter()
        .uuidEqualTo(uuid)
        .findFirst();
    if (entry == null) return false;
    return _isar.writeTxn(() => _isar.moodEntryModels.delete(entry.id));
  }
}

