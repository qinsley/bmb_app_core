import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// A +/– quantity control for meal cards and the cart.
///
/// [value] is always ≥ [min]. When the user taps **–** while [value] equals
/// [min], [onRemove] is called instead (allows the caller to handle "remove
/// from cart"):
///
/// ```dart
/// QuantityStepper(
///   value: item.quantity,
///   onChanged: (q) => context.read<CartBloc>().add(CartEvent.setQuantity(item.id, q)),
///   onRemove: () => context.read<CartBloc>().add(CartEvent.remove(item.id)),
/// )
/// ```
class QuantityStepper extends StatelessWidget {
  const QuantityStepper({
    super.key,
    required this.value,
    required this.onChanged,
    this.onRemove,
    this.min = 1,
    this.max = 99,
  }) : assert(value >= 0, 'value must be non-negative');

  final int value;
  final ValueChanged<int> onChanged;

  /// Called when the user taps **–** while [value] == [min].
  final VoidCallback? onRemove;

  final int min;
  final int max;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _StepButton(
          icon: Icons.remove,
          onPressed: value <= min ? onRemove : () => onChanged(value - 1),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: Text(
            '$value',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.neutral900,
                ),
          ),
        ),
        _StepButton(
          icon: Icons.add,
          onPressed: value >= max ? null : () => onChanged(value + 1),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Private step button
// ---------------------------------------------------------------------------

class _StepButton extends StatelessWidget {
  const _StepButton({
    required this.icon,
    this.onPressed,
  });

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    return Material(
      color: enabled ? AppColors.primary : AppColors.neutral200,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        onTap: onPressed,
        child: SizedBox(
          width: 32,
          height: 32,
          child: Icon(
            icon,
            size: 16,
            color: enabled ? AppColors.neutral0 : AppColors.neutral400,
          ),
        ),
      ),
    );
  }
}
