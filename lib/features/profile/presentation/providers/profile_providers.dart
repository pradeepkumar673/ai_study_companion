// lib/features/profile/presentation/providers/profile_providers.dart
//
// StudySpark — Profile Feature Providers
// Covers: offline detection, cloud sync state, profile edit state,
//         notifications toggle, pomodoro prefs, etc.
// ─────────────────────────────────────────────────────────────────────────────

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// OFFLINE DETECTION
// Simulates connectivity state — replace with connectivity_plus in production.
// ═══════════════════════════════════════════════════════════════════════════════

/// True when the device has no network connection.
final isOfflineProvider = StateProvider<bool>((ref) => false);

// ═══════════════════════════════════════════════════════════════════════════════
// CLOUD SYNC STATE
// ═══════════════════════════════════════════════════════════════════════════════

enum SyncStatus {
  idle,
  syncing,
  success,
  error,
  offline,
}

class SyncState {
  const SyncState({
    this.status = SyncStatus.idle,
    this.lastSyncTime,
    this.pendingChanges = 0,
    this.errorMessage,
    this.syncProgress = 0.0,
  });

  final SyncStatus status;
  final DateTime? lastSyncTime;
  final int pendingChanges;
  final String? errorMessage;
  final double syncProgress; // 0.0 – 1.0

  SyncState copyWith({
    SyncStatus? status,
    DateTime? lastSyncTime,
    int? pendingChanges,
    String? errorMessage,
    double? syncProgress,
  }) =>
      SyncState(
        status: status ?? this.status,
        lastSyncTime: lastSyncTime ?? this.lastSyncTime,
        pendingChanges: pendingChanges ?? this.pendingChanges,
        errorMessage: errorMessage ?? this.errorMessage,
        syncProgress: syncProgress ?? this.syncProgress,
      );

  String get statusLabel {
    switch (status) {
      case SyncStatus.idle:
        return lastSyncTime == null ? 'Never synced' : 'Up to date';
      case SyncStatus.syncing:
        return 'Syncing…';
      case SyncStatus.success:
        return 'Synced just now';
      case SyncStatus.error:
        return 'Sync failed';
      case SyncStatus.offline:
        return 'Offline — ${pendingChanges} pending';
    }
  }

  String get lastSyncLabel {
    if (lastSyncTime == null) return '—';
    final diff = DateTime.now().difference(lastSyncTime!);
    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}

class CloudSyncNotifier extends Notifier<SyncState> {
  Timer? _syncTimer;

  @override
  SyncState build() {
    ref.onDispose(() => _syncTimer?.cancel());
    // Simulate an existing sync timestamp
    return SyncState(
      status: SyncStatus.idle,
      lastSyncTime: DateTime.now().subtract(const Duration(minutes: 12)),
      pendingChanges: 3,
    );
  }

  Future<void> triggerSync() async {
    if (state.status == SyncStatus.syncing) return;

    final isOffline = ref.read(isOfflineProvider);
    if (isOffline) {
      state = state.copyWith(status: SyncStatus.offline);
      return;
    }

    // Simulate sync with progress
    state = state.copyWith(status: SyncStatus.syncing, syncProgress: 0.0);

    for (var i = 1; i <= 10; i++) {
      await Future.delayed(const Duration(milliseconds: 180));
      state = state.copyWith(syncProgress: i / 10);
    }

    await Future.delayed(const Duration(milliseconds: 200));
    state = state.copyWith(
      status: SyncStatus.success,
      lastSyncTime: DateTime.now(),
      pendingChanges: 0,
      syncProgress: 1.0,
    );

    // Reset to idle after 3 seconds
    _syncTimer = Timer(const Duration(seconds: 3), () {
      state = state.copyWith(status: SyncStatus.idle);
    });
  }

  void simulateOffline() {
    state = state.copyWith(
      status: SyncStatus.offline,
      pendingChanges: state.pendingChanges + 1,
    );
  }
}

final cloudSyncProvider =
    NotifierProvider<CloudSyncNotifier, SyncState>(CloudSyncNotifier.new);

// ═══════════════════════════════════════════════════════════════════════════════
// NOTIFICATIONS SETTINGS
// ═══════════════════════════════════════════════════════════════════════════════

class NotificationSettings {
  const NotificationSettings({
    this.dailyReminder = true,
    this.taskDeadlineAlerts = true,
    this.pomodoroAlerts = true,
    this.streakReminders = true,
    this.careerAlerts = true,
    this.studyGroupMessages = false,
    this.reminderTime = '08:00',
  });

  final bool dailyReminder;
  final bool taskDeadlineAlerts;
  final bool pomodoroAlerts;
  final bool streakReminders;
  final bool careerAlerts;
  final bool studyGroupMessages;
  final String reminderTime;

