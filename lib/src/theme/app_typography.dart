import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Returns the Chefly [TextTheme].
///
/// Merriweather (via [GoogleFonts]) provides the base shapes.  We override
/// font weights to follow the design system:
///
/// | Role          | Weight |
/// |---------------|--------|
/// | Display       | 700    |
/// | Headline      | 700    |
/// | Title         | 600    |
/// | Body          | 400    |
/// | Label         | 500    |
///
/// Call this function once inside `cheflyLightTheme` — do not call it in
/// widget build methods (it allocates on every call).
TextTheme cheflyTextTheme() {
  final TextTheme base = GoogleFonts.merriweatherTextTheme();

  return base.copyWith(
    // Display
    displayLarge: base.displayLarge?.copyWith(fontWeight: FontWeight.w700),
    displayMedium: base.displayMedium?.copyWith(fontWeight: FontWeight.w700),
    displaySmall: base.displaySmall?.copyWith(fontWeight: FontWeight.w700),

    // Headline
    headlineLarge: base.headlineLarge?.copyWith(fontWeight: FontWeight.w700),
    headlineMedium: base.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
    headlineSmall: base.headlineSmall?.copyWith(fontWeight: FontWeight.w700),

    // Title
    titleLarge: base.titleLarge?.copyWith(fontWeight: FontWeight.w600),
    titleMedium: base.titleMedium?.copyWith(fontWeight: FontWeight.w600),
    titleSmall: base.titleSmall?.copyWith(fontWeight: FontWeight.w600),

    // Body
    bodyLarge: base.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
    bodyMedium: base.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
    bodySmall: base.bodySmall?.copyWith(fontWeight: FontWeight.w400),

    // Label
    labelLarge: base.labelLarge?.copyWith(fontWeight: FontWeight.w500),
    labelMedium: base.labelMedium?.copyWith(fontWeight: FontWeight.w500),
    labelSmall: base.labelSmall?.copyWith(fontWeight: FontWeight.w500),
  );
}
