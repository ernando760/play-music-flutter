import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:play_music/src/modules/shared/theme/theme_app.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final themeApp = context.watch<ThemeApp>();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: themeApp.themeLight,
      darkTheme: themeApp.themeDark,
      themeMode: themeApp.themeMode,
      routerConfig: Modular.routerConfig,
    );
  }
}
