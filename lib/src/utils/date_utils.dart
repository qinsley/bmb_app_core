import 'package:bmb_core/src/utils/formatters.dart';

/// Backward-compatible date formatting helpers.
///
/// All methods delegate to [AppFormatters], which is the canonical
/// implementation. New code should use [AppFormatters] directly.
///
/// Note: do NOT re-export [AppFormatters] from this file — the public barrel
/// (`bmb_core.dart`) already exports `formatters.dart` directly, and a
/// second export would create a duplicate-symbol conflict.
abstract class DateUtils {
  static String displayDate(DateTime dt) => AppFormatters.displayDate(dt);

  static String displayTime(DateTime dt) => AppFormatters.displayTime(dt);

  static String displayDateTime(DateTime dt) =>
      AppFormatters.displayDateTime(dt);

  static String relative(DateTime dt, {DateTime? now}) =>
      AppFormatters.relative(dt, now: now);
}
