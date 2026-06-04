// lib/features/analytics/data/repositories/analytics_repository.dart
//
// StudySpark — Analytics Repository
//
// Aggregates data from all Isar collections to produce the rich analytics
// payloads consumed by the analytics providers.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:isar/isar.dart';
import 'package:intl/intl.dart';

import '../../../../core/enums/app_enums.dart';
import '../../../focus/data/models/pomodoro_session_model.dart';
import '../../../mood/data/models/mood_entry_model.dart';
import '../../../schedule/data/models/subject_model.dart';
import '../../../tasks/data/models/task_model.dart';
import '../models/gpa_entry_model.dart';

final _dateFmt = DateFormat('yyyy-MM-dd');

// ─── Data Transfer Objects ────────────────────────────────────────────────────

class SubjectPerformance {
  const SubjectPerformance({
    required this.subjectName,
    required this.subjectCode,
    required this.colorHex,
    required this.credits,
    required this.gpa,
    required this.percentage,
    required this.completedTasks,
    required this.totalTasks,
    required this.focusMinutes,
    required this.semesterLabel,
  });

  final String subjectName;
  final String subjectCode;
  final String colorHex;
  final int credits;
  final double gpa;
  final double percentage;
  final int completedTasks;
  final int totalTasks;
  final int focusMinutes;
  final String semesterLabel;

  double get taskCompletionRate =>
      totalTasks == 0 ? 0 : completedTasks / totalTasks;
}

class SemesterGPA {
  const SemesterGPA({
    required this.semesterLabel,
    required this.sgpa,
    required this.totalCredits,
    required this.subjects,
  });

  final String semesterLabel;
  final double sgpa;
  final int totalCredits;
  final List<GpaEntryModel> subjects;
}

class WeeklyReport {
  const WeeklyReport({
    required this.weekStart,
    required this.weekEnd,
    required this.dailyFocusMinutes,
    required this.totalFocusMinutes,
    required this.sessionsCompleted,
    required this.tasksCompleted,
    required this.averageMoodScore,
    required this.averageStressLevel,
    required this.averageEnergyLevel,
    required this.averageSleepHours,
    required this.productivityScore,
    required this.moodEntries,
  });

  final DateTime weekStart;
  final DateTime weekEnd;
  final Map<String, int> dailyFocusMinutes; // yyyy-MM-dd → minutes
  final int totalFocusMinutes;
  final int sessionsCompleted;
  final int tasksCompleted;
  final double averageMoodScore;
  final double averageStressLevel;
  final double averageEnergyLevel;
  final double averageSleepHours;

  /// 0–100 composite productivity score.
  final double productivityScore;

  final List<MoodEntryModel> moodEntries;
}

class DailyReport {
  const DailyReport({
    required this.date,
    required this.focusMinutes,
    required this.sessionsCompleted,
    required this.tasksCompleted,
    required this.moodEntry,
    required this.productivityScore,
  });

  final DateTime date;
  final int focusMinutes;
  final int sessionsCompleted;
  final int tasksCompleted;
  final MoodEntryModel? moodEntry;
  final double productivityScore;
}

class MoodCorrelation {
  const MoodCorrelation({
    required this.moodType,
    required this.avgFocusMinutes,
    required this.avgTasksCompleted,
    required this.sampleCount,
  });

  final MoodType moodType;
  final double avgFocusMinutes;
  final double avgTasksCompleted;
  final int sampleCount;
}

// ─── Repository ───────────────────────────────────────────────────────────────

class AnalyticsRepository {
  const AnalyticsRepository(this._isar);

  final Isar _isar;

  // ── GPA ──────────────────────────────────────────────────────────────────

  Future<List<GpaEntryModel>> getAllGpaEntries() =>
      _isar.gpaEntryModels.where().findAll();

  Future<List<GpaEntryModel>> getGpaEntriesBySemester(String semester) =>
      _isar.gpaEntryModels
          .filter()
          .semesterLabelEqualTo(semester)
          .findAll();

  Future<void> saveGpaEntry(GpaEntryModel entry) =>
      _isar.writeTxn(() => _isar.gpaEntryModels.put(entry));

  Future<void> deleteGpaEntry(int id) =>
      _isar.writeTxn(() => _isar.gpaEntryModels.delete(id));

  /// Calculate SGPA for a given semester.
  Future<double> calculateSGPA(String semesterLabel) async {
    final entries = await getGpaEntriesBySemester(semesterLabel);
    return _computeGPA(entries);
  }

  /// Calculate CGPA across all semesters.
  Future<double> calculateCGPA() async {
    final all = await getAllGpaEntries();
    return _computeGPA(all);
  }

  double _computeGPA(List<GpaEntryModel> entries) {
    if (entries.isEmpty) return 0;
    final totalWeighted =
        entries.fold<double>(0, (sum, e) => sum + e.weightedGradePoints);
    final totalCredits = entries.fold<int>(0, (sum, e) => sum + e.credits);
    if (totalCredits == 0) return 0;
    return totalWeighted / totalCredits;
  }

