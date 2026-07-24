import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_typography.dart';

/// Returns the canonical Chefly [ThemeData] for light mode.
///
/// Pass this to [MaterialApp.theme].  The function is cheap to call but
/// should still be called once at app startup (not inside build methods).
///
/// ```dart
/// MaterialApp(
///   theme: cheflyLightTheme(),
/// );
/// ```
ThemeData cheflyLightTheme() {
  final TextTheme textTheme = cheflyTextTheme();
  const ColorScheme colorScheme = AppColors.cheflyColorScheme;

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    textTheme: textTheme,
    scaffoldBackgroundColor: AppColors.background,

    // -------------------------------------------------------------------------
    // AppBar
    // -------------------------------------------------------------------------
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.neutral900,
      elevation: 0,
      scrolledUnderElevation: 1,
      // Force dark (black) status-bar icons globally — the app uses a light
      // background throughout, so white icons would be invisible.
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      titleTextStyle: textTheme.titleLarge?.copyWith(
        color: AppColors.neutral900,
      ),
      iconTheme: const IconThemeData(color: AppColors.neutral900),
    ),

    // -------------------------------------------------------------------------
    // Cards
    // -------------------------------------------------------------------------
    cardTheme: CardThemeData(
      color: AppColors.surface,
      elevation: 2,
      shadowColor: AppColors.neutral900.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      margin: EdgeInsets.zero,
    ),

    // -------------------------------------------------------------------------
    // Elevated button — primary CTA
    // -------------------------------------------------------------------------
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.neutral0,
        disabledBackgroundColor: AppColors.neutral200,
        disabledForegroundColor: AppColors.neutral500,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.md,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
        textStyle: textTheme.labelLarge,
      ),
    ),

    // -------------------------------------------------------------------------
    // Outlined button — secondary action
    // -------------------------------------------------------------------------
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.md,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
        textStyle: textTheme.labelLarge,
      ),
    ),

    // -------------------------------------------------------------------------
    // Text button — tertiary / inline action
    // -------------------------------------------------------------------------
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        textStyle: textTheme.labelLarge,
      ),
    ),

    // -------------------------------------------------------------------------
    // Input decoration
    // -------------------------------------------------------------------------
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.neutral100,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      hintStyle: textTheme.bodyMedium?.copyWith(color: AppColors.neutral500),
      labelStyle: textTheme.bodyMedium?.copyWith(color: AppColors.neutral700),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        borderSide: const BorderSide(color: AppColors.neutral300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        borderSide: const BorderSide(color: AppColors.neutral300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
    ),

    // -------------------------------------------------------------------------
    // Chip
    // -------------------------------------------------------------------------
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.neutral100,
      selectedColor: AppColors.primary10,
      labelStyle: textTheme.labelMedium,
      side: const BorderSide(color: AppColors.neutral200),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
    ),

    // -------------------------------------------------------------------------
    // Bottom navigation bar
    // -------------------------------------------------------------------------
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.surface,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.neutral500,
      selectedLabelStyle: textTheme.labelSmall,
      unselectedLabelStyle: textTheme.labelSmall,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
    ),

    // -------------------------------------------------------------------------
    // Divider
    // -------------------------------------------------------------------------
    dividerTheme: const DividerThemeData(
      color: AppColors.divider,
      thickness: 1,
      space: 1,
    ),

    // -------------------------------------------------------------------------
    // Snackbar
    // -------------------------------------------------------------------------
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.neutral900,
      contentTextStyle: textTheme.bodyMedium?.copyWith(
        color: AppColors.neutral0,
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
    ),

    // -------------------------------------------------------------------------
    // Bottom sheet
    // -------------------------------------------------------------------------
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.xl),
        ),
      ),
      elevation: 0,
    ),

    // -------------------------------------------------------------------------
    // Dialog
    // -------------------------------------------------------------------------
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      titleTextStyle: textTheme.titleLarge?.copyWith(
        color: AppColors.neutral900,
      ),
      contentTextStyle: textTheme.bodyMedium?.copyWith(
        color: AppColors.neutral700,
      ),
    ),

    // -------------------------------------------------------------------------
    // Progress indicator
    // -------------------------------------------------------------------------
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary,
    ),
  );
}

