/// Presentation-layer wrapper around a failure, ready to display.
/// Cubits convert `Failure` instances into `UIError` for the UI to render.
class UIError {
  const UIError(this.message, {this.title, this.fieldErrors});

  final String message;
  final String? title;
  final Map<String, List<String>>? fieldErrors;

  @override
  String toString() => 'UIError($message)';
}
