// lib/features/schedule/data/models/attendance_model.dart
//
// StudySpark — Isar collection tracking class attendance per subject.
//
// One document = one class occurrence.  The repository aggregates these
// to compute the attendance percentage the student must display and the
// "classes you can skip" count used in many student apps.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:isar/isar.dart';

import '../../../../core/enums/app_enums.dart';

part 'attendance_model.g.dart';

// ─── AttendanceModel ──────────────────────────────────────────────────────────

@Collection()
class AttendanceModel {
  AttendanceModel({
    this.id = Isar.autoIncrement,
    this.uuid = '',
    this.subjectId = '',
    this.subjectName = '',
    this.attendanceStatus = AttendanceStatus.present,
    this.classDate,
    this.startTime = '',
    this.endTime = '',
    this.topic = '',
    this.room = '',
    this.notes = '',
    this.isExtraClass = false,
    this.localDateKey = '',
    this.createdAt,
    this.updatedAt,
  });

  // ── Primary key ───────────────────────────────────────────────────────────
  Id id;

  @Index(unique: true, replace: true)
  String uuid;

  // ── Linkage ───────────────────────────────────────────────────────────────

  /// UUID of the [SubjectModel] this class belongs to.
  @Index(composite: [CompositeIndex('localDateKey')])
  String subjectId;

  /// Denormalised subject name for display without a join.
  String subjectName;

  // ── Status ────────────────────────────────────────────────────────────────

  @enumerated
  AttendanceStatus attendanceStatus;

  // ── Class metadata ────────────────────────────────────────────────────────

  /// The calendar date of this class (UTC midnight).
  @Index()
  DateTime? classDate;

  /// "HH:mm" formatted start time string (avoids DateTime complexity for
  /// simple time display).
  String startTime;

  /// "HH:mm" formatted end time string.
  String endTime;

  /// Topic / lecture title covered in this class.
  String topic;

  /// Classroom or online meeting link.
  String room;

  /// Notes about the class (e.g. "quiz next week").
  String notes;

  /// True for extra / compensatory classes not in the regular schedule.
  bool isExtraClass;

  /// "yyyy-MM-dd" UTC date key for fast date-range queries.
  @Index()
  String localDateKey;

  // ── Timestamps ────────────────────────────────────────────────────────────

  DateTime? createdAt;
  DateTime? updatedAt;

  // ── Derived helpers ───────────────────────────────────────────────────────

  bool get isPresent => attendanceStatus.countsAsPresent;
}
