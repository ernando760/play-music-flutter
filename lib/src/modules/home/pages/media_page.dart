import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:play_music/src/modules/home/controllers/media_controller.dart';
import 'package:play_music/src/modules/home/widgets/media_widgets/media_model_detail_widget.dart';
import 'package:play_music/src/modules/home/widgets/playlist_widgets/draggable_scroll_playlist_widget.dart';
import 'package:play_music/src/modules/shared/widgets/play_music_stream_builder_widget.dart';

class MediaPage extends StatelessWidget {
  const MediaPage({super.key});
  @override
  Widget build(BuildContext context) {
    final mediaController = Modular.get<MediaController>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () =>
                Modular.to.pushReplacementNamed(Modular.initialRoute),
            style: IconButton.styleFrom(iconSize: 26),
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Stack(
        children: [
          PlayMusicStreamBuilderWidget(
            streamController: mediaController,
            onLoading: () => const Center(child: CircularProgressIndicator()),
            onSuccess: (media) => MediaModelDetailWidget(media: media),
            onError: () => const Center(child: Text("Error Media")),
          ),
          const DraggableScrollPlaylistWidget()
        ],
      ),
      // bottomSheet: const DraggableScrollPlaylistWidget(),
    );
  }
}
