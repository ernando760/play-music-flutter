import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:play_music/src/modules/home/controllers/media_controller.dart';

import 'package:play_music/src/modules/home/controllers/playlist_controller.dart';
import 'package:play_music/src/modules/home/models/playlist_model.dart';
import 'package:play_music/src/modules/home/widgets/playlist_widgets/playlist_state_builder_widget.dart';
import 'package:play_music/src/modules/shared/extensions/context_theme_extension.dart';
import 'package:play_music/src/modules/shared/models/media_model.dart';
import 'package:play_music/src/modules/shared/widgets/play_music_stream_builder_widget.dart';

import 'card_media_info_widget.dart';

class PlaylistWidget extends StatelessWidget {
  const PlaylistWidget(
      {super.key, this.scrollController, this.onMedia, this.separatorBuilder});
  final ScrollController? scrollController;

  final ValueChanged<MediaModel?>? onMedia;

  final Widget Function(BuildContext context, int index)? separatorBuilder;

  @override
  Widget build(BuildContext context) {
    final playlistController = Modular.get<PlaylistController>();
    final mediaController = Modular.get<MediaController>();
    return PlaylistStateBuilderWidget<PlaylistModel>(
      controller: playlistController,
      onSuccess: (playlist) {
        return PlayMusicStreamBuilderWidget(
            streamController: mediaController,
            onSuccess: (mediaPlaying) {
              return ListView.separated(
                controller: scrollController,
                itemCount: playlist.medias.length,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (context, index) {
                  var media = playlist.medias[index];
                  return CardMediaInfoWidget(
                    media: media,
                    isPlayingMedia: mediaPlaying.id == media.id,
                  );
                },
                separatorBuilder: separatorBuilder ??
                    (context, index) => SizedBox(height: context.height * .015),
              );
            });
      },
    );
  }
}
