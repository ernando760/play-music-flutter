import 'dart:io';

import 'package:flutter/material.dart';
import 'package:play_music/main.dart';

class AudioItem extends StatefulWidget {
  const AudioItem({super.key});

  @override
  State<AudioItem> createState() => _MediaItemMusicState();
}

class _MediaItemMusicState extends State<AudioItem> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: audioHandler.mediaItem,
      builder: (context, snapshot) {
        var mediaItem = snapshot.data;
        if (mediaItem != null) {
          return Center(
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image.file(
                      alignment: Alignment.center,
                      cacheHeight: 200,
                      cacheWidth: 200,
                      fit: BoxFit.cover,
                      File(mediaItem.artUri!.path),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    mediaItem.title,
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          );
        }
        if (snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text("Error ${snapshot.error}"),
          );
        }
        return Container();
      },
    );
  }
}
