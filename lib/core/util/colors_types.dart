import 'package:flutter/material.dart';

Color getColorFromName(String name) {
  switch (name.toLowerCase()) {
    case '#FF0000':
      return Colors.red;
    case '#00FF00':
      return Colors.green;
    case '#0000FF':
      return Colors.blue;
    case '#FFFF00':
      return Colors.yellow;
    case '#220000':
      return const Color(0xFF220000);
    case '#000000':
      return const Color(0xFF000000);
    case '#FFA500':
      return const Color(0xFFFFA500);
    case '#800080':
      return const Color(0xFF800080);
    default:
      return Colors.transparent; // fallback color
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
