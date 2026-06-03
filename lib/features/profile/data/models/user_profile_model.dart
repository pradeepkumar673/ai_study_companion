// lib/features/profile/data/models/user_profile_model.dart
import 'package:isar/isar.dart';
part 'user_profile_model.g.dart';

@collection
class UserProfileModel {
  Id id = Isar.autoIncrement;
  String name = 'Student';
  String? avatarPath;
  String? university;
  String? major;
  int yearOfStudy = 1;
  String? bio;
  List<String> subjects = [];
  bool notificationsEnabled = true;
  bool soundEnabled = true;
  int dailyStudyGoalMinutes = 120;
  int weeklyTaskGoal = 10;
  DateTime createdAt = DateTime.now();
  // Gamification counters
  int totalFocusMinutes = 0;
  int totalTasksCompleted = 0;
  int streakDays = 0;
  DateTime? lastActiveDate;
}
