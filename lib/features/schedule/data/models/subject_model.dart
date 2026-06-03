// lib/features/schedule/data/models/subject_model.dart
//
// StudySpark — Isar collection that represents an academic subject / course.
//
// A subject acts as a colour-coded namespace for tasks, notes, attendance,
// and flashcard decks. It is intentionally lightweight; the heavy data
// lives in those feature-specific collections and references [SubjectModel]
// by its [uuid].
// ─────────────────────────────────────────────────────────────────────────────

import 'package:isar/isar.dart';

import '../../../../core/enums/app_enums.dart';

part 'subject_model.g.dart';

// ─── ScheduleSlot (embedded) ─────────────────────────────────────────────────

/// A recurring weekly timetable slot for this subject
/// (e.g. "Monday 09:00–10:30, Room A204").
@embedded
class ScheduleSlot {
  ScheduleSlot({
    this.weekday = 1,
    this.startHour = 9,
    this.startMinute = 0,
    this.durationMinutes = 60,
    this.room = '',
    this.instructor = '',
  });

  /// ISO weekday: 1 = Monday … 7 = Sunday.
  int weekday;
  int startHour;
  int startMinute;
  int durationMinutes;
  String room;
  String instructor;
}

// ─── SubjectModel ─────────────────────────────────────────────────────────────

@Collection()
class SubjectModel {
  SubjectModel({
    this.id = Isar.autoIncrement,
    this.uuid = '',
    this.name = '',
    this.code = '',
    this.subjectType = SubjectType.other,
    this.colorHex = '#6750A4',
    this.iconName = 'book',
    this.instructor = '',
    this.credits = 0,
    this.targetAttendancePercent = 75,
    this.semesterLabel = '',
    this.scheduleSlots = const [],
    this.isArchived = false,
    this.notes = '',
    this.createdAt,
    this.updatedAt,
  });

  // ── Primary key ───────────────────────────────────────────────────────────
  Id id;

  @Index(unique: true, replace: true)
  String uuid;

  // ── Identity ──────────────────────────────────────────────────────────────

  /// Full subject name, e.g. "Advanced Mathematics".
  @Index(type: IndexType.value)
  String name;

  /// Short course code, e.g. "MA301".
  @Index()
  String code;

  @enumerated
  SubjectType subjectType;

  // ── Visual identity ───────────────────────────────────────────────────────

  /// Hex colour used for chips, timeline segments, and progress rings.
  String colorHex;

  /// HugeIcons icon name (string key looked up in a constants map).
  String iconName;

  // ── Academic metadata ─────────────────────────────────────────────────────

  String instructor;

  /// Credit hours / units this subject is worth.
  int credits;

  /// Minimum % attendance the student is aiming for (default 75%).
  int targetAttendancePercent;

  /// Human-readable semester label, e.g. "Fall 2025" or "Semester 3".
  @Index()
  String semesterLabel;

  // ── Schedule ──────────────────────────────────────────────────────────────

  /// Recurring weekly timetable slots for this subject.
  List<ScheduleSlot> scheduleSlots;

  // ── Misc ──────────────────────────────────────────────────────────────────

  /// Soft-delete: archived subjects are hidden from active views.
  @Index()
  bool isArchived;

  /// Optional free-text syllabus / description notes.
  String notes;

  // ── Timestamps ────────────────────────────────────────────────────────────

  @Index()
  DateTime? createdAt;

  DateTime? updatedAt;
}
