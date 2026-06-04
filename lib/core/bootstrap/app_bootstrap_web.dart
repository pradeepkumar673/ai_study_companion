import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/services/notification_service.dart';
import '../../shared/providers/isar_provider.dart';

/// Web bootstrap overrides for [ProviderScope].
Future<List<Override>> buildProviderOverrides() async {
  final prefs = await SharedPreferences.getInstance();
  final webStore = await bootstrapWebStore(prefs);
  final notificationService = NotificationService.web();

  return [
    webStoreProvider.overrideWithValue(webStore),
    notificationServiceProvider.overrideWithValue(notificationService),
    sharedPreferencesProvider.overrideWithValue(prefs),
  ];
}
