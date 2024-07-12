import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:play_music/src/modules/home/controllers/seek_controller.dart';
import 'package:play_music/src/modules/shared/models/media_model.dart';
import 'package:play_music/src/modules/shared/widgets/play_music_stream_builder_widget.dart';

class ProgressBarWidget extends StatelessWidget {
  const ProgressBarWidget({
    Key? key,
    this.media,
  }) : super(key: key);
  final MediaModel? media;

  @override
  Widget build(BuildContext context) {
    final seekController = context.watch<SeekController>();

    return PlayMusicStreamBuilderWidget(
      streamController: seekController,
      onLoading: () =>
          const ProgressBar(progress: Duration.zero, total: Duration.zero),
      onSuccess: (positionState) => ProgressBar(
        progress: positionState.position,
        total: positionState.mediaModel.duration ?? Duration.zero,
        onSeek: (newPosition) async => await seekController.seek(newPosition),
      ),
      onError: () => const Center(child: Text("Error Seek")),
    );
  }
}
