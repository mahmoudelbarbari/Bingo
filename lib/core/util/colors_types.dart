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
