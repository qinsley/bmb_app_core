import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// Toast severity levels.
enum ToastType { success, error, warning, info }

/// Typed SnackBar toasts with consistent BMB styling.
///
/// Call anywhere you have a `BuildContext`:
///
/// ```dart
/// BMBToast.show(context, 'Profile saved', type: ToastType.success);
/// BMBToast.show(context, 'Something went wrong', type: ToastType.error);
/// ```
abstract class BMBToast {
  BMBToast._();

  /// Shows a [SnackBar] with the given [message] styled by [type].
  ///
  /// Replaces any currently-showing snack bar before showing the new one.
  static void show(
    BuildContext context,
    String message, {
    ToastType type = ToastType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: _ToastContent(message: message, type: type),
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        duration: duration,
        margin: const EdgeInsets.all(AppSpacing.lg),
        padding: EdgeInsets.zero,
      ),
    );
  }

  static void success(BuildContext context, String message) =>
      show(context, message, type: ToastType.success);

  static void error(BuildContext context, String message) =>
      show(context, message, type: ToastType.error);

  static void warning(BuildContext context, String message) =>
      show(context, message, type: ToastType.warning);

  static void info(BuildContext context, String message) =>
      show(context, message);
}

// ---------------------------------------------------------------------------
// Private toast content
// ---------------------------------------------------------------------------

class _ToastContent extends StatelessWidget {
  const _ToastContent({required this.message, required this.type});

  final String message;
  final ToastType type;

  @override
  Widget build(BuildContext context) {
    final (bg, icon, fg) = switch (type) {
      ToastType.success => (
          AppColors.success,
          Icons.check_circle_outline,
          AppColors.neutral0,
        ),
      ToastType.error => (
          AppColors.error,
          Icons.error_outline,
          AppColors.neutral0,
        ),
      ToastType.warning => (
          AppColors.warning,
          Icons.warning_amber_outlined,
          AppColors.neutral0,
        ),
      ToastType.info => (
          AppColors.neutral900,
          Icons.info_outline,
          AppColors.neutral0,
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          Icon(icon, color: fg, size: 20),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: fg,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
