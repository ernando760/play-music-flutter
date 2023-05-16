import 'package:flutter/material.dart';
import 'package:play_music/main.dart';

class SkipToNext extends StatelessWidget {
  const SkipToNext({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: audioHandler.mediaItem
          .asBroadcastStream()
          .map((event) => event)
          .distinct(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return IconButton(
              onPressed: () async => await audioHandler.skipToNext(),
              icon: const Icon(Icons.skip_next));
        }
        return Container();
      },
    );
  }
}
