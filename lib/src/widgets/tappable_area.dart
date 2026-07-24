import 'package:flutter/material.dart';

/// Wraps [child] in a transparent hit-test area that expands the tap target
/// beyond the widget's visual bounds.
///
/// Useful for small icons and text buttons that need a larger touch area
/// without affecting layout:
///
/// ```dart
/// TappableArea(
///   onTap: _handleClose,
///   padding: const EdgeInsets.all(AppSpacing.sm),
///   child: const Icon(Icons.close, size: 20),
/// )
/// ```
class TappableArea extends StatelessWidget {
  const TappableArea({
    super.key,
    required this.onTap,
    required this.child,
    this.padding = const EdgeInsets.all(8),
  });

  final VoidCallback? onTap;
  final Widget child;

  /// Extra transparent padding that expands the hit area.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
