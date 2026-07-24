// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../analytics/analytics_service.dart' as _i726;
import '../analytics/firebase_analytics_service.dart' as _i616;
import '../auth/auth_state_stream.dart' as _i174;
import '../auth/token_storage.dart' as _i1002;
import '../config/flavor_config.dart' as _i636;
import '../connection/connection_status.dart' as _i794;
import '../guest/consent_service.dart' as _i400;
import '../guest/device_id_service.dart' as _i384;
import '../storage/hive_database.dart' as _i277;
import '../storage/secure_storage.dart' as _i619;
import 'core_module.dart' as _i154;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final coreModule = _$CoreModule();
    gh.lazySingleton<_i636.FlavorConfig>(() => coreModule.flavorConfig);
    gh.lazySingleton<_i277.HiveDatabase>(() => coreModule.hiveDatabase);
    gh.lazySingleton<_i794.ConnectionStatus>(() => coreModule.connectionStatus);
    gh.lazySingleton<_i558.FlutterSecureStorage>(
        () => coreModule.secureStorage);
    gh.lazySingleton<_i174.AuthStateStream>(() => coreModule.authStateStream);
    gh.lazySingleton<_i619.SecureStorage>(() =>
        coreModule.secureStorageService(gh<_i558.FlutterSecureStorage>()));
    gh.lazySingleton<_i1002.TokenStorage>(
        () => coreModule.tokenStorage(gh<_i558.FlutterSecureStorage>()));
    gh.lazySingleton<_i384.DeviceIdService>(
        () => coreModule.deviceIdService(gh<_i558.FlutterSecureStorage>()));
    gh.lazySingleton<_i400.ConsentService>(
        () => coreModule.consentService(gh<_i558.FlutterSecureStorage>()));
    gh.lazySingleton<_i726.AnalyticsService>(
        () => const _i616.FirebaseAnalyticsService());
    return this;
  }
}

class _$CoreModule extends _i154.CoreModule {}
