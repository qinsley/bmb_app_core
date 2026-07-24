import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

/// Factory helpers that return ready-to-use `TextInputFormatter` instances.
///
/// Pass the result directly to `inputFormatters:` on a `TextField` or
/// `TextFormField`.
abstract class AppInputFormatters {
  /// Phone formatter defaulting to Kenya (+254).
  ///
  /// Automatically switches country when the user types a different dial code.
  static PhoneInputFormatter phone() => PhoneInputFormatter(
        defaultCountryCode: 'KE',
      );

  /// Money formatter with `KSh ` leading symbol and comma thousands separator.
  ///
  /// [fractionDigits] defaults to `0` (whole shillings).
  static CurrencyInputFormatter money({int fractionDigits = 0}) =>
      CurrencyInputFormatter(
        leadingSymbol: 'KSh ',
        mantissaLength: fractionDigits,
      );

  /// Generic masked formatter (digits only).
  ///
  /// Use `#` for any digit, e.g. `'##/##'` for a month/year expiry.
  static MaskedInputFormatter digitsOnly(String mask) =>
      MaskedInputFormatter(mask);

  /// Single-digit formatter for OTP boxes.
  static MaskedInputFormatter otpDigit() => MaskedInputFormatter('0');
}
