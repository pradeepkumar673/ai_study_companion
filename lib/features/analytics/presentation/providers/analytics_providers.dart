// lib/features/analytics/presentation/providers/analytics_providers.dart
//
// StudySpark — Analytics Providers
//
// All Riverpod providers that power the analytics screens. Separated from the
// UI so each widget tree can watch exactly what it needs.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/providers/isar_provider.dart';
import '../../data/models/gpa_entry_model.dart';
import '../../data/repositories/analytics_repository.dart';

// ─── Repository provider ──────────────────────────────────────────────────────

final analyticsRepositoryProvider = Provider<AnalyticsRepository>((ref) {
  final isar = ref.watch(isarProvider);
  return AnalyticsRepository(isar);
});

// ─── Subject Performance ──────────────────────────────────────────────────────

final subjectPerformancesProvider =
    FutureProvider<List<SubjectPerformance>>((ref) {
  return ref.watch(analyticsRepositoryProvider).getSubjectPerformances();
});

// ─── GPA ─────────────────────────────────────────────────────────────────────

final semesterBreakdownProvider =
    FutureProvider<List<SemesterGPA>>((ref) {
  return ref.watch(analyticsRepositoryProvider).getSemesterBreakdown();
});

final cgpaProvider = FutureProvider<double>((ref) {
  return ref.watch(analyticsRepositoryProvider).calculateCGPA();
});

final allGpaEntriesProvider =
    FutureProvider<List<GpaEntryModel>>((ref) {
  return ref.watch(analyticsRepositoryProvider).getAllGpaEntries();
});

final semestersProvider = FutureProvider<List<String>>((ref) {
  return ref.watch(analyticsRepositoryProvider).getSemesters();
});

// ─── Selected tab state ───────────────────────────────────────────────────────

final analyticsTabProvider = StateProvider<int>((ref) => 0);

// ─── GPA Calculator state ─────────────────────────────────────────────────────

/// Notifier for the GPA calculator form entries (ephemeral — not persisted).
class GpaCalculatorNotifier extends StateNotifier<List<_CalcEntry>> {
  GpaCalculatorNotifier()
      : super([_CalcEntry(), _CalcEntry(), _CalcEntry()]);

  void add() => state = [...state, _CalcEntry()];

  void remove(int index) {
    if (state.length <= 1) return;
    final copy = [...state];
    copy.removeAt(index);
    state = copy;
  }

  void updateSubject(int index, String value) {
    final copy = [...state];
    copy[index] = copy[index].copyWith(subject: value);
    state = copy;
  }

  void updateCredits(int index, int value) {
    final copy = [...state];
    copy[index] = copy[index].copyWith(credits: value);
    state = copy;
  }

  void updateGradePoint(int index, double value) {
    final copy = [...state];
    copy[index] = copy[index].copyWith(gradePoint: value);
    state = copy;
  }

  double get calculatedGPA {
    final valid = state.where((e) => e.credits > 0).toList();
    if (valid.isEmpty) return 0;
    final totalWeighted =
        valid.fold<double>(0, (s, e) => s + e.gradePoint * e.credits);
    final totalCredits = valid.fold<int>(0, (s, e) => s + e.credits);
    if (totalCredits == 0) return 0;
    return totalWeighted / totalCredits;
  }

  void reset() => state = [_CalcEntry(), _CalcEntry(), _CalcEntry()];
}

class _CalcEntry {
  _CalcEntry({
    this.subject = '',
    this.credits = 3,
    this.gradePoint = 0.0,
  });

  final String subject;
  final int credits;
  final double gradePoint;

  _CalcEntry copyWith({
    String? subject,
    int? credits,
    double? gradePoint,
  }) =>
      _CalcEntry(
        subject: subject ?? this.subject,
        credits: credits ?? this.credits,
        gradePoint: gradePoint ?? this.gradePoint,
      );
}

final gpaCalculatorProvider =
    StateNotifierProvider<GpaCalculatorNotifier, List<_CalcEntry>>(
        (ref) => GpaCalculatorNotifier());

// ─── Reports ─────────────────────────────────────────────────────────────────

/// The selected date for the daily report (defaults to today).
final dailyReportDateProvider = StateProvider<DateTime>(
    (ref) => DateTime.now());

final dailyReportProvider = FutureProvider<DailyReport>((ref) {
  final date = ref.watch(dailyReportDateProvider);
  return ref.watch(analyticsRepositoryProvider).getDailyReport(date);
});

/// The start of the selected week for the weekly report.
final weeklyReportStartProvider = StateProvider<DateTime>((ref) {
  final now = DateTime.now();
  // Monday of the current week
  final monday = now.subtract(Duration(days: now.weekday - 1));
  return DateTime(monday.year, monday.month, monday.day);
});

final weeklyReportProvider = FutureProvider<WeeklyReport>((ref) {
  final start = ref.watch(weeklyReportStartProvider);
  return ref.watch(analyticsRepositoryProvider).getWeeklyReport(start);
});

// ─── Mood & Stress ───────────────────────────────────────────────────────────

final moodCorrelationsProvider =
    FutureProvider<List<MoodCorrelation>>((ref) {
  return ref.watch(analyticsRepositoryProvider).getMoodCorrelations();
});

/// Last 30 mood entries for the chart.
final recentMoodEntriesProvider = FutureProvider<List<dynamic>>((ref) async {
  // Loaded by analytics repository which reads isar directly
  final isar = ref.watch(isarProvider);
  return isar.moodEntryModels
      .where()
      .sortByLoggedAtDesc()
      .limit(30)
      .findAll();
});
