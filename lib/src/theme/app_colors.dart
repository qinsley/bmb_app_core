import 'package:flutter/material.dart';

/// All BMB brand colours - Single source of truth
/// Rule: No hex literals allowed anywhere else in bmb_core or apps.
/// Every colour reference outside this file must use a field defined here
/// or a ColorScheme token from Theme.of(context).
abstract class AppColors {
  // Constants not themed
  static const overlay70 = Color(0xB3000000);
  static const overlay85 = Color(0xD9000000);

  // Primary Brand - Yellow FBDD11 (from your BlackYellowTheme)
  static const yellow = Color(0xFFFBDD11);
  static const green = Color(0xFF4CBF4B);
  static const blue = Color(0xFF2196F3);
  static const red = Color(0xFFF44336);
  static const greenDark = Color(0xFF276126);
  static const greyLight = Color(0xFF2A2A2E);
  static const greyDark = Color(0xFF212124);
  static const greyDarkest = Color(0xFF1A1A1C);
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const BoxShadow boxShadow = BoxShadow(color: Colors.transparent);

  // Tints for yellow primary - 90% white tint etc
  static const Color primary10 = Color(0x1AFBDD11); // 10% opacity yellow
  static const Color primary20 = Color(0x33FBDD11); // 20%
  static const Color primary30 = Color(0x4DFBDD11); // 30%
  static const Color primary45 = Color(0x73FBDD11); // 45%
  static const Color primary60 = Color(0x99FBDD11); // 60%

  // Success tints
  static const Color success10 = Color(0x1A4CBF4B);
  static const Color success30 = Color(0x4D4CBF4B);

  // Neutrals for dark theme
  static const Color neutral900 = Color(0xFF1A1A1C);
  static const Color neutral700 = Color(0xFF3D3D3D);
  static const Color neutral500 = Color(0xFF757575);
  static const Color neutral300 = Color(0xFFBDBDBD);
  static const Color neutral200 = Color(0xFFE0E0E0);
  static const Color neutral100 = Color(0xFFF5F5F5);
  static const Color neutral0 = white;

  // Material 3 ColorScheme - BMB Dark (BlackYellowTheme)
  static const ColorScheme bmbColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: yellow,
    onPrimary: black,
    primaryContainer: Color(0xFF5A4D00),
    onPrimaryContainer: yellow,
    secondary: green,
    onSecondary: black,
    secondaryContainer: Color(0xFF1A3A1A),
    onSecondaryContainer: green,
    tertiary: blue,
    onTertiary: white,
    error: red,
    onError: white,
    errorContainer: Color(0xFF4A1A1A),
    onErrorContainer: red,
    surface: greyDark,
    onSurface: white,
    surfaceContainerHighest: greyLight,
    onSurfaceVariant: Color(0xFFE0E0E0),
    outline: Color(0xFF3A3A3E),
    outlineVariant: Color(0xFF2A2A2E),
    shadow: black,
    scrim: black,
    inverseSurface: white,
    onInverseSurface: black,
    inversePrimary: Color(0xFF5A4D00),
  );

  static const ColorScheme bmbLightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: yellow,
    onPrimary: black,
    primaryContainer: Color(0xFFFFF8CC),
    onPrimaryContainer: black,
    secondary: green,
    onSecondary: white,
    secondaryContainer: Color(0xFFE8F5E9),
    onSecondaryContainer: greenDark,
    error: red,
    onError: white,
    errorContainer: Color(0xFFFFEBEE),
    onErrorContainer: red,
    surface: white,
    onSurface: black,
    surfaceContainerHighest: Color(0xFFF5F5F5),
    onSurfaceVariant: Color(0xFF757575),
    outline: Color(0xFFBDBDBD),
    outlineVariant: Color(0xFFE0E0E0),
    shadow: black,
    scrim: black,
    inverseSurface: greyDarkest,
    onInverseSurface: white,
    inversePrimary: yellow,
  );
}
