import 'package:flutter/material.dart';

import '../../../../../core/painters/dotted_line_painter.dart';

class DottedLine extends StatelessWidget {
  final double height;
  final double dotSpacing;
  final Color color;

  const DottedLine({
    this.height = 1,
    this.dotSpacing = 4,
    this.color = Colors.grey,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DottedLinePainter(
        dotSpacing: dotSpacing,
        height: height,
        color: color,
      ),
      child: SizedBox(height: height, width: double.infinity),
    );
  }
}
