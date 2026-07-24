import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../failures/cache_failure.dart';

/// Thin wrapper around `flutter_secure_storage` so other services don't
/// import it directly. Throws `CacheFailure` on errors.
class SecureStorage {
  SecureStorage({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  Future<String?> read(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      throw CacheFailure('SecureStorage read failed for $key: $e');
    }
  }

  Future<void> write(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (e) {
      throw CacheFailure('SecureStorage write failed for $key: $e');
    }
  }

  Future<void> delete(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (e) {
      throw CacheFailure('SecureStorage delete failed for $key: $e');
    }
  }

  Future<void> deleteAll() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      throw CacheFailure('SecureStorage deleteAll failed: $e');
    }
  }
}
