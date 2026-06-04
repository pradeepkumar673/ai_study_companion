// lib/core/web/web_repositories.dart
//
// StudySpark — Web repository implementations (SharedPreferences / JSON).
// Same public API as the Isar repositories in lib/features/**/data/repositories.
// ─────────────────────────────────────────────────────────────────────────────

import 'dart:async';

import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../enums/app_enums.dart';
import 'models.dart';
import 'web_store.dart' hide JsonMap;

final _dateFmt = DateFormat('yyyy-MM-dd');
const _uuid = Uuid();

// ─── Shared helpers ───────────────────────────────────────────────────────────

List<T> _mapAll<T>(WebStore store, String collection, T Function(JsonMap) fromJson) =>
    store.list(collection).map((e) => fromJson(e)).toList();

Future<void> _persist<T>(
  WebStore store,
  String collection,
  T model,
  JsonMap Function(T) toJson,
  void Function(int id) setId,
) async {
  final saved = await store.upsert(collection, toJson(model));
  setId((saved['id'] as num).toInt());
}

Stream<List<T>> _watch<T>(
  WebStore store,
  String collection,
  List<T> Function() load,
) async* {
  yield load();
  await for (final _ in store.watchCollection(collection)) {
    yield load();
  }
}

// ─── Note color helper ────────────────────────────────────────────────────────

NoteColor _noteColorFromHex(String hex) {
  final normalized = hex.toUpperCase();
  for (final c in NoteColor.values) {
    if (c.hexValue.toUpperCase() == normalized) return c;
  }
  return NoteColor.white;
}

// ─── TaskRepository ───────────────────────────────────────────────────────────

class TaskRepository {
  const TaskRepository(this._store);

  final WebStore _store;

  List<TaskModel> _all() => _mapAll(_store, 'tasks', TaskModel.fromJson);

  Future<void> _put(TaskModel task) => _persist(
        _store,
        'tasks',
        task,
        (t) => t.toJson(),
        (id) => task.id = id,
      );

  Future<TaskModel> createTask({
    required String title,
    String description = '',
    Priority priority = Priority.medium,
    TaskStatus status = TaskStatus.todo,
    DateTime? deadline,
    String subjectId = '',
    List<String> tags = const [],
    RepeatFrequency repeatFrequency = RepeatFrequency.none,
    List<SubtaskModel> subtasks = const [],
    int? estimatedMinutes,
    int? notificationId,
    DateTime? reminderAt,
  }) async {
    final now = DateTime.now().toUtc();
    final localDeadlineKey =
        deadline != null ? _dateFmt.format(deadline.toLocal()) : null;

    final task = TaskModel(
      uuid: _uuid.v4(),
      title: title.trim(),
      description: description.trim(),
      priority: priority,
      status: status,
      deadline: deadline?.toUtc(),
      localDeadlineKey: localDeadlineKey,
      subjectId: subjectId,
      tags: tags,
      repeatFrequency: repeatFrequency,
      subtasks: subtasks,
      estimatedMinutes: estimatedMinutes ?? 30,
      notificationId: notificationId,
      reminderAt: reminderAt?.toUtc(),
      createdAt: now,
      updatedAt: now,
    );

    await _put(task);
    return task;
  }

  Stream<List<TaskModel>> watchAllTasks() {
    return _watch(_store, 'tasks', () {
      final tasks = _all()
          .where((t) => t.status != TaskStatus.archived)
          .toList()
        ..sort((a, b) =>
            (a.deadline ?? DateTime(2100)).compareTo(b.deadline ?? DateTime(2100)));
      return tasks;
    });
  }

  Stream<List<TaskModel>> watchTasksByStatus(TaskStatus status) {
    return _watch(_store, 'tasks', () {
      final tasks = _all().where((t) => t.status == status).toList()
        ..sort((a, b) =>
            (a.deadline ?? DateTime(2100)).compareTo(b.deadline ?? DateTime(2100)));
      return tasks;
    });
  }

  Future<List<TaskModel>> getTasksForDay(String dateKey) async {
    return _all()
        .where((t) =>
            t.localDeadlineKey == dateKey && t.status != TaskStatus.archived)
        .toList()
      ..sort((a, b) => b.priority.index.compareTo(a.priority.index));
  }

  Future<List<TaskModel>> getTasksInRange(DateTime start, DateTime end) async {
    final s = start.toUtc();
    final e = end.toUtc();
    return _all()
        .where((t) {
          final d = t.deadline;
          if (d == null || t.status == TaskStatus.archived) return false;
          return !d.isBefore(s) && !d.isAfter(e);
        })
        .toList()
      ..sort((a, b) =>
          (a.deadline ?? DateTime(2100)).compareTo(b.deadline ?? DateTime(2100)));
  }

  Future<List<TaskModel>> getHighPriorityTasks() async {
    bool active(TaskModel t) =>
        t.status != TaskStatus.done && t.status != TaskStatus.archived;

    final high = _all()
        .where((t) => t.priority == Priority.high && active(t))
        .toList();
    final critical = _all()
        .where((t) => t.priority == Priority.critical && active(t))
        .toList();
    return [...critical, ...high]
      ..sort((a, b) =>
          (a.deadline ?? DateTime(2100)).compareTo(b.deadline ?? DateTime(2100)));
  }

  Future<List<TaskModel>> getOverdueTasks() async {
    final now = DateTime.now().toUtc();
    return _all()
        .where((t) {
          final d = t.deadline;
          return d != null &&
              d.isBefore(now) &&
              t.status != TaskStatus.done &&
              t.status != TaskStatus.archived;
        })
        .toList()
      ..sort((a, b) =>
          (a.deadline ?? DateTime(2100)).compareTo(b.deadline ?? DateTime(2100)));
  }

