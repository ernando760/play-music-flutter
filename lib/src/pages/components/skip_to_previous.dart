import 'package:flutter/material.dart';

import '../../../main.dart';

class SkipToPrevious extends StatelessWidget {
  const SkipToPrevious({super.key});

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
              onPressed: () async => await audioHandler.skipToPrevious(),
              icon: const Icon(Icons.skip_previous));
        }
        return Container();
      },
    );
  }
}
