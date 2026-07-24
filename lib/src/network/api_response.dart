/// Lightweight wrapper around a successful API response body.
///
/// The Django backend returns one of three envelope shapes:
///   1. `{ "data": <object|list>, ... }`   for single resources / collections
///   2. `{ "results": [...], "count": ... }` for paginated lists (DRF default)
///   3. raw object / list (legacy endpoints)
///
/// `ApiResponse` normalises all three into a single shape so callers can
/// always read `.data`. Pagination metadata, when present, is exposed
/// separately on `.pagination`.
class ApiResponse {
  const ApiResponse({
    required this.data,
    this.pagination,
    this.statusCode,
  });

  /// Parsed payload — typically `Map<String, dynamic>` or `List<dynamic>`.
  /// Callers cast to the expected shape.
  final dynamic data;

  /// Populated only for paginated DRF responses.
  final PaginationMeta? pagination;

  final int? statusCode;

  /// Convenience: cast `data` to a map.
  Map<String, dynamic> asMap() => data as Map<String, dynamic>;

  /// Convenience: cast `data` to a list.
  List<dynamic> asList() => data as List<dynamic>;
}

class PaginationMeta {
  const PaginationMeta({
    required this.count,
    this.next,
    this.previous,
  });

  final int count;
  final String? next;
  final String? previous;

  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    return PaginationMeta(
      count: json['count'] as int? ?? 0,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
    );
  }
}
