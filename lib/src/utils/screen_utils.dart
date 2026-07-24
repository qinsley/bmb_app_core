import 'package:flutter/material.dart';

/// Responsive dimension helpers available directly on [BuildContext].
///
/// ```dart
/// Container(
///   height: context.screenHeight * 0.3,
///   width: context.screenWidth,
/// )
/// ```
extension ScreenUtils on BuildContext {
  /// Total screen width in logical pixels.
  double get screenWidth => MediaQuery.sizeOf(this).width;

  /// Total screen height in logical pixels.
  double get screenHeight => MediaQuery.sizeOf(this).height;

  /// Screen width minus the standard horizontal page margin (2 × 24 pt).
  double get contentWidth => screenWidth - 48;

  /// `true` when the screen width is ≥ 600 pt (tablet / large phone landscape).
  bool get isTablet => screenWidth >= 600;

  /// Top padding from the system status bar / notch.
  double get statusBarHeight => MediaQuery.paddingOf(this).top;

  /// Bottom padding from the home indicator / navigation bar.
  double get bottomBarHeight => MediaQuery.paddingOf(this).bottom;

  /// `true` when the software keyboard is visible.
  bool get isKeyboardVisible => MediaQuery.viewInsetsOf(this).bottom > 0;

  /// Current software keyboard height (0 when hidden).
  double get keyboardHeight => MediaQuery.viewInsetsOf(this).bottom;
}
