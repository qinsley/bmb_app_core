import 'package:flutter/material.dart';

/// A text form field that conforms to the Chefly design system.
///
/// Styling comes entirely from [InputDecorationTheme] defined in
/// `cheflyLightTheme` — no local style overrides are applied here.
///
/// When [obscureText] is `true` the field automatically shows a
/// show/hide toggle suffix icon regardless of [suffixIcon].
///
/// Server-side validation errors (from `ValidationFailure.fieldErrors`)
/// can be passed via [fieldErrors]; they are joined with a newline and
/// shown as [InputDecoration.errorText].
class CheflyTextField extends StatefulWidget {
  /// Creates a [CheflyTextField].
  const CheflyTextField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.onChanged,
    this.onSubmitted,
    this.fieldErrors,
    this.focusNode,
    this.autofocus = false,
  });

  /// Optional label shown floating above the field.
  final String? label;

  /// Placeholder text shown when the field is empty.
  final String? hint;

  /// Controls the text being edited.
  final TextEditingController? controller;

  /// Called to validate the field value; return a non-null string to show
  /// an error (requires a [Form] ancestor).
  final String? Function(String?)? validator;

  /// When `true` the text is obscured and a show/hide icon is shown.
  /// [suffixIcon] is ignored when this is `true`.
  final bool obscureText;

  /// Widget displayed at the start of the field (e.g. a leading icon).
  final Widget? prefixIcon;

  /// Widget displayed at the end of the field. Ignored when [obscureText]
  /// is `true`.
  final Widget? suffixIcon;

  /// Keyboard layout hint passed to the OS.
  final TextInputType? keyboardType;

  /// Action shown on the keyboard's action button.
  final TextInputAction? textInputAction;

  /// Whether the field accepts user input.
  final bool enabled;

  /// When `true` the text is visible but the field cannot be edited.
  final bool readOnly;

  /// Maximum number of lines the field may grow to. Defaults to `1`.
  /// Forced to `1` when [obscureText] is `true`.
  final int? maxLines;

  /// Called whenever the field's text changes.
  final void Function(String)? onChanged;

  /// Called when the user submits the field (e.g. taps Done / Enter).
  final void Function(String)? onSubmitted;

  /// Server-side field errors from `ValidationFailure.fieldErrors[fieldName]`.
  /// Multiple messages are joined with `\n` and shown as error text.
  final List<String>? fieldErrors;

  /// Controls focus for this field. Useful for moving focus between fields.
  final FocusNode? focusNode;

  /// Whether the field should request focus as soon as it is mounted.
  final bool autofocus;

  @override
  State<CheflyTextField> createState() => _CheflyTextFieldState();
}

class _CheflyTextFieldState extends State<CheflyTextField> {
  // Starts obscured; toggled by the show/hide icon.
  bool _obscured = true;

  String? _errorText() {
    final List<String>? errors = widget.fieldErrors;
    if (errors == null || errors.isEmpty) return null;
    return errors.join('\n');
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      obscureText: widget.obscureText && _obscured,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      maxLines: widget.obscureText ? 1 : widget.maxLines,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.obscureText
            ? _ObscureToggle(
                obscured: _obscured,
                onToggle: () => setState(() => _obscured = !_obscured),
              )
            : widget.suffixIcon,
        errorText: _errorText(),
        errorMaxLines: 3,
      ),
    );
  }
}

/// Show/hide password toggle icon appended to an obscured field.
class _ObscureToggle extends StatelessWidget {
  const _ObscureToggle({
    required this.obscured,
    required this.onToggle,
  });

  final bool obscured;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onToggle,
      icon: Icon(
        obscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
      ),
    );
  }
}