  Future<TaskModel?> getTaskByUuid(String uuid) async =>
      _all().where((t) => t.uuid == uuid).firstOrNull;

  Future<TaskModel?> getTaskById(int id) async =>
      _all().where((t) => t.id == id).firstOrNull;

  Future<Map<TaskStatus, int>> getStatusCounts() async {
    final all = _all();
    final counts = <TaskStatus, int>{};
    for (final s in TaskStatus.values) {
      counts[s] = all.where((t) => t.status == s).length;
    }
    return counts;
  }

  Future<void> updateTask(TaskModel task) async {
    task.updatedAt = DateTime.now().toUtc();
    if (task.deadline != null) {
      task.localDeadlineKey = _dateFmt.format(task.deadline!.toLocal());
    }
    await _put(task);
  }

  Future<void> completeTask(String uuid) async {
    final task = await getTaskByUuid(uuid);
    if (task == null || task.status == TaskStatus.done) return;
    task.status = TaskStatus.done;
    task.completedAt = DateTime.now().toUtc();
    task.updatedAt = DateTime.now().toUtc();
    await _put(task);
  }

  Future<void> toggleSubtask(String taskUuid, String subtaskId) async {
    final task = await getTaskByUuid(taskUuid);
    if (task == null) return;
    final idx = task.subtasks.indexWhere((s) => s.id == subtaskId);
    if (idx == -1) return;
    final sub = task.subtasks[idx];
    sub.isCompleted = !sub.isCompleted;
    sub.completedAt = sub.isCompleted ? DateTime.now().toUtc() : null;
    task.updatedAt = DateTime.now().toUtc();
    await _put(task);
  }

  Future<void> addSubtask(String taskUuid, String subtaskTitle) async {
    final task = await getTaskByUuid(taskUuid);
    if (task == null) return;
    final subtask = SubtaskModel(
      id: _uuid.v4(),
      title: subtaskTitle.trim(),
      position: task.subtasks.length,
      createdAt: DateTime.now().toUtc(),
    );
    task.subtasks = [...task.subtasks, subtask];
    task.updatedAt = DateTime.now().toUtc();
    await _put(task);
  }

  Future<void> removeSubtask(String taskUuid, String subtaskId) async {
    final task = await getTaskByUuid(taskUuid);
    if (task == null) return;
    task.subtasks = task.subtasks.where((s) => s.id != subtaskId).toList();
    task.updatedAt = DateTime.now().toUtc();
    await _put(task);
  }

  Future<void> archiveTask(String uuid) async {
    final task = await getTaskByUuid(uuid);
    if (task == null) return;
    task.status = TaskStatus.archived;
    task.updatedAt = DateTime.now().toUtc();
    await _put(task);
  }

  Future<bool> deleteTask(String uuid) async {
    final task = await getTaskByUuid(uuid);
    if (task == null) return false;
    return _store.deleteById('tasks', task.id);
  }

  Future<int> purgeCompletedTasks({int daysOld = 30}) async {
    final cutoff = DateTime.now().subtract(Duration(days: daysOld)).toUtc();
    final stale = _all()
        .where((t) =>
            t.status == TaskStatus.done &&
            t.completedAt != null &&
            t.completedAt!.isBefore(cutoff))
        .toList();
    if (stale.isEmpty) return 0;
    for (final t in stale) {
      await _store.deleteById('tasks', t.id);
    }
    return stale.length;
  }
}

// ─── NoteRepository ─────────────────────────────────────────────────────────────

class NoteRepository {
  const NoteRepository(this._store);

  final WebStore _store;
  static const _noteUuid = Uuid();

  List<NoteModel> _all() => _mapAll(_store, 'notes', NoteModel.fromJson);

  List<NoteModel> _activeSorted(List<NoteModel> notes) {
    return notes.where((n) => !n.isArchived).toList()
      ..sort((a, b) {
        if (a.isPinned != b.isPinned) return a.isPinned ? -1 : 1;
        final au = a.updatedAt ?? DateTime(0);
        final bu = b.updatedAt ?? DateTime(0);
        return bu.compareTo(au);
      });
  }

  Future<void> _put(NoteModel note) => _persist(
        _store,
        'notes',
        note,
        (n) => n.toJson(),
        (id) => note.id = id,
      );

  Future<NoteModel> createNote({
    required String title,
    required String content,
    required String plainTextPreview,
    String subjectId = '',
    List<String> tags = const [],
    String colorHex = '#FFFFFF',
    bool isPinned = false,
  }) async {
    final now = DateTime.now().toUtc();
    final note = NoteModel(
      uuid: _noteUuid.v4(),
      title: title,
      content: content,
      plainTextPreview: plainTextPreview,
      subjectId: subjectId,
      tags: tags,
      color: _noteColorFromHex(colorHex),
      isPinned: isPinned,
      createdAt: now,
      updatedAt: now,
    );

    await _put(note);
    return note;
  }

  Stream<List<NoteModel>> watchAllNotes() {
    return _watch(_store, 'notes', () => _activeSorted(_all()));
  }

  Stream<List<NoteModel>> watchNotesBySubject(String subjectId) {
    return _watch(
      _store,
      'notes',
      () => _activeSorted(
        _all().where((n) => n.subjectId == subjectId).toList(),
      ),
    );
  }

  Stream<List<NoteModel>> watchNotesByTag(String tag) {
    return _watch(
      _store,
      'notes',
      () => _activeSorted(_all().where((n) => n.tags.contains(tag)).toList()),
    );
  }

  Future<NoteModel?> getNoteByUuid(String uuid) async =>
      _all().where((n) => n.uuid == uuid).firstOrNull;

