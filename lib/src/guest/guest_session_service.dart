import 'package:dartz/dartz.dart';

import '../failures/api_failure.dart';
import '../network/api_client.dart';
import '../utils/guarded_calls.dart';
import 'consent_service.dart';
import 'device_id_service.dart';

/// Coordinates the guest session lifecycle:
///   1. After consent → generate device ID
///   2. Call `POST /guest/init/` to register with backend
///   3. Register FCM token via `POST /guest/fcm/` so backend can send
///      abandoned-cart push notifications
///
/// Called once on app startup *after* consent is granted. Subsequent
/// launches just re-send the FCM token (it may have rotated).
class GuestSessionService {
  GuestSessionService({
    required ApiClient apiClient,
    required DeviceIdService deviceIdService,
    required ConsentService consentService,
    String initPath = '/api/guest/init/',
    String fcmPath = '/api/guest/fcm/',
  })  : _apiClient = apiClient,
        _deviceIdService = deviceIdService,
        _consentService = consentService,
        _initPath = initPath,
        _fcmPath = fcmPath;

  final ApiClient _apiClient;
  final DeviceIdService _deviceIdService;
  final ConsentService _consentService;
  final String _initPath;
  final String _fcmPath;

  /// Initialise a guest session with the backend. Idempotent — calling
  /// this on every app launch is safe; the backend upserts.
  Future<Either<ApiFailure, void>> initialise({
    double? latitude,
    double? longitude,
  }) async {
    final consent = await _consentService.readState();
    if (!consent.isGranted) {
      return left(
        const BadRequestFailure(
          'Consent required before initialising guest session',
        ),
      );
    }

    final deviceId = await _deviceIdService.getDeviceId();
    if (deviceId == null) {
      return left(const UnknownApiFailure('Could not obtain device ID'));
    }

    return guardedApiCall(() async {
      await _apiClient.post(
        _initPath,
        requireAuth: false,
        body: <String, dynamic>{
          'device_id': deviceId,
          if (latitude != null && longitude != null)
            'location': {'lat': latitude, 'lng': longitude},
        },
      );
    });
  }

  /// Register or update the FCM token for this guest session.
  Future<Either<ApiFailure, void>> registerFcmToken(String fcmToken) {
    return guardedApiCall(() async {
      await _apiClient.post(
        _fcmPath,
        requireAuth: false,
        body: <String, dynamic>{'fcm_token': fcmToken},
      );
    });
  }
}
