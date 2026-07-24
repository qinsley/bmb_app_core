import 'failure.dart';

/// Failures originating from API calls. Subclasses correspond to specific
/// HTTP error categories so the presentation layer can branch on the
/// runtime type via pattern matching:
///
/// ```dart
/// switch (failure) {
///   Unauthenticated() => navigateToLogin(),
///   ValidationFailure(:final fieldErrors) => showFieldErrors(fieldErrors),
///   _ => showSnackbar(failure.message),
/// }
/// ```
sealed class ApiFailure extends Failure {
  const ApiFailure(super.message, {super.data});
}

/// 400 — Malformed request or business-rule rejection that isn't
/// field-level validation.
class BadRequestFailure extends ApiFailure {
  const BadRequestFailure(super.message, {super.data});
}

/// 401 — No token, expired token after refresh failed, or invalid token.
/// Triggers logout in the auth interceptor.
class UnauthenticatedFailure extends ApiFailure {
  const UnauthenticatedFailure(super.message, {super.data});
}

/// 403 — Authenticated but not permitted (RBAC denial).
class ForbiddenFailure extends ApiFailure {
  const ForbiddenFailure(super.message, {super.data});
}

/// 404 — Resource not found.
class NotFoundFailure extends ApiFailure {
  const NotFoundFailure(super.message, {super.data});
}

/// 409 — State conflict (e.g. cart item no longer available).
class ConflictFailure extends ApiFailure {
  const ConflictFailure(super.message, {super.data});
}

/// 422 — Field-level validation failed. `fieldErrors` maps field name
/// to a list of error messages, matching DRF's default error format.
class ValidationFailure extends ApiFailure {
  const ValidationFailure(
    super.message, {
    required this.fieldErrors,
    super.data,
  });

  final Map<String, List<String>> fieldErrors;
}

/// 429 — Client is being rate-limited.
class RateLimitedFailure extends ApiFailure {
  const RateLimitedFailure(super.message, {this.retryAfter, super.data});

  /// Seconds to wait before retrying, from the `Retry-After` header.
  final int? retryAfter;
}

/// 5xx — Server-side error.
class ServerFailure extends ApiFailure {
  const ServerFailure(super.message, {super.data});
}

/// No network connectivity, DNS failure, or socket timeout.
class NetworkFailure extends ApiFailure {
  const NetworkFailure(super.message, {super.data});
}

/// Anything else — unknown status code, JSON parse error, etc.
class UnknownApiFailure extends ApiFailure {
  const UnknownApiFailure(super.message, {super.data});
}
