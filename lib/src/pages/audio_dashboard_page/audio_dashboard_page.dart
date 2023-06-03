import 'package:flutter/material.dart';
import 'package:play_music/main.dart';
import 'package:play_music/src/pages/audio_dashboard_page/widgets/bottom_bar_media.dart';
import 'package:play_music/src/pages/audio_dashboard_page/widgets/playlist.dart';
import 'package:play_music/src/theme/theme_app.dart';
import 'package:provider/provider.dart';

// ignore: depend_on_referenced_package
class AudioDashboardPage extends StatefulWidget {
  const AudioDashboardPage({super.key});

  @override
  State<AudioDashboardPage> createState() => _AudioDashboardPageState();
}

class _AudioDashboardPageState extends State<AudioDashboardPage> {
  late final ThemeApp themeApp;
  @override
  void initState() {
    themeApp = context.read<ThemeApp>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerHeader(
              child: ValueListenableBuilder(
                valueListenable: themeApp.isDark,
                builder: (context, value, child) {
                  return SizedBox(
                    child: Row(
                      children: [
                        Switch(
                            value: value,
                            onChanged: (value) {
                              themeApp.changeTheme(value);
                            }),
                        Text("alterar o tema ${value ? 'claro' : 'escuro'}")
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        backgroundColor: Theme.of(context).colorScheme.background,
        // backgroundColor: Colors.purple,
        title: const Text(
          "My Music",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Playlist(),
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          audioHandler.mediaItem.value != null ? const BottomBarMedia() : null,
    );
  }
}
