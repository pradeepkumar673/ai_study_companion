// lib/features/schedule/data/models/schedule_event_model.dart
import 'package:isar/isar.dart';
part 'schedule_event_model.g.dart';

enum EventType { lecture, study, exam, assignment, personal, other }
enum RecurrenceType { none, daily, weekly, biweekly, monthly }

@collection
class ScheduleEventModel {
  Id id = Isar.autoIncrement;
  @Index(unique: true) late String uuid;
  late String title;
  String? description;
  String? location;
  String? subject;
  String? subjectColor;
  @enumerated EventType type = EventType.lecture;
  @enumerated RecurrenceType recurrence = RecurrenceType.none;
  late DateTime startTime;
  late DateTime endTime;
  bool hasReminder = true;
  int reminderMinutesBefore = 15;
  List<String> attendees = [];
  DateTime createdAt = DateTime.now();
}
