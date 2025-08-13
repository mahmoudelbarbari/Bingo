import 'package:flutter/material.dart';

Color getColorFromName(String name) {
  final upperName = name.toUpperCase();
  switch (upperName) {
    case '#FF0000':
      return Color(0xFFFF0000);
    case '#00FF00':
      return Color(0xFF00FF00);
    case '#0000FF':
      return Color(0xFF0000FF);
    case '#FFFF00':
      return Color(0xFFFFFF00);
    case '#220000':
      return Color(0xFF220000);
    case '#000000':
      return Color(0xFF000000);
    case '#FFA500':
      return Color(0xFFFFA500);
    case '#800080':
      return Color(0xFF800080);
    default:
      return Colors.transparent;
  }
}

final Map<String, Color> colorOptions = {
  '#FF0000': const Color(0xFFFF0000), // Red
  '#00FF00': const Color(0xFF00FF00), // Green
  '#0000FF': const Color(0xFF0000FF), // Blue
  '#FFFF00': const Color(0xFFFFFF00), // Yellow
  '#220000': const Color(0xFF220000), // Dark Red
  '#000000': const Color(0xFF000000), // Black
  '#FFA500': const Color(0xFFFFA500), // Orange
  '#800080': const Color(0xFF800080), // Purple
};
