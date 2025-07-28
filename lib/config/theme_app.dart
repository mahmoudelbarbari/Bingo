import 'package:flutter/material.dart';
import 'custome_snackbar_color.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  snackBarTheme: SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    elevation: 6,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  ),
  extensions: const <ThemeExtension<dynamic>>[
    SnackBarColors(success: Color(0xFF4CAF50), error: Color(0xFFF44336)),
  ],
  colorScheme: const ColorScheme.light(
    primary: Color(0xFFAF1239),
    primaryContainer: Color(0xFFD44A64),
    secondary: Color(0xFF7A0C2B),
    secondaryContainer: Color(0xFFEBD3D9),
    surface: Colors.white,
    background: Color(0xFFCCCCCC),
    error: Color(0xFFB00020),
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Color(0xFF999999),
    onBackground: Colors.black,
    onError: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black),
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    elevation: 0,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFFAF1239),
    foregroundColor: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFFAF1239),
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      textStyle: TextStyle(fontSize: 16),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Color(0xFFAF1239),
      side: BorderSide(color: Color(0xFFAF1239), width: 1.5),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      textStyle: TextStyle(fontSize: 16),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    errorMaxLines: 2,
    errorStyle: const TextStyle(color: Color(0xFFB00020)),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: BorderSide(color: Color(0xFFAF1239), width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: BorderSide(color: Color(0xFFB00020)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: BorderSide(color: Color(0xFFB00020), width: 2),
    ),
    floatingLabelStyle: TextStyle(color: Colors.black),
  ),
  textTheme: TextTheme(
    headlineMedium: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    headlineLarge: TextStyle(color: Color(0xFFAF1239)),
    bodyMedium: TextStyle(color: Colors.black87),
    bodyLarge: TextStyle(color: Color(0xFF808080)),
    bodySmall: TextStyle(color: Color(0xFF808080)),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  snackBarTheme: SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    elevation: 6,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  ),
  extensions: const <ThemeExtension<dynamic>>[
    SnackBarColors(success: Color(0xFF81C784), error: Color(0xFFE57373)),
  ],
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFFAF1239),
    primaryContainer: Color(0xFF8C0F2F),
    secondary: Color(0xFFCF6679),
    secondaryContainer: Color(0xFF3C2B2E),
    surface: Color(0xFF121212),
    background: Color(0xFF1E1E1E),
    error: Color(0xFFCF6679),
    onPrimary: Colors.black,
    onSecondary: Colors.white,
    onSurface: Color(0xFF999999),
    onBackground: Colors.white,
    onError: Colors.black,
  ),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    backgroundColor: Color(0xFF1E1E1E),
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFFAF1239),
    foregroundColor: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFFAF1239),
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      textStyle: TextStyle(fontSize: 16),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Color(0xFFAF1239),
      side: BorderSide(color: Color(0xFFAF1239), width: 1.5),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      textStyle: TextStyle(fontSize: 16),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0x002e2e2e),
    errorMaxLines: 2,
    errorStyle: TextStyle(color: Color(0xFFCF6679)),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: BorderSide(color: Color(0xFFAF1239), width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: BorderSide(color: Color(0xFFCF6679)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: BorderSide(color: Color(0xFFCF6679), width: 2),
    ),
    floatingLabelStyle: TextStyle(color: Colors.white),
  ),
  textTheme: TextTheme(
    headlineMedium: TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    headlineLarge: TextStyle(color: Color(0xFFAF1239)),
    bodyMedium: TextStyle(fontSize: 12, color: Colors.white70),
    bodyLarge: TextStyle(color: Color(0xFFCCCCCC)),
    bodySmall: TextStyle(color: Color(0xFF999999)),
  ),
);
