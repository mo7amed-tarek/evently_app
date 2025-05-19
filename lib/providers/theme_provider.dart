import 'package:evently_app/core/prefs_manager.dart';
import 'package:flutter/material.dart';

class themeprovider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  init() {
    bool result = PrefsManager.getThemeMode();
    if (result) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
  }

  changetheme(ThemeMode newtheme) {
    themeMode = newtheme;
    notifyListeners();
  }
}
