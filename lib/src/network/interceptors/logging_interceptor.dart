import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../utils/logger.dart';

/// Logs requests and responses in debug mode only. Redacts the
/// `Authorization` header so tokens never leak into logs or crash reports.
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    if (kDebugMode) {
      final redactedHeaders = Map<String, dynamic>.from(options.headers)
        ..['Authorization'] = '<redacted>';
      logger.d('→ ${options.method} ${options.uri}\n'
          '  headers: $redactedHeaders\n'
          '  body: ${_truncate(options.data)}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      logger.d('← ${response.statusCode} ${response.requestOptions.uri}\n'
          '  body: ${_truncate(response.data)}');
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      logger.e('✗ ${err.response?.statusCode ?? '-'} '
          '${err.requestOptions.uri}\n'
          '  body: ${_truncate(err.response?.data)}\n'
          '  error: ${err.message}');
    }
    handler.next(err);
  }

  String _truncate(dynamic value, {int max = 2000}) {
    final s = value?.toString() ?? '';
    return s.length <= max ? s : '${s.substring(0, max)}…(truncated)';
  }
}
