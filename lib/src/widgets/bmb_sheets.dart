import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// Convenience wrappers for `showModalBottomSheet` with consistent BMB
/// styling: rounded top corners, a drag handle, and standard padding.
///
/// Three size variants:
/// - **flexible** — wraps content height (default, most common)
/// - **medium**   — half-screen (~50 % of screen height)
/// - **tall**     — 90 % of screen height (for complex pickers / forms)
///
/// ```dart
/// BMBSheets.flexible(
///   context,
///   title: 'Filter options',
///   child: FilterPanel(),
/// );
/// ```
abstract class BMBSheets {
  BMBSheets._();

  // ── Public entry points ───────────────────────────────────────────────────

  /// Shows a sheet that wraps its content height.
  static Future<T?> flexible<T>(
    BuildContext context, {
    required Widget child,
    String? title,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    return _show<T>(
      context,
      child: child,
      title: title,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
    );
  }

  /// Shows a sheet occupying approximately half the screen height.
  static Future<T?> medium<T>(
    BuildContext context, {
    required Widget child,
    String? title,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    return _show<T>(
      context,
      child: child,
      title: title,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      heightFactor: 0.5,
    );
  }

  /// Shows a sheet occupying 90 % of the screen height.
  static Future<T?> tall<T>(
    BuildContext context, {
    required Widget child,
    String? title,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    return _show<T>(
      context,
      child: child,
      title: title,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      heightFactor: 0.9,
    );
  }

  // ── Internal ──────────────────────────────────────────────────────────────

  static Future<T?> _show<T>(
    BuildContext context, {
    required Widget child,
    String? title,
    bool isDismissible = true,
    bool enableDrag = true,
    double? heightFactor,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.xl),
        ),
      ),
      builder: (ctx) {
        Widget content = _SheetBody(title: title, child: child);
        if (heightFactor != null) {
          content = SizedBox(
            height: MediaQuery.of(ctx).size.height * heightFactor,
            child: content,
          );
        }
        // Shift the sheet up when the keyboard appears.
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: content,
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Private sheet body
// ---------------------------------------------------------------------------

class _SheetBody extends StatelessWidget {
  const _SheetBody({required this.child, this.title});

  final Widget child;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Drag handle
        const SizedBox(height: AppSpacing.sm),
        Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: AppColors.neutral300,
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
        ),
        // Optional title
        if (title != null) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.xl,
              AppSpacing.lg,
              AppSpacing.xl,
              AppSpacing.xs,
            ),
            child: Text(
              title!,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.neutral900,
                  ),
            ),
          ),
        ] else
          const SizedBox(height: AppSpacing.md),
        child,
        // Bottom safe area
        SizedBox(height: MediaQuery.of(context).padding.bottom + AppSpacing.lg),
      ],
    );
  }
}
