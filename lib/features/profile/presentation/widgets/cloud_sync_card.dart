// lib/features/profile/presentation/widgets/cloud_sync_card.dart
//
// StudySpark — Cloud Sync Simulation Card
//
// Shows current sync status, last sync time, pending changes count,
// and an animated progress ring while syncing.
// A "Sync Now" button triggers the simulated sync flow.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../providers/profile_providers.dart';

class CloudSyncCard extends ConsumerWidget {
  const CloudSyncCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sync = ref.watch(cloudSyncProvider);
    final isSyncing = sync.status == SyncStatus.syncing;

    final (statusColor, statusIcon) = _statusMeta(sync.status);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.neutral20 : cs.surface,
        borderRadius: AppShapes.r16,
        border: Border.all(
          color: statusColor.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: statusColor.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Sync icon / progress ring
              SizedBox(
                width: 40,
                height: 40,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (isSyncing)
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(
                          value: sync.syncProgress,
                          strokeWidth: 3,
                          backgroundColor:
                              statusColor.withOpacity(0.15),
                          valueColor:
                              AlwaysStoppedAnimation(statusColor),
                        ),
                      ),
                    Container(
                      width: isSyncing ? 30 : 40,
                      height: isSyncing ? 30 : 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: statusColor.withOpacity(0.12),
                      ),
                      child: Icon(statusIcon,
                          color: statusColor,
                          size: isSyncing ? 16 : 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),

              // Status text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cloud Sync',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      sync.statusLabel,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              // Sync Now button
              if (!isSyncing)
                FilledButton.tonal(
                  onPressed: () =>
                      ref.read(cloudSyncProvider.notifier).triggerSync(),
                  style: FilledButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 8),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    backgroundColor:
                        AppColors.primary.withOpacity(0.12),
                    foregroundColor: AppColors.primary,
                  ),
                  child: const Text('Sync Now',
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w600)),
                )
              else
                Text(
                  '${(sync.syncProgress * 100).round()}%',
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
            ],
          ),

          // Details row
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest.withOpacity(0.5),
              borderRadius: AppShapes.r8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _SyncDetailItem(
                  label: 'Last sync',
                  value: sync.lastSyncLabel,
                  icon: Icons.history_rounded,
                ),
                Container(
                  width: 1,
                  height: 24,
                  color: cs.outlineVariant.withOpacity(0.4),
                ),
                _SyncDetailItem(
                  label: 'Pending',
                  value: '${sync.pendingChanges} changes',
                  icon: Icons.pending_actions_rounded,
                ),
                Container(
                  width: 1,
                  height: 24,
                  color: cs.outlineVariant.withOpacity(0.4),
                ),
                _SyncDetailItem(
                  label: 'Storage',
                  value: '12.4 MB',
                  icon: Icons.storage_rounded,
                ),
              ],
            ),
          ),

          // Progress bar (visible during sync)
          if (isSyncing) ...[
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: AppShapes.r8,
              child: LinearProgressIndicator(
                value: sync.syncProgress,
                minHeight: 4,
                backgroundColor: statusColor.withOpacity(0.15),
                valueColor: AlwaysStoppedAnimation(statusColor),
              ),
            )
                .animate(onPlay: (c) => c.repeat())
                .shimmer(duration: 1200.ms, color: statusColor.withOpacity(0.3)),
          ],
        ],
      ),
    ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1, end: 0);
  }

  (Color, IconData) _statusMeta(SyncStatus status) {
    switch (status) {
      case SyncStatus.idle:
        return (AppColors.secondary, Icons.cloud_done_rounded);
      case SyncStatus.syncing:
        return (AppColors.primary, Icons.cloud_sync_rounded);
      case SyncStatus.success:
        return (AppColors.secondary, Icons.cloud_done_rounded);
      case SyncStatus.error:
        return (Colors.red, Icons.cloud_off_rounded);
      case SyncStatus.offline:
        return (Colors.orange, Icons.cloud_off_outlined);
    }
  }
}

class _SyncDetailItem extends StatelessWidget {
  const _SyncDetailItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      children: [
        Icon(icon, size: 14, color: cs.onSurfaceVariant),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(
              fontSize: 11, fontWeight: FontWeight.w700),
        ),
        Text(
          label,
          style: TextStyle(
              fontSize: 10, color: cs.onSurfaceVariant),
        ),
      ],
    );
  }
}