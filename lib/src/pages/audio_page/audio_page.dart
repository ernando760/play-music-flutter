// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'package:flutter/material.dart';

import 'package:play_music/main.dart';
import 'package:play_music/src/extensions/context_theme_extension.dart';
import 'package:play_music/src/pages/audio_dashboard_page/audio_dashboard_page.dart';
import 'package:play_music/src/pages/audio_page/widgets/draggable_scroll_playlist.dart';
import 'package:play_music/src/pages/audio_page/widgets/playground_media.dart';

class AudioPage extends StatefulWidget {
  const AudioPage({
    Key? key,
  }) : super(key: key);
  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(children: [
      _buildMediaItemInfo(),
      const DraggableScrollPlaylist()
    ])));
  }

  Widget _buildMediaItemInfo() {
    return StreamBuilder(
      stream: audioHandler.mediaItem.asBroadcastStream(),
      builder: (context, snapshot) {
        final mediaItem = snapshot.data;
        if (mediaItem == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AudioDashboardPage()));
                  },
                  style: ButtonStyle(
                    iconSize: IconButton.styleFrom(iconSize: 40).iconSize,
                  ),
                  icon: const Icon(
                    Icons.arrow_back,
                    // size: 50,
                  )),
            ),
            Flexible(
              child: SizedBox(
                width: context.width,
                height: context.height,
                child: PlaygroundMediaItem(
                  mediaItem: mediaItem,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
