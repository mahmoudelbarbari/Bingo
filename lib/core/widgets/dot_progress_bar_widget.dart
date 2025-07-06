import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DotProgressBar extends StatelessWidget {
  final int totalDots;
  final int currentDot;
  final double dotSize;
  final double spacing;
  Color? activeColor;
  final Color inactiveColor;

  DotProgressBar({
    super.key,
    required this.totalDots,
    required this.currentDot,
    this.dotSize = 12.0,
    this.spacing = 3.0,
    this.activeColor,
    this.inactiveColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalDots, (index) {
        bool isActive = index <= currentDot;
        return Container(
          margin: EdgeInsets.symmetric(horizontal: spacing / 2),
          width: dotSize,
          height: 2,
          decoration: BoxDecoration(
            color: isActive
                ? activeColor = Theme.of(context).colorScheme.primary
                : inactiveColor,
            shape: BoxShape.rectangle,
          ),
        );
      }),
    );
  }
}
