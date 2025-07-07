import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocalizationController with ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void setLocale(Locale loc) {
    _locale = loc;
    notifyListeners();
  }
}

void toggleLocalization(BuildContext context) {
  final locController = Provider.of<LocalizationController>(
    context,
    listen: false,
  );
  final currentLocale = locController.locale;
  final newLocale = currentLocale.languageCode == 'ar'
      ? const Locale('en')
      : const Locale('ar');
  locController.setLocale(newLocale);
}
