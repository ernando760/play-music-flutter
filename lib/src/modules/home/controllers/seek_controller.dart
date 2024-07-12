import 'dart:async';
import 'package:play_music/src/modules/home/states/position_state.dart';
import 'package:play_music/src/modules/shared/controllers/base_play_music_controller.dart';
import 'package:play_music/src/modules/shared/models/media_model.dart';
import 'package:play_music/src/modules/shared/services/audio/i_audio_services.dart';
import 'package:rxdart/rxdart.dart';

class SeekController extends BaseStreamPlayMusicController<PositionState> {
  SeekController(this._services) {
    updateValue(_updatePosition());
  }

  final IAudioServices _services;

  PositionState get position => behaviorSubject.hasValue
      ? behaviorSubject.value
      : PositionState(mediaModel: MediaModel.empty(), position: Duration.zero);

  Future<void> seek(Duration newPosition) async =>
      await _services.seek(newPosition);

  Stream<PositionState> _updatePosition() {
    return Rx.combineLatest2<MediaModel, Duration, PositionState>(
        _services.mediaModelStream,
        _services.positionStream,
        (media, position) =>
            PositionState(mediaModel: media, position: position)).distinct();
  }
}
