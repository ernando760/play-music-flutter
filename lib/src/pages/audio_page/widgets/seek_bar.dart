// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audio_service/audio_service.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:play_music/main.dart';
import 'package:rxdart/rxdart.dart';

import '../../../models/media_state.dart';

class SeekBar extends StatefulWidget {
  const SeekBar({
    Key? key,
  }) : super(key: key);

  @override
  State<SeekBar> createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _mediaStateStream.asBroadcastStream().distinct(),
      builder: (context, snapshot) {
        var mediaState = snapshot.data;
        if (mediaState != null) {
          return ProgressBar(
            progress: mediaState.position,
            total: mediaState.mediaItem?.duration ?? Duration.zero,
            onSeek: (value) async => await audioHandler.seek(value),
          );
        }
        return ProgressBar(
          progress: audioHandler.playbackState.value.position,
          total: audioHandler.mediaItem.value?.duration ?? Duration.zero,
          onSeek: (value) async => await audioHandler.seek(value),
        );
      },
    );
  }
}

Stream<MediaState> get _mediaStateStream =>
    Rx.combineLatest2<MediaItem?, Duration, MediaState>(
        audioHandler.mediaItem,
        AudioService.position,
        (mediaItem, position) => MediaState(mediaItem, position));