  Future<List<NoteModel>> searchNotes(String query) async {
    if (query.trim().isEmpty) return [];
    final q = query.toLowerCase();
    return _all()
        .where((n) =>
            !n.isArchived &&
            (n.plainTextPreview.toLowerCase().contains(q) ||
                n.title.toLowerCase().contains(q)))
        .toList();
  }

  Future<void> updateNote(NoteModel updated) async {
    updated.updatedAt = DateTime.now().toUtc();
    await _put(updated);
  }

  Future<void> saveAiSummary(String uuid, String summary) async {
    final note = await getNoteByUuid(uuid);
    if (note == null) return;
    note.aiSummary = summary;
    note.updatedAt = DateTime.now().toUtc();
    await _put(note);
  }

  Future<void> togglePin(String uuid) async {
    final note = await getNoteByUuid(uuid);
    if (note == null) return;
    note.isPinned = !note.isPinned;
    note.updatedAt = DateTime.now().toUtc();
    await _put(note);
  }

  Future<void> archiveNote(String uuid) async {
    final note = await getNoteByUuid(uuid);
    if (note == null) return;
    note.isArchived = true;
    note.updatedAt = DateTime.now().toUtc();
    await _put(note);
  }

  Future<bool> deleteNote(String uuid) async {
    final note = await getNoteByUuid(uuid);
    if (note == null) return false;
    return _store.deleteById('notes', note.id);
  }
}

// ─── FocusRepository ────────────────────────────────────────────────────────────

class DailyFocusSummary {
  const DailyFocusSummary({
    required this.dateKey,
    required this.totalMinutes,
    required this.sessionCount,
  });

  final String dateKey;
  final int totalMinutes;
  final int sessionCount;
}

class FocusRepository {
  const FocusRepository(this._store);

  final WebStore _store;

  List<PomodoroSessionModel> _pomodoros() =>
      _mapAll(_store, 'pomodoroSessions', PomodoroSessionModel.fromJson);

  Future<void> saveSession(PomodoroSessionModel session) => _persist(
        _store,
        'pomodoroSessions',
        session,
        (s) => s.toJson(),
        (id) => session.id = id,
      );

  Future<void> saveFocusSession(FocusSessionModel session) => _persist(
        _store,
        'focusSessions',
        session,
        (s) => s.toJson(),
        (id) => session.id = id,
      );

  Future<int> todayTotalMinutes() async {
    final key = _dateFmt.format(DateTime.now());
    final sessions = _pomodoros()
        .where((s) =>
            s.localDateKey == key &&
            s.wasCompleted &&
            s.mode == PomodoroMode.pomodoro)
        .toList();
    final totalSecs =
        sessions.fold(0, (sum, s) => sum + s.actualDurationSeconds);
    return totalSecs ~/ 60;
  }

  Stream<List<PomodoroSessionModel>> watchSessionsForDay(String dateKey) {
    return _watch(_store, 'pomodoroSessions', () {
      final sessions =
          _pomodoros().where((s) => s.localDateKey == dateKey).toList()
            ..sort((a, b) =>
                (b.completedAt ?? DateTime(0))
                    .compareTo(a.completedAt ?? DateTime(0)));
      return sessions;
    });
  }

  Future<List<DailyFocusSummary>> getWeeklyFocusSummary() async {
    final today = DateTime.now();
    final summaries = <DailyFocusSummary>[];

    for (int i = 6; i >= 0; i--) {
      final day = today.subtract(Duration(days: i));
      final key = _dateFmt.format(day);
      final sessions = _pomodoros()
          .where((s) =>
              s.localDateKey == key &&
              s.wasCompleted &&
              s.mode == PomodoroMode.pomodoro)
          .toList();

      final totalSecs =
          sessions.fold(0, (sum, s) => sum + s.actualDurationSeconds);

      summaries.add(DailyFocusSummary(
        dateKey: key,
        totalMinutes: totalSecs ~/ 60,
        sessionCount: sessions.length,
      ));
    }
    return summaries;
  }

  Future<int> computeCurrentStreak() async {
    final today = DateTime.now();
    int streak = 0;

    for (int i = 0; i < 365; i++) {
      final key = _dateFmt.format(today.subtract(Duration(days: i)));
      final count = _pomodoros()
          .where((s) =>
              s.localDateKey == key &&
              s.wasCompleted &&
              s.mode == PomodoroMode.pomodoro)
          .length;

      if (count > 0) {
        streak++;
      } else if (i > 0) {
        break;
      }
    }
    return streak;
  }

  Future<List<PomodoroSessionModel>> getRecentSessions({int limit = 30}) async {
    final sessions = _pomodoros().where((s) => s.wasCompleted).toList()
      ..sort((a, b) =>
          (b.completedAt ?? DateTime(0)).compareTo(a.completedAt ?? DateTime(0)));
    if (sessions.length <= limit) return sessions;
    return sessions.sublist(0, limit);
  }

  Future<List<PomodoroSessionModel>> getSessionsInRange(
    DateTime start,
    DateTime end,
  ) async {
    final s = start.toUtc();
    final e = end.toUtc();
    return _pomodoros()
        .where((sess) {
          final c = sess.completedAt;
          return sess.wasCompleted &&
              c != null &&
              c.isAfter(s) &&
              c.isBefore(e);
        })
        .toList();
  }
}

// ─── SubjectRepository ──────────────────────────────────────────────────────────

class SubjectRepository {
  const SubjectRepository(this._store);

  final WebStore _store;

  List<SubjectModel> _all() => _mapAll(_store, 'subjects', SubjectModel.fromJson);

  Future<void> _put(SubjectModel subject) => _persist(
        _store,
        'subjects',
        subject,
        (s) => s.toJson(),
        (id) => subject.id = id,
      );

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

