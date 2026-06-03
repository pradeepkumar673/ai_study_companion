// lib/features/profile/presentation/screens/profile_screen.dart
//
// StudySpark — Full Profile Screen
// Features:
//   • Animated hero header with editable avatar & name
//   • XP level-up progress bar
//   • Stats overview (tasks done, focus hours, day streak)
//   • Achievement Badges showcase with locked/unlocked states
//   • Settings (theme, notifications, Pomodoro, account)
//   • Cloud Sync status widget
//   • Offline banner
//   • Study Groups preview panel
//   • Career Guidance quick-access card
// ─────────────────────────────────────────────────────────────────────────────

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../shared/providers/theme_provider.dart';
import '../providers/profile_providers.dart';
import '../widgets/achievement_badges_section.dart';
import '../widgets/cloud_sync_card.dart';
import '../widgets/offline_banner.dart';
import '../widgets/profile_settings_section.dart';
import '../widgets/study_groups_preview.dart';
import '../widgets/career_guidance_card.dart';
import '../widgets/xp_progress_card.dart';
import '../widgets/stats_row.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen>
    with TickerProviderStateMixin {
  late final AnimationController _headerCtrl;
  bool _isEditingName = false;
  final _nameCtrl = TextEditingController(text: 'Student');

  @override
  void initState() {
    super.initState();
    _headerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
  }

  @override
  void dispose() {
    _headerCtrl.dispose();
    _nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isOffline = ref.watch(isOfflineProvider);

    return Scaffold(
      backgroundColor: cs.surface,
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // ── Hero App Bar ──────────────────────────────────────────────
              _ProfileSliverAppBar(
                nameCtrl: _nameCtrl,
                isEditingName: _isEditingName,
                onEditToggle: () => setState(() => _isEditingName = !_isEditingName),
                onEditDone: () => setState(() => _isEditingName = false),
                isDark: isDark,
              ),

              // ── Body ──────────────────────────────────────────────────────
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 120),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Offline banner (conditional)
                    if (isOffline) ...[
                      const OfflineBanner(),
                      const SizedBox(height: 12),
                    ],

                    // XP Progress
                    const XpProgressCard(),
                    const SizedBox(height: 16),

                    // Stats row
                    const ProfileStatsRow(),
                    const SizedBox(height: 20),

                    // Cloud Sync status
                    const CloudSyncCard(),
                    const SizedBox(height: 20),

                    // Achievement Badges
                    const AchievementBadgesSection(),
                    const SizedBox(height: 20),

                    // Study Groups Preview
                    const StudyGroupsPreview(),
                    const SizedBox(height: 20),

                    // Career Guidance
                    const CareerGuidanceCard(),
                    const SizedBox(height: 20),

                    // Settings
                    const ProfileSettingsSection(),
                    const SizedBox(height: 8),
                  ]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Sliver App Bar ───────────────────────────────────────────────────────────

class _ProfileSliverAppBar extends ConsumerWidget {
  const _ProfileSliverAppBar({
    required this.nameCtrl,
    required this.isEditingName,
    required this.onEditToggle,
    required this.onEditDone,
    required this.isDark,
  });

  final TextEditingController nameCtrl;
  final bool isEditingName;
  final VoidCallback onEditToggle;
  final VoidCallback onEditDone;
  final bool isDark;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverAppBar(
      expandedHeight: 220,
      pinned: true,
      stretch: true,
      backgroundColor: AppColors.primary,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined, color: Colors.white),
          onPressed: () {},
          tooltip: 'Notifications',
        ),
        IconButton(
          icon: const Icon(Icons.share_outlined, color: Colors.white),
          onPressed: () {},
          tooltip: 'Share Profile',
        ),
        const SizedBox(width: 4),
      ],
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
        ],
        background: _HeaderBackground(
          nameCtrl: nameCtrl,
          isEditingName: isEditingName,
          onEditToggle: onEditToggle,
          onEditDone: onEditDone,
        ),
      ),
    );
  }
}

class _HeaderBackground extends StatelessWidget {
  const _HeaderBackground({
    required this.nameCtrl,
    required this.isEditingName,
    required this.onEditToggle,
    required this.onEditDone,
  });

  final TextEditingController nameCtrl;
  final bool isEditingName;
  final VoidCallback onEditToggle;
  final VoidCallback onEditDone;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, Color(0xFF7C5FBF), Color(0xFF4F46E5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            top: -30,
            right: -40,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),
          Positioned(
            bottom: -20,
            left: -20,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
              child: Column(
                children: [
                  // Avatar with edit button
                  Stack(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.2),
                          border: Border.all(
                            color: Colors.white,
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.person_rounded,
                          color: Colors.white,
                          size: 44,
                        ),
                      )
                          .animate()
                          .scale(
                              duration: 600.ms,
                              curve: Curves.easeOutBack),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                              color: AppColors.secondary,
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              color: Colors.white,
                              size: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Editable name
                  GestureDetector(
                    onTap: onEditToggle,
                    child: isEditingName
                        ? SizedBox(
                            width: 180,
                            height: 36,
                            child: TextField(
                              controller: nameCtrl,
                              autofocus: true,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 6),
                                filled: true,
                                fillColor: Colors.white24,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              onSubmitted: (_) => onEditDone(),
                            ),
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                nameCtrl.text,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Icon(
                                Icons.edit_rounded,
                                color: Colors.white.withOpacity(0.7),
                                size: 15,
                              ),
                            ],
                          ).animate(delay: 200.ms).fadeIn(),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Level 3 · 1,240 XP · 🔥 7 day streak',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 12,
                    ),
                  ).animate(delay: 350.ms).fadeIn(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}