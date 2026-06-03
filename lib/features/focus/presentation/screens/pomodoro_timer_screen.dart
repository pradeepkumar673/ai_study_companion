// lib/features/focus/presentation/screens/pomodoro_timer_screen.dart
//
// StudySpark — Full Pomodoro Timer Screen (Step 5)
//
// Features:
//   • Animated arc ring showing phase progress
//   • Work / Short Break / Long Break mode chips
//   • Start / Pause / Resume / Stop / Skip controls
//   • Customisable durations via bottom sheet
//   • Today's total focus time badge
//   • Round counter (4 circles → long break)
//   • Link-to-task selector (shows task name on ring)
//   • Entrance into FocusModeScreen (full-screen immersive)
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../providers/pomodoro_timer_provider.dart';

// ─────────────────────────────────────────────────────────────────────────────

class PomodoroTimerScreen extends ConsumerStatefulWidget {
  const PomodoroTimerScreen({super.key});

  @override
  ConsumerState<PomodoroTimerScreen> createState() =>
      _PomodoroTimerScreenState();
}

class _PomodoroTimerScreenState extends ConsumerState<PomodoroTimerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseCtrl;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  // ── Colour per phase ──────────────────────────────────────────────────────

  Color _phaseColor(PomodoroPhase phase, ColorScheme cs) => switch (phase) {
        PomodoroPhase.work => cs.primary,
        PomodoroPhase.shortBreak => const Color(0xFF22C55E),
        PomodoroPhase.longBreak => const Color(0xFF0EA5E9),
      };

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final timerState = ref.watch(pomodoroTimerProvider);
    final notifier = ref.read(pomodoroTimerProvider.notifier);
    final phaseColor = _phaseColor(timerState.phase, cs);

    // Pulse ring only when running
    if (timerState.isRunning) {
      if (!_pulseCtrl.isAnimating) _pulseCtrl.repeat(reverse: true);
    } else {
      _pulseCtrl.stop();
      _pulseCtrl.value = 0;
    }

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Pomodoro',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.w800),
        ),
        actions: [
          // Focus Mode button
          IconButton(
            icon: const Icon(Icons.fullscreen_rounded),
            tooltip: 'Focus Mode',
            onPressed: () => context.push('/focus/mode'),
          ),
          // Settings
          IconButton(
            icon: const Icon(Icons.tune_rounded),
            tooltip: 'Customise',
            onPressed: () => _showSettingsSheet(context, timerState, notifier),
          ),
          const Gap(4),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Gap(8),

              // ── Phase chips ────────────────────────────────────────────
              _PhaseChips(
                current: timerState.phase,
                isRunning: timerState.isRunning,
                onSelect: (phase) {
                  if (timerState.isRunning) return;
                  notifier.stop();
                },
              ),

              const Gap(28),

              // ── Timer ring ────────────────────────────────────────────
              _TimerRing(
                progress: timerState.progress,
                timeLabel: timerState.timeLabel,
                phaseLabel: timerState.phase.label,
                phaseColor: phaseColor,
                isDark: isDark,
                cs: cs,
                pulseCtrl: _pulseCtrl,
                sessionLabel: timerState.currentSessionLabel,
              ),

              const Gap(32),

              // ── Round dots ───────────────────────────────────────────
              _RoundDots(
                completedRounds: timerState.completedRounds,
                totalRounds: timerState.settings.roundsBeforeLongBreak,
                color: phaseColor,
              ),

              const Gap(28),

              // ── Controls ─────────────────────────────────────────────
              _Controls(
                state: timerState,
                phaseColor: phaseColor,
                onStart: () => notifier.start(),
                onPause: () => notifier.pause(),
                onResume: () => notifier.resume(),
                onStop: () => notifier.stop(),
                onSkip: () => notifier.skipPhase(),
              ),

              const Gap(32),

              // ── Today stats strip ────────────────────────────────────
              _TodayStrip(
                totalMinutes: timerState.todayTotalMinutes,
                sessions: timerState.completedWorkSessions,
                isDark: isDark,
                cs: cs,
                phaseColor: phaseColor,
              ),

              const Gap(24),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Settings bottom sheet ────────────────────────────────────────────────

  void _showSettingsSheet(BuildContext context, PomodoroTimerState state,
      PomodoroTimerNotifier notifier) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) => _SettingsSheet(
        initial: state.settings,
        onSave: (settings) => notifier.updateSettings(settings),
      ),
    );
  }
}

