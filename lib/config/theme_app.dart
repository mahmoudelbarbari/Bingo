import 'package:flutter/material.dart';

final ThemeData appThemne = ThemeData(
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
    backgroundColor: Color(0xFFAF1239),
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFFAF1239),
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
    fillColor: Colors.white,
    errorMaxLines: 2,
    errorStyle: const TextStyle(color: Color(0xFFB00020)),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Color(0xFFB00020)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Color(0xFFB00020), width: 2),
    ),
    // Custom error background
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(color: Color(0xFFAF1239)),
    bodyMedium: TextStyle(color: Colors.black87),
  ),
);
