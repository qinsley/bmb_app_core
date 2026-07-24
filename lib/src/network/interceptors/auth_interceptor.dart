import 'package:dio/dio.dart';

import '../../auth/token_storage.dart';
import '../../utils/logger.dart';

/// Dio interceptor that:
///   1. Attaches `Authorization: Bearer <access>` when an access token exists
///      AND the request hasn't opted out via `extra['auth'] = false`.
///   2. On 401, attempts a single refresh using the stored refresh token,
///      then retries the original request once with the new access token.
///   3. On refresh failure, clears tokens and emits `onLogout()` so the app
///      can navigate to the login screen.
///
/// The refresh endpoint is configurable since `chefly_core` doesn't own
/// the auth feature — the consuming app wires its own endpoint path and
/// payload shape.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required Dio dio,
    required TokenStorage tokenStorage,
    required Future<RefreshResult?> Function(String refreshToken) onRefresh,
    required void Function() onLogout,
  })  : _dio = dio,
        _tokenStorage = tokenStorage,
        _onRefresh = onRefresh,
        _onLogout = onLogout;

  final Dio _dio;
  final TokenStorage _tokenStorage;
  final Future<RefreshResult?> Function(String refreshToken) _onRefresh;
  final void Function() _onLogout;

  bool _isRefreshing = false;
  final List<_PendingRequest> _pendingQueue = [];

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Allow opt-out for endpoints that must remain anonymous (login, register).
    if (options.extra['auth'] == false) {
      return handler.next(options);
    }

    final token = await _tokenStorage.readAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final response = err.response;
    final shouldRefresh = response?.statusCode == 401 &&
        err.requestOptions.extra['_retried'] != true &&
        err.requestOptions.extra['auth'] != false;

    if (!shouldRefresh) {
      return handler.next(err);
    }

    final refreshToken = await _tokenStorage.readRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      _onLogout();
      return handler.next(err);
    }

    // Queue parallel 401s so we only refresh once.
    if (_isRefreshing) {
      _pendingQueue.add(_PendingRequest(err.requestOptions, handler));
      return;
    }

    _isRefreshing = true;
    try {
      final result = await _onRefresh(refreshToken);
      if (result == null) {
        await _tokenStorage.clear();
        _onLogout();
        _flushQueue(success: false);
        return handler.next(err);
      }

      await _tokenStorage.writeTokens(
        access: result.accessToken,
        refresh: result.refreshToken,
      );

      _flushQueue(success: true);

      // Retry the original request with the new token.
      final retried = await _retry(err.requestOptions, result.accessToken);
      return handler.resolve(retried);
    } catch (e, st) {
      logger.e('Token refresh failed', error: e, stackTrace: st);
      await _tokenStorage.clear();
      _onLogout();
      _flushQueue(success: false);
      return handler.next(err);
    } finally {
      _isRefreshing = false;
    }
  }

  Future<Response<dynamic>> _retry(
    RequestOptions options,
    String accessToken,
  ) async {
    final newOptions = Options(
      method: options.method,
      headers: {
        ...options.headers,
        'Authorization': 'Bearer $accessToken',
      },
      extra: {...options.extra, '_retried': true},
      responseType: options.responseType,
      contentType: options.contentType,
      sendTimeout: options.sendTimeout,
      receiveTimeout: options.receiveTimeout,
    );

    return _dio.request<dynamic>(
      options.path,
      data: options.data,
      queryParameters: options.queryParameters,
      options: newOptions,
    );
  }

  void _flushQueue({required bool success}) {
    for (final pending in _pendingQueue) {
      if (success) {
        _retry(pending.options, '').then(
          pending.handler.resolve,
          onError: (Object e) => pending.handler.reject(e as DioException),
        );
      } else {
        pending.handler.reject(
          DioException(requestOptions: pending.options, error: 'Refresh failed'),
        );
      }
    }
    _pendingQueue.clear();
  }
}

class RefreshResult {
  const RefreshResult({required this.accessToken, required this.refreshToken});

  final String accessToken;
  final String refreshToken;
}

class _PendingRequest {
  _PendingRequest(this.options, this.handler);

  final RequestOptions options;
  final ErrorInterceptorHandler handler;
}