  /// All distinct semester labels, sorted.
  Future<List<String>> getSemesters() async {
    final all = await getAllGpaEntries();
    final labels = all.map((e) => e.semesterLabel).toSet().toList();
    labels.sort();
    return labels;
  }

  /// Full semester breakdown with SGPA.
  Future<List<SemesterGPA>> getSemesterBreakdown() async {
    final semesters = await getSemesters();
    final result = <SemesterGPA>[];
    for (final sem in semesters) {
      final entries = await getGpaEntriesBySemester(sem);
      final sgpa = _computeGPA(entries);
      final credits = entries.fold<int>(0, (s, e) => s + e.credits);
      result.add(SemesterGPA(
        semesterLabel: sem,
        sgpa: sgpa,
        totalCredits: credits,
        subjects: entries,
      ));
    }
    return result;
  }

  // ── Subject Performance ───────────────────────────────────────────────────

  Future<List<SubjectPerformance>> getSubjectPerformances() async {
    final subjects = await _isar.subjectModels
        .filter()
        .isArchivedEqualTo(false)
        .findAll();

    final allSessions = await _isar.pomodoroSessionModels
        .filter()
        .wasCompletedEqualTo(true)
        .modeEqualTo(PomodoroMode.pomodoro)
        .findAll();

    final allTasks = await _isar.taskModels.where().findAll();
    final allGpa = await getAllGpaEntries();

    return subjects.map((subject) {
      final subjectSessions = allSessions; // PomodoroSessionModel has no subjectUuid field
      final focusMins = subjectSessions.fold<int>(
          0, (sum, s) => sum + s.actualDurationSeconds ~/ 60);

      final subjectTasks =
          allTasks.where((t) => t.subjectId == subject.uuid).toList();
      final completedTasks =
          subjectTasks.where((t) => t.status == TaskStatus.done).length;

      final subjectGpa =
          allGpa.where((g) => g.subjectUuid == subject.uuid).toList();
      final gpa = _computeGPA(subjectGpa);
      final avgPct = subjectGpa.isEmpty
          ? 0.0
          : subjectGpa.fold<double>(0, (s, e) => s + e.percentage) /
              subjectGpa.length;

      return SubjectPerformance(
        subjectName: subject.name,
        subjectCode: subject.code,
        colorHex: subject.colorHex,
        credits: subject.credits,
        gpa: gpa,
        percentage: avgPct,
        completedTasks: completedTasks,
        totalTasks: subjectTasks.length,
        focusMinutes: focusMins,
        semesterLabel: subject.semesterLabel,
      );
    }).toList();
  }

  // ── Daily & Weekly Reports ────────────────────────────────────────────────

  Future<DailyReport> getDailyReport(DateTime date) async {
    final key = _dateFmt.format(date);

    final sessions = await _isar.pomodoroSessionModels
        .filter()
        .localDateKeyEqualTo(key)
        .wasCompletedEqualTo(true)
        .findAll();

    final focusSessions =
        sessions.where((s) => s.mode == PomodoroMode.pomodoro).toList();
    final focusMins = focusSessions.fold<int>(
        0, (sum, s) => sum + s.actualDurationSeconds ~/ 60);

    final tasks = await _isar.taskModels
        .filter()
        .statusEqualTo(TaskStatus.done)
        .findAll();
    final tasksToday =
        tasks.where((t) => _dateFmt.format(t.updatedAt ?? DateTime(0)) == key).length;

    final moodEntries = await _isar.moodEntryModels
        .filter()
        .localDateKeyEqualTo(key)
        .findAll();
    final mood = moodEntries.isNotEmpty ? moodEntries.last : null;

    final productivity = _computeProductivityScore(
      focusMinutes: focusMins,
      tasksCompleted: tasksToday,
      moodScore: mood?.moodScore.toDouble() ?? 3,
      stressLevel: mood?.stressLevel.toDouble() ?? 3,
    );

    return DailyReport(
      date: date,
      focusMinutes: focusMins,
      sessionsCompleted: focusSessions.length,
      tasksCompleted: tasksToday,
      moodEntry: mood,
      productivityScore: productivity,
    );
  }

