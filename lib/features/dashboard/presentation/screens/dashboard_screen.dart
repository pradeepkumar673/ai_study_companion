// lib/features/dashboard/presentation/screens/dashboard_screen.dart
//
// StudySpark — Premium Home Dashboard
// Sections: Greeting + Streak Hero, Quick Stats, Today's Timetable,
//           Weekly Focus Chart (fl_chart), Mood Check-in, Quick Access Cards.

import 'dart:math' as math;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../core/enums/app_enums.dart';
import '../../../../core/theme/app_theme.dart';

// ─── Mock data (replace with real providers once wired) ──────────────────────

const _mockUserName = 'Pradeep';
const _mockStreak = 14;
const _mockXp = 2340;
const _mockLevel = 8;

final _mockWeeklyFocus = [42.0, 65.0, 30.0, 80.0, 55.0, 70.0, 48.0]; // minutes
final _mockWeekDays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

class _TimetableEntry {
  final String subject;
  final String time;
  final String room;
  final Color color;
  final bool isNow;
  const _TimetableEntry({
    required this.subject,
    required this.time,
    required this.room,
    required this.color,
    this.isNow = false,
  });
}

const _mockTimetable = [
  _TimetableEntry(
    subject: 'Mathematics',
    time: '08:00 – 09:30',
    room: 'Room 204',
    color: Color(0xFF6C4FF8),
    isNow: false,
  ),
  _TimetableEntry(
    subject: 'Physics Lab',
    time: '09:45 – 11:15',
    room: 'Lab B',
    color: Color(0xFF00BFAE),
    isNow: true,
  ),
  _TimetableEntry(
    subject: 'English Literature',
    time: '11:30 – 13:00',
    room: 'Room 110',
    color: Color(0xFFFF6B3D),
    isNow: false,
  ),
  _TimetableEntry(
    subject: 'Computer Science',
    time: '14:00 – 15:30',
    room: 'CS Lab',
    color: Color(0xFF4C9DFF),
    isNow: false,
  ),
];

class _QuickAction {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.color,
    this.onTap,
  });
}

