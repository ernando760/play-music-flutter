// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:play_music/main.dart';

class ButtonPlaying extends StatefulWidget {
  const ButtonPlaying({super.key});

  @override
  State<ButtonPlaying> createState() => _ButtonPlayingState();
}

class _ButtonPlayingState extends State<ButtonPlaying> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: audioHandler.playbackState
          .asBroadcastStream()
          .map((event) => event.playing)
          .distinct(),
      builder: (context, snapshot) {
        var playing = snapshot.data;

        if (playing != null) {
          print("playing: $playing");
          if (playing) {
            return IconButton(
                onPressed: () async {
                  await audioHandler.pause();
                },
                icon: const Icon(Icons.pause));
          }
          return IconButton(
              onPressed: () async {
                await audioHandler.play();
              },
              icon: const Icon(Icons.play_arrow));
        }
        if (snapshot.hasError) {
          return Center(
            child: Text("Error ${snapshot.error}"),
          );
        }
        return Container();
      },
    );
  }
}
