// lib/shared/providers/connectivity_provider.dart
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Emits the latest [ConnectivityResult] whenever network changes.
final connectivityProvider = StreamProvider<ConnectivityResult>((ref) {
  return Connectivity().onConnectivityChanged.map((results) =>
      results.isNotEmpty ? results.last : ConnectivityResult.none);
});

/// Simple bool — true when any network is available.
final isOnlineProvider = Provider<bool>((ref) {
  final status = ref.watch(connectivityProvider);
  return status.when(
    data: (result) => result != ConnectivityResult.none,
    loading: () => true, // optimistic
    error: (_, __) => false,
  );
});
