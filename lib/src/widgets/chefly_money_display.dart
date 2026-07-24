import 'package:chefly_core/src/theme/app_colors.dart';
import 'package:chefly_core/src/utils/formatters.dart';
import 'package:flutter/material.dart';

/// A read-only text widget that displays a monetary amount in Kenyan Shillings.
///
/// Formats the value using `AppFormatters.ksh` (or `AppFormatters.kshCompact`
/// when [compact] is `true`). Styling defaults to a bold, primary-coloured
/// `bodyLarge` but can be overridden via [style] and [color].
class CheflyMoneyDisplay extends StatelessWidget {
  const CheflyMoneyDisplay({
    super.key,
    required this.amount,
    this.style,
    this.color,
    this.showDecimals = false,
    this.compact = false,
  });

  /// The amount to display in Kenyan Shillings.
  final num amount;

  /// Custom text style. Takes full precedence over [color] when supplied.
  final TextStyle? style;

  /// Override the text colour. Has no effect when [style] is also supplied.
  final Color? color;

  /// When `true`, shows two decimal places (e.g. `KSh 1,500.00`).
  /// Ignored when [compact] is `true`.
  final bool showDecimals;

  /// When `true`, uses the compact notation (e.g. `KSh 1.5K`).
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final formatted = compact
        ? AppFormatters.kshCompact(amount)
        : AppFormatters.ksh(amount, showDecimals: showDecimals);

    return Text(
      formatted,
      style: style ??
          Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: color ?? AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
    );
  }
}
