import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

/// The global [GetIt] service locator.
final GetIt getIt = GetIt.instance;

/// Initialises the [GetIt] container with all `bmb_core` singletons.
///
/// Call once at app start, **after** `FlavorConfig.initialize` and
/// `await Firebase.initializeApp(...)`, and **before** the first route is
/// pushed.
///
/// ```dart
/// await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
/// FlavorConfig.initialize(...);
/// await configureDependencies();
/// runApp(const MyApp());
/// ```
@InjectableInit(preferRelativeImports: true)
Future<GetIt> configureDependencies() async => getIt.init();
