// lib/shared/providers/isar_provider_web.dart
//
// Web bootstrap — WebStore + SharedPreferences (no Isar).
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/web/web_store.dart';

final webStoreProvider = Provider<WebStore>((ref) {
  throw UnimplementedError(
    'webStoreProvider must be overridden in ProviderScope. See bootstrapWebStore().',
  );
});

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(
    'sharedPreferencesProvider must be overridden in ProviderScope.',
  );
});

/// Opens [WebStore] backed by browser localStorage via SharedPreferences.
Future<WebStore> bootstrapWebStore(SharedPreferences prefs) =>
    WebStore.open(prefs);
