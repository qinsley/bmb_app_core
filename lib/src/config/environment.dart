/// Compile-time environment variables passed via `--dart-define`.
///
/// Usage at runtime:
///   `flutter run --dart-define=ENVIRONMENT=staging`
///
/// Then read with `Environment.environment` — never via `String.fromEnvironment`
/// scattered around the codebase.
abstract class Environment {
  static const environment =
      String.fromEnvironment('ENVIRONMENT', defaultValue: 'dev');

  static const apiBaseUrlOverride =
      String.fromEnvironment('API_BASE_URL');

  static const enableNetworkLogging = bool.fromEnvironment(
    'ENABLE_NETWORK_LOGGING',
    defaultValue: true,
  );
}
