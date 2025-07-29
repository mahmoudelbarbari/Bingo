import 'package:flutter/material.dart';

class DottedLinePainter extends CustomPainter {
  final double dotSpacing;
  final double height;
  final Color color;

  DottedLinePainter({
    required this.dotSpacing,
    required this.height,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double startX = 0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = height;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + 2, 0), paint);
      startX += dotSpacing;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
