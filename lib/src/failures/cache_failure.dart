import 'failure.dart';

/// Failures originating from local persistence (Hive, secure storage).
class CacheFailure extends Failure {
  const CacheFailure(super.message, {super.data});
}

/// Specific cache failure when an expected key is missing.
class CacheMissFailure extends CacheFailure {
  const CacheMissFailure(super.message, {super.data});
}
