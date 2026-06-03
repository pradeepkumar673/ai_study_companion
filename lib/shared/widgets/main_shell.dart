// lib/shared/widgets/main_shell.dart
//
// StudySpark — Premium bottom navigation scaffold.
// Features: glassmorphism nav bar, animated active indicator,
// context-aware FAB, ripple-free ink, and tab-index provider sync.

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/haptic_utils.dart';
import '../../core/router/app_router.dart';
import '../providers/ui_state_providers.dart';
import 'connectivity_banner.dart';

// ─── Nav Item Model ───────────────────────────────────────────────────────────

class _NavItem {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.tooltip,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
  final String tooltip;
}

const _navItems = [
  _NavItem(
    label: 'Home',
    icon: Icons.home_outlined,
    activeIcon: Icons.home_rounded,
    tooltip: 'Dashboard',
  ),
  _NavItem(
    label: 'Tasks',
    icon: Icons.check_circle_outline_rounded,
    activeIcon: Icons.check_circle_rounded,
    tooltip: 'My Tasks',
  ),
  _NavItem(
    label: 'Notes',
    icon: Icons.sticky_note_2_outlined,
    activeIcon: Icons.sticky_note_2_rounded,
    tooltip: 'Notes',
  ),
  _NavItem(
    label: 'Analytics',
    icon: Icons.bar_chart_outlined,
    activeIcon: Icons.bar_chart_rounded,
    tooltip: 'Analytics',
  ),
  _NavItem(
    label: 'Profile',
    icon: Icons.person_outline_rounded,
    activeIcon: Icons.person_rounded,
    tooltip: 'Profile',
  ),
];

// ─── Main Shell ───────────────────────────────────────────────────────────────

class MainShell extends ConsumerWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _onTap(WidgetRef ref, int index) {
    ref.read(activeNavIndexProvider.notifier).state = index;
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = navigationShell.currentIndex;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      extendBody: true, // content flows under the nav bar
      body: Column(
        children: [
          const ConnectivityBanner(),
          Expanded(child: navigationShell),
        ],
      ),

      // ── Context-aware FAB ─────────────────────────────────────────────────
      floatingActionButton: _SparkFab(
        currentIndex: currentIndex,
        cs: cs,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      // ── Bottom Nav Bar ────────────────────────────────────────────────────
      bottomNavigationBar: _SparkNavBar(
        currentIndex: currentIndex,
        onTap: (index) => _onTap(ref, index),
        isDark: isDark,
        cs: cs,
      ),
    );
  }
}

// ─── Bottom Navigation Bar ────────────────────────────────────────────────────

class _SparkNavBar extends StatelessWidget {
  const _SparkNavBar({
    required this.currentIndex,
    required this.onTap,
    required this.isDark,
    required this.cs,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool isDark;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: Container(
          decoration: BoxDecoration(
            color: (isDark ? AppColors.surfaceDark : AppColors.surfaceLight)
                .withOpacity(isDark ? 0.85 : 0.92),
            border: Border(
              top: BorderSide(
                color: cs.outlineVariant.withOpacity(0.25),
                width: 0.75,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: (isDark ? Colors.black : cs.shadow).withOpacity(0.12),
                blurRadius: 24,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: SizedBox(
              height: 68,
              child: Row(
                children: List.generate(_navItems.length, (index) {
                  return Expanded(
                    child: _NavBarItem(
                      item: _navItems[index],
                      isSelected: index == currentIndex,
                      onTap: () => onTap(index),
                      cs: cs,
                      isDark: isDark,
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Individual Nav Bar Item ──────────────────────────────────────────────────

class _NavBarItem extends StatefulWidget {
  const _NavBarItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.cs,
    required this.isDark,
  });

  final _NavItem item;
  final bool isSelected;
  final VoidCallback onTap;
  final ColorScheme cs;
  final bool isDark;

  @override
  State<_NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<_NavBarItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.88).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _handleTap() {
    _ctrl.forward().then((_) => _ctrl.reverse());
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    final isSelected = widget.isSelected;
    final cs = widget.cs;

    return GestureDetector(
      onTap: _handleTap,
      behavior: HitTestBehavior.opaque,
      child: ScaleTransition(
        scale: _scaleAnim,
        child: Tooltip(
          message: widget.item.tooltip,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ── Animated indicator pill + icon ──────────────────────────
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOutCubic,
                width: isSelected ? 56 : 40,
                height: 32,
                decoration: BoxDecoration(
                  color: isSelected
                      ? cs.primaryContainer
                      : Colors.transparent,
                  borderRadius: AppShapes.r16,
                ),
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder: (child, anim) => ScaleTransition(
                      scale: anim,
                      child: child,
                    ),
                    child: Icon(
                      isSelected ? widget.item.activeIcon : widget.item.icon,
                      key: ValueKey(isSelected),
                      color: isSelected ? cs.primary : cs.onSurfaceVariant,
                      size: 22,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 4),

              // ── Label ───────────────────────────────────────────────────
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  color: isSelected ? cs.primary : cs.onSurfaceVariant,
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  letterSpacing: 0.2,
                ),
                child: Text(widget.item.label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Context-Aware FAB ────────────────────────────────────────────────────────

class _SparkFab extends StatelessWidget {
  const _SparkFab({required this.currentIndex, required this.cs});

  final int currentIndex;
  final ColorScheme cs;

  // FAB config per tab: index → (label, icon, onPressed callback placeholder)
  static const _fabConfig = {
    1: (label: 'Add Task', icon: Icons.add_task_rounded),    // Tasks tab
    2: (label: 'New Note', icon: Icons.edit_note_rounded),   // Notes tab
  };

  @override
  Widget build(BuildContext context) {
    final config = _fabConfig[currentIndex];
    if (config == null) return const SizedBox.shrink();

    return FloatingActionButton.extended(
      heroTag: 'spark_fab_$currentIndex',
      onPressed: () {
        HapticUtils.light();
        if (currentIndex == 1) {
          context.push(AppPaths.taskCreate);
        } else if (currentIndex == 2) {
          context.push(AppPaths.noteEditor);
        }
      },
      icon: Icon(config.icon),
      label: Text(
        config.label,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
      backgroundColor: cs.primary,
      foregroundColor: cs.onPrimary,
      elevation: 4,
      extendedPadding: const EdgeInsets.symmetric(horizontal: 20),
    )
        .animate()
        .scale(
          begin: const Offset(0.6, 0.6),
          duration: AppDurations.normal,
          curve: Curves.easeOutBack,
        )
        .fadeIn(duration: 200.ms);
  }
}
