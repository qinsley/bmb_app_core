import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// User's consent to data collection. Required before we register a
/// device ID, FCM token, or any server-side guest state.
///
/// The consent screen on first launch sets this. Once granted, the value
/// is persisted; we don't ask again unless the user explicitly resets.
///
/// Compliant with the Kenya Data Protection Act 2019 expectations for
/// explicit, informed consent prior to processing personal data.
class ConsentService {
  ConsentService({FlutterSecureStorage? secureStorage})
      : _storage = secureStorage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  static const _consentKey = 'chefly.consent.data_collection';
  static const _consentVersionKey = 'chefly.consent.version';
  static const _consentDateKey = 'chefly.consent.granted_at';

  /// Current consent text version. Bump this when the consent copy
  /// changes materially, and old consents will be treated as invalid.
  static const currentVersion = 1;

  Future<ConsentState> readState() async {
    final granted = await _storage.read(key: _consentKey);
    if (granted != 'true') return ConsentState.notGranted;

    final versionStr = await _storage.read(key: _consentVersionKey);
    final version = int.tryParse(versionStr ?? '') ?? 0;
    if (version < currentVersion) return ConsentState.outdated;

    final dateStr = await _storage.read(key: _consentDateKey);
    final grantedAt = DateTime.tryParse(dateStr ?? '');
    return ConsentState.granted(version: version, grantedAt: grantedAt);
  }

  Future<void> grant() async {
    await _storage.write(key: _consentKey, value: 'true');
    await _storage.write(
      key: _consentVersionKey,
      value: currentVersion.toString(),
    );
    await _storage.write(
      key: _consentDateKey,
      value: DateTime.now().toUtc().toIso8601String(),
    );
  }

  Future<void> revoke() async {
    await _storage.delete(key: _consentKey);
    await _storage.delete(key: _consentVersionKey);
    await _storage.delete(key: _consentDateKey);
  }
}

sealed class ConsentState {
  const ConsentState();

  static const notGranted = _ConsentNotGranted();
  static const outdated = _ConsentOutdated();

  static ConsentState granted({
    required int version,
    DateTime? grantedAt,
  }) =>
      _ConsentGranted(version: version, grantedAt: grantedAt);

  bool get isGranted => this is _ConsentGranted;
}

class _ConsentNotGranted extends ConsentState {
  const _ConsentNotGranted();
}

class _ConsentOutdated extends ConsentState {
  const _ConsentOutdated();
}

class _ConsentGranted extends ConsentState {
  const _ConsentGranted({required this.version, this.grantedAt});
  final int version;
  final DateTime? grantedAt;
}