  NotificationSettings copyWith({
    bool? dailyReminder,
    bool? taskDeadlineAlerts,
    bool? pomodoroAlerts,
    bool? streakReminders,
    bool? careerAlerts,
    bool? studyGroupMessages,
    String? reminderTime,
  }) =>
      NotificationSettings(
        dailyReminder: dailyReminder ?? this.dailyReminder,
        taskDeadlineAlerts: taskDeadlineAlerts ?? this.taskDeadlineAlerts,
        pomodoroAlerts: pomodoroAlerts ?? this.pomodoroAlerts,
        streakReminders: streakReminders ?? this.streakReminders,
        careerAlerts: careerAlerts ?? this.careerAlerts,
        studyGroupMessages: studyGroupMessages ?? this.studyGroupMessages,
        reminderTime: reminderTime ?? this.reminderTime,
      );
}

class NotificationSettingsNotifier extends Notifier<NotificationSettings> {
  @override
  NotificationSettings build() => const NotificationSettings();

  void toggle(String key) {
    state = switch (key) {
      'dailyReminder' =>
        state.copyWith(dailyReminder: !state.dailyReminder),
      'taskDeadlineAlerts' =>
        state.copyWith(taskDeadlineAlerts: !state.taskDeadlineAlerts),
      'pomodoroAlerts' =>
        state.copyWith(pomodoroAlerts: !state.pomodoroAlerts),
      'streakReminders' =>
        state.copyWith(streakReminders: !state.streakReminders),
      'careerAlerts' => state.copyWith(careerAlerts: !state.careerAlerts),
      'studyGroupMessages' =>
        state.copyWith(studyGroupMessages: !state.studyGroupMessages),
      _ => state,
    };
  }
}

final notificationSettingsProvider =
    NotifierProvider<NotificationSettingsNotifier, NotificationSettings>(
        NotificationSettingsNotifier.new);

// ═══════════════════════════════════════════════════════════════════════════════
// POMODORO SETTINGS (profile-level prefs)
// ═══════════════════════════════════════════════════════════════════════════════

class PomodoroPrefs {
  const PomodoroPrefs({
    this.workMinutes = 25,
    this.shortBreakMinutes = 5,
    this.longBreakMinutes = 15,
    this.cyclesBeforeLongBreak = 4,
    this.autoStartBreaks = false,
    this.autoStartWork = false,
  });

  final int workMinutes;
  final int shortBreakMinutes;
  final int longBreakMinutes;
  final int cyclesBeforeLongBreak;
  final bool autoStartBreaks;
  final bool autoStartWork;

  PomodoroPrefs copyWith({
    int? workMinutes,
    int? shortBreakMinutes,
    int? longBreakMinutes,
    int? cyclesBeforeLongBreak,
    bool? autoStartBreaks,
    bool? autoStartWork,
  }) =>
      PomodoroPrefs(
        workMinutes: workMinutes ?? this.workMinutes,
        shortBreakMinutes: shortBreakMinutes ?? this.shortBreakMinutes,
        longBreakMinutes: longBreakMinutes ?? this.longBreakMinutes,
        cyclesBeforeLongBreak:
            cyclesBeforeLongBreak ?? this.cyclesBeforeLongBreak,
        autoStartBreaks: autoStartBreaks ?? this.autoStartBreaks,
        autoStartWork: autoStartWork ?? this.autoStartWork,
      );
}

class PomodoroPrefsNotifier extends Notifier<PomodoroPrefs> {
  @override
  PomodoroPrefs build() => const PomodoroPrefs();

  void setWorkMinutes(int v) =>
      state = state.copyWith(workMinutes: v.clamp(5, 90));
  void setShortBreak(int v) =>
      state = state.copyWith(shortBreakMinutes: v.clamp(1, 30));
  void setLongBreak(int v) =>
      state = state.copyWith(longBreakMinutes: v.clamp(5, 60));
  void setCycles(int v) =>
      state = state.copyWith(cyclesBeforeLongBreak: v.clamp(2, 8));
  void toggleAutoStartBreaks() =>
      state = state.copyWith(autoStartBreaks: !state.autoStartBreaks);
  void toggleAutoStartWork() =>
      state = state.copyWith(autoStartWork: !state.autoStartWork);
}

final pomodoroPrefsProvider =
    NotifierProvider<PomodoroPrefsNotifier, PomodoroPrefs>(
        PomodoroPrefsNotifier.new);

// ═══════════════════════════════════════════════════════════════════════════════
// EXPANDED SETTINGS SECTIONS (tracks which accordion panel is open)
// ═══════════════════════════════════════════════════════════════════════════════

final expandedSettingsSectionProvider =
    StateProvider<String?>((ref) => null);