// ─── Main Screen ─────────────────────────────────────────────────────────────

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen>
    with SingleTickerProviderStateMixin {
  MoodType? _selectedMood;
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── Collapsing App Bar ──────────────────────────────────────────
          _DashboardSliverAppBar(
            cs: cs,
            isDark: isDark,
            greeting: _greeting,
            pulseController: _pulseController,
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
            sliver: SliverList.list(
              children: [
                // ── Quick Stats Row ──────────────────────────────────────
                _QuickStatsRow(cs: cs, isDark: isDark)
                    .animate()
                    .fadeIn(delay: 100.ms, duration: 400.ms)
                    .slideY(begin: 0.2, end: 0),

                const Gap(24),

                // ── Today's Timetable ────────────────────────────────────
                _SectionHeader(
                  title: "Today's Classes",
                  actionLabel: 'Full Schedule',
                  cs: cs,
                ).animate().fadeIn(delay: 150.ms),

                const Gap(12),

                _TimetableSection(cs: cs, isDark: isDark)
                    .animate()
                    .fadeIn(delay: 200.ms, duration: 400.ms)
                    .slideY(begin: 0.2, end: 0),

                const Gap(24),

                // ── Quick Access Cards ───────────────────────────────────
                _SectionHeader(title: 'Quick Access', cs: cs)
                    .animate()
                    .fadeIn(delay: 250.ms),
                const Gap(12),
                _QuickAccessGrid(cs: cs, isDark: isDark)
                    .animate()
                    .fadeIn(delay: 300.ms, duration: 400.ms)
                    .slideY(begin: 0.2, end: 0),

                const Gap(24),

                // ── Weekly Focus Chart ───────────────────────────────────
                _SectionHeader(
                  title: 'Focus This Week',
                  actionLabel: 'Analytics',
                  cs: cs,
                ).animate().fadeIn(delay: 350.ms),
                const Gap(12),
                _WeeklyFocusChart(cs: cs, isDark: isDark)
                    .animate()
                    .fadeIn(delay: 400.ms, duration: 400.ms)
                    .slideY(begin: 0.2, end: 0),

                const Gap(24),

                // ── Mood Check-in ────────────────────────────────────────
                _MoodCheckIn(
                  cs: cs,
                  isDark: isDark,
                  selectedMood: _selectedMood,
                  onMoodSelected: (mood) => setState(() => _selectedMood = mood),
                )
                    .animate()
                    .fadeIn(delay: 450.ms, duration: 400.ms)
                    .slideY(begin: 0.2, end: 0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Sliver App Bar ───────────────────────────────────────────────────────────

class _DashboardSliverAppBar extends StatelessWidget {
  const _DashboardSliverAppBar({
    required this.cs,
    required this.isDark,
    required this.greeting,
    required this.pulseController,
  });

  final ColorScheme cs;
  final bool isDark;
  final String greeting;
  final AnimationController pulseController;

  @override
  Widget build(BuildContext context) {
    final today = DateFormat('EEEE, MMMM d').format(DateTime.now());

    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: _HeroHeader(
          cs: cs,
          isDark: isDark,
          greeting: greeting,
          today: today,
          pulseController: pulseController,
        ),
        titlePadding: EdgeInsets.zero,
      ),
      actions: [
        // Notifications bell
        Container(
          margin: const EdgeInsets.only(right: 8),
          child: IconButton(
            icon: Badge(
              smallSize: 8,
              backgroundColor: AppColors.tertiary,
              child: Icon(
                Icons.notifications_outlined,
                color: isDark ? Colors.white70 : AppColors.neutral10,
              ),
            ),
            onPressed: () {},
          ),
        ),
        // Avatar
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: GestureDetector(
            onTap: () {},
            child: CircleAvatar(
              radius: 18,
              backgroundColor: cs.primaryContainer,
              child: Text(
                _mockUserName[0],
                style: TextStyle(
                  color: cs.onPrimaryContainer,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Hero Header ─────────────────────────────────────────────────────────────

class _HeroHeader extends StatelessWidget {
  const _HeroHeader({
    required this.cs,
    required this.isDark,
    required this.greeting,
    required this.today,
    required this.pulseController,
  });

  final ColorScheme cs;
  final bool isDark;
  final String greeting;
  final String today;
  final AnimationController pulseController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF1A1040), const Color(0xFF0D0B17)]
              : [const Color(0xFF6C4FF8), const Color(0xFF9B6DFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            top: -30,
            right: -20,
            child: AnimatedBuilder(
              animation: pulseController,
              builder: (_, __) => Opacity(
                opacity: 0.08 + 0.04 * pulseController.value,
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -40,
            left: -20,
            child: Opacity(
              opacity: 0.06,
              child: Container(
                width: 140,
                height: 140,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // Content
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    today,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const Gap(4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$greeting,',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              _mockUserName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                height: 1.1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Streak badge
                      _StreakBadge(streak: _mockStreak),
                    ],
                  ),
                  const Gap(12),
                  // XP bar
                  _XpBar(xp: _mockXp, level: _mockLevel),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Streak Badge ─────────────────────────────────────────────────────────────

class _StreakBadge extends StatelessWidget {
  const _StreakBadge({required this.streak});
  final int streak;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.25)),
      ),
      child: Column(
        children: [
          const Text('🔥', style: TextStyle(fontSize: 20)),
          const Gap(2),
          Text(
            '$streak',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
          const Text(
            'day streak',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── XP Bar ───────────────────────────────────────────────────────────────────

class _XpBar extends StatelessWidget {
  const _XpBar({required this.xp, required this.level});
  final int xp;
  final int level;

  @override
  Widget build(BuildContext context) {
    const xpPerLevel = 500;
    final progress = (xp % xpPerLevel) / xpPerLevel;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'Lv $level',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const Gap(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                  minHeight: 5,
                ),
              ),
              const Gap(3),
              Text(
                '${xp % xpPerLevel} / $xpPerLevel XP',
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Quick Stats Row ──────────────────────────────────────────────────────────

class _QuickStatsRow extends StatelessWidget {
  const _QuickStatsRow({required this.cs, required this.isDark});
  final ColorScheme cs;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: Icons.task_alt_rounded,
            label: 'Tasks Due',
            value: '5',
            sub: '2 overdue',
            color: AppColors.tertiary,
            cs: cs,
            isDark: isDark,
          ),
        ),
        const Gap(12),
        Expanded(
          child: _StatCard(
            icon: Icons.timer_rounded,
            label: 'Study Hours',
            value: '3.5h',
            sub: 'Today',
            color: AppColors.primary,
            cs: cs,
            isDark: isDark,
          ),
        ),
        const Gap(12),
        Expanded(
          child: _StatCard(
            icon: Icons.bolt_rounded,
            label: 'Focus Score',
            value: '82',
            sub: '+6 vs. avg',
            color: AppColors.secondary,
            cs: cs,
            isDark: isDark,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.sub,
    required this.color,
    required this.cs,
    required this.isDark,
  });

  final IconData icon;
  final String label;
  final String value;
  final String sub;
  final Color color;
  final ColorScheme cs;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppShadows.sm(Colors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const Gap(10),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: isDark ? Colors.white : AppColors.neutral10,
              height: 1,
            ),
          ),
          const Gap(2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: cs.onSurfaceVariant,
            ),
          ),
          const Gap(4),
          Text(
            sub,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Section Header ───────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.cs,
    this.actionLabel,
  });

  final String title;
  final String? actionLabel;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: cs.onSurface,
          ),
        ),
        const Spacer(),
        if (actionLabel != null)
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  actionLabel!,
                  style: TextStyle(
                    fontSize: 13,
                    color: cs.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(2),
                Icon(Icons.chevron_right_rounded, size: 16, color: cs.primary),
              ],
            ),
          ),
      ],
    );
  }
}

// ─── Timetable Section ────────────────────────────────────────────────────────

class _TimetableSection extends StatelessWidget {
  const _TimetableSection({required this.cs, required this.isDark});
  final ColorScheme cs;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemCount: _mockTimetable.length,
        separatorBuilder: (_, __) => const Gap(12),
        itemBuilder: (context, index) {
          final entry = _mockTimetable[index];
          return _TimetableCard(entry: entry, isDark: isDark, cs: cs);
        },
      ),
    );
  }
}

class _TimetableCard extends StatelessWidget {
  const _TimetableCard({
    required this.entry,
    required this.isDark,
    required this.cs,
  });

  final _TimetableEntry entry;
  final bool isDark;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 150,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: entry.isNow
            ? entry.color
            : (isDark ? AppColors.surfaceDark : Colors.white),
        borderRadius: BorderRadius.circular(18),
        border: entry.isNow
            ? null
            : Border.all(
                color: entry.color.withOpacity(0.2),
                width: 1.5,
              ),
        boxShadow: entry.isNow ? AppShadows.glow(entry.color) : AppShadows.sm(Colors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: entry.isNow ? Colors.white : entry.color,
                  shape: BoxShape.circle,
                ),
              ),
              if (entry.isNow) ...[
                const Gap(6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'NOW',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const Spacer(),
          Text(
            entry.subject,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: entry.isNow ? Colors.white : cs.onSurface,
              height: 1.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Gap(4),
          Text(
            entry.time,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: entry.isNow ? Colors.white70 : cs.onSurfaceVariant,
            ),
          ),
          const Gap(2),
          Row(
            children: [
              Icon(
                Icons.location_on_rounded,
                size: 10,
                color: entry.isNow ? Colors.white60 : entry.color,
              ),
              const Gap(2),
              Text(
                entry.room,
                style: TextStyle(
                  fontSize: 10,
                  color: entry.isNow ? Colors.white60 : entry.color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Quick Access Grid ────────────────────────────────────────────────────────

class _QuickAccessGrid extends StatelessWidget {
  const _QuickAccessGrid({required this.cs, required this.isDark});
  final ColorScheme cs;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final actions = [
      _QuickAction(
        icon: Icons.timer_rounded,
        label: 'Pomodoro',
        color: AppColors.primary,
      ),
      _QuickAction(
        icon: Icons.psychology_rounded,
        label: 'AI Assistant',
        color: const Color(0xFF7C3AED),
      ),
      _QuickAction(
        icon: Icons.add_task_rounded,
        label: 'Add Task',
        color: AppColors.secondary,
      ),
      _QuickAction(
        icon: Icons.style_rounded,
        label: 'Flashcards',
        color: AppColors.tertiary,
      ),
      _QuickAction(
        icon: Icons.edit_note_rounded,
        label: 'Notes',
        color: AppColors.chartAmber,
      ),
      _QuickAction(
        icon: Icons.flag_rounded,
        label: 'Goals',
        color: AppColors.chartPink,
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.05,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        return _QuickAccessTile(
          action: actions[index],
          isDark: isDark,
          cs: cs,
        )
            .animate(delay: Duration(milliseconds: 60 * index))
            .fadeIn(duration: 300.ms)
            .scale(begin: const Offset(0.85, 0.85), end: const Offset(1, 1));
      },
    );
  }
}

class _QuickAccessTile extends StatelessWidget {
  const _QuickAccessTile({
    required this.action,
    required this.isDark,
    required this.cs,
  });

  final _QuickAction action;
  final bool isDark;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: action.onTap ?? () {},
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: AppShadows.sm(Colors.black),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: action.color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(action.icon, color: action.color, size: 22),
              ),
              const Gap(8),
              Text(
                action.label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: cs.onSurface,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Weekly Focus Chart ───────────────────────────────────────────────────────

class _WeeklyFocusChart extends StatefulWidget {
  const _WeeklyFocusChart({required this.cs, required this.isDark});
  final ColorScheme cs;
  final bool isDark;

  @override
  State<_WeeklyFocusChart> createState() => _WeeklyFocusChartState();
}

class _WeeklyFocusChartState extends State<_WeeklyFocusChart> {
  int _touchedIndex = -1;

  double get _totalMinutes =>
      _mockWeeklyFocus.fold(0, (sum, v) => sum + v);

  String get _totalFormatted {
    final totalMinutes = _totalMinutes.round();
    final hours = totalMinutes ~/ 60;
    final mins = totalMinutes % 60;
    return '${hours}h ${mins}m';
  }

  @override
  Widget build(BuildContext context) {
    final todayIdx = DateTime.now().weekday - 1; // 0 = Monday

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: widget.isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppShadows.sm(Colors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _totalFormatted,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: widget.isDark ? Colors.white : AppColors.neutral10,
                    ),
                  ),
                  Text(
                    'Total this week',
                    style: TextStyle(
                      fontSize: 12,
                      color: widget.cs.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Mini line sparkline
              SizedBox(
                width: 80,
                height: 36,
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: false),
                    titlesData: const FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                    lineTouchData: const LineTouchData(enabled: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: _mockWeeklyFocus
                            .asMap()
                            .entries
                            .map((e) => FlSpot(e.key.toDouble(), e.value))
                            .toList(),
                        isCurved: true,
                        color: AppColors.primary,
                        barWidth: 2,
                        dotData: const FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          color: AppColors.primary.withOpacity(0.1),
                        ),
                      ),
                    ],
                    minY: 0,
                    maxY: 100,
                  ),
                ),
              ),
            ],
          ),

          const Gap(20),

          // Bar chart
          SizedBox(
            height: 130,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 100,
                barTouchData: BarTouchData(
                  touchCallback: (event, response) {
                    if (event is FlTapUpEvent || event is FlPanEndEvent) {
                      setState(() {
                        _touchedIndex =
                            response?.spot?.touchedBarGroupIndex ?? -1;
                      });
                    }
                  },
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (_) => AppColors.neutral10,
                    tooltipRoundedRadius: 8,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      final mins = rod.toY.round();
                      final h = mins ~/ 60;
                      final m = mins % 60;
                      return BarTooltipItem(
                        h > 0 ? '${h}h ${m}m' : '${m}m',
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final idx = value.toInt();
                        final isToday = idx == todayIdx;
                        return Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            _mockWeekDays[idx],
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight:
                                  isToday ? FontWeight.w800 : FontWeight.w500,
                              color: isToday
                                  ? AppColors.primary
                                  : widget.cs.onSurfaceVariant,
                            ),
                          ),
                        );
                      },
                      reservedSize: 24,
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 25,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: widget.cs.outlineVariant.withOpacity(0.3),
                    strokeWidth: 1,
                    dashArray: [4, 4],
                  ),
                ),
                barGroups: _mockWeeklyFocus.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final value = entry.value;
                  final isTouched = idx == _touchedIndex;
                  final isToday = idx == todayIdx;

                  Color barColor;
                  if (isToday) {
                    barColor = AppColors.primary;
                  } else if (isTouched) {
                    barColor = AppColors.secondary;
                  } else {
                    barColor = widget.isDark
                        ? AppColors.neutral30
                        : const Color(0xFFE8E5F0);
                  }

                  return BarChartGroupData(
                    x: idx,
                    barRods: [
                      BarChartRodData(
                        toY: value,
                        color: barColor,
                        width: 22,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(8),
                          bottom: Radius.circular(4),
                        ),
                        backDrawRodData: BackgroundBarChartRodData(
                          show: true,
                          toY: 100,
                          color: widget.isDark
                              ? Colors.white.withOpacity(0.04)
                              : Colors.black.withOpacity(0.03),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
              swapAnimationDuration: const Duration(milliseconds: 600),
              swapAnimationCurve: Curves.easeOutCubic,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Mood Check-In ────────────────────────────────────────────────────────────

class _MoodCheckIn extends StatelessWidget {
  const _MoodCheckIn({
    required this.cs,
    required this.isDark,
    required this.selectedMood,
    required this.onMoodSelected,
  });

  final ColorScheme cs;
  final bool isDark;
  final MoodType? selectedMood;
  final ValueChanged<MoodType> onMoodSelected;

  @override
  Widget build(BuildContext context) {
    final alreadyLogged = selectedMood != null;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: alreadyLogged
            ? LinearGradient(
                colors: [
                  selectedMood!._color.withOpacity(isDark ? 0.3 : 0.08),
                  selectedMood!._color.withOpacity(isDark ? 0.1 : 0.03),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: alreadyLogged
            ? null
            : (isDark ? AppColors.surfaceDark : Colors.white),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: alreadyLogged
              ? selectedMood!._color.withOpacity(0.3)
              : cs.outlineVariant.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: AppShadows.sm(Colors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                alreadyLogged ? 'Mood Logged  ✓' : "How are you feeling?",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: alreadyLogged ? selectedMood!._color : cs.onSurface,
                ),
              ),
              const Spacer(),
              if (!alreadyLogged)
                Text(
                  'Daily check-in',
                  style: TextStyle(
                    fontSize: 12,
                    color: cs.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
          const Gap(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: MoodType.values.map((mood) {
              final isSelected = selectedMood == mood;
              return GestureDetector(
                onTap: () => onMoodSelected(mood),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutBack,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? mood._color.withOpacity(0.15)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                    border: isSelected
                        ? Border.all(color: mood._color, width: 2)
                        : null,
                  ),
                  child: Column(
                    children: [
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 250),
                        style: TextStyle(
                          fontSize: isSelected ? 30 : 24,
                        ),
                        child: Text(mood.emoji),
                      ),
                      const Gap(4),
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 250),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                          color: isSelected ? mood._color : cs.onSurfaceVariant,
                        ),
                        child: Text(mood.label),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          if (alreadyLogged) ...[
            const Gap(12),
            Text(
              'Great! Keep tracking your mood daily for better insights.',
              style: TextStyle(
                fontSize: 12,
                color: cs.onSurfaceVariant,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

extension _MoodColor on MoodType {
  Color get _color {
    switch (this) {
      case MoodType.terrible:
        return const Color(0xFFE53935);
      case MoodType.bad:
        return const Color(0xFFFF6B3D);
      case MoodType.neutral:
        return const Color(0xFFFFB547);
      case MoodType.good:
        return const Color(0xFF2ED47A);
      case MoodType.excellent:
        return const Color(0xFF6C4FF8);
    }
  }
}
