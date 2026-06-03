// lib/features/dashboard/presentation/screens/dashboard_screen.dart
//
// StudySpark — Dashboard / Home Screen placeholder.
// TODO: Wire up DashboardRepository, today's tasks, schedule strip, AI tip card.

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_theme.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: cs.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            floating: true,
            pinned: true,
            backgroundColor: cs.surface,
            surfaceTintColor: Colors.transparent,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good morning 👋',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
                Text(
                  'StudySpark',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.w800,
                    color: cs.onSurface,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {},
              ),
              const SizedBox(width: 8),
            ],
          ),
          SliverFillRemaining(
            child: _DashboardPlaceholder(cs: cs, isDark: isDark),
          ),
        ],
      ),
    );
  }
}

class _DashboardPlaceholder extends StatelessWidget {
  const _DashboardPlaceholder({required this.cs, required this.isDark});
  final ColorScheme cs;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient(cs),
              borderRadius: AppShapes.r20,
              boxShadow: AppShadows.glow(cs.primary),
            ),
            child: const Icon(Icons.home_rounded, color: Colors.white, size: 40),
          ).animate().scale(duration: 600.ms, curve: Curves.easeOutBack),
          const SizedBox(height: 20),
          Text(
            'Dashboard',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ).animate(delay: 200.ms).fadeIn(),
          const SizedBox(height: 8),
          Text(
            'Your study overview will appear here',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: cs.onSurfaceVariant,
            ),
          ).animate(delay: 300.ms).fadeIn(),
        ],
      ),
    );
  }
}
