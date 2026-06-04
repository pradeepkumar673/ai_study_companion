import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/services/notification_service.dart';
import '../../shared/providers/isar_provider.dart';

/// Native/mobile bootstrap overrides for [ProviderScope].
Future<List<Override>> buildProviderOverrides() async {
  final isar = await bootstrapIsar();
  final notificationService = await NotificationService.init();
  final prefs = await SharedPreferences.getInstance();

  return [
    isarProvider.overrideWithValue(isar),
    notificationServiceProvider.overrideWithValue(notificationService),
    sharedPreferencesProvider.overrideWithValue(prefs),
  ];
}
