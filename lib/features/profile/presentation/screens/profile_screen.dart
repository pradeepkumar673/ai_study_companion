// lib/features/profile/presentation/screens/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: cs.surface,
      body: CustomScrollView(
        slivers: [
          // ── Gradient App Bar with Avatar ──────────────────────────────────
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: AppColors.primary,
            surfaceTintColor: Colors.transparent,
            actions: [
              IconButton(
                icon: const Icon(Icons.settings_outlined, color: Colors.white),
                onPressed: () {},
              ),
              const SizedBox(width: 8),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, const Color(0xFF9B7FFA)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 32),
                      // Avatar
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.25),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2.5),
                        ),
                        child: const Icon(
                          Icons.person_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                      ).animate().scale(duration: 600.ms, curve: Curves.easeOutBack),
                      const SizedBox(height: 10),
                      Text(
                        'Student',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ).animate(delay: 200.ms).fadeIn(),
                      Text(
                        'Level 1 • 0 XP',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 13,
                        ),
                      ).animate(delay: 300.ms).fadeIn(),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── Body ──────────────────────────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
            sliver: SliverList.list(
              children: [
                // XP progress bar
                _XpProgressCard(cs: cs, isDark: isDark),
                const SizedBox(height: 24),

                // Stats
                _StatsRow(cs: cs, isDark: isDark),
                const SizedBox(height: 24),

                // Settings sections
                _SettingsSection(
                  title: 'Preferences',
                  items: [
                    _SettingsTile(icon: Icons.dark_mode_outlined, label: 'Dark Mode', trailing: Switch(value: isDark, onChanged: (_) {})),
                    _SettingsTile(icon: Icons.notifications_outlined, label: 'Notifications', trailing: const Icon(Icons.chevron_right_rounded)),
                    _SettingsTile(icon: Icons.timer_outlined, label: 'Pomodoro Settings', trailing: const Icon(Icons.chevron_right_rounded)),
                  ],
                  cs: cs, isDark: isDark,
                ),
                const SizedBox(height: 16),
                _SettingsSection(
                  title: 'About',
                  items: [
                    _SettingsTile(icon: Icons.info_outline_rounded, label: 'App Version', trailing: Text('1.0.0', style: TextStyle(color: cs.onSurfaceVariant))),
                    _SettingsTile(icon: Icons.privacy_tip_outlined, label: 'Privacy Policy', trailing: const Icon(Icons.chevron_right_rounded)),
                    _SettingsTile(icon: Icons.star_outline_rounded, label: 'Rate the App', trailing: const Icon(Icons.chevron_right_rounded)),
                  ],
                  cs: cs, isDark: isDark,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _XpProgressCard extends StatelessWidget {
  const _XpProgressCard({required this.cs, required this.isDark});
  final ColorScheme cs;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? AppColors.neutral20 : cs.surface,
        borderRadius: AppShapes.r16,
        border: Border.all(color: cs.outlineVariant.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Level 1', style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w700)),
              Text('0 / 500 XP', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: cs.onSurfaceVariant)),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: AppShapes.r8,
            child: LinearProgressIndicator(
              value: 0.0,
              minHeight: 8,
              backgroundColor: AppColors.primary.withOpacity(0.12),
              valueColor: AlwaysStoppedAnimation(AppColors.primary),
            ),
          ),
          const SizedBox(height: 6),
          Text('Complete tasks and focus sessions to earn XP', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: cs.onSurfaceVariant)),
        ],
      ),
    ).animate().fadeIn(delay: 100.ms);
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.cs, required this.isDark});
  final ColorScheme cs;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final stats = [
      (label: 'Tasks Done', value: '0', icon: Icons.check_circle_rounded, color: AppColors.secondary),
      (label: 'Focus Hours', value: '0h', icon: Icons.timer_rounded, color: AppColors.primary),
      (label: 'Day Streak', value: '0', icon: Icons.local_fire_department_rounded, color: AppColors.tertiary),
    ];

    return Row(
      children: stats.asMap().entries.map((e) {
        final s = e.value;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: e.key == 0 ? 0 : 6,
              right: e.key == stats.length - 1 ? 0 : 6,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              decoration: BoxDecoration(
                color: isDark ? AppColors.neutral20 : cs.surface,
                borderRadius: AppShapes.r16,
                border: Border.all(color: cs.outlineVariant.withOpacity(0.4)),
              ),
              child: Column(
                children: [
                  Icon(s.icon, color: s.color, size: 22),
                  const SizedBox(height: 6),
                  Text(s.value, style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w800)),
                  Text(s.label, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: cs.onSurfaceVariant), textAlign: TextAlign.center),
                ],
              ),
            ).animate(delay: Duration(milliseconds: 80 * e.key)).fadeIn().slideY(begin: 0.2, end: 0),
          ),
        );
      }).toList(),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({required this.title, required this.items, required this.cs, required this.isDark});
  final String title;
  final List<_SettingsTile> items;
  final ColorScheme cs;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleSmall!.copyWith(color: cs.onSurfaceVariant, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.neutral20 : cs.surface,
            borderRadius: AppShapes.r16,
            border: Border.all(color: cs.outlineVariant.withOpacity(0.4)),
          ),
          child: Column(
            children: items.asMap().entries.map((e) {
              return Column(
                children: [
                  e.value,
                  if (e.key < items.length - 1)
                    Divider(height: 1, color: cs.outlineVariant.withOpacity(0.3), indent: 52),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({required this.icon, required this.label, required this.trailing});
  final IconData icon;
  final String label;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListTile(
      leading: Icon(icon, color: cs.onSurfaceVariant),
      title: Text(label),
      trailing: trailing,
      onTap: () {},
    );
  }
}
