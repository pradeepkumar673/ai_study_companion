import 'package:collection/collection.dart';

import '../../core/enums/app_enums.dart';

DateTime? _dt(dynamic v) =>
    v == null ? null : DateTime.tryParse(v.toString());

String? _dtOut(DateTime? v) => v?.toUtc().toIso8601String();

T _enumByName<T extends Enum>(List<T> values, dynamic raw, T fallback) {
  if (raw == null) return fallback;
  return values.where((e) => e.name == raw.toString()).firstOrNull ?? fallback;
}

List<String> _strList(dynamic raw) {
  if (raw is! List) return [];
  return raw.map((e) => e.toString()).toList();
}

List<T> _listFromJson<T>(dynamic raw, T Function(JsonMap) fromJson) {
  if (raw is! List) return [];
  return raw
      .whereType<Map>()
      .map((e) => fromJson(Map<String, dynamic>.from(e)))
      .toList();
}

List<JsonMap> _listToJson<T>(List<T> items, JsonMap Function(T) toJson) =>
    items.map(toJson).toList();

// ─── Web-only enums ───────────────────────────────────────────────────────────

enum FocusMode { pomodoro, shortFocus, deepWork, custom }

enum SessionStatus { active, completed, abandoned }

enum EventType { lecture, study, exam, assignment, personal, other }

enum RecurrenceType { none, daily, weekly, biweekly, monthly }

enum GradeScale {
  tenPoint,
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

// ─── Embedded / helper types ─────────────────────────────────────────────────

class SubtaskModel {
  SubtaskModel({
    this.id = '',
    this.title = '',
    this.isCompleted = false,
    this.position = 0,
    this.createdAt,
    this.completedAt,
  });

  String id;
  String title;
  bool isCompleted;
  int position;
  DateTime? createdAt;
  DateTime? completedAt;

  factory SubtaskModel.fromJson(JsonMap j) => SubtaskModel(
        id: j['id']?.toString() ?? '',
        title: j['title']?.toString() ?? '',
        isCompleted: j['isCompleted'] == true,
        position: (j['position'] as num?)?.toInt() ?? 0,
        createdAt: _dt(j['createdAt']),
        completedAt: _dt(j['completedAt']),
      );

  JsonMap toJson() => {
        'id': id,
        'title': title,
        'isCompleted': isCompleted,
        'position': position,
        'createdAt': _dtOut(createdAt),
        'completedAt': _dtOut(completedAt),
      };
}

class StudyReminderConfig {
  StudyReminderConfig({
    this.isEnabled = true,
    this.hour = 20,
    this.minute = 0,
    this.notificationId = 9999,
  });

  bool isEnabled;
  int hour;
  int minute;
  int notificationId;

  factory StudyReminderConfig.fromJson(JsonMap j) => StudyReminderConfig(
        isEnabled: j['isEnabled'] != false,
        hour: (j['hour'] as num?)?.toInt() ?? 20,
        minute: (j['minute'] as num?)?.toInt() ?? 0,
        notificationId: (j['notificationId'] as num?)?.toInt() ?? 9999,
      );

  JsonMap toJson() => {
        'isEnabled': isEnabled,
        'hour': hour,
        'minute': minute,
        'notificationId': notificationId,
      };
}

class GoalMilestone {
  GoalMilestone({
    this.id = '',
    this.title = '',
    this.isCompleted = false,
    this.targetDate,
    this.completedAt,
    this.position = 0,
  });

  String id;
  String title;
  bool isCompleted;
  DateTime? targetDate;
  DateTime? completedAt;
  int position;

  factory GoalMilestone.fromJson(JsonMap j) => GoalMilestone(
        id: j['id']?.toString() ?? '',
        title: j['title']?.toString() ?? '',
        isCompleted: j['isCompleted'] == true,
        targetDate: _dt(j['targetDate']),
        completedAt: _dt(j['completedAt']),
        position: (j['position'] as num?)?.toInt() ?? 0,
      );

  JsonMap toJson() => {
        'id': id,
        'title': title,
        'isCompleted': isCompleted,
        'targetDate': _dtOut(targetDate),
        'completedAt': _dtOut(completedAt),
        'position': position,
      };
}

class ScheduleSlot {
  ScheduleSlot({
    this.weekday = 1,
    this.startHour = 9,
    this.startMinute = 0,
    this.durationMinutes = 60,
    this.room = '',
    this.instructor = '',
  });

  int weekday;
  int startHour;
  int startMinute;
  int durationMinutes;
  String room;
  String instructor;

  factory ScheduleSlot.fromJson(JsonMap j) => ScheduleSlot(
        weekday: (j['weekday'] as num?)?.toInt() ?? 1,
        startHour: (j['startHour'] as num?)?.toInt() ?? 9,
        startMinute: (j['startMinute'] as num?)?.toInt() ?? 0,
        durationMinutes: (j['durationMinutes'] as num?)?.toInt() ?? 60,
        room: j['room']?.toString() ?? '',
        instructor: j['instructor']?.toString() ?? '',
      );

