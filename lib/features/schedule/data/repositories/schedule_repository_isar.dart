// lib/features/schedule/data/repositories/schedule_repository.dart
//
// StudySpark — Schedule Repository
//
// Bundles three related data-access objects in a single file because they
// are always used together in the schedule feature:
//
//   • [SubjectRepository]       — Subjects / timetable slots
//   • [AttendanceRepository]    — Attendance records per class session
//   • [ScheduleEventRepository] — One-off / recurring calendar events
//
// All write ops are wrapped in Isar write transactions.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/enums/app_enums.dart';
import '../models/subject_model.dart';
import '../models/attendance_model.dart';
import '../models/schedule_event_model.dart';

const _uuid = Uuid();
final _dateFmt = DateFormat('yyyy-MM-dd');

// ─── SubjectRepository ────────────────────────────────────────────────────────

class SubjectRepository {
  const SubjectRepository(this._isar);

  final Isar _isar;

  // ── CREATE ──────────────────────────────────────────────────────────────

  Future<SubjectModel> createSubject({
    required String name,
    required SubjectType type,
    String colorHex = '#6750A4',
    String iconName = 'book',
    String teacherName = '',
    String roomNumber = '',
    int targetAttendancePercent = 75,
    String semesterLabel = '',
    List<ScheduleSlot> scheduleSlots = const [],
    String notes = '',
  }) async {
    final now = DateTime.now().toUtc();
    final subject = SubjectModel(
      uuid: _uuid.v4(),
      name: name,
      subjectType: type,
      colorHex: colorHex,
      iconName: iconName,
      instructor: teacherName,
      targetAttendancePercent: targetAttendancePercent,
      semesterLabel: semesterLabel,
      scheduleSlots: scheduleSlots,
      notes: roomNumber.isEmpty ? notes : (notes.isEmpty ? 'Room: ' : ' | Room: '),
      isArchived: false,
      createdAt: now,
      updatedAt: now,
    );

    await _isar.writeTxn(() async {
      subject.id = await _isar.subjectModels.put(subject);
    });
    return subject;
  }

  // ── READ ────────────────────────────────────────────────────────────────

  /// Reactive stream of all active (non-archived) subjects.
  Stream<List<SubjectModel>> watchActiveSubjects() {
    return _isar.subjectModels
        .filter()
        .isArchivedEqualTo(false)
        .sortByName()
        .watch(fireImmediately: true);
  }

  Future<SubjectModel?> getSubjectByUuid(String uuid) =>
      _isar.subjectModels.filter().uuidEqualTo(uuid).findFirst();

  Future<List<SubjectModel>> getAllActiveSubjects() =>
      _isar.subjectModels.filter().isArchivedEqualTo(false).findAll();

  // ── UPDATE / DELETE ──────────────────────────────────────────────────────

  Future<void> updateSubject(SubjectModel updated) async {
    updated.updatedAt = DateTime.now().toUtc();
    await _isar.writeTxn(() => _isar.subjectModels.put(updated));
  }

  Future<void> archiveSubject(String uuid) async {
    final s = await getSubjectByUuid(uuid);
    if (s == null) return;
    s.isArchived = true;
    s.updatedAt = DateTime.now().toUtc();
    await _isar.writeTxn(() => _isar.subjectModels.put(s));
  }

  Future<bool> deleteSubject(String uuid) async {
    final s = await getSubjectByUuid(uuid);
    if (s == null) return false;
    return _isar.writeTxn(() => _isar.subjectModels.delete(s.id));
  }
}

// ─── AttendanceRepository ─────────────────────────────────────────────────────

class AttendanceRepository {
  const AttendanceRepository(this._isar);

  final Isar _isar;

  // ── CREATE / UPSERT ──────────────────────────────────────────────────────

  /// Records or updates the attendance for a class session identified by
  /// [subjectId] + [localDateKey].  If a record already exists it is updated.
  Future<AttendanceModel> upsertAttendance({
    required String subjectId,
    required AttendanceStatus status,
    required DateTime classDate,
    String? notes,
    int? periodNumber,
  }) async {
    final dateKey = _dateFmt.format(classDate.toLocal());

    // Look for an existing record to update (upsert semantics).
    AttendanceModel? existing = await _isar.attendanceModels
        .filter()
        .subjectIdEqualTo(subjectId)
        .localDateKeyEqualTo(dateKey)
        .findFirst();

    final now = DateTime.now().toUtc();
    if (existing != null) {
      existing.attendanceStatus = status;
      existing.notes = notes ?? existing.notes;
      existing.updatedAt = now;
      await _isar.writeTxn(() => _isar.attendanceModels.put(existing!));
      return existing;
    }

    final record = AttendanceModel(
      uuid: _uuid.v4(),
      subjectId: subjectId,
      attendanceStatus: status,
      classDate: classDate.toUtc(),
      localDateKey: dateKey,
      notes: notes ?? '',
      createdAt: now,
      updatedAt: now,
    );

    await _isar.writeTxn(() async {
      record.id = await _isar.attendanceModels.put(record);
    });
    return record;
  }

