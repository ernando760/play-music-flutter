import 'package:flutter/material.dart';
import 'package:play_music/src/pages/components/playlist.dart';
import 'package:play_music/src/theme/theme_app.dart';
import 'package:provider/provider.dart';

// ignore: depend_on_referenced_package
class AudioDashboardPage extends StatefulWidget {
  const AudioDashboardPage({super.key});

  @override
  State<AudioDashboardPage> createState() => _AudioDashboardPageState();
}

class _AudioDashboardPageState extends State<AudioDashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: Column(
          children: [
            ListTile(
              title: const Text('change theme'),
              onTap: context.read<ThemeApp>().changeDark,
            )
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        shadowColor: Colors.white,
        title: const Text(
          "Playlist",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Playlist(),
            ],
          ),
        ),
      ),
    );
  }
}
