import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

/// Listens to device connectivity changes. Cubits can subscribe to react
/// to going offline/online (e.g. flush offline-queued cart updates).
class ConnectionStatus {
  ConnectionStatus._();
  static final ConnectionStatus instance = ConnectionStatus._();

  final _connectivity = Connectivity();
  final _controller = StreamController<bool>.broadcast();
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  bool _online = true;

  bool get isOnline => _online;

  Stream<bool> get onChange => _controller.stream;

  Future<void> initialize() async {
    final initial = await _connectivity.checkConnectivity();
    _online = _hasConnection(initial);

    _subscription = _connectivity.onConnectivityChanged.listen((result) {
      final next = _hasConnection(result);
      if (next != _online) {
        _online = next;
        _controller.add(next);
      }
    });
  }

  bool _hasConnection(List<ConnectivityResult> results) {
    return results.any((r) => r != ConnectivityResult.none);
  }

  Future<void> dispose() async {
    await _subscription?.cancel();
    await _controller.close();
  }
}
