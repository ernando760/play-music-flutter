import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:play_music/src/theme/color_schemes.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeApp extends ChangeNotifier {
  late final ValueNotifier<ThemeData?> themeType =
      ValueNotifier<ThemeData?>(null);
  late final ValueNotifier<bool> isDark =
      ValueNotifier<bool>(themeType.value?.brightness == Brightness.dark);
  ValueNotifier<ThemeMode> themeMode = ValueNotifier(ThemeMode.system);

  final themeDark = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: darkColorScheme);
  final themelight =
      ThemeData(useMaterial3: true, colorScheme: lightColorScheme);

  Future<void> changeTheme(bool newValue) async {
    isDark.value = newValue;
    themeType.value = isDark.value ? themeDark : themelight;
    saveThemePreferences();
    log('isDark: ${isDark.value} \n brightness: ${themeType.value?.brightness}');
  }

  void saveThemePreferences() {
    SharedPreferences.getInstance().then((instance) {
      instance.setBool('isDark', isDark.value);
    });
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 1));
    if (prefs.containsKey('isDark') && prefs.getBool('isDark') != null) {
      themeType.value = themeDark;
    } else {
      themeType.value = themelight;
    }
  }
}
