import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// Shared logger instance. Verbose in debug, warnings-and-up in release.
///
/// Wraps the `logger` package with a single Pretty printer config so logs
/// look the same everywhere.
final Logger logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 100,
    dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
  ),
  level: kReleaseMode ? Level.warning : Level.debug,
);
