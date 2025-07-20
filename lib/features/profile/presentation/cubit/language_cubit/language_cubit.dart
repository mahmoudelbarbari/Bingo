import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../core/localization/language_preference.dart';

class LanguageCubit extends Cubit<Locale> {
  final LanguagePreference _preference;

  LanguageCubit(this._preference) : super(const Locale('en')) {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final languageCode = await _preference.getLanguage();
    emit(Locale(languageCode));
  }

  Future<void> changeLanguage(String languageCode) async {
    await _preference.saveLanguage(languageCode);
    emit(Locale(languageCode));
  }

  void toggleLanguage() {
    final newLang = state.languageCode == 'en' ? 'ar' : 'en';
    changeLanguage(newLang);
  }
}
