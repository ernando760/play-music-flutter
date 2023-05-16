import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:play_music/main.dart';
import 'package:play_music/src/pages/audio_dashboard_page/controllers/repeat_mode_controller.dart';
import 'package:provider/provider.dart';

import 'audio_item.dart';
import 'button_repeat_mode.dart';
import 'button_shuffle_mode.dart';
import 'playing.dart';
import 'seek_bar.dart';
import 'skip_to_next.dart';
import 'skip_to_previous.dart';

class PlaygroundMediaItem extends StatefulWidget {
  const PlaygroundMediaItem({
    super.key,
  });

  @override
  State<PlaygroundMediaItem> createState() => _PlaygroundMediaItemState();
}

class _PlaygroundMediaItemState extends State<PlaygroundMediaItem> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: audioHandler.mediaItem.map((event) => event).distinct(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
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
                      ButtonRepeatMode(),
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
