// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

import 'package:play_music/main.dart';

class ButtonPlaying extends StatefulWidget {
  const ButtonPlaying({
    Key? key,
    this.size = 55,
  }) : super(key: key);
  final double size;

  @override
  State<ButtonPlaying> createState() => _ButtonPlayingState();
}

class _ButtonPlayingState extends State<ButtonPlaying> {
  Future<void> _playOrPause(bool playing) async =>
      playing ? await audioHandler.pause() : await audioHandler.play();

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
          return IconButton(
              iconSize: widget.size,
              onPressed: () async => await _playOrPause(playing),
              icon: Icon(playing ? Icons.pause : Icons.play_arrow));
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text("Error no botão play"),
          );
        }
        return Container();
      },
    );
  }
}
