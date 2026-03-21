import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme_type.dart';

class ThemeController extends ChangeNotifier {
  static const _themeKey = 'selected_theme';

  AppTheme _theme = AppTheme.light;
  AppTheme get theme => _theme;

  ThemeMode get themeMode {
    switch (_theme) {
      case AppTheme.dark:
        return ThemeMode.dark;
      case AppTheme.light:
        return ThemeMode.light;
    }
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedValue = prefs.getString(_themeKey);

    if (savedValue == 'dark') {
      _theme = AppTheme.dark;
    } else {
      _theme = AppTheme.light;
    }
  }

  Future<void> setTheme(AppTheme newTheme) async {
    if (_theme == newTheme) return;

    _theme = newTheme;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _themeKey,
      newTheme == AppTheme.dark ? 'dark' : 'light',
    );
  }
}
