import 'package:flutter/material.dart';

const primaryColor = Color.fromRGBO(175, 18, 57, 255);
const Color headline1Color = Color.fromRGBO(164, 164, 164, 255);
const secondaryColor = Color.fromARGB(255, 8, 0, 0);
const Color onBoardingIndcatorColor = Color.fromRGBO(229, 229, 229, 1);
const Color authTextFromFieldHintTextColor = Color.fromRGBO(194, 189, 189, 1);
const Color authTextFromFieldPorderColor = Color.fromRGBO(214, 218, 225, 1);
const Color authTextFromFieldFillColor = Color.fromRGBO(241, 244, 254, 1);
const Color authTextFromFieldErrorBorderColor = Color.fromRGBO(
  253,
  245,
  245,
  255,
);
final appTheme = ThemeData(
  fontFamily: 'SFProText',
  appBarTheme: const AppBarTheme(
    backgroundColor: primaryColor,
    iconTheme: IconThemeData(color: secondaryColor),
    centerTitle: true,
  ),
  brightness: Brightness.light,
  primaryColor: primaryColor,
  colorScheme: const ColorScheme.light(primary: primaryColor),
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: primaryColor),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: primaryColor,
    foregroundColor: secondaryColor,
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: const BorderSide(color: primaryColor),
      foregroundColor: primaryColor,
    ),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: primaryColor),
    bodyMedium: TextStyle(color: secondaryColor),
    bodySmall: TextStyle(color: Colors.white),
    titleLarge: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 22,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: authTextFromFieldFillColor.withOpacity(.3),
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: authTextFromFieldPorderColor.withOpacity(.5),
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: authTextFromFieldPorderColor.withOpacity(.5),
      ),
      borderRadius: BorderRadius.circular(10),
    ),

    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: authTextFromFieldErrorBorderColor),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(10),
    ),
    floatingLabelStyle: const TextStyle(color: primaryColor),
    iconColor: secondaryColor,
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: primaryColor),
      borderRadius: BorderRadius.circular(12),
    ),
  ),
);
