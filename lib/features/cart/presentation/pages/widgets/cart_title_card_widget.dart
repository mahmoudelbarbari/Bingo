import 'package:flutter/material.dart';

class CartTitleCardWidget extends StatelessWidget {
  final String title;
  final TextStyle textStyle;

  const CartTitleCardWidget({
    super.key,
    required this.title,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      child: Text(title, style: textStyle),
    );
  }
}
