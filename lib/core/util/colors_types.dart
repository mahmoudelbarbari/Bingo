import 'package:flutter/material.dart';

Color getColorFromName(String name) {
  switch (name.toLowerCase()) {
    case 'red':
      return Colors.red;
    case 'green':
      return Colors.green;
    case 'blue':
      return Colors.blue;
    case 'yellow':
      return Colors.yellow;
    case 'orange':
      return Colors.orange;
    case 'purple':
      return Colors.purple;
    case 'pink':
      return Colors.pink;
    case 'brown':
      return Colors.brown;
    case 'grey':
    case 'gray':
      return Colors.grey;
    case 'black':
      return Colors.black;
    case 'white':
      return Colors.white;
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
