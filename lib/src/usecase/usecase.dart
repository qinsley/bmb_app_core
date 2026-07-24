import 'package:dartz/dartz.dart';

import '../failures/failure.dart';

/// Base class for all use-cases. A use-case is a single domain operation
/// (e.g. `FetchFeed`, `Logout`, `AddToCart`) that takes an input and
/// returns `Either<Failure, Output>`.
///
/// Use-cases live in `domain/usecases/` and are injected into cubits.
/// They are the only thing presentation imports from the data layer
/// indirectly — they keep cubits free of Dio, Hive, and other
/// infrastructure concerns.
///
/// ```dart
/// class FetchFeed extends UseCase<NoParams, List<Chef>> {
///   final FeedRepository repo;
///   FetchFeed(this.repo);
///
///   @override
///   Future<Either<Failure, List<Chef>>> call(NoParams params) =>
///       repo.fetchFeed();
/// }
/// ```
abstract class UseCase<Input, Output> {
  const UseCase();

  Future<Either<Failure, Output>> call(Input input);
}

/// Use this for use-cases that take no input.
class NoParams {
  const NoParams();
}
