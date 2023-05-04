import 'dart:io';
import 'package:flutter/material.dart';
import 'package:play_music/main.dart';

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
            return SizedBox(
              width: double.infinity,
              height: 500,
              child: ListView.builder(
                itemCount: playlist.length,
                itemBuilder: (context, index) {
                  var mediaItem = playlist[index];

                  return StreamBuilder(
                      stream: audioHandler.mediaItem
                          .map((event) => event)
                          .distinct(),
                      builder: (context, snapshot) {
                        var mediaItemCurrent = snapshot.data;

                        if (mediaItemCurrent != null) {
                          if (mediaItemCurrent.id == mediaItem.id) {
                            return ListTile(
                              leading: Image.file(
                                File(mediaItem.artUri!.path),
                                width: 50,
                                height: 50,
                              ),
                              title: Text(
                                mediaItem.title,
                                style: const TextStyle(color: Colors.redAccent),
                              ),
                              onTap: () async {
                                await audioHandler.playMediaItem(mediaItem);
                              },
                              style: ListTileStyle.drawer,
                            );
                          }
                        }
                        return ListTile(
                          leading: Image.file(
                            File(mediaItem.artUri!.path),
                            width: 50,
                            height: 50,
                          ),
                          title: Text(
                            mediaItem.title,
                          ),
                          onTap: () async {
                            await audioHandler.playMediaItem(mediaItem);
                          },
                          style: ListTileStyle.drawer,
                        );
                      });
                },
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
