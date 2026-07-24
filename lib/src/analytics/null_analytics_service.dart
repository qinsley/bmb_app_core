import 'analytics_service.dart';

/// No-op [AnalyticsService] used in tests and when the user chooses the
/// "Browse only" consent path (no data collection).
///
/// Every method is a silent no-op returning an already-resolved [Future].
/// Not annotated with `@injectable` — registered manually wherever needed.
class NullAnalyticsService implements AnalyticsService {
  /// Creates a [NullAnalyticsService].
  const NullAnalyticsService();

  @override
  Future<void> logEvent(String name, {Map<String, dynamic>? parameters}) =>
      Future.value();

  @override
  Future<void> logScreenView(String screenName, {String? screenClass}) =>
      Future.value();

  @override
  Future<void> setUserId(String? userId) => Future.value();

  @override
  Future<void> setUserProperty({required String name, required String value}) =>
      Future.value();

  @override
  Future<void> resetUser() => Future.value();
}
