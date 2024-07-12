import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:play_music/src/modules/shared/theme/theme_app.dart';

class ChangeThemeButtonWidget extends StatelessWidget {
  const ChangeThemeButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeApp = context.watch<ThemeApp>();
    return IconButton(
        onPressed: () {
          themeApp.changeTheme(!themeApp.isDark);
        },
        icon: themeApp.isDark
            ? const Icon(Icons.dark_mode)
            : const Icon(Icons.sunny));
  }
}
