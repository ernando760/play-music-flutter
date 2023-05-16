import 'package:flutter/material.dart';
import 'package:play_music/src/pages/audio_dashboard_page/audio_dashboard_page.dart';
import 'package:play_music/src/theme/theme_app.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: context.read<ThemeApp>(),
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData.dark(),
          home: const AudioDashboardPage(),
        );
      },
    );
  }
}
