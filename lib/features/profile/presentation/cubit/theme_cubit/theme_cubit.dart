import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/theme_preference.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final ThemePreference _preference;

  ThemeCubit(this._preference) : super(ThemeMode.system) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final savedTheme = await _preference.getThemeMode();
    emit(savedTheme);
  }

  Future<void> updateTheme(ThemeMode mode) async {
    await _preference.saveThemeMode(mode);
    emit(mode);
  }
}
