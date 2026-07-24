// firebase_analytics removed temporarily — restore after flutterfire configure.
// import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:injectable/injectable.dart';

import 'analytics_service.dart';

@LazySingleton(as: AnalyticsService)
class FirebaseAnalyticsService implements AnalyticsService {
  const FirebaseAnalyticsService();

  @override
  Future<void> logEvent(String name, {Map<String, dynamic>? parameters}) async {}

  @override
  Future<void> logScreenView(String screenName, {String? screenClass}) async {}

  @override
  Future<void> setUserId(String? userId) async {}

  @override
  Future<void> setUserProperty({required String name, required String value}) async {}

  @override
  Future<void> resetUser() async {}
}
