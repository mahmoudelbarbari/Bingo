import 'package:flutter/material.dart';

class CustomeOutlinedBtnWidget extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;
  const CustomeOutlinedBtnWidget({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final onPrimary = Theme.of(context).colorScheme.onPrimary;
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: isSelected ? primaryColor : Colors.transparent,
        side: BorderSide(color: primaryColor),
        foregroundColor: isSelected ? onPrimary : primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      child: Text(text),
    );
  }
}