// ─── Phase chips ─────────────────────────────────────────────────────────────

class _PhaseChips extends StatelessWidget {
  const _PhaseChips({
    required this.current,
    required this.isRunning,
    required this.onSelect,
  });

  final PomodoroPhase current;
  final bool isRunning;
  final ValueChanged<PomodoroPhase> onSelect;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: PomodoroPhase.values.map((phase) {
        final isSelected = phase == current;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: AnimatedContainer(
            duration: 250.ms,
            child: ChoiceChip(
              label: Text(phase.label),
              selected: isSelected,
              onSelected: isRunning ? null : (_) => onSelect(phase),
              selectedColor: cs.primaryContainer,
              labelStyle: TextStyle(
                fontWeight:
                    isSelected ? FontWeight.w700 : FontWeight.w500,
                fontSize: 12,
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ─── Timer ring ──────────────────────────────────────────────────────────────

class _TimerRing extends StatelessWidget {
  const _TimerRing({
    required this.progress,
    required this.timeLabel,
    required this.phaseLabel,
    required this.phaseColor,
    required this.isDark,
    required this.cs,
    required this.pulseCtrl,
    required this.sessionLabel,
  });

  final double progress;
  final String timeLabel;
  final String phaseLabel;
  final Color phaseColor;
  final bool isDark;
  final ColorScheme cs;
  final AnimationController pulseCtrl;
  final String sessionLabel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 280,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Subtle glow pulse when running
          AnimatedBuilder(
            animation: pulseCtrl,
            builder: (_, __) => Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: phaseColor
                        .withOpacity(0.08 + 0.10 * pulseCtrl.value),
                    blurRadius: 40 + 20 * pulseCtrl.value,
                    spreadRadius: 4,
                  ),
                ],
              ),
            ),
          ),

          // Arc painter
          CustomPaint(
            size: const Size(280, 280),
            painter: _RingPainter(
              progress: progress,
              ringColor: phaseColor,
              trackColor: phaseColor.withOpacity(0.12),
            ),
          ),

          // Time & label
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (sessionLabel.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: phaseColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    sessionLabel,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: phaseColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              if (sessionLabel.isNotEmpty) const Gap(6),
              Text(
                timeLabel,
                style: TextStyle(
                  fontSize: 54,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : AppColors.neutral10,
                  letterSpacing: -2,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
              const Gap(4),
              Text(
                phaseLabel,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: phaseColor,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Ring painter ─────────────────────────────────────────────────────────────

class _RingPainter extends CustomPainter {
  const _RingPainter({
    required this.progress,
    required this.ringColor,
    required this.trackColor,
  });

  final double progress;
  final Color ringColor;
  final Color trackColor;

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 12.0;
    final rect = Rect.fromCircle(
      center: size.center(Offset.zero),
      radius: size.width / 2 - strokeWidth / 2,
    );

    // Track
    canvas.drawArc(
      rect,
      -1.5707963, // -90°
      6.2831853,  // 360°
      false,
      Paint()
        ..color = trackColor
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );

    // Progress arc
    if (progress > 0) {
      canvas.drawArc(
        rect,
        -1.5707963,
        6.2831853 * progress,
        false,
        Paint()
          ..color = ringColor
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.progress != progress ||
      old.ringColor != ringColor ||
      old.trackColor != trackColor;
}

// ─── Round dots ──────────────────────────────────────────────────────────────

class _RoundDots extends StatelessWidget {
  const _RoundDots({
    required this.completedRounds,
    required this.totalRounds,
    required this.color,
  });

  final int completedRounds;
  final int totalRounds;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final filled = completedRounds % totalRounds;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalRounds, (i) {
        final active = i < filled;
        return AnimatedContainer(
          duration: 300.ms,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: active ? 20 : 10,
          height: 10,
          decoration: BoxDecoration(
            color: active ? color : color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(5),
          ),
        );
      }),
    );
  }
}

// ─── Controls ────────────────────────────────────────────────────────────────

class _Controls extends StatelessWidget {
  const _Controls({
    required this.state,
    required this.phaseColor,
    required this.onStart,
    required this.onPause,
    required this.onResume,
    required this.onStop,
    required this.onSkip,
  });

  final PomodoroTimerState state;
  final Color phaseColor;
  final VoidCallback onStart;
  final VoidCallback onPause;
  final VoidCallback onResume;
  final VoidCallback onStop;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Stop (visible when running/paused)
        if (!state.isIdle && !state.isFinished)
          _ControlButton(
            icon: Icons.stop_rounded,
            color: Colors.red.shade400,
            size: 52,
            onTap: onStop,
            tooltip: 'Stop',
          ),
        const Gap(16),

        // Main play/pause button
        _MainButton(
          state: state,
          phaseColor: phaseColor,
          onStart: onStart,
          onPause: onPause,
          onResume: onResume,
        ),

        const Gap(16),

        // Skip (visible when running/paused)
        if (!state.isIdle && !state.isFinished)
          _ControlButton(
            icon: Icons.skip_next_rounded,
            color: phaseColor.withOpacity(0.7),
            size: 52,
            onTap: onSkip,
            tooltip: 'Skip Phase',
          ),
      ],
    );
  }
}

class _MainButton extends StatelessWidget {
  const _MainButton({
    required this.state,
    required this.phaseColor,
    required this.onStart,
    required this.onPause,
    required this.onResume,
  });

  final PomodoroTimerState state;
  final Color phaseColor;
  final VoidCallback onStart;
  final VoidCallback onPause;
  final VoidCallback onResume;

  @override
  Widget build(BuildContext context) {
    final isRunning = state.isRunning;
    final isPaused = state.isPaused;
    final isFinished = state.isFinished;

    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        if (state.isIdle || isFinished) {
          onStart();
        } else if (isRunning) {
          onPause();
        } else if (isPaused) {
          onResume();
        }
      },
      child: AnimatedContainer(
        duration: 200.ms,
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: phaseColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: phaseColor.withOpacity(0.4),
              blurRadius: isRunning ? 20 : 8,
              spreadRadius: isRunning ? 2 : 0,
            ),
          ],
        ),
        child: Icon(
          isRunning
              ? Icons.pause_rounded
              : (isPaused ? Icons.play_arrow_rounded : Icons.play_arrow_rounded),
          color: Colors.white,
          size: 40,
        ),
      ),
    ).animate().scale(delay: 100.ms, curve: Curves.easeOutBack);
  }
}

