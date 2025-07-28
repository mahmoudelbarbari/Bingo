import 'package:bingo/core/util/size_config.dart';
import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatefulWidget {
  final String label;
  final List<T> items;
  final T? initialValue;
  final String placeholder;
  final void Function(T?)? onChanged;
  final String Function(T)? itemToString;
  final String? Function(T?)? dropDownValidator;
  final bool hasError;
  final bool isSuccess;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.placeholder,
    this.initialValue,
    this.onChanged,
    this.itemToString,
    this.dropDownValidator,
    this.hasError = false,
    this.isSuccess = false,
  });

  @override
  _CustomDropdownState<T> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  T? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: Theme.of(context).textTheme.headlineMedium),
        SizedBox(height: 12.h),
        DropdownButtonFormField<T>(
          elevation: 2,
          padding: EdgeInsets.symmetric(vertical: 2.5.h),
          validator: widget.dropDownValidator,
          value: _selectedValue,
          isExpanded: true,
          hint: Text(widget.placeholder),
          items: widget.items.map((item) {
            final displayText = widget.itemToString != null
                ? widget.itemToString!(item)
                : item.toString();
            return DropdownMenuItem<T>(value: item, child: Text(displayText));
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedValue = value;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
          decoration: InputDecoration(
            enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
            focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
            errorBorder: Theme.of(context).inputDecorationTheme.errorBorder,
            focusedErrorBorder: Theme.of(
              context,
            ).inputDecorationTheme.focusedErrorBorder,
            filled: true,
            fillColor: widget.hasError
                ? (isDark ? Color(0xFF3A1F1F) : Color(0xFFFDF5F5))
                : widget.isSuccess
                ? (isDark ? Color(0xFF1F3A2B) : Color(0xFFF3FDF7))
                : null,
            errorStyle: Theme.of(context).inputDecorationTheme.errorStyle,
            border: Theme.of(context).inputDecorationTheme.border,
          ),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
