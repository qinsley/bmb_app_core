import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';

import '../auth/token_storage.dart';
import '../config/flavor_config.dart';
import '../failures/api_failure.dart';
import '../guest/device_id_service.dart';
import 'api_response.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/device_id_interceptor.dart';
import 'interceptors/logging_interceptor.dart';

/// The single networking entry point for both apps.
///
/// Wraps Dio with the standard interceptor chain (device ID → auth →
/// retry → logging) and normalises responses into `ApiResponse` while
/// converting Dio errors into typed `ApiFailure` subclasses that the
/// repository layer can pattern-match on.
///
/// Repositories use this directly rather than going through a wrapper:
///
/// ```dart
/// final response = await apiClient.get('/feed/');
/// final chefs = (response.asMap()['data'] as List)
///     .map((e) => ChefModel.fromJson(e as Map<String, dynamic>))
///     .toList();
/// ```
class ApiClient {
  ApiClient({
    required this.flavorConfig,
    required this.tokenStorage,
    required this.deviceIdService,
    required Future<RefreshResult?> Function(String refreshToken) onRefresh,
    required void Function() onLogout,
    Dio? dio,
  }) : _dio = dio ?? Dio() {
    _configure(onRefresh: onRefresh, onLogout: onLogout);
  }

  final FlavorConfig flavorConfig;
  final TokenStorage tokenStorage;
  final DeviceIdService deviceIdService;
  final Dio _dio;

  Dio get dio => _dio;

  void _configure({
    required Future<RefreshResult?> Function(String refreshToken) onRefresh,
    required void Function() onLogout,
  }) {
    _dio.options
      ..baseUrl = flavorConfig.baseUrl
      ..connectTimeout = const Duration(seconds: 15)
      ..receiveTimeout = const Duration(seconds: 30)
      ..sendTimeout = const Duration(seconds: 30)
      ..headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
      };

