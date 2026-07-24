import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

import 'string_extensions.dart';

/// Static field validators compatible with `TextFormField.validator`.
///
/// Each method returns `null` when the value is valid, or a human-readable
/// error string when it is not.
abstract class AppValidators {
  // ── Primitive ────────────────────────────────────────────────────────────

  /// Fails if [value] is null or contains only whitespace.
  static String? required(
    String? value, {
    String message = 'This field is required',
  }) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  // ── Identity ─────────────────────────────────────────────────────────────

  /// Validates full name: non-empty, at least two words, letters/spaces only.
  static String? fullName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Full name is required';
    final trimmed = value.trim();
    if (trimmed.split(RegExp(r'\s+')).length < 2) {
      return 'Please enter your first and last name';
    }
    if (!RegExp(r"^[a-zA-Z\s\-']+$").hasMatch(trimmed)) {
      return 'Name can only contain letters, spaces, or hyphens';
    }
    return null;
  }

  // ── Contact ───────────────────────────────────────────────────────────────

  /// Validates an e-mail address (RFC-5321 basic pattern).
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email address is required';
    if (!value.trim().isValidEmail) return 'Enter a valid email address';
    return null;
  }

  /// Validates a phone number via `flutter_multi_formatter`.
  ///
  /// Pass the formatted value from the field (e.g. `+254 712 345 678`).
  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) return 'Phone number is required';
    if (!isPhoneValid(value)) return 'Enter a valid phone number';
    return null;
  }

  /// Like [phone] but allows an empty / null value (field is optional).
  static String? phoneOptional(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    if (!isPhoneValid(value)) return 'Enter a valid phone number';
    return null;
  }

  // ── Auth ──────────────────────────────────────────────────────────────────

  /// Validates a new password: ≥8 chars, at least one letter and one digit.
  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 8) return 'Password must be at least 8 characters';
    if (!RegExp(r'[A-Za-z]').hasMatch(value)) {
      return 'Password must contain at least one letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }
    return null;
  }

  /// Returns a validator that checks the value matches [original].
  ///
  /// Usage:
  /// ```dart
  /// validator: AppValidators.confirmPassword(_passwordController.text),
  /// ```
  static String? Function(String?) confirmPassword(String original) {
    return (String? value) {
      if (value == null || value.isEmpty) return 'Please confirm your password';
      if (value != original) return 'Passwords do not match';
      return null;
    };
  }

  /// Validates a 6-digit OTP.
  static String? otp(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter the verification code';
    if (!RegExp(r'^\d{6}$').hasMatch(value.trim())) {
      return 'The code must be exactly 6 digits';
    }
    return null;
  }
}
