import 'package:dio/dio.dart';

import '../../guest/device_id_service.dart';

/// Attaches `X-Device-ID` to every request, enabling the backend to
/// associate guest activity (cart, browsing) with a stable device identity
/// even before the user creates an account.
///
/// Set `extra['skipDeviceId'] = true` on a request to opt out.
class DeviceIdInterceptor extends Interceptor {
  DeviceIdInterceptor(this._deviceIdService);

  final DeviceIdService _deviceIdService;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.extra['skipDeviceId'] == true) {
      return handler.next(options);
    }

    final deviceId = await _deviceIdService.getDeviceId();
    if (deviceId != null) {
      options.headers['X-Device-ID'] = deviceId;
    }
    return handler.next(options);
  }
}
