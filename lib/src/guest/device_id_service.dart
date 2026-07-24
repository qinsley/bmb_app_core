import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

/// Manages a stable, anonymous device identifier used for guest sessions.
///
/// Generated as a UUIDv4 on first launch and persisted to secure storage so
/// it survives app updates. It is **not** the hardware device ID (which
/// requires platform-specific permissions on Android 10+) — it's an
/// app-scoped identifier that survives reinstall only if iOS Keychain
/// preserves it (it usually does on iOS; Android resets on reinstall).
///
/// Importantly, this is created lazily: the consuming app should not call
/// `getDeviceId()` until the user has granted privacy consent. See
/// `ConsentService`.
class DeviceIdService {
  DeviceIdService({FlutterSecureStorage? secureStorage, Uuid? uuid})
      : _storage = secureStorage ?? const FlutterSecureStorage(),
        _uuid = uuid ?? const Uuid();

  final FlutterSecureStorage _storage;
  final Uuid _uuid;

  static const _key = 'chefly.guest.device_id';

  String? _cached;

  /// Returns the device ID, generating one if it doesn't exist yet.
  /// Returns `null` only if storage is unavailable (extremely rare).
  Future<String?> getDeviceId() async {
    if (_cached != null) return _cached;

    final existing = await _storage.read(key: _key);
    if (existing != null && existing.isNotEmpty) {
      _cached = existing;
      return existing;
    }

    final generated = _uuid.v4();
    await _storage.write(key: _key, value: generated);
    _cached = generated;
    return generated;
  }

  /// Returns the device ID only if one already exists. Does not generate.
  /// Used by the API client interceptor — we don't want to silently create
  /// an identity before consent is granted.
  Future<String?> peekDeviceId() async {
    if (_cached != null) return _cached;
    final existing = await _storage.read(key: _key);
    _cached = existing;
    return existing;
  }

  /// Clears the device ID. Used when the user revokes consent or on
  /// explicit reset.
  Future<void> clear() async {
    await _storage.delete(key: _key);
    _cached = null;
  }
}