    await _put(subject);
    return subject;
  }

  Stream<List<SubjectModel>> watchActiveSubjects() {
    return _watch(_store, 'subjects', () {
      return _all().where((s) => !s.isArchived).toList()
        ..sort((a, b) => a.name.compareTo(b.name));
    });
  }

  Future<SubjectModel?> getSubjectByUuid(String uuid) async =>
      _all().where((s) => s.uuid == uuid).firstOrNull;

  Future<List<SubjectModel>> getAllActiveSubjects() async =>
      _all().where((s) => !s.isArchived).toList();

  Future<void> updateSubject(SubjectModel updated) async {
    updated.updatedAt = DateTime.now().toUtc();
    await _put(updated);
  }

  Future<void> archiveSubject(String uuid) async {
    final s = await getSubjectByUuid(uuid);
    if (s == null) return;
    s.isArchived = true;
    s.updatedAt = DateTime.now().toUtc();
    await _put(s);
  }

  Future<bool> deleteSubject(String uuid) async {
    final s = await getSubjectByUuid(uuid);
    if (s == null) return false;
    return _store.deleteById('subjects', s.id);
  }
}

// ─── AttendanceRepository ───────────────────────────────────────────────────────

class AttendanceRepository {
  const AttendanceRepository(this._store);

  final WebStore _store;

  List<AttendanceModel> _all() =>
      _mapAll(_store, 'attendance', AttendanceModel.fromJson);

  Future<void> _put(AttendanceModel record) => _persist(
        _store,
        'attendance',
        record,
        (r) => r.toJson(),
        (id) => record.id = id,
      );

  Future<AttendanceModel> upsertAttendance({
    required String subjectId,
    required AttendanceStatus status,
    required DateTime classDate,
    String? notes,
    int? periodNumber,
  }) async {
    final dateKey = _dateFmt.format(classDate.toLocal());

    final existing = _all()
        .where((r) => r.subjectId == subjectId && r.localDateKey == dateKey)
        .firstOrNull;

    final now = DateTime.now().toUtc();
    if (existing != null) {
      existing.attendanceStatus = status;
      existing.notes = notes ?? existing.notes;
      existing.updatedAt = now;
      await _put(existing);
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

    await _put(record);
    return record;
  }

  Stream<List<AttendanceModel>> watchAttendanceForSubject(String subjectId) {
    return _watch(_store, 'attendance', () {
      return _all().where((r) => r.subjectId == subjectId).toList()
        ..sort((a, b) =>
            (b.classDate ?? DateTime(0)).compareTo(a.classDate ?? DateTime(0)));
    });
  }

  Stream<List<AttendanceModel>> watchAttendanceForDay(String dateKey) {
    return _watch(
      _store,
      'attendance',
      () => _all().where((r) => r.localDateKey == dateKey).toList(),
    );
  }

  Future<double> getAttendancePercent(String subjectId) async {
    final records = _all().where((r) => r.subjectId == subjectId).toList();
    if (records.isEmpty) return 100.0;
    final present =
        records.where((r) => r.attendanceStatus.countsAsPresent).length;
    return (present / records.length) * 100;
  }

  Future<Map<AttendanceStatus, int>> getAttendanceSummary(
    String subjectId,
  ) async {
    final records = _all().where((r) => r.subjectId == subjectId).toList();
    final summary = <AttendanceStatus, int>{};
    for (final status in AttendanceStatus.values) {
      summary[status] =
          records.where((r) => r.attendanceStatus == status).length;
    }
    return summary;
  }

  Future<bool> deleteAttendance(String uuid) async {
    final record = _all().where((r) => r.uuid == uuid).firstOrNull;
    if (record == null) return false;
    return _store.deleteById('attendance', record.id);
  }
}

// ─── ScheduleEventRepository ────────────────────────────────────────────────────

class ScheduleEventRepository {
  const ScheduleEventRepository(this._store);

  final WebStore _store;

  List<ScheduleEventModel> _all() =>
      _mapAll(_store, 'scheduleEvents', ScheduleEventModel.fromJson);

  Future<void> _put(ScheduleEventModel event) => _persist(
        _store,
        'scheduleEvents',
        event,
        (e) => e.toJson(),
        (id) => event.id = id,
      );

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

    await _put(event);
    return event;
  }

  Stream<List<ScheduleEventModel>> watchEventsForDay(String dateKey) {
    return _watch(_store, 'scheduleEvents', () {
      final date = _dateFmt.parse(dateKey);
      final startOfDay = DateTime(date.year, date.month, date.day).toUtc();
      final endOfDay = startOfDay.add(const Duration(days: 1));
      return _all()
          .where((e) =>
              e.startTime.isAfter(startOfDay) && e.startTime.isBefore(endOfDay))
          .toList()
        ..sort((a, b) => a.startTime.compareTo(b.startTime));
    });
  }

  Future<List<ScheduleEventModel>> getEventsInRange(
    DateTime start,
    DateTime end,
  ) async {
    final s = start.toUtc();
    final e = end.toUtc();
    return _all()
        .where((ev) => ev.startTime.isAfter(s) && ev.startTime.isBefore(e))
        .toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));
  }

  Future<ScheduleEventModel?> getEventByUuid(String uuid) async =>
      _all().where((e) => e.uuid == uuid).firstOrNull;

  Future<void> updateEvent(ScheduleEventModel updated) async {
    await _put(updated);
  }

  Future<bool> deleteEvent(String uuid) async {
    final event = await getEventByUuid(uuid);
    if (event == null) return false;
    return _store.deleteById('scheduleEvents', event.id);
  }
}

// ─── FlashcardRepository ────────────────────────────────────────────────────────

class FlashcardRepository {
  const FlashcardRepository(this._store);

  final WebStore _store;

  List<FlashcardDeckModel> _decks() =>
      _mapAll(_store, 'flashcardDecks', FlashcardDeckModel.fromJson);

