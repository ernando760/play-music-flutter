import 'dart:developer';

import 'package:play_music/src/modules/shared/controllers/base_play_music_controller.dart';
import 'package:play_music/src/modules/shared/services/audio/i_audio_services.dart';
import 'package:play_music/src/modules/shared/services/enums/shuffle_mode_enum.dart';

class ShuffleModeController
    extends BaseNotifierPlayMusicController<ShuffleMode> {
  ShuffleModeController(this._services) : super(ShuffleMode.none);
  final IAudioServices _services;

  Future<void> setShuffleMode({required ShuffleMode shuffleMode}) async {
    shuffleMode =
        shuffleMode == ShuffleMode.none ? ShuffleMode.all : ShuffleMode.none;

    await _services.setShuffleMode(shuffleMode);
    log("$shuffleMode", name: "ShuffleMode");
    updateValue(shuffleMode);
  }
}
