import 'package:flutter/material.dart';
import 'package:bingo/core/util/size_config.dart';

class UserTypeSelector extends StatefulWidget {
  final List<UserTypeOption> options;
  final ValueChanged<String> onSelected;

  const UserTypeSelector({
    super.key,
    required this.options,
    required this.onSelected,
  });

  @override
  State<UserTypeSelector> createState() => _UserTypeSelectorState();
}

class _UserTypeSelectorState extends State<UserTypeSelector> {
  String? selectedType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.options.map((option) {
        final isSelected = option.value == selectedType;

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedType = option.value;
            });
            widget.onSelected(option.value);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey.withOpacity(.3),
                width: 2,
              ),
            ),
            margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 20.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  option.displayText,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Image.asset(option.imgPath),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class UserTypeOption {
  final String text;
  final String displayText;
  final String value;
  final String imgPath;

  UserTypeOption({
    required this.text,
    required this.displayText,
    required this.value,
    required this.imgPath,
  });
}