  List<FlashcardModel> _cards() =>
      _mapAll(_store, 'flashcards', FlashcardModel.fromJson);

  Future<void> _putDeck(FlashcardDeckModel deck) => _persist(
        _store,
        'flashcardDecks',
        deck,
        (d) => d.toJson(),
        (id) => deck.id = id,
      );

  Future<void> _putCard(FlashcardModel card) => _persist(
        _store,
        'flashcards',
        card,
        (c) => c.toJson(),
        (id) => card.id = id,
      );

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
    await _putDeck(deck);
    return deck;
  }

  Stream<List<FlashcardDeckModel>> watchAllDecks() {
    return _watch(_store, 'flashcardDecks', () {
      return _decks().where((d) => !d.isArchived).toList()
        ..sort((a, b) => a.title.compareTo(b.title));
    });
  }

  Stream<List<FlashcardDeckModel>> watchDecksBySubject(String subjectId) {
    return _watch(_store, 'flashcardDecks', () {
      return _decks()
          .where((d) => d.subjectId == subjectId && !d.isArchived)
          .toList();
    });
  }

  Future<FlashcardDeckModel?> getDeckByUuid(String uuid) async =>
      _decks().where((d) => d.uuid == uuid).firstOrNull;

  Future<void> updateDeck(FlashcardDeckModel deck) async {
    deck.updatedAt = DateTime.now().toUtc();
    await _putDeck(deck);
  }

  Future<void> archiveDeck(String uuid) async {
    final deck = await getDeckByUuid(uuid);
    if (deck == null) return;
    deck.isArchived = true;
    deck.updatedAt = DateTime.now().toUtc();
    await _putDeck(deck);
  }

  Future<bool> deleteDeck(String uuid) async {
    final deck = await getDeckByUuid(uuid);
    if (deck == null) return false;

    final cards = await getCardsForDeck(uuid);
    for (final c in cards) {
      await _store.deleteById('flashcards', c.id);
    }
    return _store.deleteById('flashcardDecks', deck.id);
  }

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
      nextReviewAt: now,
      createdAt: now,
      updatedAt: now,
    );
    await _putCard(card);
    await _syncDeckCardCount(deckId);
    return card;
  }

  Future<List<FlashcardModel>> getCardsForDeck(String deckId) async =>
      _cards()
          .where((c) => c.deckId == deckId && !c.isSuspended)
          .toList();

  Future<List<FlashcardModel>> getDueCards(String deckId) async {
    final now = DateTime.now().toUtc();
    return _cards()
        .where((c) =>
            c.deckId == deckId &&
            !c.isSuspended &&
            c.nextReviewAt != null &&
            !c.nextReviewAt!.isAfter(now))
        .toList()
      ..sort((a, b) =>
          (a.nextReviewAt ?? DateTime(0)).compareTo(b.nextReviewAt ?? DateTime(0)));
  }

  Stream<int> watchTotalDueCardCount() async* {
    int countDue() {
      final now = DateTime.now().toUtc();
      return _cards()
          .where((c) =>
              !c.isSuspended &&
              c.nextReviewAt != null &&
              !c.nextReviewAt!.isAfter(now))
          .length;
    }

    yield countDue();
    await for (final _ in _store.watchCollection('flashcards')) {
      yield countDue();
    }
  }

  Future<void> updateCard(FlashcardModel card) async {
    card.updatedAt = DateTime.now().toUtc();
    await _putCard(card);
  }

  Future<bool> deleteCard(String uuid) async {
    final card = _cards().where((c) => c.uuid == uuid).firstOrNull;
    if (card == null) return false;
    final deckId = card.deckId;
    await _store.deleteById('flashcards', card.id);
    await _syncDeckCardCount(deckId);
    return true;
  }

  Future<void> recordReview(String cardUuid, FlashcardDifficulty difficulty) async {
    final card = _cards().where((c) => c.uuid == cardUuid).firstOrNull;
    if (card == null) return;

    card.updateSm2(difficulty);
    await _putCard(card);
    await _syncDeckCardCount(card.deckId);
  }

  Future<void> markDeckStudied(String deckId) async {
    final deck = await getDeckByUuid(deckId);
    if (deck == null) return;
    deck.lastStudiedAt = DateTime.now().toUtc();
    deck.updatedAt = DateTime.now().toUtc();
    await _putDeck(deck);
  }

  Future<void> _syncDeckCardCount(String deckId) async {
    final deck = await getDeckByUuid(deckId);
    if (deck == null) return;

    final allCards = _cards().where((c) => c.deckId == deckId).toList();
    final mastered = allCards
        .where((c) => c.accuracy > 0.8 && c.interval > 21)
        .length;

    deck.totalCards = allCards.length;
    deck.masteredCards = mastered;
    deck.updatedAt = DateTime.now().toUtc();
    await _putDeck(deck);
  }
}

// ─── QuizRepository ─────────────────────────────────────────────────────────────

class QuizRepository {
  const QuizRepository(this._store);

  final WebStore _store;

  List<QuizModel> _quizzes() => _mapAll(_store, 'quizzes', QuizModel.fromJson);

  List<QuizAttemptModel> _attempts() =>
      _mapAll(_store, 'quizAttempts', QuizAttemptModel.fromJson);

  Future<void> _putQuiz(QuizModel quiz) => _persist(
        _store,
        'quizzes',
        quiz,
        (q) => q.toJson(),
        (id) => quiz.id = id,
      );

