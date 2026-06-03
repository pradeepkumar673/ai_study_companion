// lib/shared/providers/notifications_provider.dart
//
// Exposes the [FlutterLocalNotificationsPlugin] singleton and a
// [NotificationService] with helper methods for scheduling task reminders
// and focus session alerts.

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/timezone.dart' as tz;

// ─── Plugin Provider ─────────────────────────────────────────────────────────

/// Overridden in main.dart with the initialized plugin instance.
final notificationsPluginProvider =
    Provider<FlutterLocalNotificationsPlugin>((ref) {
  throw UnimplementedError(
    'notificationsPluginProvider must be overridden in ProviderScope',
  );
});

// ─── Notification Channel IDs ─────────────────────────────────────────────────
abstract final class NotificationChannels {
  static const taskReminder  = 'task_reminders';
  static const focusSession  = 'focus_sessions';
  static const dailySummary  = 'daily_summary';
}

// ─── Notification IDs (base) ─────────────────────────────────────────────────
abstract final class NotificationIds {
  static const taskBase    = 1000; // task id hash offset
  static const focusStart  = 2001;
  static const focusEnd    = 2002;
  static const dailySummary = 3001;
}

// ─── Service ─────────────────────────────────────────────────────────────────

/// High-level notification service.  Inject via [notificationServiceProvider].
class NotificationService {
  const NotificationService(this._plugin);

  final FlutterLocalNotificationsPlugin _plugin;

  // ── Android notification details ─────────────────────────────────────
  static const _androidTask = AndroidNotificationDetails(
    NotificationChannels.taskReminder,
    'Task Reminders',
    channelDescription: 'Reminders for upcoming tasks and deadlines',
    importance: Importance.high,
    priority: Priority.high,
    icon: '@mipmap/ic_launcher',
  );

  static const _androidFocus = AndroidNotificationDetails(
    NotificationChannels.focusSession,
    'Focus Sessions',
    channelDescription: 'Alerts for focus timer start and completion',
    importance: Importance.high,
    priority: Priority.high,
    icon: '@mipmap/ic_launcher',
  );

  // ── Schedule a task reminder ──────────────────────────────────────────

  /// Schedule a notification for [scheduledDate] with [title] & [body].
  /// [taskId] is used to derive a unique notification id (for cancellation).
  Future<void> scheduleTaskReminder({
    required String taskId,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    final id = NotificationIds.taskBase + taskId.hashCode.abs() % 10000;
    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      const NotificationDetails(android: _androidTask),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: 'task:$taskId',
    );
  }

  /// Cancel a specific task reminder.
  Future<void> cancelTaskReminder(String taskId) async {
    final id = NotificationIds.taskBase + taskId.hashCode.abs() % 10000;
    await _plugin.cancel(id);
  }

  // ── Focus session notifications ───────────────────────────────────────

  /// Show an immediate notification when a focus session starts.
  Future<void> showFocusStarted(int durationMinutes) async {
    await _plugin.show(
      NotificationIds.focusStart,
      '🎯 Focus Session Started',
      'Stay focused for $durationMinutes minutes. You\'ve got this!',
      const NotificationDetails(android: _androidFocus),
    );
  }

  /// Show a notification when a focus session completes.
  Future<void> showFocusCompleted(int durationMinutes) async {
    await _plugin.show(
      NotificationIds.focusEnd,
      '✅ Focus Session Complete!',
      'Great work — you stayed focused for $durationMinutes minutes.',
      const NotificationDetails(android: _androidFocus),
    );
  }

  // ── Cancel all ───────────────────────────────────────────────────────────
  Future<void> cancelAll() => _plugin.cancelAll();
}

// ─── Service Provider ─────────────────────────────────────────────────────────
final notificationServiceProvider = Provider<NotificationService>((ref) {
  final plugin = ref.watch(notificationsPluginProvider);
  return NotificationService(plugin);
});
