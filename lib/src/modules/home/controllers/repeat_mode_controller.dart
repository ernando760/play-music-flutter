import 'dart:async';
import 'dart:developer';

import 'package:play_music/src/modules/shared/controllers/base_play_music_controller.dart';
import 'package:play_music/src/modules/shared/services/audio/i_audio_services.dart';
import 'package:play_music/src/modules/shared/services/enums/repeat_mode_enum.dart';

class RepeatModeController extends BaseNotifierPlayMusicController<RepeatMode> {
  RepeatModeController(this._services) : super(RepeatMode.none);

  final IAudioServices _services;

  Future<void> setRepeatMode(RepeatMode repeatMode) async {
    repeatMode =
        repeatMode == RepeatMode.none ? RepeatMode.one : RepeatMode.none;

    await _services.setRepeatMode(repeatMode);
    log("$repeatMode", name: "RepeatMode");
    updateValue(repeatMode);
  }
}
