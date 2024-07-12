import 'dart:async';

import 'package:play_music/src/modules/shared/controllers/base_play_music_controller.dart';
import 'package:play_music/src/modules/shared/models/media_model.dart';
import 'package:play_music/src/modules/shared/services/audio/i_audio_services.dart';

class MediaController extends BaseStreamPlayMusicController<MediaModel> {
  MediaController(this._services) {
    updateValue(_services.mediaModelStream);
  }

  final IAudioServices _services;

  MediaModel get mediaModelCurrent =>
      behaviorSubject.hasValue ? behaviorSubject.value : MediaModel.empty();

  Future<void> getMedia(String mediaId) async =>
      await _services.getMedia(mediaId);

  Future<void> playMedia(MediaModel media) async {
    await _services.playMedia(media);
  }
}