  // ── READ ────────────────────────────────────────────────────────────────

  /// Stream of all attendance for a subject, sorted by date descending.
  Stream<List<AttendanceModel>> watchAttendanceForSubject(String subjectId) {
    return _isar.attendanceModels
        .filter()
        .subjectIdEqualTo(subjectId)
        .sortByClassDateDesc()
        .watch(fireImmediately: true);
  }

  /// Stream of all attendance records for a given day.
  Stream<List<AttendanceModel>> watchAttendanceForDay(String dateKey) {
    return _isar.attendanceModels
        .filter()
        .localDateKeyEqualTo(dateKey)
        .watch(fireImmediately: true);
  }

  /// Computes the attendance percentage for [subjectId].
  ///
  /// Returns a value 0–100.  Only records where
  /// [AttendanceStatus.countsAsPresent] == true count toward the numerator.
  Future<double> getAttendancePercent(String subjectId) async {
    final records = await _isar.attendanceModels
        .filter()
        .subjectIdEqualTo(subjectId)
        .findAll();

    if (records.isEmpty) return 100.0;

    final present =
        records.where((r) => r.attendanceStatus.countsAsPresent).length;
    return (present / records.length) * 100;
  }

  /// Returns the count breakdown by status for a subject (for pie charts).
  Future<Map<AttendanceStatus, int>> getAttendanceSummary(
      String subjectId) async {
    final records = await _isar.attendanceModels
        .filter()
        .subjectIdEqualTo(subjectId)
        .findAll();

    final summary = <AttendanceStatus, int>{};
    for (final status in AttendanceStatus.values) {
      summary[status] = records.where((r) => r.attendanceStatus == status).length;
    }
    return summary;
  }

  // ── DELETE ───────────────────────────────────────────────────────────────

  Future<bool> deleteAttendance(String uuid) async {
    final record = await _isar.attendanceModels
        .filter()
        .uuidEqualTo(uuid)
        .findFirst();
    if (record == null) return false;
    return _isar.writeTxn(() => _isar.attendanceModels.delete(record.id));
  }
}

// ─── ScheduleEventRepository ──────────────────────────────────────────────────

class ScheduleEventRepository {
  const ScheduleEventRepository(this._isar);

  final Isar _isar;

  // ── CREATE ───────────────────────────────────────────────────────────────

  Future<ScheduleEventModel> createEvent({
    required String title,
    required DateTime startTime,
    required DateTime endTime,
    String subjectId = '',
    String location = '',
    String colorHex = '#6750A4',
    String description = '',
    EventType type = EventType.lecture,
    bool isRecurring = false,
    RecurrenceType repeat = RecurrenceType.none,
    int? notificationId,
  }) async {
    final now = DateTime.now().toUtc();
    final event = ScheduleEventModel()
      ..uuid = _uuid.v4()
      ..title = title
      ..startTime = startTime.toUtc()
      ..endTime = endTime.toUtc()
      ..subject = subjectId
      ..location = location
      ..subjectColor = colorHex
      ..description = description
      ..type = type
      ..recurrence = repeat
      ..createdAt = now;

    await _isar.writeTxn(() async {
      event.id = await _isar.scheduleEventModels.put(event);
    });
    return event;
  }

  // ── READ ─────────────────────────────────────────────────────────────────

  /// Reactive stream of events for a given day key (e.g. "2025-06-03").
  Stream<List<ScheduleEventModel>> watchEventsForDay(String dateKey) {
    // The previous implementation used localDateKey, but we must query by date bounds instead
    final date = _dateFmt.parse(dateKey);
    final startOfDay = DateTime(date.year, date.month, date.day).toUtc();
    final endOfDay = startOfDay.add(const Duration(days: 1));
    return _isar.scheduleEventModels
        .filter()
        .startTimeGreaterThan(startOfDay)
        .startTimeLessThan(endOfDay)
        .sortByStartTime()
        .watch(fireImmediately: true);
  }

  /// Events in a date range — used to populate a month/week calendar view.
  Future<List<ScheduleEventModel>> getEventsInRange(
    DateTime start,
    DateTime end,
  ) {
    return _isar.scheduleEventModels
        .filter()
        .startTimeGreaterThan(start.toUtc())
        .startTimeLessThan(end.toUtc())
        .sortByStartTime()
        .findAll();
  }

  Future<ScheduleEventModel?> getEventByUuid(String uuid) =>
      _isar.scheduleEventModels.filter().uuidEqualTo(uuid).findFirst();

  // ── UPDATE / DELETE ──────────────────────────────────────────────────────

  Future<void> updateEvent(ScheduleEventModel updated) async {
    await _isar.writeTxn(() => _isar.scheduleEventModels.put(updated));
  }

  Future<bool> deleteEvent(String uuid) async {
    final event = await getEventByUuid(uuid);
    if (event == null) return false;
    return _isar.writeTxn(() => _isar.scheduleEventModels.delete(event.id));
  }
}

