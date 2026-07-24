import 'package:chefly_core/src/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

/// A phone number input field with an integrated country picker.
///
/// The leading slot shows a flag emoji, international dial code, and a
/// dropdown chevron. Tapping it opens a searchable bottom sheet so the user
/// can pick their country. The field uses [PhoneInputFormatter] from
/// `flutter_multi_formatter` for live formatting and auto-detection.
///
/// [onSaved] is called with digits-only (stripped of spaces, dashes, and the
/// `+` prefix). Pass [required] to choose between the strict vs. optional
/// built-in validator, or supply your own via [validator].
class CheflyPhoneField extends StatefulWidget {
  const CheflyPhoneField({
    super.key,
    this.controller,
    this.label = 'Phone number',
    this.hint,
    this.validator,
    this.required = false,
    this.onSaved,
    this.textInputAction = TextInputAction.done,
    this.focusNode,
    this.enabled = true,
    this.fieldErrors,
  });

  /// Controls the text being edited.
  final TextEditingController? controller;

  /// Floating label.
  final String label;

  /// Placeholder text shown while the field is empty.
  final String? hint;

  /// Custom validator; overrides the default required / optional check.
  final String? Function(String?)? validator;

  /// When `true` the field must be non-empty and valid. Ignored when a custom
  /// [validator] is provided.
  final bool required;

  /// Called when the form is saved. Receives the digits-only phone string.
  final void Function(String?)? onSaved;

  /// Keyboard action button behaviour. Defaults to [TextInputAction.done].
  final TextInputAction textInputAction;

  /// Controls focus for the underlying text field.
  final FocusNode? focusNode;

  /// Whether the field accepts user input.
  final bool enabled;

  /// Server-side field errors displayed verbatim below the field.
  final List<String>? fieldErrors;

  @override
  State<CheflyPhoneField> createState() => _CheflyPhoneFieldState();
}

class _CheflyPhoneFieldState extends State<CheflyPhoneField> {
  late PhoneCountryData _selectedCountry;
  late final PhoneInputFormatter _formatter;

  @override
  void initState() {
    super.initState();
    _selectedCountry = PhoneCodes.getPhoneCountryDataByCountryCode('KE') ??
        PhoneCodes.getAllCountryDatas().first;

    _formatter = PhoneInputFormatter(
      onCountrySelected: (PhoneCountryData? detected) {
        if (detected != null &&
            detected.countryCode != _selectedCountry.countryCode) {
          setState(() => _selectedCountry = detected);
        }
      },
      defaultCountryCode: 'KE',
    );
  }

  // ── Country prefix widget ──────────────────────────────────────────────

  String _flag(String? isoCode) {
    if (isoCode == null || isoCode.length != 2) return '🌍';
    return isoCode.toUpperCase().runes
        .map((int r) => String.fromCharCode(r - 0x41 + 0x1F1E6))
        .join();
  }

  Widget _buildPrefix(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _showCountryPicker(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _flag(_selectedCountry.countryCode),
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(width: 4),
            Text(
              '+${_selectedCountry.phoneCode ?? ''}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(width: 2),
            const Icon(Icons.arrow_drop_down, size: 18),
          ],
        ),
      ),
    );
  }

  // ── Country picker bottom sheet ────────────────────────────────────────

  void _showCountryPicker(BuildContext outerContext) {
    showModalBottomSheet<void>(
      context: outerContext,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _CountryPickerSheet(
        selected: _selectedCountry,
        onSelected: (PhoneCountryData country) {
          setState(() => _selectedCountry = country);
          // Seed the field with the new dial code so formatting starts
          // from the correct country on the next keystroke.
          final dialCode = '+${country.phoneCode ?? ''}';
          widget.controller?.value = TextEditingValue(
            text: dialCode,
            selection: TextSelection.collapsed(offset: dialCode.length),
          );
        },
      ),
    );
  }

  // ── Validation ─────────────────────────────────────────────────────────

  String? _validate(String? value) {
    if (widget.validator != null) return widget.validator!(value);
    final bool empty = value == null || value.trim().isEmpty;
    if (empty) {
      return widget.required ? 'Phone number is required' : null;
    }
    // Pass the currently-selected country code so that local formats
    // (e.g. "0712 345 678" for Kenya) are validated against the right mask
    // rather than requiring a full international prefix like "+254 …".
    if (!isPhoneValid(
      value,
      defaultCountryCode: _selectedCountry.countryCode,
    )) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  String? _errorText() {
    final List<String>? errors = widget.fieldErrors;
    if (errors == null || errors.isEmpty) return null;
    return errors.join('\n');
  }

  // ── Build ──────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      enabled: widget.enabled,
      keyboardType: TextInputType.phone,
      textInputAction: widget.textInputAction,
      inputFormatters: [_formatter],
      validator: _validate,
      onSaved: (String? v) =>
          widget.onSaved?.call(v == null ? null : toNumericString(v)),
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        prefixIcon: _buildPrefix(context),
        errorText: _errorText(),
        errorMaxLines: 3,
      ),
    );
  }
}

