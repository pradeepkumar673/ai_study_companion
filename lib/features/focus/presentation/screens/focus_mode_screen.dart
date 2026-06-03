// lib/features/focus/presentation/screens/focus_mode_screen.dart
//
// StudySpark — Focus Mode (Full-screen immersive, Step 5)
//
// Features:
//   • Hides system UI (status bar + nav bar) for full immersion
//   • Dark canvas with animated particle background
//   • Live Pomodoro timer arc centred on screen
//   • Rotating motivational quotes (auto-cycle every 30 s)
//   • Simulated distraction-blocker overlay (shows blocked app list)
//   • Exit confirmation dialog
// ─────────────────────────────────────────────────────────────────────────────

import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../providers/pomodoro_timer_provider.dart';

// ─── Motivational quotes ──────────────────────────────────────────────────────

const _quotes = [
  ('The secret of getting ahead is getting started.', '— Mark Twain'),
  ('It does not matter how slowly you go as long as you do not stop.', '— Confucius'),
  ('You don\'t have to be great to start, but you have to start to be great.', '— Zig Ziglar'),
  ('Concentrate all your thoughts upon the work in hand.', '— Alexander Graham Bell'),
  ('The key is not to prioritise what\'s on your schedule, but to schedule your priorities.', '— Stephen Covey'),
  ('Done is better than perfect.', '— Sheryl Sandberg'),
  ('Focus on being productive instead of busy.', '— Tim Ferriss'),
  ('Successful people do what unsuccessful people are not willing to do.', '— Jeff Olson'),
  ('Your mind is for having ideas, not holding them.', '— David Allen'),
  ('Small daily improvements are the key to staggering long-term results.', '— Robin Sharma'),
];

const _blockedApps = [
  ('Instagram', '📸'),
  ('TikTok', '🎵'),
  ('Twitter / X', '🐦'),
  ('YouTube', '▶️'),
  ('WhatsApp', '💬'),
  ('Snapchat', '👻'),
];

// ─────────────────────────────────────────────────────────────────────────────

class FocusModeScreen extends ConsumerStatefulWidget {
  const FocusModeScreen({super.key});

  @override
  ConsumerState<FocusModeScreen> createState() => _FocusModeScreenState();
}

