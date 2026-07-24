import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// The pill-shaped search bar shown on home and search screens.
///
/// Two modes:
/// - **Read-only shell** (`readOnly: true`, default) — renders as a tappable
///   pill with no keyboard; forward [onTap] to push the search route.
/// - **Editable** (`readOnly: false`) — opens the keyboard and fires
///   [onChanged] / [onSubmitted] as the user types.
///
/// Styling is deliberately independent from [InputDecorationTheme] so the
/// pill shape does not inherit the rectangular style used by `BMBTextField`.
class BMBSearchBar extends StatelessWidget {
  /// Creates a [BMBSearchBar].
  const BMBSearchBar({
    super.key,
    this.hint = 'Search foods and kitchen',
    this.readOnly = true,
    this.onTap,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.trailingIcon,
    this.onTrailingTap,
  });

  /// Placeholder text shown when the field is empty.
  final String hint;

  /// When `true` no keyboard is shown; use [onTap] to handle the tap.
  final bool readOnly;

  /// Called when the bar is tapped in read-only mode.
  final VoidCallback? onTap;

  /// Controls the text being edited (editable mode).
  final TextEditingController? controller;

  /// Called on every keystroke in editable mode.
  final void Function(String)? onChanged;

  /// Called when the user submits the query.
  final void Function(String)? onSubmitted;

  /// Widget shown at the trailing end. Defaults to a filter/tune icon.
  final Widget? trailingIcon;

  /// Called when the trailing icon is tapped.
  final VoidCallback? onTrailingTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.neutral500,
            ),
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: AppColors.neutral500,
        ),
        suffixIcon: GestureDetector(
          onTap: onTrailingTap,
          child: trailingIcon ??
              const Icon(
                Icons.tune_rounded,
                color: AppColors.neutral500,
              ),
        ),
        filled: true,
        fillColor: AppColors.neutral100,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.pill)),
          borderSide: BorderSide.none,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.pill)),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
              const BorderRadius.all(Radius.circular(AppRadius.pill)),
          borderSide: BorderSide(color: cs.primary, width: 2),
        ),
      ),
    );
  }
}