// ── Country picker sheet ───────────────────────────────────────────────────

class _CountryPickerSheet extends StatefulWidget {
  const _CountryPickerSheet({
    required this.selected,
    required this.onSelected,
  });

  final PhoneCountryData selected;
  final void Function(PhoneCountryData) onSelected;

  @override
  State<_CountryPickerSheet> createState() => _CountryPickerSheetState();
}

class _CountryPickerSheetState extends State<_CountryPickerSheet> {
  late final List<PhoneCountryData> _all;
  late List<PhoneCountryData> _filtered;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Kenya first, then alphabetical by country name.
    final kenya = PhoneCodes.getAllCountryDatas()
        .where((PhoneCountryData c) => c.countryCode == 'KE')
        .toList();
    final rest = PhoneCodes.getAllCountryDatas()
        .where((PhoneCountryData c) => c.countryCode != 'KE')
        .toList()
      ..sort(
        (PhoneCountryData a, PhoneCountryData b) =>
            (a.country ?? '').compareTo(b.country ?? ''),
      );

    _all = [...kenya, ...rest];
    _filtered = List.of(_all);

    _searchController.addListener(_onSearch);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearch);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch() {
    final String query = _searchController.text.toLowerCase();
    setState(() {
      _filtered = query.isEmpty
          ? List.of(_all)
          : _all.where((PhoneCountryData c) {
              return (c.country ?? '').toLowerCase().contains(query) ||
                  (c.phoneCode ?? '').contains(query);
            }).toList();
    });
  }

  String _flag(String? isoCode) {
    if (isoCode == null || isoCode.length != 2) return '🌍';
    return isoCode.toUpperCase().runes
        .map((int r) => String.fromCharCode(r - 0x41 + 0x1F1E6))
        .join();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      minChildSize: 0.4,
      maxChildSize: 0.92,
      builder: (BuildContext sheetContext, ScrollController scrollController) =>
          Column(
        children: [
          // Handle bar
          const SizedBox(height: 8),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.neutral300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 12),

          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Select Country',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const SizedBox(height: 12),

          // Search field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              autofocus: true,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              decoration: const InputDecoration(
                hintText: 'Search country…',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Country list
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: _filtered.length,
              itemBuilder: (BuildContext _, int index) {
                final PhoneCountryData country = _filtered[index];
                final bool isSelected =
                    country.countryCode == widget.selected.countryCode;

                return ListTile(
                  leading: Text(
                    _flag(country.countryCode),
                    style: const TextStyle(fontSize: 24),
                  ),
                  title: Text(country.country ?? ''),
                  trailing: Text(
                    '+${country.phoneCode ?? ''}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isSelected ? AppColors.primary : null,
                        ),
                  ),
                  selected: isSelected,
                  selectedTileColor: AppColors.primary.withValues(alpha: 0.08),
                  onTap: () {
                    widget.onSelected(country);
                    Navigator.of(sheetContext).pop();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
