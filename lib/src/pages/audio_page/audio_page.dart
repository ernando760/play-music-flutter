import 'package:flutter/material.dart';
import 'package:play_music/src/pages/audio_dashboard_page/audio_dashboard_page.dart';
import 'package:play_music/src/pages/components/playground_media.dart';

class AudioPage extends StatefulWidget {
  const AudioPage({super.key});

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AudioDashboardPage()));
              },
              icon: const Icon(Icons.arrow_back)),
          const Center(child: PlaygroundMediaItem()),
        ],
      )),
    );
  }
}
