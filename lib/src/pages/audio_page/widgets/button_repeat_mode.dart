// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:play_music/src/pages/audio_dashboard_page/controllers/repeat_mode_controller.dart';

class ButtonRepeatMode extends StatefulWidget {
  const ButtonRepeatMode({
    Key? key,
    this.size = 30,
  }) : super(key: key);
  final double size;

  @override
  State<ButtonRepeatMode> createState() => _ButtonRepeatModeState();
}

class _ButtonRepeatModeState extends State<ButtonRepeatMode> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: context.read<RepeatModeController>(),
        builder: (context, repeatMode, child) => IconButton(
              iconSize: widget.size,
              onPressed: () {
                context
                    .read<RepeatModeController>()
                    .handleRepeatMode(audioServiceRepeatMode: repeatMode);
              },
              icon: Icon(context.read<RepeatModeController>().repeatIcon),
            ));
  }
}
