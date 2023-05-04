import 'package:flutter/material.dart';
import 'package:play_music/main.dart';

import '../utils/audio_item.dart';
import '../utils/button_repeat_mode.dart';
import '../utils/button_shuffle_mode.dart';
import '../utils/playing.dart';
import '../utils/seek_bar.dart';
import '../utils/skip_to_next.dart';
import '../utils/skip_to_previous.dart';

class PlaygroundMediaItem extends StatelessWidget {
  const PlaygroundMediaItem({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: audioHandler.mediaItem.map((event) => event).distinct(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AudioItem(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      ButtonShuffleMode(),
                      SkipToPrevious(),
                      ButtonPlaying(),
                      SkipToNext(),
                      ButtonRepeatMode()
                    ],
                  ),
                  const SeekBar()
                ],
              ),
            );
          }
          return Container();
        });
  }
}
