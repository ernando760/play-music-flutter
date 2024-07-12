import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:play_music/src/modules/home/controllers/play_and_pause_controller.dart';
import 'package:play_music/src/modules/shared/widgets/play_music_stream_builder_widget.dart';

class PlayAndPauseButton extends StatelessWidget {
  const PlayAndPauseButton({
    Key? key,
    this.size = 55,
  }) : super(key: key);
  final double size;

  @override
  Widget build(BuildContext context) {
    final playAndPauseController = Modular.get<PlayAndPauseController>();
    return PlayMusicStreamBuilderWidget(
      streamController: playAndPauseController,
      initialData: false,
      onLoading: () =>
          const IconButton(onPressed: null, icon: Icon(Icons.play_arrow)),
      onSuccess: (isPlaying) => IconButton(
          onPressed: () async => isPlaying
              ? await playAndPauseController.pause()
              : await playAndPauseController.play(),
          icon: isPlaying
              ? Icon(Icons.pause, size: size)
              : Icon(Icons.play_arrow, size: size)),
      onError: () => const Center(child: Text("Error play and pause")),
    );
  }
}






// return StreamBuilder(
//       stream: audioHandler.playbackState
//           .asBroadcastStream()
//           .map((event) => event.playing)
//           .distinct(),
//       builder: (context, snapshot) {
//         var playing = snapshot.data;
//         if (playing != null) {
//           return IconButton(
//               iconSize: size,
//               onPressed: () async => await _playOrPause(playing),
//               icon: Icon(playing ? Icons.pause : Icons.play_arrow));
//         }
//         if (snapshot.hasError) {
//           return const Center(
//             child: Text("Error no botão play"),
//           );
//         }
//         return Container();
//       },
//     );
