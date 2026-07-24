import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// A skeleton placeholder shaped like a vertical list of rows.
///
/// Renders [count] identical shimmer rows, each containing a circular avatar
/// placeholder on the left and two text-line placeholders on the right.
/// Use this while a list of chefs, orders, or items is loading.
class ListShimmer extends StatelessWidget {
  /// Creates a [ListShimmer].
  const ListShimmer({
    super.key,
    this.count = 6,
  });

  /// Number of skeleton rows to display. Defaults to `6`.
  final int count;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.neutral100,
      highlightColor: AppColors.neutral200,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: count,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
        itemBuilder: (_, __) => const _ListShimmerRow(),
      ),
    );
  }
}

/// A single skeleton row: circle avatar + two text lines.
class _ListShimmerRow extends StatelessWidget {
  const _ListShimmerRow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          // Avatar circle placeholder
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: AppColors.neutral100,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          // Text lines
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ShimmerLine(width: double.infinity, height: 14),
                SizedBox(height: AppSpacing.xs),
                _ShimmerLine(width: 120, height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A single rounded-rectangle line used inside [_ListShimmerRow].
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
