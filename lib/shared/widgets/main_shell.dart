// lib/shared/widgets/main_shell.dart
//
// StudySpark — Bottom navigation scaffold.
// Wraps [StatefulNavigationShell] (GoRouter's indexed stack) with a
// custom animated [NavigationBar] and an optional floating action button.

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';

// ─── Nav Destination Model ────────────────────────────────────────────────────
class _NavDestination {
  const _NavDestination({
    required this.label,
    required this.icon,
    required this.activeIcon,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
}

// ─── Destination Definitions ─────────────────────────────────────────────────
const _destinations = [
  _NavDestination(
    label: 'Home',
    icon: Icons.home_outlined,
    activeIcon: Icons.home_rounded,
  ),
  _NavDestination(
    label: 'Tasks',
    icon: Icons.check_circle_outline_rounded,
    activeIcon: Icons.check_circle_rounded,
  ),
  _NavDestination(
    label: 'Schedule',
    icon: Icons.calendar_month_outlined,
    activeIcon: Icons.calendar_month_rounded,
  ),
  _NavDestination(
    label: 'Focus',
    icon: Icons.timer_outlined,
    activeIcon: Icons.timer_rounded,
  ),
  _NavDestination(
    label: 'Notes',
    icon: Icons.sticky_note_2_outlined,
    activeIcon: Icons.sticky_note_2_rounded,
  ),
  _NavDestination(
    label: 'Profile',
    icon: Icons.person_outline_rounded,
    activeIcon: Icons.person_rounded,
  ),
];

// ─── Shell Widget ─────────────────────────────────────────────────────────────
class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _onDestinationSelected(int index) {
    navigationShell.goBranch(
      index,
      // Return to the initial route when re-tapping the current tab
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: navigationShell,

      // ── Floating Action Button (visible on Tasks & Notes tabs) ──────────
      floatingActionButton: _buildFab(context, navigationShell.currentIndex),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      // ── Bottom Navigation Bar ────────────────────────────────────────────
      bottomNavigationBar: _SparkNavBar(
        currentIndex: navigationShell.currentIndex,
        onDestinationSelected: _onDestinationSelected,
        isDark: isDark,
        cs: cs,
      ),
    );
  }

  Widget? _buildFab(BuildContext context, int index) {
    // Show FAB only on Tasks (1) and Notes (4) tabs
    if (index != 1 && index != 4) return null;

    final cs = Theme.of(context).colorScheme;
    final label = index == 1 ? 'Add Task' : 'New Note';
    final icon  = index == 1 ? Icons.add_task_rounded : Icons.edit_note_rounded;

    return FloatingActionButton.extended(
      onPressed: () {
        if (index == 1) {
          // TODO: Navigate to task creation bottom sheet
          // context.push(AppPaths.taskCreate);
        } else {
          // TODO: Navigate to note editor
          // context.push(AppPaths.noteEditor);
        }
      },
      icon: Icon(icon),
      label: Text(label),
      backgroundColor: cs.primary,
      foregroundColor: cs.onPrimary,
    ).animate().scale(
      duration: AppDurations.normal,
      curve: Curves.easeOutBack,
    );
  }
}

// ─── Custom Navigation Bar ────────────────────────────────────────────────────
class _SparkNavBar extends StatelessWidget {
  const _SparkNavBar({
    required this.currentIndex,
    required this.onDestinationSelected,
    required this.isDark,
    required this.cs,
  });

  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;
  final bool isDark;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        border: Border(
          top: BorderSide(
            color: cs.outlineVariant.withOpacity(0.3),
            width: 1,
          ),
        ),
        boxShadow: AppShadows.md(
          isDark ? Colors.black : cs.shadow,
        ),
      ),
      child: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: onDestinationSelected,
        destinations: _destinations.map((d) {
          return NavigationDestination(
            icon: Icon(d.icon),
            selectedIcon: Icon(d.activeIcon),
            label: d.label,
          );
        }).toList(),
      ),
    );
  }
}
