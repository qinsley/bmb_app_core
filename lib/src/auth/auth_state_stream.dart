import 'dart:async';

/// Authentication state at the lowest level — just "are we logged in or not".
/// The consuming app's `AuthBloc` adds user details on top.
enum AuthStatus {
  /// Initial state, before any check has run.
  unknown,

  /// No valid tokens.
  unauthenticated,

  /// Guest session active (device registered, no user).
  guest,

  /// User logged in with valid tokens.
  authenticated,
}

/// Broadcast stream of the current auth status. Updated by:
///   - `TokenStorage` when tokens are written/cleared
///   - The app's auth feature when guest → user transitions happen
///
/// `bmb_core` provides the stream; the app decides when to emit.
class AuthStateStream {
  final _controller = StreamController<AuthStatus>.broadcast();
  AuthStatus _current = AuthStatus.unknown;

  AuthStatus get current => _current;

  Stream<AuthStatus> get stream => _controller.stream;

  void emit(AuthStatus status) {
    _current = status;
    _controller.add(status);
  }

  Future<void> dispose() async {
    await _controller.close();
  }
}
