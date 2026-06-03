// lib/features/profile/presentation/widgets/profile_settings_section.dart
//
// StudySpark — Profile Settings
//
// Sections:
//   1. Preferences  — Theme toggle, accent colour picker
//   2. Notifications — Per-type toggles with time picker
//   3. Pomodoro      — Work/break duration sliders, auto-start
//   4. Account       — Sign in, privacy, data export, about, rate app
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../shared/providers/theme_provider.dart';
import '../providers/profile_providers.dart';

class ProfileSettingsSection extends ConsumerWidget {
  const ProfileSettingsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Settings',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        const _PreferencesSection(),
        const SizedBox(height: 12),
        const _NotificationsSection(),
        const SizedBox(height: 12),
        const _PomodoroSection(),
        const SizedBox(height: 12),
        const _AccountSection(),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Preferences
// ─────────────────────────────────────────────────────────────────────────────

class _PreferencesSection extends ConsumerWidget {
  const _PreferencesSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(isDarkModeProvider);

    return _SettingsGroup(
      title: 'Preferences',
      icon: Icons.tune_rounded,
      children: [
        _SettingsTile(
          icon: isDark
              ? Icons.dark_mode_rounded
              : Icons.light_mode_rounded,
          iconColor: isDark
              ? const Color(0xFF7986CB)
              : const Color(0xFFFFA000),
          label: 'Dark Mode',
          subtitle: isDark ? 'Dark theme active' : 'Light theme active',
          trailing: Switch(
            value: isDark,
            onChanged: (_) =>
                ref.read(themeModeProvider.notifier).toggle(),
            activeColor: AppColors.primary,
          ),
        ),
        _SettingsTile(
          icon: Icons.text_fields_rounded,
          iconColor: AppColors.tertiary,
          label: 'Font Size',
          subtitle: 'Medium (default)',
          trailing: const Icon(Icons.chevron_right_rounded),
          onTap: () {},
        ),
        _SettingsTile(
          icon: Icons.language_rounded,
          iconColor: AppColors.secondary,
          label: 'Language',
          subtitle: 'English',
          trailing: const Icon(Icons.chevron_right_rounded),
          onTap: () {},
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Notifications
// ─────────────────────────────────────────────────────────────────────────────

class _NotificationsSection extends ConsumerWidget {
  const _NotificationsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(notificationSettingsProvider);
    final notifier = ref.read(notificationSettingsProvider.notifier);

    return _SettingsGroup(
      title: 'Notifications',
      icon: Icons.notifications_rounded,
      children: [
        _SettingsTile(
          icon: Icons.alarm_rounded,
          iconColor: AppColors.primary,
          label: 'Daily Reminder',
          subtitle: settings.dailyReminder ? settings.reminderTime : 'Off',
          trailing: Switch(
            value: settings.dailyReminder,
            onChanged: (_) => notifier.toggle('dailyReminder'),
            activeColor: AppColors.primary,
          ),
        ),
        _SettingsTile(
          icon: Icons.task_alt_rounded,
          iconColor: const Color(0xFFEF5350),
          label: 'Task Deadlines',
          subtitle: 'Alert 1 hour before',
          trailing: Switch(
            value: settings.taskDeadlineAlerts,
            onChanged: (_) => notifier.toggle('taskDeadlineAlerts'),
            activeColor: AppColors.primary,
          ),
        ),
        _SettingsTile(
          icon: Icons.timer_rounded,
          iconColor: const Color(0xFFF57C00),
          label: 'Pomodoro Alerts',
          subtitle: 'Session start & end',
          trailing: Switch(
            value: settings.pomodoroAlerts,
            onChanged: (_) => notifier.toggle('pomodoroAlerts'),
            activeColor: AppColors.primary,
          ),
        ),
        _SettingsTile(
          icon: Icons.local_fire_department_rounded,
          iconColor: const Color(0xFFFF7043),
          label: 'Streak Reminders',
          subtitle: 'Keep your streak alive',
          trailing: Switch(
            value: settings.streakReminders,
            onChanged: (_) => notifier.toggle('streakReminders'),
            activeColor: AppColors.primary,
          ),
        ),
        _SettingsTile(
          icon: Icons.work_outline_rounded,
          iconColor: AppColors.secondary,
          label: 'Career Alerts',
          subtitle: 'Internships & deadlines',
          trailing: Switch(
            value: settings.careerAlerts,
            onChanged: (_) => notifier.toggle('careerAlerts'),
            activeColor: AppColors.primary,
          ),
        ),
        _SettingsTile(
          icon: Icons.groups_rounded,
          iconColor: AppColors.tertiary,
          label: 'Study Group Messages',
          subtitle: 'New messages & polls',
          trailing: Switch(
            value: settings.studyGroupMessages,
            onChanged: (_) => notifier.toggle('studyGroupMessages'),
            activeColor: AppColors.primary,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Pomodoro Settings
// ─────────────────────────────────────────────────────────────────────────────

class _PomodoroSection extends ConsumerWidget {
  const _PomodoroSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(pomodoroPrefsProvider);
    final notifier = ref.read(pomodoroPrefsProvider.notifier);
    final cs = Theme.of(context).colorScheme;

    return _SettingsGroup(
      title: 'Pomodoro',
      icon: Icons.timer_outlined,
      children: [
        _SliderTile(
          icon: Icons.work_history_rounded,
          iconColor: AppColors.primary,
          label: 'Work Duration',
          value: prefs.workMinutes,
          min: 5,
          max: 90,
          unit: 'min',
          onChanged: notifier.setWorkMinutes,
        ),
        _SliderTile(
          icon: Icons.coffee_rounded,
          iconColor: AppColors.secondary,
          label: 'Short Break',
          value: prefs.shortBreakMinutes,
          min: 1,
          max: 30,
          unit: 'min',
          onChanged: notifier.setShortBreak,
        ),
        _SliderTile(
          icon: Icons.self_improvement_rounded,
          iconColor: AppColors.tertiary,
          label: 'Long Break',
          value: prefs.longBreakMinutes,
          min: 5,
          max: 60,
          unit: 'min',
          onChanged: notifier.setLongBreak,
        ),
        _SliderTile(
          icon: Icons.repeat_rounded,
          iconColor: const Color(0xFF8D6E63),
          label: 'Cycles before long break',
          value: prefs.cyclesBeforeLongBreak,
          min: 2,
          max: 8,
          unit: 'cycles',
          onChanged: notifier.setCycles,
        ),
        _SettingsTile(
          icon: Icons.play_circle_outline_rounded,
          iconColor: AppColors.primary,
          label: 'Auto-start breaks',
          subtitle: 'Skip the play button',
          trailing: Switch(
            value: prefs.autoStartBreaks,
            onChanged: (_) => notifier.toggleAutoStartBreaks(),
            activeColor: AppColors.primary,
          ),
        ),
        _SettingsTile(
          icon: Icons.restart_alt_rounded,
          iconColor: AppColors.secondary,
          label: 'Auto-start work sessions',
          subtitle: 'After every break',
          trailing: Switch(
            value: prefs.autoStartWork,
            onChanged: (_) => notifier.toggleAutoStartWork(),
            activeColor: AppColors.primary,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Account
// ─────────────────────────────────────────────────────────────────────────────

class _AccountSection extends StatelessWidget {
  const _AccountSection();

  @override
  Widget build(BuildContext context) {
    return _SettingsGroup(
      title: 'Account & Info',
      icon: Icons.manage_accounts_rounded,
      children: [
        _SettingsTile(
          icon: Icons.backup_rounded,
          iconColor: AppColors.primary,
          label: 'Export My Data',
          subtitle: 'Download all your study data',
          trailing: const Icon(Icons.chevron_right_rounded),
          onTap: () => _showExportDialog(context),
        ),
        _SettingsTile(
          icon: Icons.privacy_tip_outlined,
          iconColor: const Color(0xFF5E35B1),
          label: 'Privacy Policy',
          trailing: const Icon(Icons.chevron_right_rounded),
          onTap: () {},
        ),
        _SettingsTile(
          icon: Icons.star_outline_rounded,
          iconColor: const Color(0xFFFFD600),
          label: 'Rate StudySpark',
          subtitle: 'Love the app? Tell us!',
          trailing: const Icon(Icons.chevron_right_rounded),
          onTap: () {},
        ),
        _SettingsTile(
          icon: Icons.info_outline_rounded,
          iconColor: const Color(0xFF78909C),
          label: 'App Version',
          trailing: Text(
            '2.0.0-beta',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 12),
          ),
        ),
        _SettingsTile(
          icon: Icons.logout_rounded,
          iconColor: Colors.red,
          label: 'Sign Out',
          trailing: const Icon(Icons.chevron_right_rounded),
          onTap: () => _showSignOutDialog(context),
        ),
      ],
    );
  }

  void _showExportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Export Data'),
        content: const Text(
            'Your study data will be packaged as a JSON file. This may take a few seconds.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Export')),
        ],
      ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Sign Out?'),
        content: const Text(
            'Your local data will remain. You can sign back in anytime.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Sign Out')),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared Widgets
// ─────────────────────────────────────────────────────────────────────────────

class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({
    required this.title,
    required this.icon,
    required this.children,
  });

  final String title;
  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Row(
            children: [
              Icon(icon, size: 14, color: cs.onSurfaceVariant),
              const SizedBox(width: 6),
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: cs.onSurfaceVariant,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.neutral20 : cs.surface,
            borderRadius: AppShapes.r16,
            border:
                Border.all(color: cs.outlineVariant.withOpacity(0.35)),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: children.length,
            separatorBuilder: (_, i) => Divider(
              height: 1,
              color: cs.outlineVariant.withOpacity(0.25),
              indent: 56,
            ),
            itemBuilder: (_, i) => children[i],
          ),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.label,
    required this.trailing,
    this.iconColor,
    this.subtitle,
    this.onTap,
  });

  final IconData icon;
  final Color? iconColor;
  final String label;
  final String? subtitle;
  final Widget trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: (iconColor ?? cs.primary).withOpacity(0.12),
          borderRadius: AppShapes.r8,
        ),
        child: Icon(icon,
            color: iconColor ?? cs.primary, size: 18),
      ),
      title: Text(label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      subtitle: subtitle != null
          ? Text(subtitle!,
              style: TextStyle(
                  fontSize: 11, color: cs.onSurfaceVariant))
          : null,
      trailing: trailing,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
      visualDensity: VisualDensity.comfortable,
    );
  }
}

class _SliderTile extends StatelessWidget {
  const _SliderTile({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.unit,
    required this.onChanged,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final int value;
  final int min;
  final int max;
  final String unit;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 2),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.12),
                  borderRadius: AppShapes.r8,
                ),
                child: Icon(icon, color: iconColor, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: AppShapes.r8,
                ),
                child: Text(
                  '$value $unit',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              thumbRadius: 8,
              trackHeight: 4,
              overlayRadius: 16,
            ),
            child: Slider(
              value: value.toDouble(),
              min: min.toDouble(),
              max: max.toDouble(),
              divisions: max - min,
              activeColor: iconColor,
              inactiveColor: iconColor.withOpacity(0.2),
              onChanged: (v) => onChanged(v.round()),
            ),
          ),
        ],
      ),
    );
  }
}