import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import 'bmb_button.dart';

/// Full-area centered empty state with an icon, title, subtitle, and optional
/// primary action button.
///
/// Use this when a list or data region has no items to display. If
/// [actionLabel] and [onAction] are both provided a full-width
/// [BMBButton] primary variant appears below the subtitle.
class EmptyState extends StatelessWidget {
  /// Creates an [EmptyState].
  const EmptyState({
    required this.title,
    required this.subtitle,
    super.key,
    this.icon = Icons.inbox_outlined,
    this.actionLabel,
    this.onAction,
  });

  /// Heading displayed in title style.
  final String title;

  /// Supporting description displayed in body style below [title].
  final String subtitle;

  /// Icon shown at the top of the column. Defaults to an outlined inbox.
  final IconData icon;

  /// Label for the optional action button. When non-null the button renders.
  final String? actionLabel;

  /// Called when the action button is tapped.
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;
    final String? label = actionLabel;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 64,
              color: AppColors.neutral500,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              title,
              style: tt.titleMedium?.copyWith(color: AppColors.neutral900),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              subtitle,
              style: tt.bodyMedium?.copyWith(color: AppColors.neutral500),
              textAlign: TextAlign.center,
            ),
            if (label != null) ...[
              const SizedBox(height: AppSpacing.xl),
              BMBButton(
                label: label,
                onPressed: onAction,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
