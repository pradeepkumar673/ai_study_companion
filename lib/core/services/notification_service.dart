// lib/core/services/notification_service.dart
//
// StudySpark — Notification Service
//
// Wraps [flutter_local_notifications] and [timezone] to provide a clean
// API for scheduling and cancelling task / goal / pomodoro reminders.
//
// Usage (from providers or repository layer):
//   final ns = ref.read(notificationServiceProvider);
//   final id = await ns.scheduleTaskReminder(task);
//   await ns.cancelNotification(id);
//
// Platform setup:
//   • Android: add <uses-permission> for SCHEDULE_EXACT_ALARM in AndroidManifest.
//   • iOS: request authorisation during onboarding via [requestPermission].
// ─────────────────────────────────────────────────────────────────────────────

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

// ─── NotificationService ──────────────────────────────────────────────────────

class NotificationService {
  NotificationService._(this._plugin);

  final FlutterLocalNotificationsPlugin? _plugin;

  bool get _isWebStub => _plugin == null;

  // ── Initialisation ────────────────────────────────────────────────────────

  /// No-op notification service for web builds.
  static NotificationService web() => NotificationService._(null);

  /// Creates and initialises the service.  Call once from [main.dart].
  static Future<NotificationService> init() async {
    // Timezone data required for scheduled notifications.
    tz.initializeTimeZones();

    final plugin = FlutterLocalNotificationsPlugin();

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings(
      requestAlertPermission: false, // asked explicitly during onboarding
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    await plugin.initialize(
      const InitializationSettings(android: androidInit, iOS: iosInit),
      onDidReceiveNotificationResponse: _onNotificationTap,
    );

    return NotificationService._(plugin);
  }

  // ── Permission ────────────────────────────────────────────────────────────

  /// Requests iOS notification permission.  Call during onboarding.
  Future<bool?> requestPermission() async {
    if (_isWebStub) return true;
    return _plugin!
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  // ── ID generation ─────────────────────────────────────────────────────────

  /// Generates a unique integer notification id.
  ///
  /// Uses a random int in [1, 2^30] to avoid collisions between models.
  static int generateId() => Random().nextInt(1 << 30) + 1;

  // ── Task / Goal reminders ─────────────────────────────────────────────────

  /// Schedules a reminder notification for a task/goal deadline.
  ///
  /// [id] should be stored on the model so it can be cancelled later.
  /// [scheduledAt] is the UTC DateTime at which to fire the notification.
  ///
  /// Returns the notification [id] for storage.
  Future<int> scheduleReminder({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledAt,
    String? payload, // e.g. "task:uuid-here" for deep-link routing
  }) async {
    if (_isWebStub) return id;
    // Notifications in the past are silently skipped.
    if (scheduledAt.isBefore(DateTime.now())) return id;

    final tzTime = tz.TZDateTime.from(scheduledAt, tz.local);

    await _plugin!.zonedSchedule(
      id,
      title,
      body,
      tzTime,
      _buildDetails(),
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
    return id;
  }

  // ── Pomodoro flow notifications ───────────────────────────────────────────

  /// Fires an immediate notification when a Pomodoro session completes.
  Future<void> showPomodoroComplete({
    required String sessionType, // e.g. "Work", "Short Break"
    required String nextType,    // e.g. "Short Break", "Work"
  }) async {
    if (_isWebStub) return;
    await _plugin!.show(
      0, // reuse id 0 for all transient pomodoro alerts
      '✅ $sessionType complete!',
      'Time for a $nextType',
      _buildDetails(),
    );
  }

  /// Schedules the end-of-session notification exactly [durationSeconds] from now.
  Future<void> scheduleTimerEnd({
    required int durationSeconds,
    required String title,
    required String body,
  }) async {
    final fireAt = DateTime.now().add(Duration(seconds: durationSeconds));
    await scheduleReminder(
      id: 1, // reserved id for the active timer
      title: title,
      body: body,
      scheduledAt: fireAt,
    );
  }

  /// Cancels the active timer notification (e.g. user pauses / stops timer).
  Future<void> cancelTimerNotification() => cancelNotification(1);

  // ── Daily study streak reminder ───────────────────────────────────────────

  /// Schedules a daily reminder at [hour]:[minute] local time.
  ///
  /// Uses [RepeatInterval.daily] so it fires every day without re-scheduling.
  Future<void> scheduleDailyStreakReminder({
    int hour = 20,
    int minute = 0,
  }) async {
    if (_isWebStub) return;
    await _plugin!.zonedSchedule(
      2, // reserved id for streak reminder
      '🔥 Keep your streak alive!',
      "You haven't studied today yet. Open StudySpark to stay on track.",
      _nextInstanceOfTime(hour, minute),
      _buildDetails(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time, // repeat daily
    );
  }

  // ── Cancel helpers ────────────────────────────────────────────────────────

  /// Cancels a single notification by [id].
  Future<void> cancelNotification(int id) {
    if (_isWebStub) return Future.value();
    return _plugin!.cancel(id);
  }

  /// Cancels all scheduled notifications (e.g. on sign-out).
  Future<void> cancelAll() {
    if (_isWebStub) return Future.value();
    return _plugin!.cancelAll();
  }

  // ── Private helpers ───────────────────────────────────────────────────────

  /// Builds the [NotificationDetails] for both platforms.
  NotificationDetails _buildDetails({
    String channelId = 'studyspark_main',
    String channelName = 'StudySpark',
    String channelDesc = 'Task, goal, and study session reminders',
    Importance importance = Importance.high,
    Priority priority = Priority.high,
  }) {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        channelId,
        channelName,
        channelDescription: channelDesc,
        importance: importance,
        priority: priority,
        icon: '@mipmap/ic_launcher',
      ),
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );
  }

  /// Returns the next occurrence of [hour]:[minute] in the local timezone.
  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }

  /// Global handler for notification taps.
  ///
  /// Route to the appropriate screen based on [payload] format:
  ///   "task:<uuid>"  → TaskDetailScreen
  ///   "goal:<uuid>"  → GoalDetailScreen
  static void _onNotificationTap(NotificationResponse response) {
    final payload = response.payload;
    if (payload == null) return;

    // TODO: integrate with GoRouter navigatorKey for deep-link handling:
    // final parts = payload.split(':');
    // if (parts.length == 2 && parts[0] == 'task') {
    //   navigatorKey.currentContext?.push(AppPaths.taskDetail(parts[1]));
    // }
    debugPrint('[NotificationService] tapped: $payload');
  }
}

/// Injected from main.dart via ProviderScope.overrides.
final notificationServiceProvider = Provider<NotificationService>((ref) {
  throw UnimplementedError(
    'notificationServiceProvider must be overridden with an initialised '
    'NotificationService instance. See main.dart.',
  );
});
