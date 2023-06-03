// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_typing_uninitialized_variables
import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:play_music/src/extensions/context_theme_extension.dart';

import '../../../../main.dart';
import '../../audio_page/audio_page.dart';

class CardAudioInfo extends StatefulWidget {
  const CardAudioInfo({
    Key? key,
    required this.mediaItem,
  }) : super(key: key);
  final MediaItem mediaItem;

  @override
  State<CardAudioInfo> createState() => _CardAudioInfoState();
}

class _CardAudioInfoState extends State<CardAudioInfo> {
  void navigateToAudioPage() async {
    if (audioHandler.mediaItem.value != widget.mediaItem) {
      await audioHandler.playMediaItem(widget.mediaItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: audioHandler.mediaItem.asBroadcastStream(),
      builder: (context, snapshot) {
        final mediaItemCurrent = snapshot.data;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () async {
              navigateToAudioPage();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AudioPage(),
                  ));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              width: context.width,
              height: 70,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.file(
                          File(widget.mediaItem.artUri!.path),
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: Text(
                    widget.mediaItem.title,
                    style: TextStyle(
                      fontSize: 18,
                      overflow: TextOverflow.ellipsis,
                      color: widget.mediaItem == mediaItemCurrent
                          ? context.theme.colorScheme.primary
                          : null,
                    ),
                  ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