    // Order matters. Device ID first (always present), then auth (may inject
    // bearer), then retry (handles transient errors), then logging (sees
    // everything that actually went out).
    _dio.interceptors.addAll([
      DeviceIdInterceptor(deviceIdService),
      AuthInterceptor(
        dio: _dio,
        tokenStorage: tokenStorage,
        onRefresh: onRefresh,
        onLogout: onLogout,
      ),
      RetryInterceptor(
        dio: _dio,
        retries: 2,
        retryDelays: const [Duration(seconds: 1), Duration(seconds: 3)],
        // Don't retry 4xx — they're not transient.
        retryEvaluator: (error, attempt) {
          final status = error.response?.statusCode;
          if (status != null && status >= 400 && status < 500) return false;
          return DefaultRetryEvaluator(defaultRetryableStatuses).evaluate(
            error,
            attempt,
          );
        },
      ),
      LoggingInterceptor(),
    ]);
  }

  Future<ApiResponse> get(
    String path, {
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    bool requireAuth = true,
  }) {
    return _request(
      () => _dio.get<dynamic>(
        path,
        queryParameters: query,
        options: _options(headers: headers, requireAuth: requireAuth),
      ),
    );
  }

  Future<ApiResponse> post(
    String path, {
    Object? body,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    bool requireAuth = true,
  }) {
    return _request(
      () => _dio.post<dynamic>(
        path,
        data: body,
        queryParameters: query,
        options: _options(headers: headers, requireAuth: requireAuth),
      ),
    );
  }

  Future<ApiResponse> put(
    String path, {
    Object? body,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    bool requireAuth = true,
  }) {
    return _request(
      () => _dio.put<dynamic>(
        path,
        data: body,
        queryParameters: query,
        options: _options(headers: headers, requireAuth: requireAuth),
      ),
    );
  }

  Future<ApiResponse> patch(
    String path, {
    Object? body,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    bool requireAuth = true,
  }) {
    return _request(
      () => _dio.patch<dynamic>(
        path,
        data: body,
        queryParameters: query,
        options: _options(headers: headers, requireAuth: requireAuth),
      ),
    );
  }

  Future<ApiResponse> delete(
    String path, {
    Object? body,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    bool requireAuth = true,
  }) {
    return _request(
      () => _dio.delete<dynamic>(
        path,
        data: body,
        queryParameters: query,
        options: _options(headers: headers, requireAuth: requireAuth),
      ),
    );
  }

  Options _options({
    Map<String, dynamic>? headers,
    required bool requireAuth,
  }) {
    return Options(
      headers: headers,
      extra: {'auth': requireAuth},
    );
  }

  Future<ApiResponse> _request(Future<Response<dynamic>> Function() run) async {
    try {
      final res = await run();
      return _toResponse(res);
    } on DioException catch (e) {
      throw _toFailure(e);
    } catch (e) {
      throw UnknownApiFailure('Unexpected error: $e');
    }
  }

  ApiResponse _toResponse(Response<dynamic> res) {
    final data = res.data;
    PaginationMeta? pagination;
    dynamic payload = data;

    if (data is Map<String, dynamic> && data.containsKey('results')) {
      pagination = PaginationMeta.fromJson(data);
      payload = data['results'];
    }

    return ApiResponse(
      data: payload,
      pagination: pagination,
      statusCode: res.statusCode,
    );
  }

  ApiFailure _toFailure(DioException e) {
    final res = e.response;
    final status = res?.statusCode;
    final body = res?.data;
    final message = _extractMessage(body) ?? e.message ?? 'Request failed';

    // No response → network problem.
    if (res == null) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return const NetworkFailure('Connection timed out');
        case DioExceptionType.connectionError:
        case DioExceptionType.unknown:
          return const NetworkFailure('No internet connection');
        case DioExceptionType.cancel:
          return const UnknownApiFailure('Request cancelled');
        case DioExceptionType.badCertificate:
          return const NetworkFailure('Certificate error');
        case DioExceptionType.badResponse:
          return UnknownApiFailure(message);
      }
    }

    switch (status) {
      case 400:
        return BadRequestFailure(message, data: body);
      case 401:
        return UnauthenticatedFailure(message, data: body);
      case 403:
        return ForbiddenFailure(message, data: body);
      case 404:
        return NotFoundFailure(message, data: body);
      case 409:
        return ConflictFailure(message, data: body);
      case 422:
        return ValidationFailure(
          message,
          fieldErrors: _extractFieldErrors(body),
          data: body,
        );
      case 429:
        final retryAfter = int.tryParse(
          res.headers.value('retry-after') ?? '',
        );
        return RateLimitedFailure(
          message,
          retryAfter: retryAfter,
          data: body,
        );
      default:
        if (status != null && status >= 500) {
          return ServerFailure(message, data: body);
        }
        return UnknownApiFailure(message, data: body);
    }
  }

  String? _extractMessage(dynamic body) {
    if (body is Map) {
      // Prefer the first field-level error over the generic top-level message.
      // e.g. {errors: {email: ["user with this email already exists."]}}
      // → "user with this email already exists."
      final errors = body['errors'];
      if (errors is Map && errors.isNotEmpty) {
        final firstValue = errors.values.first;
        if (firstValue is List && firstValue.isNotEmpty) {
          return firstValue.first.toString();
        }
        if (firstValue is String) return firstValue;
      }

      // Fallback to the generic message fields.
      final detail = body['detail'] ?? body['message'] ?? body['error'];
      if (detail is String) return detail;
    }
    return null;
  }

  Map<String, List<String>> _extractFieldErrors(dynamic body) {
    final result = <String, List<String>>{};
    if (body is Map) {
      body.forEach((key, value) {
        if (key == 'detail' || key == 'message') return;
        if (value is List) {
          result[key.toString()] =
              value.map((e) => e.toString()).toList();
        } else if (value is String) {
          result[key.toString()] = [value];
        }
      });
    }
    return result;
  }
}
