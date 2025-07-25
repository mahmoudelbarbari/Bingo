import 'package:bingo/core/util/size_config.dart';
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
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Text(
          text,
          style: isSelected
              ? TextStyle(color: Colors.white, fontSize: 16)
              : Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
