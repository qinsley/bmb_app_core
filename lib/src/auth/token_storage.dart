import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Secure persistence for JWT access and refresh tokens.
///
/// Uses `flutter_secure_storage` which backs onto the iOS Keychain and
/// Android EncryptedSharedPreferences. Tokens never touch unencrypted disk.
///
/// Also exposes a broadcast stream of token-changed events so other parts
/// of the app (e.g. an `AuthBloc`) can react to login/logout without
/// polling.
class TokenStorage {
  TokenStorage({FlutterSecureStorage? secureStorage})
      : _storage = secureStorage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;
  final _controller = StreamController<TokenChange>.broadcast();

  static const _accessKey = 'bmb.auth.access_token';
  static const _refreshKey = 'bmb.auth.refresh_token';

  /// Emits whenever tokens are written or cleared. Useful for reacting
  /// to logout from anywhere in the app.
  Stream<TokenChange> get changes => _controller.stream;

  Future<String?> readAccessToken() => _storage.read(key: _accessKey);

  Future<String?> readRefreshToken() => _storage.read(key: _refreshKey);

  Future<bool> hasTokens() async {
    final access = await readAccessToken();
    return access != null && access.isNotEmpty;
  }

  Future<void> writeTokens({
    required String access,
    required String refresh,
  }) async {
    await _storage.write(key: _accessKey, value: access);
    await _storage.write(key: _refreshKey, value: refresh);
    _controller.add(TokenChange.written);
  }

  Future<void> clear() async {
    await _storage.delete(key: _accessKey);
    await _storage.delete(key: _refreshKey);
    _controller.add(TokenChange.cleared);
  }

  /// Call from app shutdown only. Most apps never need this.
  Future<void> dispose() async {
    await _controller.close();
  }
}

enum TokenChange { written, cleared }
