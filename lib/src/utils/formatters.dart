import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:intl/intl.dart';

/// Static display-formatting helpers used across the Chefly apps.
///
/// All methods are pure (no side effects) and safe to call from any isolate.
abstract class AppFormatters {
  // ── Currency ──────────────────────────────────────────────────────────────

  /// Formats [amount] as Kenyan Shillings: `KSh 1,500` (or `KSh 1,500.00`).
  static String ksh(num amount, {bool showDecimals = false}) {
    final fmt = NumberFormat.currency(
      symbol: 'KSh ',
      decimalDigits: showDecimals ? 2 : 0,
      locale: 'en_KE',
    );
    return fmt.format(amount);
  }

  /// Compact KSh format: `KSh 1.5K`, `KSh 2.3M`, etc.
  static String kshCompact(num amount) {
    if (amount >= 1000000) {
      return 'KSh ${(amount / 1000000).toStringAsFixed(1)}M';
    }
    if (amount >= 1000) {
      return 'KSh ${(amount / 1000).toStringAsFixed(1)}K';
    }
    return ksh(amount);
  }

  // ── Phone ─────────────────────────────────────────────────────────────────

  /// Returns a display-formatted phone string (e.g. `+254 712 345 678`).
  static String phone(String raw) => formatAsPhoneNumber(raw) ?? raw;

  /// Strips a formatted phone string down to digits only.
  static String phoneDigitsOnly(String formatted) => toNumericString(formatted);

  // ── Date / Time ───────────────────────────────────────────────────────────

  /// `14 May 2025`
  static String displayDate(DateTime dt) => DateFormat('d MMM y').format(dt);

  /// `14 May 2025, 2:30 PM`
  static String displayDateTime(DateTime dt) =>
      DateFormat('d MMM y, h:mm a').format(dt);

  /// `2:30 PM`
  static String displayTime(DateTime dt) => DateFormat('h:mm a').format(dt);

  /// Human-readable relative time: `just now`, `5 min ago`, `3 hrs ago`,
  /// `Yesterday`, or a full date for anything older.
  static String relative(DateTime dt, {DateTime? now}) {
    final reference = now ?? DateTime.now();
    final diff = reference.difference(dt);

    if (diff.isNegative) return displayDateTime(dt);
    if (diff.inSeconds < 60) return 'just now';
    if (diff.inMinutes < 60) {
      final m = diff.inMinutes;
      return '$m min ago';
    }
    if (diff.inHours < 24) {
      final h = diff.inHours;
      return '$h ${h == 1 ? 'hr' : 'hrs'} ago';
    }
    final today = DateTime(reference.year, reference.month, reference.day);
    final dtDay = DateTime(dt.year, dt.month, dt.day);
    final daysDiff = today.difference(dtDay).inDays;
    if (daysDiff == 1) return 'Yesterday';
    return displayDate(dt);
  }

  // ── Geo ───────────────────────────────────────────────────────────────────

  /// `0.8 km` / `1.2 km` / `12 km`
  static String distance(double km) {
    if (km < 1) return '${(km * 1000).round()} m';
    if (km < 10) return '${km.toStringAsFixed(1)} km';
    return '${km.round()} km';
  }

  // ── Misc ──────────────────────────────────────────────────────────────────

  /// One decimal place, e.g. `4.7`
  static String rating(double value) => value.toStringAsFixed(1);

  /// Short order reference: last 8 chars of UUID in upper-case.
  /// `ORD-A1B2C3D4`
  static String orderId(String uuid) {
    final clean = uuid.replaceAll('-', '');
    final short = clean.substring(clean.length - 8).toUpperCase();
    return 'ORD-$short';
  }
}
