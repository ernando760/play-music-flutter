import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:play_music/src/theme/color_schemes.g.dart';

class ThemeApp extends ChangeNotifier {
  ValueNotifier<bool> isDark = ValueNotifier<bool>(false);
  ValueNotifier<ThemeMode> themeMode = ValueNotifier(ThemeMode.system);
  late final ValueNotifier<ThemeData> theme =
      ValueNotifier<ThemeData>(themelight);

  final themeDark = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: darkColorScheme);
  final themelight =
      ThemeData(useMaterial3: true, colorScheme: lightColorScheme);

  void changeTheme(bool newValue) {
    isDark.value = newValue;
    theme.value = isDark.value ? themeDark : themelight;
    log('isDark: ${isDark.value} \n brightness: ${theme.value.brightness}');
  }
}
