import 'package:flutter/material.dart';

import 'package:play_music/src/pages/audio_dashboard_page/controllers/shuflle_mode_controller.dart';
import 'package:provider/provider.dart';

class ButtonShuffleMode extends StatefulWidget {
  const ButtonShuffleMode({super.key, this.size = 30});
  final double size;

  @override
  State<ButtonShuffleMode> createState() => _ButtonShuffleModeState();
}

class _ButtonShuffleModeState extends State<ButtonShuffleMode> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: context.read<ShuffleModeController>(),
        builder: (context, shuffleMode, child) => IconButton(
              iconSize: widget.size,
              onPressed: () {
                context
                    .read<ShuffleModeController>()
                    .handleShuffleMode(audioServiceShuffleMode: shuffleMode);
              },
              icon: context.read<ShuffleModeController>().shuffleIcon,
            ));
  }
}



// StreamBuilder(
//       stream: audioHandler.playbackState
//           .asyncMap((event) => event.shuffleMode)
//           .asBroadcastStream()
//           .distinct(),
//       builder: (context, snapshot) {
//         final shuffleMode = snapshot.data;
//         return Visibility(
//             visible: shuffleMode != null ||
//                 shuffleMode == AudioServiceShuffleMode.none,
//             replacement: IconButton(
//                 onPressed: () {
//                   audioHandler.setShuffleMode(AudioServiceShuffleMode.none);
//                 },
//                 icon: const Icon(
//                   Icons.shuffle,
//                 )),
//             child: IconButton(
//                 onPressed: () {
//                   audioHandler.setShuffleMode(AudioServiceShuffleMode.all);
//                 },
//                 icon: const Icon(
//                   Icons.shuffle,
//                   weight: 20,
//                 )));
//       },
//     );