class _ControlButton extends StatelessWidget {
  const _ControlButton({
    required this.icon,
    required this.color,
    required this.size,
    required this.onTap,
    required this.tooltip,
  });

  final IconData icon;
  final Color color;
  final double size;
  final VoidCallback onTap;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: size * 0.45),
        ),
      ),
    );
  }
}

// ─── Today strip ─────────────────────────────────────────────────────────────

class _TodayStrip extends StatelessWidget {
  const _TodayStrip({
    required this.totalMinutes,
    required this.sessions,
    required this.isDark,
    required this.cs,
    required this.phaseColor,
  });

  final int totalMinutes;
  final int sessions;
  final bool isDark;
  final ColorScheme cs;
  final Color phaseColor;

  @override
  Widget build(BuildContext context) {
    final hours = totalMinutes ~/ 60;
    final mins = totalMinutes % 60;
    final timeStr = hours > 0 ? '${hours}h ${mins}m' : '${mins}m';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppShadows.sm(Colors.black),
      ),
      child: Row(
        children: [
          Expanded(
            child: _StatCell(
              icon: Icons.local_fire_department_rounded,
              value: timeStr,
              label: "Today's Focus",
              color: phaseColor,
              isDark: isDark,
              cs: cs,
            ),
          ),
          Container(
            width: 1,
            height: 48,
            color: cs.outlineVariant.withOpacity(0.4),
          ),
          Expanded(
            child: _StatCell(
              icon: Icons.check_circle_outline_rounded,
              value: '$sessions',
              label: 'Sessions Done',
              color: const Color(0xFF22C55E),
              isDark: isDark,
              cs: cs,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1);
  }
}

class _StatCell extends StatelessWidget {
  const _StatCell({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
    required this.isDark,
    required this.cs,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color color;
  final bool isDark;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 22),
        const Gap(6),
        Text(
          value,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: isDark ? Colors.white : AppColors.neutral10,
          ),
        ),
        const Gap(2),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: cs.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// ─── Settings sheet ───────────────────────────────────────────────────────────

class _SettingsSheet extends StatefulWidget {
  const _SettingsSheet({required this.initial, required this.onSave});

  final PomodoroSettings initial;
  final ValueChanged<PomodoroSettings> onSave;

  @override
  State<_SettingsSheet> createState() => _SettingsSheetState();
}

class _SettingsSheetState extends State<_SettingsSheet> {
  late int _work;
  late int _shortBreak;
  late int _longBreak;
  late int _rounds;
  late bool _autoBreak;
  late bool _autoWork;

  @override
  void initState() {
    super.initState();
    _work = widget.initial.workMinutes;
    _shortBreak = widget.initial.shortBreakMinutes;
    _longBreak = widget.initial.longBreakMinutes;
    _rounds = widget.initial.roundsBeforeLongBreak;
    _autoBreak = widget.initial.autoStartBreaks;
    _autoWork = widget.initial.autoStartWork;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.fromLTRB(
          24, 24, 24, MediaQuery.of(context).viewInsets.bottom + 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: cs.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const Gap(20),

          Text(
            'Timer Settings',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.w800),
          ),
          const Gap(24),

          _DurationSlider(
            label: 'Focus Duration',
            emoji: '🎯',
            value: _work,
            min: 5,
            max: 90,
            unit: 'min',
            color: cs.primary,
            onChanged: (v) => setState(() => _work = v),
          ),
          const Gap(16),

          _DurationSlider(
            label: 'Short Break',
            emoji: '☕',
            value: _shortBreak,
            min: 1,
            max: 15,
            unit: 'min',
            color: const Color(0xFF22C55E),
            onChanged: (v) => setState(() => _shortBreak = v),
          ),
          const Gap(16),

          _DurationSlider(
            label: 'Long Break',
            emoji: '🌴',
            value: _longBreak,
            min: 5,
            max: 30,
            unit: 'min',
            color: const Color(0xFF0EA5E9),
            onChanged: (v) => setState(() => _longBreak = v),
          ),
          const Gap(16),

          _DurationSlider(
            label: 'Rounds per Long Break',
            emoji: '🔄',
            value: _rounds,
            min: 2,
            max: 8,
            unit: 'rounds',
            color: cs.secondary,
            onChanged: (v) => setState(() => _rounds = v),
          ),
          const Gap(20),

          Row(
            children: [
              Expanded(
                child: _ToggleTile(
                  label: 'Auto-start breaks',
                  value: _autoBreak,
                  onChanged: (v) => setState(() => _autoBreak = v),
                ),
              ),
              const Gap(12),
              Expanded(
                child: _ToggleTile(
                  label: 'Auto-start work',
                  value: _autoWork,
                  onChanged: (v) => setState(() => _autoWork = v),
                ),
              ),
            ],
          ),
          const Gap(24),

          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                widget.onSave(PomodoroSettings(
                  workMinutes: _work,
                  shortBreakMinutes: _shortBreak,
                  longBreakMinutes: _longBreak,
                  roundsBeforeLongBreak: _rounds,
                  autoStartBreaks: _autoBreak,
                  autoStartWork: _autoWork,
                ));
                Navigator.pop(context);
              },
              child: const Text('Save Settings'),
            ),
          ),
        ],
      ),
    );
  }
}

class _DurationSlider extends StatelessWidget {
  const _DurationSlider({
    required this.label,
    required this.emoji,
    required this.value,
    required this.min,
    required this.max,
    required this.unit,
    required this.color,
    required this.onChanged,
  });

  final String label;
  final String emoji;
  final int value;
  final int min;
  final int max;
  final String unit;
  final Color color;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 20)),
        const Gap(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(label,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w600)),
                  Text(
                    '$value $unit',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: color),
                  ),
                ],
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: color,
                  thumbColor: color,
                  overlayColor: color.withOpacity(0.15),
                  inactiveTrackColor: color.withOpacity(0.2),
                  trackHeight: 3,
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                ),
                child: Slider(
                  value: value.toDouble(),
                  min: min.toDouble(),
                  max: max.toDouble(),
                  divisions: max - min,
                  onChanged: (v) => onChanged(v.round()),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ToggleTile extends StatelessWidget {
  const _ToggleTile({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: 200.ms,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: value ? cs.primaryContainer : cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: value ? cs.onPrimaryContainer : cs.onSurface,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }
}
