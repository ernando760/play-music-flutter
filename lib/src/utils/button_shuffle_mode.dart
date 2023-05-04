import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:play_music/main.dart';

class ButtonShuffleMode extends StatefulWidget {
  const ButtonShuffleMode({super.key});

  @override
  State<ButtonShuffleMode> createState() => _ButtonShuffleModeState();
}

class _ButtonShuffleModeState extends State<ButtonShuffleMode> {
  final shufflers = AudioServiceShuffleMode.values;

  IconButton _shuffleButton(AudioServiceShuffleMode audioServiceShuffleMode) {
    return IconButton(
        onPressed: () async => audioHandler.setShuffleMode(
            audioServiceShuffleMode == AudioServiceShuffleMode.all ||
                    audioServiceShuffleMode == AudioServiceShuffleMode.group
                ? AudioServiceShuffleMode.none
                : AudioServiceShuffleMode.all),
        icon: audioServiceShuffleMode == AudioServiceShuffleMode.all ||
                audioServiceShuffleMode == AudioServiceShuffleMode.group
            ? const Icon(Icons.shuffle_on)
            : const Icon(Icons.shuffle));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: AudioServiceShuffleMode.none,
        stream: audioHandler.playbackState
            .map((audio) => audio.shuffleMode)
            .distinct(),
        builder: (context, snapshot) {
          final shufflerMode = snapshot.data;

          if (shufflerMode != null) {
            return _shuffleButton(shufflerMode);
          }
          if (snapshot.hasError) {
            return Text("Error ${snapshot.error}");
          }
          return Container();
        });
  }
}
