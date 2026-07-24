// String utility extensions used across bmb_core and consuming apps.
// Import via bmb_core.dart — do not import this file directly.

// ---------------------------------------------------------------------------
// Non-nullable
// ---------------------------------------------------------------------------

/// Extensions on non-null [String].
extension StringExtensions on String {
  /// Returns `true` if the string is empty or contains only whitespace.
  bool get isBlank => trim().isEmpty;

  /// Capitalises the first character and lowercases the rest.
  ///
  /// ```dart
  /// 'hELLO'.capitalized // 'Hello'
  /// ```
  String get capitalized {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  /// Capitalises the first character of each word.
  ///
  /// ```dart
  /// 'hello world'.titleCase // 'Hello World'
  /// ```
  String get titleCase {
    if (isEmpty) return this;
    return split(' ').map((w) => w.isEmpty ? w : w.capitalized).join(' ');
  }

  /// Returns `true` when the string matches a basic e-mail pattern.
  ///
  /// Matches `local@domain.tld` — does not aim for full RFC 5321 compliance,
  /// but covers the vast majority of real addresses.
  bool get isValidEmail {
    final pattern = RegExp(
      r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$',
    );
    return pattern.hasMatch(trim());
  }

  /// Removes all whitespace characters.
  String get removeWhitespace => replaceAll(RegExp(r'\s+'), '');

  /// Truncates the string to [maxLength] characters, appending [ellipsis] if
  /// truncation occurred.
  String truncate(int maxLength, {String ellipsis = '…'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$ellipsis';
  }
}

// ---------------------------------------------------------------------------
// Nullable
// ---------------------------------------------------------------------------

/// Extensions on nullable [String].
extension NullableStringExtensions on String? {
  /// Returns `true` if the value is `null`, empty, or whitespace-only.
  bool get isNullOrBlank {
    final v = this;
    return v == null || v.trim().isEmpty;
  }

  /// Returns the value or [fallback] when null/blank.
  String orDefault(String fallback) => isNullOrBlank ? fallback : this!;
}

// ---------------------------------------------------------------------------
// Greeting helper (top-level, not extension)
// ---------------------------------------------------------------------------

/// Returns a locale-neutral time-of-day greeting.
///
/// ```dart
/// Text(timeGreeting()) // 'Good morning', 'Good afternoon', 'Good evening'
/// ```
String timeGreeting() {
  final hour = DateTime.now().hour;
  if (hour < 12) return 'Good morning';
  if (hour < 17) return 'Good afternoon';
  return 'Good evening';
}
