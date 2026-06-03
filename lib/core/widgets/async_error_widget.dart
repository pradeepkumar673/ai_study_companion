// lib/core/widgets/async_error_widget.dart
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AsyncErrorWidget extends StatelessWidget {
  const AsyncErrorWidget({
    super.key,
    required this.error,
    this.onRetry,
    this.message,
  });

  final Object error;
  final VoidCallback? onRetry;
  final String? message;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final displayMessage = message ?? _friendlyMessage(error);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: cs.errorContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.error_outline_rounded,
                  color: cs.onErrorContainer, size: 32),
            ),
            const Gap(16),
            Text(
              'Something went wrong',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            const Gap(8),
            Text(
              displayMessage,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const Gap(20),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: const Text('Try again'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _friendlyMessage(Object error) {
    final msg = error.toString().toLowerCase();
    if (msg.contains('socketexception') ||
        msg.contains('connection') ||
        msg.contains('network')) {
      return 'Check your internet connection and try again.';
    }
    if (msg.contains('timeout')) {
      return 'The request timed out. Please try again.';
    }
    if (msg.contains('permission')) {
      return 'Permission denied. Check app settings.';
    }
    return 'An unexpected error occurred. Please try again.';
  }
}

// ── Full-page error (used in GoRouter error builder) ─────────────────────────

class AppErrorPage extends StatelessWidget {
  const AppErrorPage({super.key, this.error});

  final Object? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AsyncErrorWidget(
        error: error ?? 'Unknown error',
        onRetry: () => Navigator.of(context).pop(),
        message: 'We couldn\'t load this page.',
      ),
    );
  }
}
