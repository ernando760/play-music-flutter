import 'package:flutter/material.dart';
import 'package:play_music/main.dart';
import 'package:play_music/src/extensions/context_theme_extension.dart';
import 'card_audio_info.dart';

class Playlist extends StatefulWidget {
  const Playlist({super.key, this.scrollController});
  final ScrollController? scrollController;

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  @override
  Widget build(BuildContext context) {
    final height = context.height;
    final width = context.width;
    return StreamBuilder(
        stream: audioHandler.queue.map((event) => event).distinct(),
        builder: (context, snapshot) {
          var playlist = snapshot.data;
          if (playlist != null) {
            return Container(
              width: width,
              height: audioHandler.mediaItem.value != null ? 550 : height - 50,
              padding: const EdgeInsets.only(bottom: 50, left: 10, right: 10),
              child: ListView.builder(
                controller: widget.scrollController,
                itemCount: playlist.length,
                itemBuilder: (context, index) {
                  var mediaItem = playlist[index];

                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return CardAudioInfo(
                    mediaItem: mediaItem,
                  );
                },
              ),
            );
          }
          return const Text("Error");
        });
  }
}
