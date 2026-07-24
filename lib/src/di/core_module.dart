// firebase_analytics removed temporarily — restore after flutterfire configure.
// import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../auth/auth_state_stream.dart';
import '../auth/token_storage.dart';
import '../config/flavor_config.dart';
import '../connection/connection_status.dart';
import '../guest/consent_service.dart';
import '../guest/device_id_service.dart';
import '../storage/hive_database.dart';
import '../storage/secure_storage.dart';

// ignore_for_file: avoid_unused_imports — re-exported via barrel

/// Injectable module that wires up all `chefly_core` singletons.
///
/// Consuming apps must call `configureDependencies` (from `injection.dart`)
/// **after** `FlavorConfig.initialize` and Firebase initialization, but
/// **before** the first route is pushed.
///
/// **Not registered here:**
/// - `ApiClient` — requires `onRefresh` / `onLogout` callbacks supplied by
///   the app.  Register it in the app's own `@module`.
/// - `GuestSessionService` — depends on `ApiClient`.
///
/// **Singletons with internal constructors** (`HiveDatabase`,
/// `ConnectionStatus`, `FlavorConfig`) are registered via provider getters
/// that return the pre-existing static instance.
@module
abstract class CoreModule {
  // ---------------------------------------------------------------------------
  // Infrastructure singletons
  // ---------------------------------------------------------------------------

  /// Provides the shared [FlavorConfig] instance initialised by the app.
  @lazySingleton
  FlavorConfig get flavorConfig => FlavorConfig.instance;

  /// Provides the shared [HiveDatabase] instance.
  @lazySingleton
  HiveDatabase get hiveDatabase => HiveDatabase.instance;

  /// Provides the shared [ConnectionStatus] instance.
  @lazySingleton
  ConnectionStatus get connectionStatus => ConnectionStatus.instance;

  // ---------------------------------------------------------------------------
  // Storage
  // ---------------------------------------------------------------------------

  /// Shared [FlutterSecureStorage] instance used by several services.
  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

  /// [SecureStorage] thin wrapper — shares the same [FlutterSecureStorage].
  @lazySingleton
  SecureStorage secureStorageService(FlutterSecureStorage storage) =>
      SecureStorage(storage: storage);

  // ---------------------------------------------------------------------------
  // Auth
  // ---------------------------------------------------------------------------

  /// [TokenStorage] backed by the shared [FlutterSecureStorage] instance.
  @lazySingleton
  TokenStorage tokenStorage(FlutterSecureStorage storage) =>
      TokenStorage(secureStorage: storage);

  /// [AuthStateStream] — plain default constructor, no dependencies.
  @lazySingleton
  AuthStateStream get authStateStream => AuthStateStream();

  // ---------------------------------------------------------------------------
  // Guest
  // ---------------------------------------------------------------------------

  /// [DeviceIdService] — [Uuid] left as default (created internally).
  @lazySingleton
  DeviceIdService deviceIdService(FlutterSecureStorage storage) =>
      DeviceIdService(secureStorage: storage);

  /// [ConsentService] backed by the shared [FlutterSecureStorage] instance.
  @lazySingleton
  ConsentService consentService(FlutterSecureStorage storage) =>
      ConsentService(secureStorage: storage);

  // ---------------------------------------------------------------------------
  // Analytics
  // ---------------------------------------------------------------------------

  // firebase_analytics removed temporarily — restore after flutterfire configure.
  // @lazySingleton
  // FirebaseAnalytics get firebaseAnalytics => FirebaseAnalytics.instance;

  // FirebaseAnalyticsService is annotated with @LazySingleton(as: AnalyticsService)
  // directly on the class. With the stub (no-op) implementation it needs no
  // constructor args, so injectable_generator wires it automatically.
}
