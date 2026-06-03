// lib/features/profile/presentation/widgets/offline_banner.dart
//
// Offline mode banner — shown at the top of any screen that detects no network.
// Includes "Try Again" button and pending-changes count.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../providers/profile_providers.dart';

class OfflineBanner extends ConsumerWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sync = ref.watch(cloudSyncProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0),
        borderRadius: AppShapes.r12,
        border: Border.all(color: Colors.orange.shade300),
      ),
      child: Row(
        children: [
          const Icon(Icons.wifi_off_rounded, color: Colors.orange, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'You\'re offline',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: Color(0xFFE65100),
                  ),
                ),
                if (sync.pendingChanges > 0)
                  Text(
                    '${sync.pendingChanges} change${sync.pendingChanges == 1 ? '' : 's'} will sync when reconnected',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFFBF360C),
                    ),
                  ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              // Simulate reconnection attempt
              ref.read(isOfflineProvider.notifier).state = false;
              ref.read(cloudSyncProvider.notifier).triggerSync();
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.orange.shade800,
              minimumSize: Size.zero,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text('Retry',
                style: TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 300.ms)
        .slideY(begin: -0.3, end: 0, curve: Curves.easeOut);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Global offline snack helper — call from any screen
// ─────────────────────────────────────────────────────────────────────────────

void showOfflineSnack(BuildContext context, {String? message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      shape: RoundedRectangleBorder(borderRadius: AppShapes.r12),
      backgroundColor: const Color(0xFF37474F),
      content: Row(
        children: [
          const Icon(Icons.wifi_off_rounded,
              color: Colors.orangeAccent, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message ?? 'You\'re offline. Changes saved locally.',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      duration: const Duration(seconds: 3),
    ),
  );
}