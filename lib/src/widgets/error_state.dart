import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import 'chefly_button.dart';

/// Full-area centered error state with an icon, message, and optional retry.
///
/// Use this whenever a data-fetch or action fails. If [retryLabel] and
/// [onRetry] are provided a [CheflyButton] text-variant appears below the
/// message so the user can attempt the action again.
class ErrorState extends StatelessWidget {
  /// Creates an [ErrorState].
  const ErrorState({
    required this.message,
    super.key,
    this.title,
    this.icon = Icons.error_outline_rounded,
    this.retryLabel,
    this.onRetry,
  });

  /// Primary error description shown in body text.
  final String message;

  /// Optional heading displayed in title style above [message].
  final String? title;

  /// Icon shown at the top of the column. Defaults to an outlined error mark.
  final IconData icon;

  /// Label for the retry button. When non-null the button is rendered.
  final String? retryLabel;

  /// Called when the retry button is tapped.
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;
    final String? heading = title;
    final String? retry = retryLabel;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 48,
              color: AppColors.neutral400,
            ),
            const SizedBox(height: AppSpacing.md),
            if (heading != null) ...[
              Text(
                heading,
                style: tt.titleMedium?.copyWith(color: AppColors.neutral900),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
            Text(
              message,
              style: tt.bodyMedium?.copyWith(color: AppColors.neutral500),
              textAlign: TextAlign.center,
            ),
            if (retry != null) ...[
              const SizedBox(height: AppSpacing.lg),
              CheflyButton(
                label: retry,
                onPressed: onRetry,
                variant: CheflyButtonVariant.text,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
