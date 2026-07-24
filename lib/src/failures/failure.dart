/// Base class for all failures returned from the data layer to the
/// domain/presentation layer.
///
/// Failures are values (not exceptions) and are typically wrapped in
/// `Either<Failure, T>` from `dartz`. The repository layer catches
/// raw exceptions and converts them into `Failure` subclasses.
abstract class Failure {
  const Failure(this.message, {this.data});

  /// Human-readable message safe to display to a user.
  final String message;

  /// Optional structured payload (e.g. field-level validation errors).
  final dynamic data;

  @override
  String toString() => '$runtimeType($message)';
}
