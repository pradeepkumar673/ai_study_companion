// lib/core/enums/app_enums.dart
//
// StudySpark — Centralised enum definitions.
// Every Isar model that needs an enum imports from here.
// ─────────────────────────────────────────────────────────────────────────────

// ─── Priority ────────────────────────────────────────────────────────────────

/// Task / goal urgency level.
enum Priority {
  low,
  medium,
  high,
  critical;

  String get label {
    switch (this) {
      case Priority.low:
        return 'Low';
      case Priority.medium:
        return 'Medium';
      case Priority.high:
        return 'High';
      case Priority.critical:
        return 'Critical';
    }
  }

  /// Returns a hex colour string matched to the priority level.
  String get hexColor {
    switch (this) {
      case Priority.low:
        return '#4CAF50'; // green
      case Priority.medium:
        return '#FF9800'; // orange
      case Priority.high:
        return '#F44336'; // red
      case Priority.critical:
        return '#9C27B0'; // purple
    }
  }
}

// ─── TaskStatus ───────────────────────────────────────────────────────────────

/// Lifecycle state of a task.
enum TaskStatus {
  todo,
  inProgress,
  done,
  cancelled,
  archived;

  String get label {
    switch (this) {
      case TaskStatus.todo:
        return 'To Do';
      case TaskStatus.inProgress:
        return 'In Progress';
      case TaskStatus.done:
        return 'Done';
      case TaskStatus.cancelled:
        return 'Cancelled';
      case TaskStatus.archived:
        return 'Archived';
    }
  }

  bool get isTerminal => this == TaskStatus.done || this == TaskStatus.cancelled || this == TaskStatus.archived;
}

// ─── RepeatFrequency ─────────────────────────────────────────────────────────

/// How often a task / goal recurs.
enum RepeatFrequency {
  none,
  daily,
  weekdays,
  weekly,
  biweekly,
  monthly;

  String get label {
    switch (this) {
      case RepeatFrequency.none:
        return 'Does not repeat';
      case RepeatFrequency.daily:
        return 'Every day';
      case RepeatFrequency.weekdays:
        return 'Weekdays (Mon–Fri)';
      case RepeatFrequency.weekly:
        return 'Every week';
      case RepeatFrequency.biweekly:
        return 'Every 2 weeks';
      case RepeatFrequency.monthly:
        return 'Every month';
    }
  }
}

// ─── PomodoroMode ────────────────────────────────────────────────────────────

/// Focus session timer modes.
enum PomodoroMode {
  pomodoro,       // classic 25 min work
  shortBreak,     // 5 min break
  longBreak,      // 15 min break
  deepWork;       // custom-duration deep focus

  String get label {
    switch (this) {
      case PomodoroMode.pomodoro:
        return 'Pomodoro';
      case PomodoroMode.shortBreak:
        return 'Short Break';
      case PomodoroMode.longBreak:
        return 'Long Break';
      case PomodoroMode.deepWork:
        return 'Deep Work';
    }
  }

  /// Default duration in minutes.
  int get defaultMinutes {
    switch (this) {
      case PomodoroMode.pomodoro:
        return 25;
      case PomodoroMode.shortBreak:
        return 5;
      case PomodoroMode.longBreak:
        return 15;
      case PomodoroMode.deepWork:
        return 90;
    }
  }
}

// ─── SessionStatus ────────────────────────────────────────────────────────────

/// Whether a focus session was completed or abandoned.
enum SessionStatus {
  completed,
  abandoned,
  paused; // persisted but not finished — rare edge case

  String get label {
    switch (this) {
      case SessionStatus.completed:
        return 'Completed';
      case SessionStatus.abandoned:
        return 'Abandoned';
      case SessionStatus.paused:
        return 'Paused';
    }
  }
}

// ─── NoteColor ───────────────────────────────────────────────────────────────

/// Preset background colours for note cards (hex strings).
enum NoteColor {
  white,
  yellow,
  blue,
  green,
  pink,
  purple,
  orange,
  teal;

  String get hexValue {
    switch (this) {
      case NoteColor.white:
        return '#FFFFFF';
      case NoteColor.yellow:
        return '#FFF9C4';
      case NoteColor.blue:
        return '#BBDEFB';
      case NoteColor.green:
        return '#C8E6C9';
      case NoteColor.pink:
        return '#F8BBD9';
      case NoteColor.purple:
        return '#E1BEE7';
      case NoteColor.orange:
        return '#FFE0B2';
      case NoteColor.teal:
        return '#B2EBF2';
    }
  }
}

// ─── MoodType ────────────────────────────────────────────────────────────────

/// Subjective mood / energy state at the time of logging.
enum MoodType {
  terrible,
  bad,
  neutral,
  good,
  excellent;

  String get label {
    switch (this) {
      case MoodType.terrible:
        return 'Terrible';
      case MoodType.bad:
        return 'Bad';
      case MoodType.neutral:
        return 'Okay';
      case MoodType.good:
        return 'Good';
      case MoodType.excellent:
        return 'Excellent';
    }
  }

