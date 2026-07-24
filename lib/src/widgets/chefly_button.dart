import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';

/// Button variants available in the Chefly design system.
enum CheflyButtonVariant {
  /// Green filled button — primary call-to-action.
  primary,

  /// Green-bordered, transparent background — secondary action.
  secondary,

  /// Label only, no background or border — inline tertiary action.
  text,
}

/// Chefly's standard button widget.
///
/// Adapts to all three design-system button roles via [CheflyButtonVariant].
/// Pass `null` to [onPressed] to disable the button. Set [isLoading] to
/// `true` to replace the content with a size-appropriate spinner and
/// prevent taps while the action is in flight.
class CheflyButton extends StatelessWidget {
  /// Creates a [CheflyButton].
  const CheflyButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.variant = CheflyButtonVariant.primary,
    this.isLoading = false,
    this.leadingIcon,
    this.width,
    this.padding,
  });

  /// Text displayed inside the button.
  final String label;

  /// Invoked when the button is tapped. `null` renders the button disabled.
  final VoidCallback? onPressed;

  /// Visual role. Defaults to [CheflyButtonVariant.primary].
  final CheflyButtonVariant variant;

  /// Replaces the content with a progress indicator and prevents taps.
  final bool isLoading;

  /// Optional widget displayed to the left of [label].
  final Widget? leadingIcon;

  /// Explicit width. `null` expands the button to fill available width.
  final double? width;

  /// Custom content padding. `null` uses the value from the active [ButtonStyle].
  final EdgeInsets? padding;

  static const double _minHeight = 52;

  @override
  Widget build(BuildContext context) {
    final VoidCallback? effectivePressed = isLoading ? null : onPressed;
    final Widget content = _content(context);
    final ButtonStyle style = _style();

    final Widget button = switch (variant) {
      CheflyButtonVariant.primary => ElevatedButton(
          onPressed: effectivePressed,
          style: style,
          child: content,
        ),
      CheflyButtonVariant.secondary => OutlinedButton(
          onPressed: effectivePressed,
          style: style,
          child: content,
        ),
      CheflyButtonVariant.text => TextButton(
          onPressed: effectivePressed,
          style: style,
          child: content,
        ),
    };

    return SizedBox(
      width: width ?? double.infinity,
      child: button,
    );
  }

  ButtonStyle _style() {
    final EdgeInsets? localPadding = padding;
    return ButtonStyle(
      minimumSize: const WidgetStatePropertyAll(
        Size(double.infinity, _minHeight),
      ),
      padding: localPadding != null
          ? WidgetStatePropertyAll(localPadding)
          : null,
      shape: const WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.pill)),
        ),
      ),
    );
  }

  Widget _content(BuildContext context) {
    if (isLoading) {
      final ColorScheme cs = Theme.of(context).colorScheme;
      final Color indicatorColor = switch (variant) {
        CheflyButtonVariant.primary => cs.onPrimary,
        CheflyButtonVariant.secondary ||
        CheflyButtonVariant.text =>
          cs.primary,
      };
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator.adaptive(
          valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
          strokeWidth: 2,
        ),
      );
    }

    if (leadingIcon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          leadingIcon!,
          const SizedBox(width: AppSpacing.sm),
          Text(label),
        ],
      );
    }

    return Text(label);
  }
}
