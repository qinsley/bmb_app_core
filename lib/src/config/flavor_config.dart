/// Per-flavor configuration: base URLs, feature flags, identifiers.
///
/// Set at app startup before any service is constructed:
///
/// ```dart
/// FlavorConfig.initialize(
///   FlavorConfig(
///     flavor: Flavor.staging,
///     name: 'Chefly Staging',
///     baseUrl: 'https://staging.chefly.co.ke',
///     enableAnalytics: false,
///   ),
/// );
/// ```
class FlavorConfig {
  FlavorConfig({
    required this.flavor,
    required this.name,
    required this.baseUrl,
    this.enableAnalytics = true,
    this.enableCrashlytics = true,
  });

  final Flavor flavor;
  final String name;
  final String baseUrl;
  final bool enableAnalytics;
  final bool enableCrashlytics;

  static FlavorConfig? _instance;

  static FlavorConfig get instance {
    final i = _instance;
    if (i == null) {
      throw StateError(
        'FlavorConfig not initialised. Call FlavorConfig.initialize() in main.',
      );
    }
    return i;
  }

  static bool get isInitialised => _instance != null;

  static void initialize(FlavorConfig config) {
    _instance = config;
  }

  bool get isDev => flavor == Flavor.dev;
  bool get isStaging => flavor == Flavor.staging;
  bool get isProd => flavor == Flavor.prod;
}

enum Flavor { dev, staging, prod }