  Future<void> _putAttempt(QuizAttemptModel attempt) => _persist(
        _store,
        'quizAttempts',
        attempt,
        (a) => a.toJson(),
        (id) => attempt.id = id,
      );

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
      isAiGenerated: isAiGenerated,
      questionCount: questions.length,
      createdAt: now,
      updatedAt: now,
    );
    await _putQuiz(quiz);
    return quiz;
  }

  Stream<List<QuizModel>> watchAllQuizzes() {
    return _watch(_store, 'quizzes', () {
      return _quizzes()
        ..sort((a, b) =>
            (b.createdAt ?? DateTime(0)).compareTo(a.createdAt ?? DateTime(0)));
    });
  }

  Future<QuizModel?> getQuizByUuid(String uuid) async =>
      _quizzes().where((q) => q.uuid == uuid).firstOrNull;

  Future<void> updateQuiz(QuizModel quiz) async {
    quiz.updatedAt = DateTime.now().toUtc();
    await _putQuiz(quiz);
  }

  Future<bool> deleteQuiz(String uuid) async {
    final quiz = await getQuizByUuid(uuid);
    if (quiz == null) return false;
    return _store.deleteById('quizzes', quiz.id);
  }

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
    );
    await _putAttempt(attempt);
    return attempt;
  }

  Future<List<QuizAttemptModel>> getAttemptsForQuiz(String quizId) async {
    return _attempts()
        .where((a) => a.quizId == quizId)
        .toList()
      ..sort((a, b) =>
          (b.completedAt ?? DateTime(0)).compareTo(a.completedAt ?? DateTime(0)));
  }

  Future<int> getBestScore(String quizId) async {
    final attempts = await getAttemptsForQuiz(quizId);
    if (attempts.isEmpty) return 0;
    return attempts.map((a) => a.score).reduce((a, b) => a > b ? a : b);
  }
}

// ─── GoalRepository ─────────────────────────────────────────────────────────────

class GoalRepository {
  const GoalRepository(this._store);

  final WebStore _store;
  static const _goalUuid = Uuid();

  List<GoalModel> _all() => _mapAll(_store, 'goals', GoalModel.fromJson);

  Future<void> _put(GoalModel goal) => _persist(
        _store,
        'goals',
        goal,
        (g) => g.toJson(),
        (id) => goal.id = id,
      );

  Future<GoalModel> createGoal({
    required String title,
    String description = '',
    String subjectId = '',
    Priority priority = Priority.medium,
    double targetValue = 100.0,
    String unit = '%',
    DateTime? startDate,
    DateTime? targetDate,
    DateTime? reminderAt,
    List<GoalMilestone> milestones = const [],
    List<String> linkedTaskIds = const [],
    List<String> tags = const [],
    String colorHex = '#6750A4',
    String iconName = 'target',
    int? notificationId,
  }) async {
    final now = DateTime.now().toUtc();
    final goal = GoalModel(
      uuid: _goalUuid.v4(),
      title: title,
      description: description,
      subjectId: subjectId,
      priority: priority,
      status: GoalStatus.active,
      targetValue: targetValue,
      currentValue: 0.0,
      unit: unit,
      startDate: startDate ?? now,
      targetDate: targetDate,
      reminderAt: reminderAt,
      notificationId: notificationId,
      milestones: milestones,
      linkedTaskIds: linkedTaskIds,
      tags: tags,
      colorHex: colorHex,
      iconName: iconName,
      createdAt: now,
      updatedAt: now,
    );
    await _put(goal);
    return goal;
  }

  Stream<List<GoalModel>> watchActiveGoals() {
    return _watch(_store, 'goals', () {
      return _all()
          .where((g) => g.status == GoalStatus.active)
          .toList()
        ..sort((a, b) =>
            (a.targetDate ?? DateTime(2100))
                .compareTo(b.targetDate ?? DateTime(2100)));
    });
  }

  Stream<List<GoalModel>> watchAllGoals() {
    return _watch(_store, 'goals', () {
      return _all()
        ..sort((a, b) =>
            (b.createdAt ?? DateTime(0)).compareTo(a.createdAt ?? DateTime(0)));
    });
  }

  Future<GoalModel?> getGoalByUuid(String uuid) async =>
      _all().where((g) => g.uuid == uuid).firstOrNull;

  Future<void> updateGoal(GoalModel updated) async {
    updated.updatedAt = DateTime.now().toUtc();
    await _put(updated);
  }

  Future<void> incrementProgress(String uuid, double delta) async {
    final goal = await getGoalByUuid(uuid);
    if (goal == null || goal.status.isTerminal) return;

    goal.currentValue =
        (goal.currentValue + delta).clamp(0.0, goal.targetValue);
    goal.updatedAt = DateTime.now().toUtc();

    if (goal.currentValue >= goal.targetValue) {
      goal.status = GoalStatus.completed;
      goal.completedAt = DateTime.now().toUtc();
    }

    await _put(goal);
  }

  Future<void> completeMilestone(String goalUuid, String milestoneId) async {
    final goal = await getGoalByUuid(goalUuid);
    if (goal == null) return;

    final idx = goal.milestones.indexWhere((m) => m.id == milestoneId);
    if (idx == -1) return;

    goal.milestones[idx].isCompleted = true;
    goal.milestones[idx].completedAt = DateTime.now().toUtc();
    goal.updatedAt = DateTime.now().toUtc();
    await _put(goal);
  }

  Future<bool> deleteGoal(String uuid) async {
    final goal = await getGoalByUuid(uuid);
    if (goal == null) return false;
    return _store.deleteById('goals', goal.id);
  }
}

// ─── MoodRepository ─────────────────────────────────────────────────────────────

class MoodRepository {
  const MoodRepository(this._store);

  final WebStore _store;
  static const _moodUuid = Uuid();

  List<MoodEntryModel> _all() =>
      _mapAll(_store, 'moodEntries', MoodEntryModel.fromJson);

