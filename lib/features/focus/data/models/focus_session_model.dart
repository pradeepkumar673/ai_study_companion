// lib/features/focus/data/models/focus_session_model.dart
import 'package:isar/isar.dart';
part 'focus_session_model.g.dart';

enum FocusMode { pomodoro, shortFocus, deepWork, custom }
enum SessionStatus { active, completed, abandoned }

@collection
class FocusSessionModel {
  Id id = Isar.autoIncrement;
  @Index(unique: true) late String uuid;
  @enumerated FocusMode mode = FocusMode.pomodoro;
  @enumerated SessionStatus status = SessionStatus.completed;
  String? linkedTaskId;
  String? subject;
  late int durationMinutes;
  int actualMinutes = 0;
  int breakMinutes = 5;
  late DateTime startedAt;
  DateTime? completedAt;
  String? notes;
  // TODO: AI focus quality — HuggingFace distilbert sentiment on session notes
  // double? aiQualityScore;
}
