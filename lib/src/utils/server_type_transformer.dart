/// Coerces values from Django/DRF responses into Dart types.
///
/// DRF sometimes returns numbers as strings (especially `DecimalField`),
/// IDs as either int or string, and booleans as 'true'/'false' strings.
/// These helpers normalise to expected Dart types so `freezed` models
/// don't blow up on field deserialisation.
abstract class ServerTypeTransformer {
  static String toStringFromServer(dynamic value) {
    if (value == null) return '';
    return value.toString();
  }

  static int toIntFromServer(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  static double toDoubleFromServer(dynamic value) {
    if (value == null) return 0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0;
    return 0;
  }

  static bool toBoolFromServer(dynamic value) {
    if (value == null) return false;
    if (value is bool) return value;
    if (value is String) return value.toLowerCase() == 'true';
    if (value is int) return value == 1;
    return false;
  }

  static DateTime? toDateTimeFromServer(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }
}
