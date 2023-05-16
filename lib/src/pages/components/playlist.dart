import 'package:flutter/material.dart';
import 'package:play_music/main.dart';
import 'package:play_music/src/pages/components/card_audio_info.dart';
import 'package:play_music/src/pages/audio_dashboard_page/audio_dashboard_page.dart';
import 'package:play_music/src/pages/audio_page/audio_page.dart';

class Playlist extends StatefulWidget {
  const Playlist({super.key});

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: audioHandler.queue.map((event) => event).distinct(),
        builder: (context, snapshot) {
          var playlist = snapshot.data;
          if (playlist != null) {
            return Container(
              width: double.infinity,
              height: 600,
              padding: const EdgeInsets.only(bottom: 20),
              child: ListView.builder(
                itemCount: playlist.length,
                itemBuilder: (context, index) {
                  var mediaItem = playlist[index];

                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return StreamBuilder(
                      stream: audioHandler.mediaItem
                          .asBroadcastStream()
                          .map((event) => event)
                          .distinct(),
                      builder: (context, snapshot) {
                        var mediaItemCurrent = snapshot.data;
                        return CardAudioInfo(
                            image: mediaItem.artUri!.path,
                            title: mediaItem.title,
                            audioSelected: mediaItemCurrent?.id == mediaItem.id,
                            onPressed: () async {
                              if (mediaItemCurrent?.id != mediaItem.id) {
                                await audioHandler.playMediaItem(mediaItem);
                              }
                              // ignore: use_build_context_synchronously
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AudioPage(),
                                  ));
                            });
                      });
                },
              ),
            );
          }

          return const Text("Error");
        });
  }
}
