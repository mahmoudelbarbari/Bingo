// app_theme_extension.dart
import 'package:flutter/material.dart';

@immutable
class SnackBarColors extends ThemeExtension<SnackBarColors> {
  final Color success;
  final Color error;

  const SnackBarColors({required this.success, required this.error});

  @override
  SnackBarColors copyWith({Color? success, Color? error}) {
    return SnackBarColors(
      success: success ?? this.success,
      error: error ?? this.error,
    );
  }

  @override
  SnackBarColors lerp(ThemeExtension<SnackBarColors>? other, double t) {
    if (other is! SnackBarColors) return this;
    return SnackBarColors(
      success: Color.lerp(success, other.success, t)!,
      error: Color.lerp(error, other.error, t)!,
    );
  }
}