/// Returns the canonical Chefly [ThemeData] for dark mode.
///
/// Pass this to [MaterialApp.darkTheme].  The function is cheap to call but
/// should still be called once at app startup (not inside build methods).
///
/// ```dart
/// MaterialApp(
///   theme: cheflyLightTheme(),
///   darkTheme: cheflyDarkTheme(),
///   themeMode: ThemeMode.system, // or ThemeMode.dark
/// );
/// ```
ThemeData cheflyDarkTheme() {
  final TextTheme textTheme = cheflyTextTheme().apply(
    bodyColor: AppColors.darkTextPrimary,
    displayColor: AppColors.darkTextPrimary,
  );
  const ColorScheme colorScheme = AppColors.darkColorScheme;

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    textTheme: textTheme,
    scaffoldBackgroundColor: AppColors.darkBackground,

    // -------------------------------------------------------------------------
    // AppBar
    // -------------------------------------------------------------------------
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkSurface,
      foregroundColor: AppColors.darkTextPrimary,
      elevation: 0,
      scrolledUnderElevation: 1,
      // Light status-bar icons for dark backgrounds.
      systemOverlayStyle: SystemUiOverlayStyle.light,
      titleTextStyle: textTheme.titleLarge?.copyWith(
        color: AppColors.darkTextPrimary,
      ),
      iconTheme: const IconThemeData(color: AppColors.darkTextPrimary),
    ),

    // -------------------------------------------------------------------------
    // Cards
    // -------------------------------------------------------------------------
    cardTheme: CardThemeData(
      color: AppColors.darkSurface,
      elevation: 2,
      shadowColor: AppColors.neutral900.withValues(alpha: 0.48),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      margin: EdgeInsets.zero,
    ),

    // -------------------------------------------------------------------------
    // Elevated button — primary CTA
    // -------------------------------------------------------------------------
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.neutral0,
        disabledBackgroundColor: AppColors.darkElevated,
        disabledForegroundColor: AppColors.darkTextDisabled,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.md,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
        textStyle: textTheme.labelLarge,
      ),
    ),

    // -------------------------------------------------------------------------
    // Outlined button — secondary action
    // -------------------------------------------------------------------------
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.md,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
        textStyle: textTheme.labelLarge,
      ),
    ),

    // -------------------------------------------------------------------------
    // Text button — tertiary / inline action
    // -------------------------------------------------------------------------
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        textStyle: textTheme.labelLarge,
      ),
    ),

    // -------------------------------------------------------------------------
    // Input decoration
    // -------------------------------------------------------------------------
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkInputFill,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      hintStyle: textTheme.bodyMedium?.copyWith(color: AppColors.darkTextSecondary),
      labelStyle: textTheme.bodyMedium?.copyWith(color: AppColors.darkTextSecondary),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        borderSide: const BorderSide(color: AppColors.darkDivider),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        borderSide: const BorderSide(color: AppColors.darkDivider),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
    ),

    // -------------------------------------------------------------------------
    // Chip
    // -------------------------------------------------------------------------
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.darkElevated,
      selectedColor: AppColors.primaryDark,
      labelStyle: textTheme.labelMedium?.copyWith(color: AppColors.darkTextPrimary),
      side: const BorderSide(color: AppColors.darkDivider),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
    ),

    // -------------------------------------------------------------------------
    // Bottom navigation bar
    // -------------------------------------------------------------------------
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkSurface,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.darkTextSecondary,
      selectedLabelStyle: textTheme.labelSmall,
      unselectedLabelStyle: textTheme.labelSmall,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
    ),

    // -------------------------------------------------------------------------
    // Tab bar
    // -------------------------------------------------------------------------
    tabBarTheme: TabBarThemeData(
      labelColor: AppColors.primary,
      unselectedLabelColor: AppColors.darkTextSecondary,
      labelStyle: textTheme.labelLarge,
      unselectedLabelStyle: textTheme.labelLarge,
      indicatorColor: AppColors.primary,
      dividerColor: AppColors.darkDivider,
    ),

    // -------------------------------------------------------------------------
    // Divider
    // -------------------------------------------------------------------------
    dividerTheme: const DividerThemeData(
      color: AppColors.darkDivider,
      thickness: 1,
      space: 1,
    ),

    // -------------------------------------------------------------------------
    // Snackbar
    // -------------------------------------------------------------------------
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.darkElevated,
      contentTextStyle: textTheme.bodyMedium?.copyWith(
        color: AppColors.darkTextPrimary,
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
    ),

    // -------------------------------------------------------------------------
    // Bottom sheet
    // -------------------------------------------------------------------------
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.darkSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.xl),
        ),
      ),
      elevation: 0,
    ),

    // -------------------------------------------------------------------------
    // Dialog
    // -------------------------------------------------------------------------
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.darkSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      titleTextStyle: textTheme.titleLarge?.copyWith(
        color: AppColors.darkTextPrimary,
      ),
      contentTextStyle: textTheme.bodyMedium?.copyWith(
        color: AppColors.darkTextSecondary,
      ),
    ),

    // -------------------------------------------------------------------------
    // Progress indicator
    // -------------------------------------------------------------------------
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary,
    ),

    // -------------------------------------------------------------------------
    // Slider
    // -------------------------------------------------------------------------
    sliderTheme: SliderThemeData(
      activeTrackColor: AppColors.primary,
      inactiveTrackColor: AppColors.darkElevated,
      thumbColor: AppColors.primary,
      overlayColor: AppColors.primary.withValues(alpha: 0.12),
      valueIndicatorColor: AppColors.primary,
      valueIndicatorTextStyle: textTheme.labelSmall?.copyWith(
        color: AppColors.neutral0,
      ),
    ),

    // -------------------------------------------------------------------------
    // Switch
    // -------------------------------------------------------------------------
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColors.primary;
        return AppColors.darkTextSecondary;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary.withValues(alpha: 0.5);
        }
        return AppColors.darkElevated;
      }),
    ),

    // -------------------------------------------------------------------------
    // Checkbox
    // -------------------------------------------------------------------------
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColors.primary;
        return AppColors.darkInputFill;
      }),
      checkColor: WidgetStateProperty.all(AppColors.neutral0),
      side: const BorderSide(color: AppColors.darkTextSecondary),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),

    // -------------------------------------------------------------------------
    // ListTile
    // -------------------------------------------------------------------------
    listTileTheme: const ListTileThemeData(
      tileColor: Colors.transparent,
      iconColor: AppColors.darkTextSecondary,
      textColor: AppColors.darkTextPrimary,
    ),
  );
}
