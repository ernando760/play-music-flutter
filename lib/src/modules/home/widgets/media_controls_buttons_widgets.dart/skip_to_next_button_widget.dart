import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:play_music/src/modules/home/controllers/skip_media_controller.dart';

class SkipToNextButtonWidget extends StatelessWidget {
  const SkipToNextButtonWidget({
    Key? key,
    this.size = 40,
  }) : super(key: key);
  final double size;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        iconSize: size,
        onPressed: () async =>
            await context.read<SkipMediaController>().skipToNext(),
        icon: const Icon(Icons.skip_next));
  }
}
