import 'dart:async';

import 'package:play_music/src/modules/shared/controllers/base_play_music_controller.dart';
import 'package:play_music/src/modules/shared/services/audio/i_audio_services.dart';

class PlayAndPauseController extends BaseStreamPlayMusicController<bool> {
  final IAudioServices _audioServices;

  PlayAndPauseController(this._audioServices) {
    updateValue(_audioServices.isPlayingStream);
  }

  Future<void> play() async => await _audioServices.play();

  Future<void> pause() async => await _audioServices.pause();
}