  JsonMap toJson() => {
        'weekday': weekday,
        'startHour': startHour,
        'startMinute': startMinute,
        'durationMinutes': durationMinutes,
        'room': room,
        'instructor': instructor,
      };
}

typedef JsonMap = Map<String, dynamic>;

// ─── TaskModel ────────────────────────────────────────────────────────────────

class TaskModel {
  TaskModel({
    this.id = 0,
    required this.uuid,
    required this.title,
    this.description = '',
    this.priority = Priority.medium,
    this.status = TaskStatus.todo,
    this.deadline,
    this.localDeadlineKey,
    this.reminderAt,
    this.repeatFrequency = RepeatFrequency.none,
    this.isRecurring = false,
    this.estimatedMinutes = 30,
    this.actualMinutes,
    this.subjectId = '',
    this.tags = const [],
    this.subtasks = const [],
    this.notificationId,
    this.completedAt,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String uuid;
  String title;
  String description;
  Priority priority;
  TaskStatus status;
  DateTime? deadline;
  String? localDeadlineKey;
  DateTime? reminderAt;
  RepeatFrequency repeatFrequency;
  bool isRecurring;
  int estimatedMinutes;
  int? actualMinutes;
  String subjectId;
  List<String> tags;
  List<SubtaskModel> subtasks;
  int? notificationId;
  DateTime? completedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  bool get isCompleted => status == TaskStatus.done;

  bool get isOverdue =>
      deadline != null &&
      deadline!.isBefore(DateTime.now().toUtc()) &&
      !isCompleted;

  int get completedSubtaskCount => subtasks.where((s) => s.isCompleted).length;

  double get subtaskProgress =>
      subtasks.isEmpty ? 0.0 : completedSubtaskCount / subtasks.length;

  bool get allSubtasksDone =>
      subtasks.isNotEmpty && subtasks.every((s) => s.isCompleted);

  int get daysUntilDeadline =>
      deadline?.difference(DateTime.now()).inDays ?? 999;

  factory TaskModel.fromJson(JsonMap j) => TaskModel(
        id: (j['id'] as num?)?.toInt() ?? 0,
        uuid: j['uuid']?.toString() ?? '',
        title: j['title']?.toString() ?? '',
        description: j['description']?.toString() ?? '',
        priority: _enumByName(
            Priority.values, j['priority'], Priority.medium),
        status: _enumByName(TaskStatus.values, j['status'], TaskStatus.todo),
        deadline: _dt(j['deadline']),
        localDeadlineKey: j['localDeadlineKey']?.toString(),
        reminderAt: _dt(j['reminderAt']),
        repeatFrequency: _enumByName(
            RepeatFrequency.values, j['repeatFrequency'], RepeatFrequency.none),
        isRecurring: j['isRecurring'] == true,
        estimatedMinutes: (j['estimatedMinutes'] as num?)?.toInt() ?? 30,
        actualMinutes: (j['actualMinutes'] as num?)?.toInt(),
        subjectId: j['subjectId']?.toString() ?? '',
        tags: _strList(j['tags']),
        subtasks: _listFromJson(j['subtasks'], SubtaskModel.fromJson),
        notificationId: (j['notificationId'] as num?)?.toInt(),
        completedAt: _dt(j['completedAt']),
        createdAt: _dt(j['createdAt']),
        updatedAt: _dt(j['updatedAt']),
      );

  JsonMap toJson() => {
        'id': id,
        'uuid': uuid,
        'title': title,
        'description': description,
        'priority': priority.name,
        'status': status.name,
        'deadline': _dtOut(deadline),
        'localDeadlineKey': localDeadlineKey,
        'reminderAt': _dtOut(reminderAt),
        'repeatFrequency': repeatFrequency.name,
        'isRecurring': isRecurring,
        'estimatedMinutes': estimatedMinutes,
        'actualMinutes': actualMinutes,
        'subjectId': subjectId,
        'tags': tags,
        'subtasks': _listToJson(subtasks, (s) => s.toJson()),
        'notificationId': notificationId,
        'completedAt': _dtOut(completedAt),
        'createdAt': _dtOut(createdAt),
        'updatedAt': _dtOut(updatedAt),
      };
}

// ─── UserModel ────────────────────────────────────────────────────────────────

class UserModel {
  UserModel({
    this.id = 0,
    this.uuid = '',
    this.displayName = '',
    this.email = '',
    this.avatarPath = '',
    this.bio = '',
    this.institutionName = '',
    this.gradeOrYear = '',
    this.fieldOfStudy = '',
    this.xp = 0,
    this.level = 1,
    this.currentStreakDays = 0,
    this.longestStreakDays = 0,
    this.lastActiveDate,
    this.totalTasksCompleted = 0,
    this.totalFocusMinutes = 0,
    this.totalNotesCreated = 0,
    this.totalFlashcardsReviewed = 0,
    this.totalQuizzesTaken = 0,
    this.earnedBadgeKeys = const [],
    this.prefersDarkMode = false,
    this.dailyFocusGoalMinutes = 120,
    this.dailyTaskGoalCount = 5,
    this.weeklyFocusGoalMinutes = 600,
    this.pomodoroWorkMinutes = 25,
    this.pomodoroShortBreakMinutes = 5,
    this.pomodoroLongBreakMinutes = 15,
    this.pomodorosBeforeLongBreak = 4,
    this.studyReminder,
    this.hasCompletedOnboarding = false,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String uuid;
  String displayName;
  String email;
  String avatarPath;
  String bio;
  String institutionName;
  String gradeOrYear;
  String fieldOfStudy;
  int xp;
  int level;
  int currentStreakDays;
  int longestStreakDays;
  DateTime? lastActiveDate;
  int totalTasksCompleted;
  int totalFocusMinutes;
  int totalNotesCreated;
  int totalFlashcardsReviewed;
  int totalQuizzesTaken;
  List<String> earnedBadgeKeys;
  bool prefersDarkMode;
  int dailyFocusGoalMinutes;
  int dailyTaskGoalCount;
  int weeklyFocusGoalMinutes;
  int pomodoroWorkMinutes;
  int pomodoroShortBreakMinutes;
  int pomodoroLongBreakMinutes;
  int pomodorosBeforeLongBreak;
  StudyReminderConfig? studyReminder;
  bool hasCompletedOnboarding;
  DateTime? createdAt;
  DateTime? updatedAt;

  int get xpForNextLevel => level * level * 100;

  bool get hasAvatar => avatarPath.isNotEmpty;

  String get initials {
    final parts = displayName.trim().split(' ');
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  double get xpProgressToNextLevel {
    final threshold = xpForNextLevel;
    return threshold == 0 ? 0.0 : (xp % threshold) / threshold;
  }

  factory UserModel.fromJson(JsonMap j) => UserModel(
        id: (j['id'] as num?)?.toInt() ?? 0,
        uuid: j['uuid']?.toString() ?? '',
        displayName: j['displayName']?.toString() ?? '',
        email: j['email']?.toString() ?? '',
        avatarPath: j['avatarPath']?.toString() ?? '',
        bio: j['bio']?.toString() ?? '',
        institutionName: j['institutionName']?.toString() ?? '',
        gradeOrYear: j['gradeOrYear']?.toString() ?? '',
        fieldOfStudy: j['fieldOfStudy']?.toString() ?? '',
        xp: (j['xp'] as num?)?.toInt() ?? 0,
        level: (j['level'] as num?)?.toInt() ?? 1,
        currentStreakDays: (j['currentStreakDays'] as num?)?.toInt() ?? 0,
        longestStreakDays: (j['longestStreakDays'] as num?)?.toInt() ?? 0,
        lastActiveDate: _dt(j['lastActiveDate']),
        totalTasksCompleted: (j['totalTasksCompleted'] as num?)?.toInt() ?? 0,
        totalFocusMinutes: (j['totalFocusMinutes'] as num?)?.toInt() ?? 0,
        totalNotesCreated: (j['totalNotesCreated'] as num?)?.toInt() ?? 0,
        totalFlashcardsReviewed:
            (j['totalFlashcardsReviewed'] as num?)?.toInt() ?? 0,
        totalQuizzesTaken: (j['totalQuizzesTaken'] as num?)?.toInt() ?? 0,
        earnedBadgeKeys: _strList(j['earnedBadgeKeys']),
        prefersDarkMode: j['prefersDarkMode'] == true,
        dailyFocusGoalMinutes:
            (j['dailyFocusGoalMinutes'] as num?)?.toInt() ?? 120,
        dailyTaskGoalCount: (j['dailyTaskGoalCount'] as num?)?.toInt() ?? 5,
        weeklyFocusGoalMinutes:
            (j['weeklyFocusGoalMinutes'] as num?)?.toInt() ?? 600,
        pomodoroWorkMinutes: (j['pomodoroWorkMinutes'] as num?)?.toInt() ?? 25,
        pomodoroShortBreakMinutes:
            (j['pomodoroShortBreakMinutes'] as num?)?.toInt() ?? 5,
        pomodoroLongBreakMinutes:
            (j['pomodoroLongBreakMinutes'] as num?)?.toInt() ?? 15,
        pomodorosBeforeLongBreak:
            (j['pomodorosBeforeLongBreak'] as num?)?.toInt() ?? 4,
        studyReminder: j['studyReminder'] is Map
            ? StudyReminderConfig.fromJson(
                Map<String, dynamic>.from(j['studyReminder'] as Map))
            : null,
        hasCompletedOnboarding: j['hasCompletedOnboarding'] == true,
        createdAt: _dt(j['createdAt']),
        updatedAt: _dt(j['updatedAt']),
      );

  JsonMap toJson() => {
        'id': id,
        'uuid': uuid,
        'displayName': displayName,
        'email': email,
        'avatarPath': avatarPath,
        'bio': bio,
        'institutionName': institutionName,
        'gradeOrYear': gradeOrYear,
        'fieldOfStudy': fieldOfStudy,
        'xp': xp,
        'level': level,
        'currentStreakDays': currentStreakDays,
        'longestStreakDays': longestStreakDays,
        'lastActiveDate': _dtOut(lastActiveDate),
        'totalTasksCompleted': totalTasksCompleted,
        'totalFocusMinutes': totalFocusMinutes,
        'totalNotesCreated': totalNotesCreated,
        'totalFlashcardsReviewed': totalFlashcardsReviewed,
        'totalQuizzesTaken': totalQuizzesTaken,
        'earnedBadgeKeys': earnedBadgeKeys,
        'prefersDarkMode': prefersDarkMode,
        'dailyFocusGoalMinutes': dailyFocusGoalMinutes,
        'dailyTaskGoalCount': dailyTaskGoalCount,
        'weeklyFocusGoalMinutes': weeklyFocusGoalMinutes,
        'pomodoroWorkMinutes': pomodoroWorkMinutes,
        'pomodoroShortBreakMinutes': pomodoroShortBreakMinutes,
        'pomodoroLongBreakMinutes': pomodoroLongBreakMinutes,
        'pomodorosBeforeLongBreak': pomodorosBeforeLongBreak,
        'studyReminder': studyReminder?.toJson(),
        'hasCompletedOnboarding': hasCompletedOnboarding,
        'createdAt': _dtOut(createdAt),
        'updatedAt': _dtOut(updatedAt),
      };
}

// ─── BadgeModel ───────────────────────────────────────────────────────────────

class BadgeModel {
  BadgeModel({
    this.id = 0,
    this.uuid = '',
    this.badgeKey = '',
    this.title = '',
    this.description = '',
    this.category = BadgeCategory.tasks,
    this.iconName = 'star',
    this.colorHex = '#FFD700',
    this.tier = 1,
    this.isUnlocked = false,
    this.isNew = false,
    this.requiredThreshold = 1,
    this.currentProgress = 0,
    this.unlockedAt,
    this.createdAt,
  });

  int id;
  String uuid;
  String badgeKey;
  String title;
  String description;
  BadgeCategory category;
  String iconName;
  String colorHex;
  int tier;
  bool isUnlocked;
  bool isNew;
  int requiredThreshold;
  int currentProgress;
  DateTime? unlockedAt;
  DateTime? createdAt;

  String get tierLabel {
    switch (tier) {
      case 1:
        return 'Bronze';
      case 2:
        return 'Silver';
      case 3:
        return 'Gold';
      case 4:
        return 'Platinum';
      default:
        return 'Special';
    }
  }

  double get progressRatio =>
      requiredThreshold == 0
          ? 0.0
          : (currentProgress / requiredThreshold).clamp(0.0, 1.0);

  factory BadgeModel.fromJson(JsonMap j) => BadgeModel(
        id: (j['id'] as num?)?.toInt() ?? 0,
        uuid: j['uuid']?.toString() ?? '',
        badgeKey: j['badgeKey']?.toString() ?? '',
        title: j['title']?.toString() ?? '',
        description: j['description']?.toString() ?? '',
        category: _enumByName(
            BadgeCategory.values, j['category'], BadgeCategory.tasks),
        iconName: j['iconName']?.toString() ?? 'star',
        colorHex: j['colorHex']?.toString() ?? '#FFD700',
        tier: (j['tier'] as num?)?.toInt() ?? 1,
        isUnlocked: j['isUnlocked'] == true,
        isNew: j['isNew'] == true,
        requiredThreshold: (j['requiredThreshold'] as num?)?.toInt() ?? 1,
        currentProgress: (j['currentProgress'] as num?)?.toInt() ?? 0,
        unlockedAt: _dt(j['unlockedAt']),
        createdAt: _dt(j['createdAt']),
      );

  JsonMap toJson() => {
        'id': id,
        'uuid': uuid,
        'badgeKey': badgeKey,
        'title': title,
        'description': description,
        'category': category.name,
        'iconName': iconName,
        'colorHex': colorHex,
        'tier': tier,
        'isUnlocked': isUnlocked,
        'isNew': isNew,
        'requiredThreshold': requiredThreshold,
        'currentProgress': currentProgress,
        'unlockedAt': _dtOut(unlockedAt),
        'createdAt': _dtOut(createdAt),
      };
}

// ─── NoteModel ────────────────────────────────────────────────────────────────

class NoteModel {
  NoteModel({
    this.id = 0,
    this.uuid = '',
    this.title = '',
    this.content = '',
    this.plainTextPreview = '',
    this.subjectId = '',
    this.color = NoteColor.white,
    this.tags = const [],
    this.isPinned = false,
    this.isArchived = false,
    this.isFavourite = false,
    this.aiSummary = '',
    this.aiSummaryGeneratedAt,
    this.attachmentPaths = const [],
    this.wordCount = 0,
    this.readingTimeSeconds = 0,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String uuid;
  String title;
  String content;
  String plainTextPreview;
  String subjectId;
  NoteColor color;
  List<String> tags;
  bool isPinned;
  bool isArchived;
  bool isFavourite;
  String aiSummary;
  DateTime? aiSummaryGeneratedAt;
  List<String> attachmentPaths;
  int wordCount;
  int readingTimeSeconds;
  DateTime? createdAt;
  DateTime? updatedAt;

  bool get hasAiSummary => aiSummary.isNotEmpty;

  bool get isAiSummaryStale =>
      aiSummaryGeneratedAt != null &&
      DateTime.now().toUtc().difference(aiSummaryGeneratedAt!).inDays > 7;

  factory NoteModel.fromJson(JsonMap j) => NoteModel(
        id: (j['id'] as num?)?.toInt() ?? 0,
        uuid: j['uuid']?.toString() ?? '',
        title: j['title']?.toString() ?? '',
        content: j['content']?.toString() ?? '',
        plainTextPreview: j['plainTextPreview']?.toString() ?? '',
        subjectId: j['subjectId']?.toString() ?? '',
        color: _enumByName(NoteColor.values, j['color'], NoteColor.white),
        tags: _strList(j['tags']),
        isPinned: j['isPinned'] == true,
        isArchived: j['isArchived'] == true,
        isFavourite: j['isFavourite'] == true,
        aiSummary: j['aiSummary']?.toString() ?? '',
        aiSummaryGeneratedAt: _dt(j['aiSummaryGeneratedAt']),
        attachmentPaths: _strList(j['attachmentPaths']),
        wordCount: (j['wordCount'] as num?)?.toInt() ?? 0,
        readingTimeSeconds: (j['readingTimeSeconds'] as num?)?.toInt() ?? 0,
        createdAt: _dt(j['createdAt']),
        updatedAt: _dt(j['updatedAt']),
      );

  JsonMap toJson() => {
        'id': id,
        'uuid': uuid,
        'title': title,
        'content': content,
        'plainTextPreview': plainTextPreview,
        'subjectId': subjectId,
        'color': color.name,
        'tags': tags,
        'isPinned': isPinned,
        'isArchived': isArchived,
        'isFavourite': isFavourite,
        'aiSummary': aiSummary,
        'aiSummaryGeneratedAt': _dtOut(aiSummaryGeneratedAt),
        'attachmentPaths': attachmentPaths,
        'wordCount': wordCount,
        'readingTimeSeconds': readingTimeSeconds,
        'createdAt': _dtOut(createdAt),
        'updatedAt': _dtOut(updatedAt),
      };
}

// ─── PomodoroSessionModel ─────────────────────────────────────────────────────

class PomodoroSessionModel {
  PomodoroSessionModel({
    this.id = 0,
    this.uuid = '',
    this.mode = PomodoroMode.pomodoro,
    this.plannedDurationSeconds = 1500,
    this.actualDurationSeconds = 0,
    this.completedAt,
    this.localDateKey = '',
    this.wasCompleted = false,
    this.linkedTaskId = '',
    this.label = '',
  });

  int id;
  String uuid;
  PomodoroMode mode;
  int plannedDurationSeconds;
  int actualDurationSeconds;
  DateTime? completedAt;
  String localDateKey;
  bool wasCompleted;
  String linkedTaskId;
  String label;

  factory PomodoroSessionModel.fromJson(JsonMap j) => PomodoroSessionModel(
        id: (j['id'] as num?)?.toInt() ?? 0,
        uuid: j['uuid']?.toString() ?? '',
        mode: _enumByName(
            PomodoroMode.values, j['mode'], PomodoroMode.pomodoro),
        plannedDurationSeconds:
            (j['plannedDurationSeconds'] as num?)?.toInt() ?? 1500,
        actualDurationSeconds:
            (j['actualDurationSeconds'] as num?)?.toInt() ?? 0,
        completedAt: _dt(j['completedAt']),
        localDateKey: j['localDateKey']?.toString() ?? '',
        wasCompleted: j['wasCompleted'] == true,
        linkedTaskId: j['linkedTaskId']?.toString() ?? '',
        label: j['label']?.toString() ?? '',
      );

  JsonMap toJson() => {
        'id': id,
        'uuid': uuid,
        'mode': mode.name,
        'plannedDurationSeconds': plannedDurationSeconds,
        'actualDurationSeconds': actualDurationSeconds,
        'completedAt': _dtOut(completedAt),
        'localDateKey': localDateKey,
        'wasCompleted': wasCompleted,
        'linkedTaskId': linkedTaskId,
        'label': label,
      };
}

// ─── FocusSessionModel ────────────────────────────────────────────────────────

class FocusSessionModel {
  FocusSessionModel({
    this.id = 0,
    this.uuid = '',
    this.mode = FocusMode.pomodoro,
    this.status = SessionStatus.completed,
    this.linkedTaskId,
    this.subject,
    this.durationMinutes = 25,
    this.actualMinutes = 0,
    this.breakMinutes = 5,
    DateTime? startedAt,
    this.completedAt,
    this.notes,
  }) : startedAt = startedAt ?? DateTime.now().toUtc();

  int id;
  String uuid;
  FocusMode mode;
  SessionStatus status;
  String? linkedTaskId;
  String? subject;
  int durationMinutes;
  int actualMinutes;
  int breakMinutes;
  DateTime startedAt;
  DateTime? completedAt;
  String? notes;

  factory FocusSessionModel.fromJson(JsonMap j) => FocusSessionModel(
        id: (j['id'] as num?)?.toInt() ?? 0,
        uuid: j['uuid']?.toString() ?? '',
        mode: _enumByName(FocusMode.values, j['mode'], FocusMode.pomodoro),
        status: _enumByName(
            SessionStatus.values, j['status'], SessionStatus.completed),
        linkedTaskId: j['linkedTaskId']?.toString(),
        subject: j['subject']?.toString(),
        durationMinutes: (j['durationMinutes'] as num?)?.toInt() ?? 25,
        actualMinutes: (j['actualMinutes'] as num?)?.toInt() ?? 0,
        breakMinutes: (j['breakMinutes'] as num?)?.toInt() ?? 5,
        startedAt: _dt(j['startedAt']) ?? DateTime.now().toUtc(),
        completedAt: _dt(j['completedAt']),
        notes: j['notes']?.toString(),
      );

  JsonMap toJson() => {
        'id': id,
        'uuid': uuid,
        'mode': mode.name,
        'status': status.name,
        'linkedTaskId': linkedTaskId,
        'subject': subject,
        'durationMinutes': durationMinutes,
        'actualMinutes': actualMinutes,
        'breakMinutes': breakMinutes,
        'startedAt': _dtOut(startedAt),
        'completedAt': _dtOut(completedAt),
        'notes': notes,
      };
}

// ─── MoodEntryModel ───────────────────────────────────────────────────────────

class MoodEntryModel {
  MoodEntryModel({
    this.id = 0,
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

  int id;
  String uuid;
  MoodType mood;
  int energyLevel;
  int stressLevel;
  double sleepHours;
  String note;
  List<String> factors;
  String localDateKey;
  DateTime? loggedAt;

  int get moodScore => mood.score;

  bool get hasSleepData => sleepHours > 0;

  factory MoodEntryModel.fromJson(JsonMap j) => MoodEntryModel(
        id: (j['id'] as num?)?.toInt() ?? 0,
        uuid: j['uuid']?.toString() ?? '',
        mood: _enumByName(MoodType.values, j['mood'], MoodType.neutral),
        energyLevel: (j['energyLevel'] as num?)?.toInt() ?? 3,
        stressLevel: (j['stressLevel'] as num?)?.toInt() ?? 3,
        sleepHours: (j['sleepHours'] as num?)?.toDouble() ?? 0.0,
        note: j['note']?.toString() ?? '',
        factors: _strList(j['factors']),
        localDateKey: j['localDateKey']?.toString() ?? '',
        loggedAt: _dt(j['loggedAt']),
      );

  JsonMap toJson() => {
        'id': id,
        'uuid': uuid,
        'mood': mood.name,
        'energyLevel': energyLevel,
        'stressLevel': stressLevel,
        'sleepHours': sleepHours,
        'note': note,
        'factors': factors,
        'localDateKey': localDateKey,
        'loggedAt': _dtOut(loggedAt),
      };
}

// ─── GoalModel ────────────────────────────────────────────────────────────────

class GoalModel {
  GoalModel({
    this.id = 0,
    this.uuid = '',
    this.title = '',
    this.description = '',
    this.subjectId = '',
    this.priority = Priority.medium,
    this.status = GoalStatus.active,
    this.repeatFrequency = RepeatFrequency.none,
    this.targetValue = 100.0,
    this.currentValue = 0.0,
    this.unit = '%',
    this.milestones = const [],
    this.linkedTaskIds = const [],
    this.tags = const [],
    this.colorHex = '#6750A4',
    this.iconName = 'target',
    this.startDate,
    this.targetDate,
    this.completedAt,
    this.reminderAt,
    this.notificationId,
    this.streakDays = 0,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String uuid;
  String title;
  String description;
  String subjectId;
  Priority priority;
  GoalStatus status;
  RepeatFrequency repeatFrequency;
  double targetValue;
  double currentValue;
  String unit;
  List<GoalMilestone> milestones;
  List<String> linkedTaskIds;
  List<String> tags;
  String colorHex;
  String iconName;
  DateTime? startDate;
  DateTime? targetDate;
  DateTime? completedAt;
  DateTime? reminderAt;
  int? notificationId;
  int streakDays;
  DateTime? createdAt;
  DateTime? updatedAt;

  double get progressRatio =>
      targetValue == 0 ? 0.0 : (currentValue / targetValue).clamp(0.0, 1.0);

  double get progressPercent => progressRatio * 100;

  int get completedMilestoneCount =>
      milestones.where((m) => m.isCompleted).length;

  bool get isCompleted => status == GoalStatus.completed;

  bool get isOverdue =>
      targetDate != null &&
      targetDate!.isBefore(DateTime.now().toUtc()) &&
      !isCompleted;

  int get daysRemaining => targetDate == null
      ? -1
      : targetDate!.difference(DateTime.now().toUtc()).inDays;

  factory GoalModel.fromJson(JsonMap j) => GoalModel(
        id: (j['id'] as num?)?.toInt() ?? 0,
        uuid: j['uuid']?.toString() ?? '',
        title: j['title']?.toString() ?? '',
        description: j['description']?.toString() ?? '',
        subjectId: j['subjectId']?.toString() ?? '',
        priority: _enumByName(
            Priority.values, j['priority'], Priority.medium),
        status: _enumByName(GoalStatus.values, j['status'], GoalStatus.active),
        repeatFrequency: _enumByName(
            RepeatFrequency.values, j['repeatFrequency'], RepeatFrequency.none),
        targetValue: (j['targetValue'] as num?)?.toDouble() ?? 100.0,
        currentValue: (j['currentValue'] as num?)?.toDouble() ?? 0.0,
        unit: j['unit']?.toString() ?? '%',
        milestones: _listFromJson(j['milestones'], GoalMilestone.fromJson),
        linkedTaskIds: _strList(j['linkedTaskIds']),
        tags: _strList(j['tags']),
        colorHex: j['colorHex']?.toString() ?? '#6750A4',
        iconName: j['iconName']?.toString() ?? 'target',
        startDate: _dt(j['startDate']),
        targetDate: _dt(j['targetDate']),
        completedAt: _dt(j['completedAt']),
        reminderAt: _dt(j['reminderAt']),
        notificationId: (j['notificationId'] as num?)?.toInt(),
        streakDays: (j['streakDays'] as num?)?.toInt() ?? 0,
        createdAt: _dt(j['createdAt']),
        updatedAt: _dt(j['updatedAt']),
      );

  JsonMap toJson() => {
        'id': id,
        'uuid': uuid,
        'title': title,
        'description': description,
        'subjectId': subjectId,
        'priority': priority.name,
        'status': status.name,
        'repeatFrequency': repeatFrequency.name,
        'targetValue': targetValue,
        'currentValue': currentValue,
        'unit': unit,
        'milestones': _listToJson(milestones, (m) => m.toJson()),
        'linkedTaskIds': linkedTaskIds,
        'tags': tags,
        'colorHex': colorHex,
        'iconName': iconName,
        'startDate': _dtOut(startDate),
        'targetDate': _dtOut(targetDate),
        'completedAt': _dtOut(completedAt),
        'reminderAt': _dtOut(reminderAt),
        'notificationId': notificationId,
        'streakDays': streakDays,
        'createdAt': _dtOut(createdAt),
        'updatedAt': _dtOut(updatedAt),
      };
}

// ─── SubjectModel ─────────────────────────────────────────────────────────────

class SubjectModel {
  SubjectModel({
    this.id = 0,
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

  int id;
  String uuid;
  String name;
  String code;
  SubjectType subjectType;
  String colorHex;
  String iconName;
  String instructor;
  int credits;
  int targetAttendancePercent;
  String semesterLabel;
  List<ScheduleSlot> scheduleSlots;
  bool isArchived;
  String notes;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory SubjectModel.fromJson(JsonMap j) => SubjectModel(
        id: (j['id'] as num?)?.toInt() ?? 0,
        uuid: j['uuid']?.toString() ?? '',
        name: j['name']?.toString() ?? '',
        code: j['code']?.toString() ?? '',
        subjectType: _enumByName(
            SubjectType.values, j['subjectType'], SubjectType.other),
        colorHex: j['colorHex']?.toString() ?? '#6750A4',
        iconName: j['iconName']?.toString() ?? 'book',
        instructor: j['instructor']?.toString() ?? '',
        credits: (j['credits'] as num?)?.toInt() ?? 0,
        targetAttendancePercent:
            (j['targetAttendancePercent'] as num?)?.toInt() ?? 75,
        semesterLabel: j['semesterLabel']?.toString() ?? '',
        scheduleSlots:
            _listFromJson(j['scheduleSlots'], ScheduleSlot.fromJson),
        isArchived: j['isArchived'] == true,
        notes: j['notes']?.toString() ?? '',
        createdAt: _dt(j['createdAt']),
        updatedAt: _dt(j['updatedAt']),
      );

  JsonMap toJson() => {
        'id': id,
        'uuid': uuid,
        'name': name,
        'code': code,
        'subjectType': subjectType.name,
        'colorHex': colorHex,
        'iconName': iconName,
        'instructor': instructor,
        'credits': credits,
        'targetAttendancePercent': targetAttendancePercent,
        'semesterLabel': semesterLabel,
        'scheduleSlots': _listToJson(scheduleSlots, (s) => s.toJson()),
        'isArchived': isArchived,
        'notes': notes,
        'createdAt': _dtOut(createdAt),
        'updatedAt': _dtOut(updatedAt),
      };
}

// ─── AttendanceModel ──────────────────────────────────────────────────────────

class AttendanceModel {
  AttendanceModel({
    this.id = 0,
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

  int id;
  String uuid;
  String subjectId;
  String subjectName;
  AttendanceStatus attendanceStatus;
  DateTime? classDate;
  String startTime;
  String endTime;
  String topic;
  String room;
  String notes;
  bool isExtraClass;
  String localDateKey;
  DateTime? createdAt;
  DateTime? updatedAt;

  bool get isPresent => attendanceStatus.countsAsPresent;

  factory AttendanceModel.fromJson(JsonMap j) => AttendanceModel(
        id: (j['id'] as num?)?.toInt() ?? 0,
        uuid: j['uuid']?.toString() ?? '',
        subjectId: j['subjectId']?.toString() ?? '',
        subjectName: j['subjectName']?.toString() ?? '',
        attendanceStatus: _enumByName(AttendanceStatus.values,
            j['attendanceStatus'], AttendanceStatus.present),
        classDate: _dt(j['classDate']),
        startTime: j['startTime']?.toString() ?? '',
        endTime: j['endTime']?.toString() ?? '',
        topic: j['topic']?.toString() ?? '',
        room: j['room']?.toString() ?? '',
        notes: j['notes']?.toString() ?? '',
        isExtraClass: j['isExtraClass'] == true,
        localDateKey: j['localDateKey']?.toString() ?? '',
        createdAt: _dt(j['createdAt']),
        updatedAt: _dt(j['updatedAt']),
      );

  JsonMap toJson() => {
        'id': id,
        'uuid': uuid,
        'subjectId': subjectId,
        'subjectName': subjectName,
        'attendanceStatus': attendanceStatus.name,
        'classDate': _dtOut(classDate),
        'startTime': startTime,
        'endTime': endTime,
        'topic': topic,
        'room': room,
        'notes': notes,
        'isExtraClass': isExtraClass,
        'localDateKey': localDateKey,
        'createdAt': _dtOut(createdAt),
        'updatedAt': _dtOut(updatedAt),
      };
}

// ─── ScheduleEventModel ───────────────────────────────────────────────────────

class ScheduleEventModel {
  ScheduleEventModel({
    this.id = 0,
    this.uuid = '',
    this.title = '',
    this.description,
    this.location,
    this.subject,
    this.subjectColor,
    this.type = EventType.lecture,
    this.recurrence = RecurrenceType.none,
    DateTime? startTime,
    DateTime? endTime,
    this.hasReminder = true,
    this.reminderMinutesBefore = 15,
    this.attendees = const [],
    DateTime? createdAt,
  })  : startTime = startTime ?? DateTime.now().toUtc(),
        endTime = endTime ?? DateTime.now().toUtc(),
        createdAt = createdAt ?? DateTime.now().toUtc();

  int id;
  String uuid;
  String title;
  String? description;
  String? location;
  String? subject;
  String? subjectColor;
  EventType type;
  RecurrenceType recurrence;
  DateTime startTime;
  DateTime endTime;
  bool hasReminder;
  int reminderMinutesBefore;
  List<String> attendees;
  DateTime createdAt;

  factory ScheduleEventModel.fromJson(JsonMap j) => ScheduleEventModel(
        id: (j['id'] as num?)?.toInt() ?? 0,
        uuid: j['uuid']?.toString() ?? '',
        title: j['title']?.toString() ?? '',
        description: j['description']?.toString(),
        location: j['location']?.toString(),
        subject: j['subject']?.toString(),
        subjectColor: j['subjectColor']?.toString(),
        type: _enumByName(EventType.values, j['type'], EventType.lecture),
        recurrence: _enumByName(
            RecurrenceType.values, j['recurrence'], RecurrenceType.none),
        startTime: _dt(j['startTime']) ?? DateTime.now().toUtc(),
        endTime: _dt(j['endTime']) ?? DateTime.now().toUtc(),
        hasReminder: j['hasReminder'] != false,
        reminderMinutesBefore:
            (j['reminderMinutesBefore'] as num?)?.toInt() ?? 15,
        attendees: _strList(j['attendees']),
        createdAt: _dt(j['createdAt']) ?? DateTime.now().toUtc(),
      );

  JsonMap toJson() => {
        'id': id,
        'uuid': uuid,
        'title': title,
        'description': description,
        'location': location,
        'subject': subject,
        'subjectColor': subjectColor,
        'type': type.name,
        'recurrence': recurrence.name,
        'startTime': _dtOut(startTime),
        'endTime': _dtOut(endTime),
        'hasReminder': hasReminder,
        'reminderMinutesBefore': reminderMinutesBefore,
        'attendees': attendees,
        'createdAt': _dtOut(createdAt),
      };
}

// ─── FlashcardModel ───────────────────────────────────────────────────────────

class FlashcardModel {
  FlashcardModel({
    this.id = 0,
    this.uuid = '',
    this.deckId = '',
    this.subjectId = '',
    this.front = '',
    this.back = '',
    this.hint = '',
    this.frontImagePath = '',
    this.backImagePath = '',
    this.tags = const [],
    this.easeFactor = 2.5,
    this.interval = 1,
    this.repetitions = 0,
    this.totalReviews = 0,
    this.correctReviews = 0,
    this.isSuspended = false,
    this.nextReviewAt,
    this.lastReviewedAt,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String uuid;
  String deckId;
  String subjectId;
  String front;
  String back;
  String hint;
  String frontImagePath;
  String backImagePath;
  List<String> tags;
  double easeFactor;
  int interval;
  int repetitions;
  int totalReviews;
  int correctReviews;
  bool isSuspended;
  DateTime? nextReviewAt;
  DateTime? lastReviewedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  double get accuracy =>
      totalReviews == 0 ? 0.0 : correctReviews / totalReviews;

  bool get isDueToday =>
      nextReviewAt != null &&
      !nextReviewAt!.isAfter(DateTime.now().toUtc());

  void updateSm2(FlashcardDifficulty difficulty) {
    final q = difficulty.sm2Quality;
    totalReviews++;

    if (q >= 3) {
      correctReviews++;
      if (repetitions == 0) {
        interval = 1;
      } else if (repetitions == 1) {
        interval = 6;
      } else {
        interval = (interval * easeFactor).round();
      }
      repetitions++;
    } else {
      repetitions = 0;
      interval = 1;
    }

    easeFactor = (easeFactor + 0.1 - (5 - q) * (0.08 + (5 - q) * 0.02))
        .clamp(1.3, double.infinity);

    lastReviewedAt = DateTime.now().toUtc();
    nextReviewAt = DateTime.now().toUtc().add(Duration(days: interval));
    updatedAt = DateTime.now().toUtc();
  }

  factory FlashcardModel.fromJson(JsonMap j) => FlashcardModel(
        id: (j['id'] as num?)?.toInt() ?? 0,
        uuid: j['uuid']?.toString() ?? '',
        deckId: j['deckId']?.toString() ?? '',
        subjectId: j['subjectId']?.toString() ?? '',
        front: j['front']?.toString() ?? '',
        back: j['back']?.toString() ?? '',
        hint: j['hint']?.toString() ?? '',
        frontImagePath: j['frontImagePath']?.toString() ?? '',
        backImagePath: j['backImagePath']?.toString() ?? '',
        tags: _strList(j['tags']),
        easeFactor: (j['easeFactor'] as num?)?.toDouble() ?? 2.5,
        interval: (j['interval'] as num?)?.toInt() ?? 1,
        repetitions: (j['repetitions'] as num?)?.toInt() ?? 0,
        totalReviews: (j['totalReviews'] as num?)?.toInt() ?? 0,
        correctReviews: (j['correctReviews'] as num?)?.toInt() ?? 0,
        isSuspended: j['isSuspended'] == true,
        nextReviewAt: _dt(j['nextReviewAt']),
        lastReviewedAt: _dt(j['lastReviewedAt']),
        createdAt: _dt(j['createdAt']),
        updatedAt: _dt(j['updatedAt']),
      );

  JsonMap toJson() => {
        'id': id,
        'uuid': uuid,
        'deckId': deckId,
        'subjectId': subjectId,
        'front': front,
        'back': back,
        'hint': hint,
        'frontImagePath': frontImagePath,
        'backImagePath': backImagePath,
        'tags': tags,
        'easeFactor': easeFactor,
        'interval': interval,
        'repetitions': repetitions,
        'totalReviews': totalReviews,
        'correctReviews': correctReviews,
        'isSuspended': isSuspended,
        'nextReviewAt': _dtOut(nextReviewAt),
        'lastReviewedAt': _dtOut(lastReviewedAt),
        'createdAt': _dtOut(createdAt),
        'updatedAt': _dtOut(updatedAt),
      };
}

// ─── FlashcardDeckModel ───────────────────────────────────────────────────────

class FlashcardDeckModel {
  FlashcardDeckModel({
    this.id = 0,
    this.uuid = '',
    this.title = '',
    this.description = '',
    this.subjectId = '',
    this.colorHex = '#6750A4',
    this.coverEmoji = '📚',
    this.tags = const [],
    this.totalCards = 0,
    this.masteredCards = 0,
    this.isArchived = false,
    this.lastStudiedAt,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String uuid;
  String title;
  String description;
  String subjectId;
  String colorHex;
  String coverEmoji;
  List<String> tags;
  int totalCards;
  int masteredCards;
  bool isArchived;
  DateTime? lastStudiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  double get masteryPercent =>
      totalCards == 0 ? 0.0 : masteredCards / totalCards;

  factory FlashcardDeckModel.fromJson(JsonMap j) => FlashcardDeckModel(
        id: (j['id'] as num?)?.toInt() ?? 0,
        uuid: j['uuid']?.toString() ?? '',
        title: j['title']?.toString() ?? '',
        description: j['description']?.toString() ?? '',
        subjectId: j['subjectId']?.toString() ?? '',
        colorHex: j['colorHex']?.toString() ?? '#6750A4',
        coverEmoji: j['coverEmoji']?.toString() ?? '📚',
        tags: _strList(j['tags']),
        totalCards: (j['totalCards'] as num?)?.toInt() ?? 0,
        masteredCards: (j['masteredCards'] as num?)?.toInt() ?? 0,
        isArchived: j['isArchived'] == true,
        lastStudiedAt: _dt(j['lastStudiedAt']),
        createdAt: _dt(j['createdAt']),
        updatedAt: _dt(j['updatedAt']),
      );

  JsonMap toJson() => {
        'id': id,
        'uuid': uuid,
        'title': title,
        'description': description,
        'subjectId': subjectId,
        'colorHex': colorHex,
        'coverEmoji': coverEmoji,
        'tags': tags,
        'totalCards': totalCards,
        'masteredCards': masteredCards,
        'isArchived': isArchived,
        'lastStudiedAt': _dtOut(lastStudiedAt),
        'createdAt': _dtOut(createdAt),
        'updatedAt': _dtOut(updatedAt),
      };
}

// ─── Quiz models ──────────────────────────────────────────────────────────────

class QuizOptionModel {
  QuizOptionModel({
    this.id = '',
    this.text = '',
    this.isCorrect = false,
    this.explanation = '',
  });

  String id;
  String text;
  bool isCorrect;
  String explanation;

  factory QuizOptionModel.fromJson(JsonMap j) => QuizOptionModel(
        id: j['id']?.toString() ?? '',
        text: j['text']?.toString() ?? '',
        isCorrect: j['isCorrect'] == true,
        explanation: j['explanation']?.toString() ?? '',
      );

  JsonMap toJson() => {
        'id': id,
        'text': text,
        'isCorrect': isCorrect,
        'explanation': explanation,
      };
}

class QuizQuestionModel {
  QuizQuestionModel({
    this.id = 0,
    this.uuid = '',
    this.quizId = '',
    this.subjectId = '',
    this.questionType = QuizQuestionType.multipleChoice,
    this.questionText = '',
    this.options = const [],
    this.correctAnswer = '',
    this.explanation = '',
    this.difficultyScore = 1,
    this.sourceNoteId = '',
    this.position = 0,
    this.imagePathQuestion = '',
    this.timeLimitSeconds = 0,
    this.tags = const [],
    this.createdAt,
  });

  int id;
  String uuid;
  String quizId;
  String subjectId;
  QuizQuestionType questionType;
  String questionText;
  List<QuizOptionModel> options;
  String correctAnswer;
  String explanation;
  int difficultyScore;
  String sourceNoteId;
  int position;
  String imagePathQuestion;
  int timeLimitSeconds;
  List<String> tags;
  DateTime? createdAt;

  factory QuizQuestionModel.fromJson(JsonMap j) => QuizQuestionModel(
        id: (j['id'] as num?)?.toInt() ?? 0,
        uuid: j['uuid']?.toString() ?? '',
        quizId: j['quizId']?.toString() ?? '',
        subjectId: j['subjectId']?.toString() ?? '',
        questionType: _enumByName(QuizQuestionType.values, j['questionType'],
            QuizQuestionType.multipleChoice),
        questionText: j['questionText']?.toString() ?? '',
        options: _listFromJson(j['options'], QuizOptionModel.fromJson),
        correctAnswer: j['correctAnswer']?.toString() ?? '',
        explanation: j['explanation']?.toString() ?? '',
        difficultyScore: (j['difficultyScore'] as num?)?.toInt() ?? 1,
        sourceNoteId: j['sourceNoteId']?.toString() ?? '',
        position: (j['position'] as num?)?.toInt() ?? 0,
        imagePathQuestion: j['imagePathQuestion']?.toString() ?? '',
        timeLimitSeconds: (j['timeLimitSeconds'] as num?)?.toInt() ?? 0,
        tags: _strList(j['tags']),
        createdAt: _dt(j['createdAt']),
      );

  JsonMap toJson() => {
        'id': id,
        'uuid': uuid,
        'quizId': quizId,
        'subjectId': subjectId,
        'questionType': questionType.name,
        'questionText': questionText,
        'options': _listToJson(options, (o) => o.toJson()),
        'correctAnswer': correctAnswer,
        'explanation': explanation,
        'difficultyScore': difficultyScore,
        'sourceNoteId': sourceNoteId,
        'position': position,
        'imagePathQuestion': imagePathQuestion,
        'timeLimitSeconds': timeLimitSeconds,
        'tags': tags,
        'createdAt': _dtOut(createdAt),
      };
}

class QuizAttemptAnswerModel {
  QuizAttemptAnswerModel({
    this.questionUuid = '',
    this.chosenOptionId = '',
    this.chosenText = '',
    this.isCorrect = false,
    this.timeTakenSeconds = 0,
  });

  String questionUuid;
  String chosenOptionId;
  String chosenText;
  bool isCorrect;
  int timeTakenSeconds;

  factory QuizAttemptAnswerModel.fromJson(JsonMap j) => QuizAttemptAnswerModel(
        questionUuid: j['questionUuid']?.toString() ?? '',
        chosenOptionId: j['chosenOptionId']?.toString() ?? '',
        chosenText: j['chosenText']?.toString() ?? '',
        isCorrect: j['isCorrect'] == true,
        timeTakenSeconds: (j['timeTakenSeconds'] as num?)?.toInt() ?? 0,
      );

  JsonMap toJson() => {
        'questionUuid': questionUuid,
        'chosenOptionId': chosenOptionId,
        'chosenText': chosenText,
        'isCorrect': isCorrect,
        'timeTakenSeconds': timeTakenSeconds,
      };
}

class QuizAttemptModel {
  QuizAttemptModel({
    this.id = 0,
    this.uuid = '',
    this.quizId = '',
    this.answers = const [],
    this.score = 0,
    this.totalQuestions = 0,
    this.durationSeconds = 0,
    this.startedAt,
    this.completedAt,
  });

  int id;
  String uuid;
  String quizId;
  List<QuizAttemptAnswerModel> answers;
  int score;
  int totalQuestions;
  int durationSeconds;
  DateTime? startedAt;
  DateTime? completedAt;

  double get scorePercent =>
      totalQuestions == 0 ? 0.0 : score / totalQuestions;

  bool get isPassed => scorePercent >= 0.6;

  factory QuizAttemptModel.fromJson(JsonMap j) => QuizAttemptModel(
        id: (j['id'] as num?)?.toInt() ?? 0,
        uuid: j['uuid']?.toString() ?? '',
        quizId: j['quizId']?.toString() ?? '',
        answers: _listFromJson(j['answers'], QuizAttemptAnswerModel.fromJson),
        score: (j['score'] as num?)?.toInt() ?? 0,
        totalQuestions: (j['totalQuestions'] as num?)?.toInt() ?? 0,
        durationSeconds: (j['durationSeconds'] as num?)?.toInt() ?? 0,
        startedAt: _dt(j['startedAt']),
        completedAt: _dt(j['completedAt']),
      );

  JsonMap toJson() => {
        'id': id,
        'uuid': uuid,
        'quizId': quizId,
        'answers': _listToJson(answers, (a) => a.toJson()),
        'score': score,
        'totalQuestions': totalQuestions,
        'durationSeconds': durationSeconds,
        'startedAt': _dtOut(startedAt),
        'completedAt': _dtOut(completedAt),
      };
}

class QuizModel {
  QuizModel({
    this.id = 0,
    this.uuid = '',
    this.title = '',
    this.description = '',
    this.subjectId = '',
    this.sourceNoteId = '',
    this.tags = const [],
    this.questionCount = 0,
    this.defaultTimeLimitSeconds = 30,
    this.isAiGenerated = false,
    this.isPublished = false,
    this.bestScore = 0,
    this.attemptCount = 0,
    this.lastAttemptAt,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String uuid;
  String title;
  String description;
  String subjectId;
  String sourceNoteId;
  List<String> tags;
  int questionCount;
  int defaultTimeLimitSeconds;
  bool isAiGenerated;
  bool isPublished;
  int bestScore;
  int attemptCount;
  DateTime? lastAttemptAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory QuizModel.fromJson(JsonMap j) => QuizModel(
        id: (j['id'] as num?)?.toInt() ?? 0,
        uuid: j['uuid']?.toString() ?? '',
        title: j['title']?.toString() ?? '',
        description: j['description']?.toString() ?? '',
        subjectId: j['subjectId']?.toString() ?? '',
        sourceNoteId: j['sourceNoteId']?.toString() ?? '',
        tags: _strList(j['tags']),
        questionCount: (j['questionCount'] as num?)?.toInt() ?? 0,
        defaultTimeLimitSeconds:
            (j['defaultTimeLimitSeconds'] as num?)?.toInt() ?? 30,
        isAiGenerated: j['isAiGenerated'] == true,
        isPublished: j['isPublished'] == true,
        bestScore: (j['bestScore'] as num?)?.toInt() ?? 0,
        attemptCount: (j['attemptCount'] as num?)?.toInt() ?? 0,
        lastAttemptAt: _dt(j['lastAttemptAt']),
        createdAt: _dt(j['createdAt']),
        updatedAt: _dt(j['updatedAt']),
      );

  JsonMap toJson() => {
        'id': id,
        'uuid': uuid,
        'title': title,
        'description': description,
        'subjectId': subjectId,
        'sourceNoteId': sourceNoteId,
        'tags': tags,
        'questionCount': questionCount,
        'defaultTimeLimitSeconds': defaultTimeLimitSeconds,
        'isAiGenerated': isAiGenerated,
        'isPublished': isPublished,
        'bestScore': bestScore,
        'attemptCount': attemptCount,
        'lastAttemptAt': _dtOut(lastAttemptAt),
        'createdAt': _dtOut(createdAt),
        'updatedAt': _dtOut(updatedAt),
      };
}

// ─── GpaEntryModel ────────────────────────────────────────────────────────────

class GpaEntryModel {
  GpaEntryModel({
    this.id = 0,
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

  int id;
  String uuid;
  String subjectName;
  String subjectCode;
  String subjectUuid;
  String semesterLabel;
  int credits;
  double gradePoint;
  String letterGrade;
  double marksObtained;
  double maxMarks;
  bool isInternal;
  String examType;
  String notes;
  DateTime? createdAt;

  double get percentage =>
      maxMarks == 0 ? 0 : (marksObtained / maxMarks) * 100;

  double get weightedGradePoints => gradePoint * credits;

  factory GpaEntryModel.fromJson(JsonMap j) => GpaEntryModel(
        id: (j['id'] as num?)?.toInt() ?? 0,
        uuid: j['uuid']?.toString() ?? '',
        subjectName: j['subjectName']?.toString() ?? '',
        subjectCode: j['subjectCode']?.toString() ?? '',
        subjectUuid: j['subjectUuid']?.toString() ?? '',
        semesterLabel: j['semesterLabel']?.toString() ?? '',
        credits: (j['credits'] as num?)?.toInt() ?? 0,
        gradePoint: (j['gradePoint'] as num?)?.toDouble() ?? 0.0,
        letterGrade: j['letterGrade']?.toString() ?? '',
        marksObtained: (j['marksObtained'] as num?)?.toDouble() ?? 0.0,
        maxMarks: (j['maxMarks'] as num?)?.toDouble() ?? 100.0,
        isInternal: j['isInternal'] == true,
        examType: j['examType']?.toString() ?? '',
        notes: j['notes']?.toString() ?? '',
        createdAt: _dt(j['createdAt']),
      );

  JsonMap toJson() => {
        'id': id,
        'uuid': uuid,
        'subjectName': subjectName,
        'subjectCode': subjectCode,
        'subjectUuid': subjectUuid,
        'semesterLabel': semesterLabel,
        'credits': credits,
        'gradePoint': gradePoint,
        'letterGrade': letterGrade,
        'marksObtained': marksObtained,
        'maxMarks': maxMarks,
        'isInternal': isInternal,
        'examType': examType,
        'notes': notes,
        'createdAt': _dtOut(createdAt),
      };
}
