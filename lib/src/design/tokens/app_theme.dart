import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';

abstract class BaseTheme {
  late Color primary; late Color primary60; late Color primary45; late Color primary30; late Color primary20; late Color primary15; late Color primary10;
  late Color success; late Color success60; late Color success30; late Color success15; late Color successDark; late Color successDark30;
  late Color background; late Color background40; late Color background00; late Color backgroundDark; late Color backgroundDark00; late Color backgroundDarkest;
  late Color text; late Color text60; late Color text45; late Color text30; late Color text20; late Color text15; late Color text10; late Color text05; late Color text03;
  late Color overlay90; late Color overlay85; late Color overlay80; late Color overlay70; late Color overlay50; late Color overlay30; late Color overlay20;
  late Color animationOverlayMedium; late Color animationOverlayStrong;
  late Brightness brightness; late SystemUiOverlayStyle statusBar; late BoxShadow boxShadow; late BoxShadow boxShadowButton;
}

class BlackYellowTheme extends BaseTheme {
  static const yellow = Color(0xFFFBDD11);
  static const green = Color(0xFF4CBF4B);
  static const greenDark = Color(0xFF276126);
  static const greyLight = Color(0xFF2A2A2E);
  static const greyDark = Color(0xFF212124);
  static const greyDarkest = Color(0xFF1A1A1C);
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  @override Color primary = yellow;
  @override Color primary60 = yellow.withOpacity(0.6);
  @override Color primary45 = yellow.withOpacity(0.45);
  @override Color primary30 = yellow.withOpacity(0.3);
  @override Color primary20 = yellow.withOpacity(0.2);
  @override Color primary15 = yellow.withOpacity(0.15);
  @override Color primary10 = yellow.withOpacity(0.1);
  @override Color success = green;
  @override Color success60 = green.withOpacity(0.6);
  @override Color success30 = green.withOpacity(0.3);
  @override Color success15 = green.withOpacity(0.15);
  @override Color successDark = greenDark;
  @override Color successDark30 = greenDark.withOpacity(0.3);
  @override Color background = greyLight;
  @override Color background40 = greyLight.withOpacity(0.4);
  @override Color background00 = greyLight.withOpacity(0.0);
  @override Color backgroundDark = greyDark;
  @override Color backgroundDark00 = greyDark.withOpacity(0.0);
  @override Color backgroundDarkest = greyDarkest;
  @override Color text = white.withOpacity(0.9);
  @override Color text60 = white.withOpacity(0.6);
  @override Color text45 = white.withOpacity(0.45);
  @override Color text30 = white.withOpacity(0.3);
  @override Color text20 = white.withOpacity(0.2);
  @override Color text15 = white.withOpacity(0.15);
  @override Color text10 = white.withOpacity(0.1);
  @override Color text05 = white.withOpacity(0.05);
  @override Color text03 = white.withOpacity(0.03);
  @override Color overlay90 = black.withOpacity(0.9);
  @override Color overlay85 = black.withOpacity(0.85);
  @override Color overlay80 = black.withOpacity(0.8);
  @override Color overlay70 = black.withOpacity(0.7);
  @override Color overlay50 = black.withOpacity(0.5);
  @override Color overlay30 = black.withOpacity(0.3);
  @override Color overlay20 = black.withOpacity(0.2);
  @override Color animationOverlayMedium = black.withOpacity(0.7);
  @override Color animationOverlayStrong = black.withOpacity(0.85);
  @override Brightness brightness = Brightness.dark;
  @override SystemUiOverlayStyle statusBar = SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent);
  @override BoxShadow boxShadow = const BoxShadow(color: Colors.transparent);
  @override BoxShadow boxShadowButton = const BoxShadow(color: Colors.transparent);
}

ThemeData bmbDarkTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: AppColors.bmbColorScheme,
    scaffoldBackgroundColor: AppColors.greyDarkest,
  );
}
