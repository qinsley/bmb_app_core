import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../failures/api_failure.dart';
import '../failures/cache_failure.dart';
import 'logger.dart';

/// Wraps an API call so any thrown `ApiFailure` becomes a `Left`, and any
/// successful result becomes a `Right`. Unexpected exceptions are caught,
/// logged, and converted into `UnknownApiFailure`.
///
/// This is the canonical way to call the network layer from a repository:
///
/// ```dart
/// Future<Either<ApiFailure, List<Meal>>> fetchMeals() {
///   return guardedApiCall(() async {
///     final res = await apiClient.get('/meals/');
///     return (res.asList())
///         .map((e) => Meal.fromJson(e as Map<String, dynamic>))
///         .toList();
///   });
/// }
/// ```
Future<Either<ApiFailure, T>> guardedApiCall<T>(
  Future<T> Function() run,
) async {
  try {
    final value = await run();
    return right(value);
  } on ApiFailure catch (e) {
    return left(e);
  } catch (e, st) {
    if (kDebugMode) {
      logger.e('Unexpected error in guardedApiCall', error: e, stackTrace: st);
    }
    return left(UnknownApiFailure(e.toString()));
  }
}

/// Same shape as [guardedApiCall] but for cache/local storage access.
Future<Either<CacheFailure, T>> guardedCacheAccess<T>(
  Future<T> Function() run,
) async {
  try {
    final value = await run();
    return right(value);
  } on CacheFailure catch (e) {
    return left(e);
  } catch (e, st) {
    if (kDebugMode) {
      logger.e(
        'Unexpected error in guardedCacheAccess',
        error: e,
        stackTrace: st,
      );
    }
    return left(CacheFailure(e.toString()));
  }
}
