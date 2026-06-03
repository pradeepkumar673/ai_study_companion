// lib/shared/providers/isar_provider.dart
//
// Provides the bootstrapped Isar instance and SharedPreferences.
// Both are overridden at the ProviderScope level in main.dart.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provides the single [Isar] database instance for the entire app.
/// Overridden in main.dart after [Isar.open] completes.
final isarProvider = Provider<Isar>((ref) {
  throw UnimplementedError('isarProvider must be overridden in ProviderScope');
});

/// Provides [SharedPreferences] for lightweight key-value storage.
/// Overridden in main.dart after [SharedPreferences.getInstance] completes.
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(
    'sharedPreferencesProvider must be overridden in ProviderScope',
  );
});
