// ignore_for_file: avoid_print

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:play_music/main.dart';
import 'package:play_music/src/pages/audio_dashboard_page/controllers/repeat_mode_controller.dart';
import 'package:provider/provider.dart';

class ButtonRepeatMode extends StatefulWidget {
  const ButtonRepeatMode({
    super.key,
  });

  @override
  State<ButtonRepeatMode> createState() => _ButtonRepeatModeState();
}

class _ButtonRepeatModeState extends State<ButtonRepeatMode> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: context.read<RepeatModeController>(),
        builder: (context, repeatMode, child) => IconButton(
              onPressed: () {
                context
                    .read<RepeatModeController>()
                    .handleRepeatMode(audioServiceRepeatMode: repeatMode);
              },
              icon: Icon(context.read<RepeatModeController>().repeatIcon),
            ));
  }
}