class _FocusModeScreenState extends ConsumerState<FocusModeScreen>
    with TickerProviderStateMixin {
  late AnimationController _particleCtrl;
  late AnimationController _quoteCtrl;
  late AnimationController _pulseCtrl;

  int _quoteIndex = 0;
  Timer? _quoteTimer;
  bool _showBlockedSheet = false;

  @override
  void initState() {
    super.initState();

    // Hide system UI for full immersion
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    _particleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _quoteCtrl = AnimationController(
      vsync: this,
      duration: 600.ms,
    )..forward();

    _quoteTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      _quoteCtrl.reverse().then((_) {
        if (mounted) {
          setState(() {
            _quoteIndex = (_quoteIndex + 1) % _quotes.length;
          });
          _quoteCtrl.forward();
        }
      });
    });
  }

  @override
  void dispose() {
    // Restore system UI
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _particleCtrl.dispose();
    _quoteCtrl.dispose();
    _pulseCtrl.dispose();
    _quoteTimer?.cancel();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    final timerState = ref.read(pomodoroTimerProvider);
    if (!timerState.isRunning) return true;

    return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Exit Focus Mode?'),
            content: const Text(
                'Your timer is still running. Do you want to leave focus mode?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Stay'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('Exit'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final timerState = ref.watch(pomodoroTimerProvider);
    final notifier = ref.read(pomodoroTimerProvider.notifier);

    final phaseColor = timerState.phase == PomodoroPhase.work
        ? const Color(0xFF818CF8) // indigo-400
        : timerState.phase == PomodoroPhase.shortBreak
            ? const Color(0xFF34D399) // emerald-400
            : const Color(0xFF38BDF8); // sky-400

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        final shouldPop = await _onWillPop();
        if (shouldPop && mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0F),
        body: Stack(
          children: [
            // ── Particle background ──────────────────────────────────
            AnimatedBuilder(
              animation: _particleCtrl,
              builder: (_, __) => CustomPaint(
                painter: _ParticlePainter(
                  t: _particleCtrl.value,
                  color: phaseColor,
                ),
                child: const SizedBox.expand(),
              ),
            ),

            // ── Main content ─────────────────────────────────────────
            SafeArea(
              child: Column(
                children: [
                  // Top row: close + blocker toggle
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 8),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close_rounded,
                              color: Colors.white54),
                          onPressed: () async {
                            final shouldPop = await _onWillPop();
                            if (shouldPop && mounted) {
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                        const Spacer(),
                        // Distraction blocker chip
                        GestureDetector(
                          onTap: () => setState(
                              () => _showBlockedSheet = !_showBlockedSheet),
                          child: AnimatedContainer(
                            duration: 200.ms,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: _showBlockedSheet
                                  ? phaseColor.withOpacity(0.2)
                                  : Colors.white.withOpacity(0.06),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: _showBlockedSheet
                                    ? phaseColor.withOpacity(0.5)
                                    : Colors.white.withOpacity(0.1),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.block_rounded,
                                  size: 14,
                                  color: _showBlockedSheet
                                      ? phaseColor
                                      : Colors.white54,
                                ),
                                const Gap(6),
                                Text(
                                  'Distractions Blocked',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: _showBlockedSheet
                                        ? phaseColor
                                        : Colors.white54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Phase label
                  Text(
                    timerState.phase.label.toUpperCase(),
                    style: TextStyle(
                      fontSize: 11,
                      letterSpacing: 3,
                      fontWeight: FontWeight.w600,
                      color: phaseColor,
                    ),
                  ).animate().fadeIn(),

                  const Spacer(),

                  // ── Giant ring + time ──────────────────────────────────
                  _FocusRing(
                    progress: timerState.progress,
                    timeLabel: timerState.timeLabel,
                    phaseColor: phaseColor,
                    pulseCtrl: _pulseCtrl,
                    isRunning: timerState.isRunning,
                  ),

                  const Gap(20),

                  // Round dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        timerState.settings.roundsBeforeLongBreak, (i) {
                      final filled =
                          i < (timerState.completedRounds %
                              timerState.settings.roundsBeforeLongBreak);
                      return AnimatedContainer(
                        duration: 300.ms,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: filled ? 16 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: filled
                              ? phaseColor
                              : phaseColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),

                  const Spacer(),

                  // ── Quote ─────────────────────────────────────────────
                  FadeTransition(
                    opacity: _quoteCtrl,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          Text(
                            '"${_quotes[_quoteIndex].$1}"',
                            style: const TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              color: Colors.white70,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const Gap(8),
                          Text(
                            _quotes[_quoteIndex].$2,
                            style: TextStyle(
                              fontSize: 12,
                              color: phaseColor.withOpacity(0.8),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Gap(32),

                  // ── Controls ──────────────────────────────────────────
                  _FocusControls(
                    state: timerState,
                    phaseColor: phaseColor,
                    onStart: () => notifier.start(),
                    onPause: () => notifier.pause(),
                    onResume: () => notifier.resume(),
                    onStop: () => notifier.stop(),
                    onSkip: () => notifier.skipPhase(),
                  ),

                  const Gap(40),
                ],
              ),
            ),

            // ── Distraction blocker overlay ───────────────────────────
            AnimatedPositioned(
              duration: 300.ms,
              curve: Curves.easeOutCubic,
              bottom: _showBlockedSheet ? 0 : -260,
              left: 0,
              right: 0,
              child: _DistractionSheet(
                color: phaseColor,
                onDismiss: () =>
                    setState(() => _showBlockedSheet = false),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Focus ring ───────────────────────────────────────────────────────────────

class _FocusRing extends StatelessWidget {
  const _FocusRing({
    required this.progress,
    required this.timeLabel,
    required this.phaseColor,
    required this.pulseCtrl,
    required this.isRunning,
  });

  final double progress;
  final String timeLabel;
  final Color phaseColor;
  final AnimationController pulseCtrl;
  final bool isRunning;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Glow
          AnimatedBuilder(
            animation: pulseCtrl,
            builder: (_, __) => Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: phaseColor
                        .withOpacity(0.1 + 0.15 * pulseCtrl.value),
                    blurRadius: 60 + 30 * pulseCtrl.value,
                    spreadRadius: 5,
                  ),
                ],
              ),
            ),
          ),

          CustomPaint(
            size: const Size(300, 300),
            painter: _FocusRingPainter(
              progress: progress,
              ringColor: phaseColor,
              trackColor: phaseColor.withOpacity(0.08),
            ),
          ),

          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                timeLabel,
                style: const TextStyle(
                  fontSize: 68,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -2,
                  fontFeatures: [FontFeature.tabularFigures()],
                ),
              ),
              const Gap(4),
              Text(
                isRunning ? '● RUNNING' : '■ PAUSED',
                style: TextStyle(
                  fontSize: 11,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.w600,
                  color: isRunning
                      ? phaseColor
                      : Colors.white38,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FocusRingPainter extends CustomPainter {
  const _FocusRingPainter({
    required this.progress,
    required this.ringColor,
    required this.trackColor,
  });

  final double progress;
  final Color ringColor;
  final Color trackColor;

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 14.0;
    final rect = Rect.fromCircle(
      center: size.center(Offset.zero),
      radius: size.width / 2 - strokeWidth / 2,
    );

    canvas.drawArc(
      rect,
      -math.pi / 2,
      math.pi * 2,
      false,
      Paint()
        ..color = trackColor
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );

    if (progress > 0) {
      canvas.drawArc(
        rect,
        -math.pi / 2,
        math.pi * 2 * progress,
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
  bool shouldRepaint(_FocusRingPainter old) =>
      old.progress != progress ||
      old.ringColor != ringColor ||
      old.trackColor != trackColor;
}

// ─── Focus controls ───────────────────────────────────────────────────────────

class _FocusControls extends StatelessWidget {
  const _FocusControls({
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
        if (!state.isIdle && !state.isFinished)
          _FocusBtn(
            icon: Icons.stop_rounded,
            color: Colors.red.shade400,
            size: 56,
            onTap: onStop,
          ),
        const Gap(20),
        _FocusBtn(
          icon: state.isRunning
              ? Icons.pause_rounded
              : Icons.play_arrow_rounded,
          color: phaseColor,
          size: 72,
          onTap: () {
            HapticFeedback.mediumImpact();
            if (state.isIdle || state.isFinished) {
              onStart();
            } else if (state.isRunning) {
              onPause();
            } else {
              onResume();
            }
          },
        ),
        const Gap(20),
        if (!state.isIdle && !state.isFinished)
          _FocusBtn(
            icon: Icons.skip_next_rounded,
            color: phaseColor.withOpacity(0.6),
            size: 56,
            onTap: onSkip,
          ),
      ],
    );
  }
}

class _FocusBtn extends StatelessWidget {
  const _FocusBtn({
    required this.icon,
    required this.color,
    required this.size,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final double size;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          shape: BoxShape.circle,
          border: Border.all(color: color.withOpacity(0.4), width: 1.5),
        ),
        child: Icon(icon, color: color, size: size * 0.45),
      ),
    );
  }
}

// ─── Distraction blocker sheet ────────────────────────────────────────────────

class _DistractionSheet extends StatelessWidget {
  const _DistractionSheet({
    required this.color,
    required this.onDismiss,
  });

  final Color color;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF12121A),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        border: Border(
          top: BorderSide(color: color.withOpacity(0.2), width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(Icons.block_rounded, color: color, size: 18),
              const Gap(8),
              Text(
                'Blocking Distractions',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
              const Spacer(),
              IconButton(
                icon:
                    const Icon(Icons.close_rounded, color: Colors.white38, size: 18),
                onPressed: onDismiss,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const Gap(4),
          const Text(
            'These apps are blocked during your focus session',
            style: TextStyle(fontSize: 12, color: Colors.white38),
          ),
          const Gap(16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _blockedApps
                .map((app) => _BlockedChip(name: app.$1, emoji: app.$2))
                .toList(),
          ),
          const Gap(16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color.withOpacity(0.15)),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline_rounded,
                    size: 16, color: color),
                const Gap(8),
                Expanded(
                  child: Text(
                    'On a real device, system-level blocking requires device-manager permissions. '
                    'This simulates the experience — enable in Settings for full blocking.',
                    style: TextStyle(
                      fontSize: 11,
                      color: color.withOpacity(0.8),
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BlockedChip extends StatelessWidget {
  const _BlockedChip({required this.name, required this.emoji});

  final String name;
  final String emoji;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(20),
        border:
            Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 14)),
          const Gap(6),
          Text(
            name,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white60,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Particle painter ─────────────────────────────────────────────────────────

class _ParticlePainter extends CustomPainter {
  const _ParticlePainter({required this.t, required this.color});

  final double t;
  final Color color;

  static const _count = 30;
  static final _rng = math.Random(42);
  static final _particles = List.generate(
    _count,
    (i) => [
      _rng.nextDouble(), // x fraction
      _rng.nextDouble(), // y fraction
      _rng.nextDouble() * 0.5 + 0.2, // speed
      _rng.nextDouble() * 3 + 1, // radius
      _rng.nextDouble(), // phase offset
    ],
  );

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (final p in _particles) {
      final x = (p[0] + t * p[2] * 0.05) % 1.0 * size.width;
      final y = (p[1] + t * p[2] * 0.03) % 1.0 * size.height;
      final opacity = (math.sin((t + p[4]) * math.pi * 2) + 1) / 2 * 0.25;

      paint.color = color.withOpacity(opacity.clamp(0.02, 0.25));
      canvas.drawCircle(Offset(x, y), p[3], paint);
    }
  }

  @override
  bool shouldRepaint(_ParticlePainter old) => old.t != t;
}
