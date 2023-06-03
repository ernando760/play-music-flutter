// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:play_music/main.dart';

class SkipToNext extends StatefulWidget {
  const SkipToNext({
    Key? key,
    this.size = 40,
  }) : super(key: key);
  final double size;

  @override
  State<SkipToNext> createState() => _SkipToNextState();
}

class _SkipToNextState extends State<SkipToNext> {
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
              iconSize: widget.size,
              onPressed: () async {
                await audioHandler.skipToNext();
              },
              icon: const Icon(Icons.skip_next));
        }
        if (snapshot.hasError) {
          return const Text('error no botão skip to next');
        }
        return Container();
      },
    );
  }
}
