import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';

/// Full-area centered loading indicator with an optional message.
///
/// Drop this into any screen region while data is being fetched.
/// The indicator colour defaults to [ColorScheme.primary]; pass [color]
/// to override (e.g. white when used on a coloured background).
class LoadingState extends StatelessWidget {
  /// Creates a [LoadingState].
  const LoadingState({
    super.key,
    this.message,
    this.color,
  });

  /// Optional text displayed below the spinner.
  final String? message;

  /// Indicator colour. Defaults to [ColorScheme.primary] when `null`.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final Color effectiveColor =
        color ?? Theme.of(context).colorScheme.primary;
    final String? msg = message;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation<Color>(effectiveColor),
            ),
            if (msg != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                msg,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
