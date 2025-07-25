import 'package:bingo/config/theme_app.dart';
import 'package:bingo/core/util/size_config.dart';
import 'package:flutter/material.dart';

class CartProgressWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  const CartProgressWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: BoxBorder.all(color: Color(0xFFCCCCCC)),
          ),
          child: Icon(
            icon,
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Color(0xFFCCCCCC),
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          title,
          style: isSelected
              ? TextStyle(fontSize: 12, color: lightTheme.colorScheme.primary)
              : Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
