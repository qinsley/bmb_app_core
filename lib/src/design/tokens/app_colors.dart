import 'package:flutter/material.dart';
abstract class AppColors {
  static const overlay70 = Color(0xB3000000);
  static const overlay85 = Color(0xD9000000);
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
    surface: greyDark,
    onSurface: white,
    surfaceContainerHighest: greyLight,
    outline: Color(0xFF3A3A3E),
    shadow: black,
  );
}
