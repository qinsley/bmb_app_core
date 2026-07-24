import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// A skeleton placeholder shaped like a food/chef card.
///
/// Drop this into a list while the real cards are loading. The shimmer sweep
/// animates from [AppColors.neutral100] to [AppColors.neutral200] to give a
/// convincing loading feel.
///
/// Layout (top to bottom inside a [Card]):
/// - Image block (square, full card width, `imageHeight` tall)
/// - Padding with three text skeleton lines (title, subtitle, label)
class CardShimmer extends StatelessWidget {
  /// Creates a [CardShimmer].
  const CardShimmer({
    super.key,
    this.imageHeight = 160,
  });

  /// Height of the image placeholder block. Defaults to `160`.
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Shimmer.fromColors(
        baseColor: AppColors.neutral100,
        highlightColor: AppColors.neutral200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image block placeholder
            Container(
              height: imageHeight,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.neutral100,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(AppRadius.lg),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title line
                  _ShimmerLine(width: double.infinity, height: 16),
                  SizedBox(height: AppSpacing.sm),
                  // Subtitle line (shorter)
                  _ShimmerLine(width: 140, height: 12),
                  SizedBox(height: AppSpacing.sm),
                  // Label / meta line (shortest)
                  _ShimmerLine(width: 80, height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A single rounded rectangle shimmer line used inside [CardShimmer].
class _ShimmerLine extends StatelessWidget {
  const _ShimmerLine({
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        color: AppColors.neutral100,
        borderRadius: BorderRadius.all(Radius.circular(AppRadius.sm)),
      ),
    );
  }
}
