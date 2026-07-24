import 'package:flutter/material.dart';

/// Wraps [child] in a transparent [GestureDetector] that calls
/// `FocusScope.unfocus()` whenever the user taps outside any focused input.
///
/// Place this at the top of a page scaffold body so keyboard-dismissal works
/// without explicit `onTapOutside` callbacks on every [TextField]:
///
/// ```dart
/// body: TapOutsideUnfocus(
///   child: SingleChildScrollView(child: Form(...)),
/// )
/// ```
class TapOutsideUnfocus extends StatelessWidget {
  const TapOutsideUnfocus({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.translucent,
      child: child,
    );
  }
}
