import 'package:flutter/material.dart';
import 'package:play_music/src/pages/audio_dashboard_page/audio_dashboard_page.dart';
import 'package:play_music/src/theme/theme_app.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final ThemeApp themeApp;
  @override
  void initState() {
    super.initState();
    themeApp = context.read<ThemeApp>();
    themeApp.loadTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: themeApp.themeType,
      builder: (context, theme, child) {
        if (theme != null) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme,
            home: const AudioDashboardPage(),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
