import 'package:flutter/material.dart';

class GradientCircleBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double borderWidth = 5.0;

    // Create a rect that bounds the circle
    final rect = Offset.zero & size;
    final center = size.center(Offset.zero);
    final radius = (size.shortestSide - borderWidth) / 2;

    // Create gradient shader
    final gradient = SweepGradient(
      colors: [Colors.blue, Colors.purple, Colors.blue],
      startAngle: 0.0,
      endAngle: 3.14 * 2,
    ).createShader(rect);

    final paint = Paint()
      ..shader = gradient
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