  /// Emoji shorthand for display.
  String get emoji {
    switch (this) {
      case MoodType.terrible:
        return '😞';
      case MoodType.bad:
        return '😕';
      case MoodType.neutral:
        return '😐';
      case MoodType.good:
        return '😊';
      case MoodType.excellent:
        return '😄';
    }
  }

  /// Numeric score for charting (1–5).
  int get score => index + 1;
}

// ─── AttendanceStatus ─────────────────────────────────────────────────────────

/// Whether the student was present at a class.
enum AttendanceStatus {
  present,
  absent,
  late,
  excused;

  String get label {
    switch (this) {
      case AttendanceStatus.present:
        return 'Present';
      case AttendanceStatus.absent:
        return 'Absent';
      case AttendanceStatus.late:
        return 'Late';
      case AttendanceStatus.excused:
        return 'Excused';
    }
  }

  /// Whether this status counts toward the attendance percentage.
  bool get countsAsPresent =>
      this == AttendanceStatus.present || this == AttendanceStatus.late;
}

// ─── FlashcardDifficulty ──────────────────────────────────────────────────────

/// Self-assessed recall confidence after reviewing a flashcard (SM-2 inspired).
enum FlashcardDifficulty {
  again,   // complete blackout — repeat today
  hard,    // significant difficulty
  good,    // correct with some effort
  easy;    // perfect recall

  String get label {
    switch (this) {
      case FlashcardDifficulty.again:
        return 'Again';
      case FlashcardDifficulty.hard:
        return 'Hard';
      case FlashcardDifficulty.good:
        return 'Good';
      case FlashcardDifficulty.easy:
        return 'Easy';
    }
  }

  /// SM-2 quality score (0–5).
  int get sm2Quality {
    switch (this) {
      case FlashcardDifficulty.again:
        return 0;
      case FlashcardDifficulty.hard:
        return 2;
      case FlashcardDifficulty.good:
        return 4;
      case FlashcardDifficulty.easy:
        return 5;
    }
  }
}

// ─── GoalStatus ───────────────────────────────────────────────────────────────

/// Lifecycle state of a long-term goal.
enum GoalStatus {
  active,
  completed,
  failed,
  abandoned;

  String get label {
    switch (this) {
      case GoalStatus.active:
        return 'Active';
      case GoalStatus.completed:
        return 'Completed';
      case GoalStatus.failed:
        return 'Failed';
      case GoalStatus.abandoned:
        return 'Abandoned';
    }
  }

  bool get isTerminal =>
      this == GoalStatus.completed ||
      this == GoalStatus.failed ||
      this == GoalStatus.abandoned;
}

// ─── BadgeCategory ────────────────────────────────────────────────────────────

/// Which area of the app the badge is awarded for.
enum BadgeCategory {
  streak,
  tasks,
  focus,
  notes,
  attendance,
  flashcards,
  goals,
  social;

  String get label {
    switch (this) {
      case BadgeCategory.streak:
        return 'Streak';
      case BadgeCategory.tasks:
        return 'Tasks';
      case BadgeCategory.focus:
        return 'Focus';
      case BadgeCategory.notes:
        return 'Notes';
      case BadgeCategory.attendance:
        return 'Attendance';
      case BadgeCategory.flashcards:
        return 'Flashcards';
      case BadgeCategory.goals:
        return 'Goals';
      case BadgeCategory.social:
        return 'Social';
    }
  }
}

// ─── SubjectType ──────────────────────────────────────────────────────────────

/// Broad academic discipline — used for icon selection in the UI.
enum SubjectType {
  mathematics,
  science,
  physics,
  chemistry,
  biology,
  computerScience,
  english,
  history,
  geography,
  economics,
  art,
  music,
  physicalEducation,
  other;

  String get label {
    switch (this) {
      case SubjectType.mathematics:
        return 'Mathematics';
      case SubjectType.science:
        return 'Science';
      case SubjectType.physics:
        return 'Physics';
      case SubjectType.chemistry:
        return 'Chemistry';
      case SubjectType.biology:
        return 'Biology';
      case SubjectType.computerScience:
        return 'Computer Science';
      case SubjectType.english:
        return 'English';
      case SubjectType.history:
        return 'History';
      case SubjectType.geography:
        return 'Geography';
      case SubjectType.economics:
        return 'Economics';
      case SubjectType.art:
        return 'Art';
      case SubjectType.music:
        return 'Music';
      case SubjectType.physicalEducation:
        return 'P.E.';
      case SubjectType.other:
        return 'Other';
    }
  }
}

// ─── QuizQuestionType ────────────────────────────────────────────────────────

/// Format of a quiz question.
enum QuizQuestionType {
  multipleChoice,
  trueFalse,
  shortAnswer,
  fillInBlank;

  String get label {
    switch (this) {
      case QuizQuestionType.multipleChoice:
        return 'Multiple Choice';
      case QuizQuestionType.trueFalse:
        return 'True / False';
      case QuizQuestionType.shortAnswer:
        return 'Short Answer';
      case QuizQuestionType.fillInBlank:
        return 'Fill in the Blank';
    }
  }
}
