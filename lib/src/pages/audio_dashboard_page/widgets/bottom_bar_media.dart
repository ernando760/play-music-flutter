import 'dart:io';
import 'package:flutter/material.dart';
import 'package:play_music/main.dart';
import 'package:play_music/src/pages/audio_page/audio_page.dart';
import 'package:play_music/src/pages/audio_page/widgets/playing.dart';
import 'package:play_music/src/pages/audio_page/widgets/skip_to_next.dart';
import 'package:play_music/src/pages/audio_page/widgets/skip_to_previous.dart';

class BottomBarMedia extends StatelessWidget {
  const BottomBarMedia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: InkWell(
        onTap: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const AudioPage(),
            )),
        child: StreamBuilder(
          stream: audioHandler.mediaItem
              .asBroadcastStream()
              .map((event) => event)
              .distinct(),
          builder: (context, snapshot) {
            final mediaItem = snapshot.data;
            if (mediaItem != null) {
              return Container(
                padding: const EdgeInsets.all(10),
                // decoration: const BoxDecoration(
                //     border: Border(top: BorderSide(color: Colors.purple))),
                height: 80,
                child: Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: SizedBox(
                          child: Image.file(
                            File(mediaItem.artUri!.path),
                            width: 80,
                            height: 80,
                          ),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Text(mediaItem.title,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold))),
                    const SkipToPrevious(
                      size: 20,
                    ),
                    const ButtonPlaying(
                      size: 20,
                    ),
                    const SkipToNext(
                      size: 20,
                    )
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
