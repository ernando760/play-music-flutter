// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:play_music/main.dart';

import 'audio_item.dart';
import 'button_repeat_mode.dart';
import 'button_shuffle_mode.dart';
import 'playing.dart';
import 'seek_bar.dart';
import 'skip_to_next.dart';
import 'skip_to_previous.dart';

class PlaygroundMediaItem extends StatefulWidget {
  const PlaygroundMediaItem({
    Key? key,
    required this.mediaItem,
  }) : super(key: key);
  final MediaItem mediaItem;

  @override
  State<PlaygroundMediaItem> createState() => _PlaygroundMediaItemState();
}

class _PlaygroundMediaItemState extends State<PlaygroundMediaItem> {
  showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height,
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            StreamBuilder(
              stream: audioHandler.playbackState
                  .map((event) => event.processingState)
                  .distinct(),
              builder: (context, snapshot) {
                final state = snapshot.data;
                switch (state) {
                  case AudioProcessingState.idle:
                  case AudioProcessingState.loading:
                    return const Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  case AudioProcessingState.ready:
                    return AudioItem(
                      imagePath: widget.mediaItem.artUri!.path,
                      title: widget.mediaItem.title,
                    );
                  default:
                }
                return Container();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonShuffleMode(),
                  SkipToPrevious(),
                  ButtonPlaying(),
                  SkipToNext(),
                  ButtonRepeatMode(),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SeekBar(),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}


//  StreamBuilder(
//         stream: audioHandler.mediaItem.map((event) => event).distinct(),
//         builder: (context, snapshot) {
//           final mediaItem = snapshot.data;
//           if (mediaItem != null) {
//             if (!snapshot.hasData) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             return Container(
//               height: MediaQuery.of(context).size.height,
//               padding: const EdgeInsets.only(left: 10, right: 10),
//               child: Center(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     AudioItem(
//                       imagePath: mediaItem.artUri!.path,
//                       title: mediaItem.title,
//                     ),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: const [
//                         ButtonShuffleMode(),
//                         SkipToPrevious(),
//                         ButtonPlaying(),
//                         SkipToNext(),
//                         ButtonRepeatMode(),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     const SeekBar()
//                   ],
//                 ),
//               ),
//             );
//           }
//           return Container();
//         });