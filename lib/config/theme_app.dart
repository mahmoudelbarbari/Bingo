import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  colorScheme: const ColorScheme(
    primary: Color(0xFFAF1239),
    primaryContainer: Color(0xFFD44A64),
    secondary: Color(0xFF7A0C2B),
    secondaryContainer: Color(0xFFEBD3D9),
    surface: Colors.white,
    background: Color(0xFFFFF5F7),
    error: Color(0xFFB00020),
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.black,
    onBackground: Colors.black,
    onError: Colors.white,
    brightness: Brightness.light,
  ),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black),
    // backgroundColor: Color(0xFFAF1239),
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  // Add any additional theme properties here if needed, e.g.:
  // progressIndicatorTheme: const ProgressIndicatorThemeData(color: Color(0xFFAF1239)),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color.fromRGBO(175, 18, 57, 1),
    foregroundColor: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFAF1239),
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      textStyle: const TextStyle(fontSize: 16),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: const Color(0xFFAF1239),
      side: const BorderSide(color: Color(0xFFAF1239), width: 1.5),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      textStyle: const TextStyle(fontSize: 16),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: MaterialStateColor.resolveWith((states) {
      if (states.contains(MaterialState.error)) {
        return Color(0xFFFDF5F5); // your error color
      }
      return Colors.grey.shade200;
    }),
    errorMaxLines: 2,
    errorStyle: const TextStyle(color: Color(0xFFB00020)),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: const BorderSide(color: Color(0xFFAF1239), width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: const BorderSide(color: Color(0xFFB00020)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: const BorderSide(color: Color(0xFFB00020), width: 2),
    ),
    floatingLabelStyle: TextStyle(color: Colors.black),
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(color: Color(0xFFAF1239)),
    bodyMedium: TextStyle(color: Colors.black87),
    bodyLarge: TextStyle(color: Color(0xFF808080)),
    bodySmall: TextStyle(color: Color(0xFF808080)),
  ),
);
