// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:play_music/src/modules/shared/theme/color_schemes.g.dart';

class ThemeApp extends ChangeNotifier {
  ThemeApp() {
    _loadTheme();
  }

  final String themeKey = "theme_key";
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  bool get isDark => _themeMode == ThemeMode.dark;

  final themeDark = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: darkColorScheme);

  final themeLight =
      ThemeData(useMaterial3: true, colorScheme: lightColorScheme);

  Future<void> changeTheme(bool isDark) async {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(themeKey, _themeMode.index);
    notifyListeners();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(themeKey) ?? 0;
    _themeMode = ThemeMode.values[themeIndex];
    notifyListeners();
  }
}
