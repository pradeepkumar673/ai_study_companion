// lib/shared/providers/theme_provider.dart
//
// Persists the user's [ThemeMode] choice in [SharedPreferences] so it
// survives app restarts.  Consumed by [StudySparkApp] in main.dart.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'isar_provider.dart';

// ─── Key used in SharedPreferences ───────────────────────────────────────────
const _kThemeModeKey = 'theme_mode';

// ─── Notifier ────────────────────────────────────────────────────────────────

/// Stateful notifier that holds the current [ThemeMode] and persists changes.
class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    final prefs = ref.read(sharedPreferencesProvider);
    final saved = prefs.getString(_kThemeModeKey);
    return switch (saved) {
      'light'  => ThemeMode.light,
      'dark'   => ThemeMode.dark,
      _        => ThemeMode.system, // default
    };
  }

  /// Toggle between light and dark (ignoring system).
  void toggle() {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    _persist();
  }

  /// Explicitly set [ThemeMode].
  void setMode(ThemeMode mode) {
    state = mode;
    _persist();
  }

  void _persist() {
    final prefs = ref.read(sharedPreferencesProvider);
    prefs.setString(_kThemeModeKey, state.name);
  }
}

// ─── Provider ────────────────────────────────────────────────────────────────

/// Exposes the current [ThemeMode].  Read in [StudySparkApp].
final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);

// ─── Convenience helpers ─────────────────────────────────────────────────────

/// Returns true when dark mode is active (either explicit or from system).
final isDarkModeProvider = Provider<bool>((ref) {
  final mode = ref.watch(themeModeProvider);
  if (mode == ThemeMode.system) {
    // Read system brightness via platform dispatcher
    final window = WidgetsBinding.instance.platformDispatcher;
    return window.platformBrightness == Brightness.dark;
  }
  return mode == ThemeMode.dark;
});
