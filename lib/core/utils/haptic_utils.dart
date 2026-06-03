// lib/core/utils/haptic_utils.dart
import 'package:flutter/services.dart';

/// Centralised haptic feedback helpers.
/// Add `HapticUtils.light()` calls to button presses, swipe-to-dismiss, etc.
class HapticUtils {
  HapticUtils._();

  /// Short, subtle tap — use on most button presses.
  static Future<void> light() => HapticFeedback.lightImpact();

  /// Medium click — use on selection changes, toggles.
  static Future<void> medium() => HapticFeedback.mediumImpact();

  /// Heavy thud — use on destructive actions (delete confirm).
  static Future<void> heavy() => HapticFeedback.heavyImpact();

  /// Brief buzz — use on validation errors.
  static Future<void> error() => HapticFeedback.vibrate();

  /// Subtle tick — use on checkbox / switch toggles.
  static Future<void> selection() => HapticFeedback.selectionClick();
}
