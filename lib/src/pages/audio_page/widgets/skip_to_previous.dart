// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../main.dart';

class SkipToPrevious extends StatefulWidget {
  const SkipToPrevious({
    Key? key,
    this.size = 40,
  }) : super(key: key);
  final double size;

  @override
  State<SkipToPrevious> createState() => _SkipToPreviousState();
}

class _SkipToPreviousState extends State<SkipToPrevious> {
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
              onPressed: () async => await audioHandler.skipToPrevious(),
              icon: const Icon(Icons.skip_previous));
        }
        if (snapshot.hasError) {
          return const Text('error no botão skip to next');
        }
        return Container();
      },
    );
  }
}
