// lib/core/widgets/shimmer_widgets.dart
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/theme/app_theme.dart';

// ── Base shimmer box ──────────────────────────────────────────────────────────

class ShimmerBox extends StatelessWidget {
  const ShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 12,
  });

  final double width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: isDark ? const Color(0xFF2A2A3A) : const Color(0xFFE8E8F0),
      highlightColor: isDark ? const Color(0xFF3A3A4A) : const Color(0xFFF5F5FA),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

// ── Stats card shimmer (dashboard quick-stats row) ────────────────────────────

class ShimmerStatsCard extends StatelessWidget {
  const ShimmerStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
          const ShimmerBox(width: 32, height: 32, borderRadius: 10),
          const SizedBox(height: 10),
          const ShimmerBox(width: 48, height: 20),
          const SizedBox(height: 6),
          const ShimmerBox(width: 64, height: 10),
          const SizedBox(height: 4),
          const ShimmerBox(width: 40, height: 10),
        ],
      ),
    );
  }
}

// ── Task card shimmer ─────────────────────────────────────────────────────────

class ShimmerTaskCard extends StatelessWidget {
  const ShimmerTaskCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const ShimmerBox(width: 20, height: 20, borderRadius: 6),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ShimmerBox(width: double.infinity, height: 14),
                SizedBox(height: 6),
                ShimmerBox(width: 120, height: 10),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const ShimmerBox(width: 48, height: 20, borderRadius: 8),
        ],
      ),
    );
  }
}

// ── Generic list shimmer (pass item count) ────────────────────────────────────

class ShimmerList extends StatelessWidget {
  const ShimmerList({super.key, this.itemCount = 5});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (_, __) => const ShimmerTaskCard(),
    );
  }
}

// ── Chat bubble shimmer (AI screens) ─────────────────────────────────────────

class ShimmerChatBubble extends StatelessWidget {
  const ShimmerChatBubble({super.key, this.isUser = false});

  final bool isUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) ...[
            const ShimmerBox(width: 28, height: 28, borderRadius: 14),
            const SizedBox(width: 6),
          ],
          Column(
            crossAxisAlignment:
                isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              ShimmerBox(
                width: isUser ? 180 : 220,
                height: 48,
                borderRadius: 18,
              ),
              const SizedBox(height: 4),
              const ShimmerBox(width: 32, height: 10),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Note card shimmer ─────────────────────────────────────────────────────────

class ShimmerNoteCard extends StatelessWidget {
  const ShimmerNoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.surfaceDark
            : Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          ShimmerBox(width: double.infinity, height: 14),
          SizedBox(height: 8),
          ShimmerBox(width: double.infinity, height: 10),
          SizedBox(height: 4),
          ShimmerBox(width: 140, height: 10),
          SizedBox(height: 12),
          ShimmerBox(width: 60, height: 20, borderRadius: 8),
        ],
      ),
    );
  }
}
