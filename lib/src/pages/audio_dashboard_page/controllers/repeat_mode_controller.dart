// ignore_for_file: avoid_print

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:play_music/main.dart';

class RepeatModeController extends ValueNotifier<AudioServiceRepeatMode> {
  IconData repeatIcon = Icons.repeat;

  RepeatModeController(super.value);
  handleRepeatMode(
      {required AudioServiceRepeatMode audioServiceRepeatMode}) async {
    // check if the repeat mode is enabled
    value = audioServiceRepeatMode == AudioServiceRepeatMode.none
        ? AudioServiceRepeatMode.one
        : AudioServiceRepeatMode.none;

    // set repeat mode
    await audioHandler.setRepeatMode(value);

    //  set repeat mode icon
    repeatIcon =
        value == AudioServiceRepeatMode.none ? Icons.repeat : Icons.repeat_one;
    notifyListeners();
  }
}
