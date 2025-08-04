// import 'package:flutter/services.dart';

// class Validators {
//   static String? requiredField(String? value, {String? message}) {
//     if (value == null || value.trim().isEmpty) {
//       return message ?? 'This field is required';
//     }
//     return null;
//   }

//   static String? email(String? value, {String? message}) {
//     if (value == null || value.trim().isEmpty) {
//       return message ?? 'Email is required';
//     }
//     final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
//     if (!emailRegex.hasMatch(value.trim())) {
//       return message ?? 'Enter a valid email';
//     }
//     return null;
//   }

//   static String? password(String? value, {String? message}) {
//     if (value == null || value.trim().isEmpty) {
//       return message ?? 'Email is required';
//     }
//     final passwordRegex = RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9.]+');
//     if (!passwordRegex.hasMatch(value.trim())) {
//       return message ??
//           'Please enter a valid password....\nYour password must be at least 8 characters long,\nattached with lowercase and uppercase letters';
//     }
//     return null;
//   }

//   static String? minLength(String? value, int min, {String? message}) {
//     if (value == null || value.length < min) {
//       return message ?? 'Minimum $min characters required';
//     }
//     return null;
//   }

//   static String? maxLength(String? value, int max, {String? message}) {
//     if (value != null && value.length > max) {
//       return message ?? 'Maximum $max characters allowed';
//     }
//     return null;
//   }

//   static String? match(String? value, String? otherValue, {String? message}) {
//     if (value != otherValue) {
//       return message ?? 'Values do not match';
//     }
//     return null;
//   }

// }

//TODO: do this in the end of the project

import 'package:flutter/material.dart';
import 'package:bingo/l10n/app_localizations.dart';
import 'package:flutter/services.dart';

class Validators {
  static String? requiredField(
    BuildContext context,
    String? value, {
    String? message,
  }) {
    final loc = AppLocalizations.of(context)!;
    if (value == null || value.trim().isEmpty) {
      return message ?? loc.fieldRequired;
    }
    return null;
  }

  static String? email(BuildContext context, String? value, {String? message}) {
    final loc = AppLocalizations.of(context)!;
    if (value == null || value.trim().isEmpty) {
      return message ?? loc.emailRequired;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return message ?? loc.enterValidEmail;
    }
    return null;
  }

  static String? password(
    BuildContext context,
    String? value, {
    String? message,
  }) {
    final loc = AppLocalizations.of(context)!;
    if (value == null || value.trim().isEmpty) {
      return message ?? loc.passwordRequired;
    }
    final passwordRegex = RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9.]+');
    if (!passwordRegex.hasMatch(value.trim())) {
      return message ?? loc.passwordValidation;
    }
    return null;
  }

  static String? minLength(
    BuildContext context,
    String? value,
    int min, {
    String? message,
  }) {
    final loc = AppLocalizations.of(context)!;
    if (value == null || value.length < min) {
      return message ?? loc.minLengthRequired(min);
    }
    return null;
  }

  static String? maxLength(
    BuildContext context,
    String? value,
    int max, {
    String? message,
  }) {
    final loc = AppLocalizations.of(context)!;
    if (value != null && value.length > max) {
      return message ?? loc.maxLengthRequired(max);
    }
    return null;
  }

  static String? match(
    BuildContext context,
    String? value,
    String? otherValue, {
    String? message,
  }) {
    final loc = AppLocalizations.of(context)!;
    if (value != otherValue) {
      return message ?? loc.valueDoesNotMatch;
    }
    return null;
  }

  static String? phoneNumber(
    BuildContext context,
    String? value, {
    String? message,
  }) {
    final loc = AppLocalizations.of(context)!;
    if (value == null || value.trim().isEmpty) {
      return message ?? loc.phoneNumbIsRequired;
    }
    final passwordRegex = RegExp(r'^(\+201|01|00201)[0-2,5]{1}[0-9]{8}');
    if (!passwordRegex.hasMatch(value.trim())) {
      return message ?? loc.enterValidPhoneNumber;
    }
    return null;
  }

  static String? cardExpiryDate(String? value, {String? message}) {
    if (value == null || value.trim().isEmpty) {
      return message ?? 'Expiry date is required';
    }

    // Check format (MM/YY)
    if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(value.trim())) {
      return message ?? 'Enter date in MM/YY format';
    }

    try {
      final parts = value.split('/');
      final month = int.parse(parts[0]);
      final year = int.parse(parts[1]);

      // Get current date
      final now = DateTime.now();
      final currentYear = now.year % 100; // Get last 2 digits of year
      final currentMonth = now.month;

      // Validate month
      if (month < 1 || month > 12) {
        return message ?? 'Invalid month';
      }

      // Validate year and expiration
      if (year < currentYear || (year == currentYear && month < currentMonth)) {
        return message ?? 'Card has expired';
      }

      return null;
    } catch (e) {
      return message ?? 'Invalid date format';
    }
  }
}

class CardExpiryInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != text.length) {
        buffer.write('/');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}
