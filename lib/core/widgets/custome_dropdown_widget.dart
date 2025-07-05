import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatefulWidget {
  final String label;
  final List<T> items;
  final T? initialValue;
  final String placeholder;
  final void Function(T?)? onChanged;
  final String Function(T)? itemToString;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.placeholder,
    this.initialValue,
    this.onChanged,
    this.itemToString,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8),
        DropdownButtonFormField<T>(
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
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
        ),
      ],
    );
  }
}
