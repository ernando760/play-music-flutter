import 'package:flutter/material.dart';
import 'package:play_music/src/components/playground_media.dart';
import 'package:play_music/src/utils/playlist.dart';

// ignore: depend_on_referenced_package
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home page"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              PlaygroundMediaItem(),
              Playlist(),
            ],
          ),
        ),
      ),
    );
  }
}
