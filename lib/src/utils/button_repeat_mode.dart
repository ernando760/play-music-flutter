// ignore_for_file: avoid_print

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:play_music/main.dart';

class ButtonRepeatMode extends StatefulWidget {
  const ButtonRepeatMode({super.key});

  @override
  State<ButtonRepeatMode> createState() => _ButtonRepeatModeState();
}

class _ButtonRepeatModeState extends State<ButtonRepeatMode> {
  IconButton _repeatButton(AudioServiceRepeatMode audioServiceRepeatMode) {
    return IconButton(
        onPressed: () async {
          if (audioServiceRepeatMode == AudioServiceRepeatMode.none) {
            await audioHandler.setRepeatMode(AudioServiceRepeatMode.one);
          } else if (audioServiceRepeatMode == AudioServiceRepeatMode.one) {
            await audioHandler.setRepeatMode(AudioServiceRepeatMode.all);
          } else {
            await audioHandler.setRepeatMode(AudioServiceRepeatMode.none);
          }
        },
        icon: audioServiceRepeatMode == AudioServiceRepeatMode.none
            ? const Icon(Icons.repeat)
            : audioServiceRepeatMode == AudioServiceRepeatMode.one
                ? const Icon(Icons.repeat_one)
                : const Icon(Icons.repeat_on));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: AudioServiceRepeatMode.none,
      stream: audioHandler.playbackState
          .map((audio) => audio.repeatMode)
          .distinct(),
      builder: (context, snapshot) {
        final repeatMode = snapshot.data;

        if (repeatMode != null) {
          return _repeatButton(repeatMode);
        }
        print(repeatMode);
        return Container();
      },
    );
  }
}
