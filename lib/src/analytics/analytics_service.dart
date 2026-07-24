/// Contract for app-level analytics.
///
/// All feature code depends on this interface, never on a concrete
/// implementation.  The live app wires `FirebaseAnalyticsService`; tests and
/// the "Browse only" consent path use `NullAnalyticsService`.
abstract interface class AnalyticsService {
  /// Logs a custom event with an optional parameter map.
  Future<void> logEvent(String name, {Map<String, dynamic>? parameters});

  /// Logs a screen-view event.  [screenClass] defaults to [screenName] when
  /// omitted.
  Future<void> logScreenView(String screenName, {String? screenClass});

  /// Associates subsequent events with [userId].  Pass `null` to clear.
  Future<void> setUserId(String? userId);

  /// Sets a persistent user property visible in Analytics dashboards.
  Future<void> setUserProperty({required String name, required String value});

  /// Clears the user ID and all previously set user properties.
  Future<void> resetUser();
}
