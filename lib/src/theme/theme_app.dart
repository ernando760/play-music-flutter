import 'package:flutter/material.dart';

class ThemeApp extends ChangeNotifier {
  bool isDark = false;

  ThemeData theme = ThemeData.light();

  void changeDark() {
    isDark ? theme = ThemeData.dark() : theme = ThemeData.light();
    notifyListeners();
  }
}