  Future<WeeklyReport> getWeeklyReport(DateTime weekStart) async {
    final weekEnd = weekStart.add(const Duration(days: 6));
    final dailyMap = <String, int>{};
    var totalFocus = 0;
    var totalSessions = 0;
    var totalTasks = 0;

    for (int i = 0; i < 7; i++) {
      final day = weekStart.add(Duration(days: i));
      final key = _dateFmt.format(day);
      final sessions = await _isar.pomodoroSessionModels
          .filter()
          .localDateKeyEqualTo(key)
          .wasCompletedEqualTo(true)
          .modeEqualTo(PomodoroMode.pomodoro)
          .findAll();
      final mins = sessions.fold<int>(
          0, (sum, s) => sum + s.actualDurationSeconds ~/ 60);
      dailyMap[key] = mins;
      totalFocus += mins;
      totalSessions += sessions.length;
    }

    // Tasks completed this week
    final allDoneTasks = await _isar.taskModels
        .filter()
        .statusEqualTo(TaskStatus.done)
        .findAll();
    for (final t in allDoneTasks) {
      final updated = t.updatedAt;
      if (updated != null &&
          !updated.isBefore(weekStart) &&
          !updated.isAfter(weekEnd)) {
        totalTasks++;
      }
    }

    // Mood for the week
    final moodEntries = <MoodEntryModel>[];
    for (int i = 0; i < 7; i++) {
      final key = _dateFmt.format(weekStart.add(Duration(days: i)));
      final entries = await _isar.moodEntryModels
          .filter()
          .localDateKeyEqualTo(key)
          .findAll();
      moodEntries.addAll(entries);
    }

    double avgMood = 0, avgStress = 0, avgEnergy = 0, avgSleep = 0;
    if (moodEntries.isNotEmpty) {
      avgMood = moodEntries.fold<double>(0, (s, e) => s + e.moodScore) /
          moodEntries.length;
      avgStress = moodEntries.fold<double>(0, (s, e) => s + e.stressLevel) /
          moodEntries.length;
      avgEnergy = moodEntries.fold<double>(0, (s, e) => s + e.energyLevel) /
          moodEntries.length;
      final sleepEntries =
          moodEntries.where((e) => e.hasSleepData).toList();
      if (sleepEntries.isNotEmpty) {
        avgSleep = sleepEntries.fold<double>(0, (s, e) => s + e.sleepHours) /
            sleepEntries.length;
      }
    }

    final productivity = _computeProductivityScore(
      focusMinutes: totalFocus ~/ 7,
      tasksCompleted: totalTasks,
      moodScore: avgMood == 0 ? 3 : avgMood,
      stressLevel: avgStress == 0 ? 3 : avgStress,
    );

    return WeeklyReport(
      weekStart: weekStart,
      weekEnd: weekEnd,
      dailyFocusMinutes: dailyMap,
      totalFocusMinutes: totalFocus,
      sessionsCompleted: totalSessions,
      tasksCompleted: totalTasks,
      averageMoodScore: avgMood,
      averageStressLevel: avgStress,
      averageEnergyLevel: avgEnergy,
      averageSleepHours: avgSleep,
      productivityScore: productivity,
      moodEntries: moodEntries,
    );
  }

  // ── Mood Correlations ─────────────────────────────────────────────────────

  Future<List<MoodCorrelation>> getMoodCorrelations() async {
    final allMood = await _isar.moodEntryModels.where().findAll();
    if (allMood.isEmpty) return [];

    final correlations = <MoodType, _CorrelationAccumulator>{};

    for (final entry in allMood) {
      final key = entry.localDateKey;
      final sessions = await _isar.pomodoroSessionModels
          .filter()
          .localDateKeyEqualTo(key)
          .wasCompletedEqualTo(true)
          .modeEqualTo(PomodoroMode.pomodoro)
          .findAll();
      final focusMins = sessions.fold<int>(
          0, (sum, s) => sum + s.actualDurationSeconds ~/ 60);

      final tasks = await _isar.taskModels
          .filter()
          .statusEqualTo(TaskStatus.done)
          .findAll();
      final tasksToday =
          tasks.where((t) => _dateFmt.format(t.updatedAt ?? DateTime(0)) == key).length;

      correlations.putIfAbsent(entry.mood, () => _CorrelationAccumulator());
      correlations[entry.mood]!.add(focusMins.toDouble(), tasksToday.toDouble());
    }

    return correlations.entries.map((e) {
      final acc = e.value;
      return MoodCorrelation(
        moodType: e.key,
        avgFocusMinutes: acc.count == 0 ? 0 : acc.totalFocus / acc.count,
        avgTasksCompleted: acc.count == 0 ? 0 : acc.totalTasks / acc.count,
        sampleCount: acc.count,
      );
    }).toList()
      ..sort((a, b) => a.moodType.index.compareTo(b.moodType.index));
  }

  // ── Productivity Score ────────────────────────────────────────────────────

  /// Composite productivity score 0–100.
  /// Weights: focus (40%), tasks (30%), mood (20%), stress inverse (10%).
  double _computeProductivityScore({
    required int focusMinutes,
    required int tasksCompleted,
    required double moodScore,
    required double stressLevel,
  }) {
    const targetFocusMin = 120.0; // 2 hours goal
    const targetTasks = 5.0;

    final focusScore = (focusMinutes / targetFocusMin).clamp(0.0, 1.0) * 40;
    final taskScore = (tasksCompleted / targetTasks).clamp(0.0, 1.0) * 30;
    final moodScore_ = ((moodScore - 1) / 4).clamp(0.0, 1.0) * 20;
    final stressScore = (1 - (stressLevel - 1) / 4).clamp(0.0, 1.0) * 10;

    return focusScore + taskScore + moodScore_ + stressScore;
  }
}

// Private accumulator for correlations
class _CorrelationAccumulator {
  double totalFocus = 0;
  double totalTasks = 0;
  int count = 0;

  void add(double focus, double tasks) {
    totalFocus += focus;
    totalTasks += tasks;
    count++;
  }
}