  Future<void> _put(MoodEntryModel entry) => _persist(
        _store,
        'moodEntries',
        entry,
        (e) => e.toJson(),
        (id) => entry.id = id,
      );

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
      localDateKey: _dateFmt.format(now.toLocal()),
      loggedAt: now,
    );
    await _put(entry);
    return entry;
  }

  Future<MoodEntryModel?> getEntryForDay(String dateKey) async =>
      _all().where((e) => e.localDateKey == dateKey).firstOrNull;

  Stream<List<MoodEntryModel>> watchRecentEntries({int days = 14}) async* {
    final cutoff = DateTime.now().toUtc().subtract(Duration(days: days));

    List<MoodEntryModel> load() {
      return _all()
          .where((e) =>
              e.loggedAt != null && e.loggedAt!.isAfter(cutoff))
          .toList()
        ..sort((a, b) =>
            (a.loggedAt ?? DateTime(0)).compareTo(b.loggedAt ?? DateTime(0)));
    }

    yield load();
    await for (final _ in _store.watchCollection('moodEntries')) {
      yield load();
    }
  }

  Future<void> updateEntry(MoodEntryModel entry) async {
    await _put(entry);
  }

  Future<bool> deleteEntry(String uuid) async {
    final entry = _all().where((e) => e.uuid == uuid).firstOrNull;
    if (entry == null) return false;
    return _store.deleteById('moodEntries', entry.id);
  }
}

// ─── ProfileRepository ──────────────────────────────────────────────────────────

class ProfileRepository {
  const ProfileRepository(this._store);

  final WebStore _store;
  static const _profileUuid = Uuid();
  static const _singletonUserId = 1;

  List<UserModel> _users() => _mapAll(_store, 'users', UserModel.fromJson);

  List<BadgeModel> _badges() => _mapAll(_store, 'badges', BadgeModel.fromJson);

  Future<void> _putUser(UserModel profile) async {
    if (profile.id == 0) profile.id = _singletonUserId;
    await _persist(
      _store,
      'users',
      profile,
      (p) => p.toJson(),
      (id) => profile.id = id,
    );
  }

  Future<void> _putBadge(BadgeModel badge) => _persist(
        _store,
        'badges',
        badge,
        (b) => b.toJson(),
        (id) => badge.id = id,
      );

  Future<UserModel> getOrCreateProfile() async {
    final users = _users();
    final existing = users.where((u) => u.id == _singletonUserId).firstOrNull ??
        users.firstOrNull;
    if (existing != null) return existing;

    final now = DateTime.now().toUtc();
    final profile = UserModel(
      uuid: _profileUuid.v4(),
      displayName: 'Student',
      xp: 0,
      level: 1,
      currentStreakDays: 0,
      pomodoroWorkMinutes: 25,
      pomodoroShortBreakMinutes: 5,
      pomodoroLongBreakMinutes: 15,
      pomodorosBeforeLongBreak: 4,
      createdAt: now,
      updatedAt: now,
    );

    profile.id = _singletonUserId;
    await _putUser(profile);
    return profile;
  }

  Stream<UserModel?> watchProfile() async* {
    UserModel? load() {
      final users = _users();
      if (users.isEmpty) return null;
      return users.where((u) => u.id == _singletonUserId).firstOrNull ??
          users.first;
    }

    yield load();
    await for (final _ in _store.watchCollection('users')) {
      yield load();
    }
  }

  Future<void> updateProfile(UserModel profile) async {
    profile.updatedAt = DateTime.now().toUtc();
    await _putUser(profile);
  }

  Future<void> addXp(int amount) async {
    final profile = await getOrCreateProfile();
    profile.xp += amount;
    profile.level = (profile.xp ~/ 100) + 1;
    profile.updatedAt = DateTime.now().toUtc();
    await _putUser(profile);
  }

  Future<void> setStreak(int days) async {
    final profile = await getOrCreateProfile();
    profile.currentStreakDays = days;
    profile.updatedAt = DateTime.now().toUtc();
    await _putUser(profile);
  }

  Stream<List<BadgeModel>> watchBadges() =>
      _watch(_store, 'badges', _badges);

  Future<void> unlockBadge(String badgeKey) async {
    final badge =
        _badges().where((b) => b.badgeKey == badgeKey).firstOrNull;
    if (badge == null || badge.isUnlocked) return;

    badge.isUnlocked = true;
    badge.unlockedAt = DateTime.now().toUtc();
    await _putBadge(badge);
  }

  Future<void> updateBadgeProgress(String badgeKey, int progress) async {
    final badge =
        _badges().where((b) => b.badgeKey == badgeKey).firstOrNull;
    if (badge == null || badge.isUnlocked) return;

    badge.currentProgress = progress;
    if (badge.currentProgress >= badge.requiredThreshold) {
      badge.isUnlocked = true;
      badge.unlockedAt = DateTime.now().toUtc();
    }
    await _putBadge(badge);
  }
}

// ─── Analytics DTOs ───────────────────────────────────────────────────────────

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
  final Map<String, int> dailyFocusMinutes;
  final int totalFocusMinutes;
  final int sessionsCompleted;
  final int tasksCompleted;
  final double averageMoodScore;
  final double averageStressLevel;
  final double averageEnergyLevel;
  final double averageSleepHours;
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

// ─── AnalyticsRepository ────────────────────────────────────────────────────────

class AnalyticsRepository {
  const AnalyticsRepository(this._store);

  final WebStore _store;

  List<GpaEntryModel> _gpaEntries() =>
      _mapAll(_store, 'gpaEntries', GpaEntryModel.fromJson);

  List<TaskModel> _tasks() => _mapAll(_store, 'tasks', TaskModel.fromJson);

  List<PomodoroSessionModel> _pomodoros() =>
      _mapAll(_store, 'pomodoroSessions', PomodoroSessionModel.fromJson);

