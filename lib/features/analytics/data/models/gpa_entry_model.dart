// lib/features/analytics/data/models/gpa_entry_model.dart
//
// StudySpark — Isar collection for GPA / CGPA calculation entries.
// Each entry represents one subject in one semester with a grade.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:isar/isar.dart';

part 'gpa_entry_model.g.dart';

// ─── Grade scale enum ─────────────────────────────────────────────────────────

/// Common letter grade → grade point mappings (10-point and 4-point scale).
enum GradeScale {
  /// 10-point scale (common in Indian universities)
  tenPoint,

  /// Classic 4-point scale (US universities)
  fourPoint;

  String get label {
    switch (this) {
      case GradeScale.tenPoint:
        return '10-Point Scale';
      case GradeScale.fourPoint:
        return '4-Point Scale';
    }
  }
}

// ─── GpaEntryModel ────────────────────────────────────────────────────────────

@Collection()
class GpaEntryModel {
  GpaEntryModel({
    this.id = Isar.autoIncrement,
    this.uuid = '',
    this.subjectName = '',
    this.subjectCode = '',
    this.subjectUuid = '',
    this.semesterLabel = '',
    this.credits = 0,
    this.gradePoint = 0.0,
    this.letterGrade = '',
    this.marksObtained = 0.0,
    this.maxMarks = 100.0,
    this.isInternal = false,
    this.examType = '',
    this.notes = '',
    this.createdAt,
  });

  Id id;

  @Index(unique: true, replace: true)
  String uuid;

  /// Subject name — may differ from SubjectModel.name if the user overrides it.
  @Index(type: IndexType.value)
  String subjectName;

  String subjectCode;

  /// Reference to [SubjectModel.uuid]; empty if not linked.
  @Index()
  String subjectUuid;

  /// Semester label, e.g. "Semester 3" or "Fall 2025".
  @Index()
  String semesterLabel;

  /// Credit hours for this subject.
  int credits;

  /// Grade point earned (e.g. 8.5 on a 10-point scale, or 3.7 on a 4-point scale).
  double gradePoint;

  /// Letter grade string, e.g. "A+", "B", "O".
  String letterGrade;

  /// Raw marks obtained (0–maxMarks).
  double marksObtained;

  /// Total marks for this exam/component.
  double maxMarks;

  /// Whether this is an internal/continuous assessment (vs end-semester exam).
  bool isInternal;

  /// Exam type label, e.g. "Mid-Term", "Final", "Assignment".
  String examType;

  String notes;

  @Index()
  DateTime? createdAt;

  // ── Derived helpers ───────────────────────────────────────────────────────

  /// Percentage score for this entry.
  double get percentage =>
      maxMarks == 0 ? 0 : (marksObtained / maxMarks) * 100;

  /// Weighted grade points (gradePoint × credits) — used in GPA formula.
  double get weightedGradePoints => gradePoint * credits;
}
