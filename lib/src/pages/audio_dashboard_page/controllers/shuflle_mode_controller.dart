import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';

class ShuffleModeController extends ValueNotifier<AudioServiceShuffleMode> {
  ShuffleModeController(super.value);

  IconData shuffleIcon = Icons.shuffle;

  handleShuffleMode(
      {required AudioServiceShuffleMode audioServiceShuffleMode}) async {
    // check if the shuffle mode is enabled
    value = audioServiceShuffleMode == AudioServiceShuffleMode.none
        ? AudioServiceShuffleMode.all
        : AudioServiceShuffleMode.none;

    // set shuffle mode
    await audioHandler.setShuffleMode(value);

    //  set shuffle mode icon
    shuffleIcon = value == AudioServiceShuffleMode.none
        ? Icons.shuffle
        : Icons.shuffle_on_sharp;
    notifyListeners();
  }
}