  List<MoodEntryModel> _moods() =>
      _mapAll(_store, 'moodEntries', MoodEntryModel.fromJson);

  List<SubjectModel> _subjects() =>
      _mapAll(_store, 'subjects', SubjectModel.fromJson);

  Future<List<GpaEntryModel>> getAllGpaEntries() async => _gpaEntries();

  Future<List<GpaEntryModel>> getGpaEntriesBySemester(String semester) async =>
      _gpaEntries().where((e) => e.semesterLabel == semester).toList();

  Future<void> saveGpaEntry(GpaEntryModel entry) async {
    await _persist(
      _store,
      'gpaEntries',
      entry,
      (e) => e.toJson(),
      (id) => entry.id = id,
    );
  }

  Future<void> deleteGpaEntry(int id) async {
    await _store.deleteById('gpaEntries', id);
  }

  Future<double> calculateSGPA(String semesterLabel) async {
    final entries = await getGpaEntriesBySemester(semesterLabel);
    return _computeGPA(entries);
  }

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

  Future<List<String>> getSemesters() async {
    final all = await getAllGpaEntries();
    final labels = all.map((e) => e.semesterLabel).toSet().toList();
    labels.sort();
    return labels;
  }

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

  Future<List<SubjectPerformance>> getSubjectPerformances() async {
    final subjects = _subjects().where((s) => !s.isArchived).toList();

    final allSessions = _pomodoros()
        .where((s) => s.wasCompleted && s.mode == PomodoroMode.pomodoro)
        .toList();

    final allTasks = _tasks();
    final allGpa = await getAllGpaEntries();

    return subjects.map((subject) {
      final subjectSessions = allSessions;
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

  Future<DailyReport> getDailyReport(DateTime date) async {
    final key = _dateFmt.format(date);

    final sessions = _pomodoros()
        .where((s) => s.localDateKey == key && s.wasCompleted)
        .toList();

    final focusSessions =
        sessions.where((s) => s.mode == PomodoroMode.pomodoro).toList();
    final focusMins = focusSessions.fold<int>(
        0, (sum, s) => sum + s.actualDurationSeconds ~/ 60);

    final tasks = _tasks().where((t) => t.status == TaskStatus.done).toList();
    final tasksToday = tasks
        .where((t) => _dateFmt.format(t.updatedAt ?? DateTime(0)) == key)
        .length;

    final moodEntries = _moods().where((e) => e.localDateKey == key).toList();
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
      final sessions = _pomodoros()
          .where((s) =>
              s.localDateKey == key &&
              s.wasCompleted &&
              s.mode == PomodoroMode.pomodoro)
          .toList();
      final mins = sessions.fold<int>(
          0, (sum, s) => sum + s.actualDurationSeconds ~/ 60);
      dailyMap[key] = mins;
      totalFocus += mins;
      totalSessions += sessions.length;
    }

    final allDoneTasks =
        _tasks().where((t) => t.status == TaskStatus.done).toList();
    for (final t in allDoneTasks) {
      final updated = t.updatedAt;
      if (updated != null &&
          !updated.isBefore(weekStart) &&
          !updated.isAfter(weekEnd)) {
        totalTasks++;
      }
    }

    final moodEntries = <MoodEntryModel>[];
    for (int i = 0; i < 7; i++) {
      final key = _dateFmt.format(weekStart.add(Duration(days: i)));
      moodEntries.addAll(_moods().where((e) => e.localDateKey == key));
    }

    double avgMood = 0, avgStress = 0, avgEnergy = 0, avgSleep = 0;
    if (moodEntries.isNotEmpty) {
      avgMood = moodEntries.fold<double>(0, (s, e) => s + e.moodScore) /
          moodEntries.length;
      avgStress = moodEntries.fold<double>(0, (s, e) => s + e.stressLevel) /
          moodEntries.length;
      avgEnergy = moodEntries.fold<double>(0, (s, e) => s + e.energyLevel) /
          moodEntries.length;
      final sleepEntries = moodEntries.where((e) => e.hasSleepData).toList();
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

  Future<List<MoodCorrelation>> getMoodCorrelations() async {
    final allMood = _moods();
    if (allMood.isEmpty) return [];

    final correlations = <MoodType, _CorrelationAccumulator>{};
    final doneTasks = _tasks().where((t) => t.status == TaskStatus.done).toList();

    for (final entry in allMood) {
      final key = entry.localDateKey;
      final sessions = _pomodoros()
          .where((s) =>
              s.localDateKey == key &&
              s.wasCompleted &&
              s.mode == PomodoroMode.pomodoro)
          .toList();
      final focusMins = sessions.fold<int>(
          0, (sum, s) => sum + s.actualDurationSeconds ~/ 60);

      final tasksToday = doneTasks
          .where((t) => _dateFmt.format(t.updatedAt ?? DateTime(0)) == key)
          .length;

      correlations.putIfAbsent(entry.mood, () => _CorrelationAccumulator());
      correlations[entry.mood]!
          .add(focusMins.toDouble(), tasksToday.toDouble());
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

  double _computeProductivityScore({
    required int focusMinutes,
    required int tasksCompleted,
    required double moodScore,
    required double stressLevel,
  }) {
    const targetFocusMin = 120.0;
    const targetTasks = 5.0;

    final focusScore = (focusMinutes / targetFocusMin).clamp(0.0, 1.0) * 40;
    final taskScore = (tasksCompleted / targetTasks).clamp(0.0, 1.0) * 30;
    final moodScore_ = ((moodScore - 1) / 4).clamp(0.0, 1.0) * 20;
    final stressScore = (1 - (stressLevel - 1) / 4).clamp(0.0, 1.0) * 10;

    return focusScore + taskScore + moodScore_ + stressScore;
  }
}

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
