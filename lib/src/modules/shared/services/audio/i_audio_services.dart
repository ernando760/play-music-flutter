import 'dart:async';

import 'package:play_music/src/modules/shared/models/media_model.dart';
import 'package:play_music/src/modules/shared/services/enums/media_processing_state_enum.dart';
import 'package:play_music/src/modules/shared/services/enums/repeat_mode_enum.dart';
import 'package:play_music/src/modules/shared/services/enums/shuffle_mode_enum.dart';

abstract class IAudioServices {
  bool get playing;
  Duration get position;
  MediaModel? get mediaModelCurrent;
  Stream<MediaModel> get mediaModelStream => const Stream.empty();
  Stream<Duration> get positionStream => const Stream.empty();
  Stream<List<MediaModel>> get queueMedia => const Stream.empty();
  Stream<bool> get isPlayingStream => const Stream.empty();
  Stream<RepeatMode> get repeatModeStream => const Stream.empty();
  Stream<ShuffleMode> get shuffleModeStream => const Stream.empty();
  Stream<MediaProcessingState> get mediaProcessingStateStream =>
      const Stream.empty();
  List<MediaModel> getMedias();
  Future<void> addMediasInPlaylist(List<MediaModel> medias);
  Future<MediaModel?> getMedia(String id);
  Future<void> play();
  Future<void> stop();
  Future<void> pause();
  Future<void> skipToNext();
  Future<void> skipToPrevious();
  Future<void> setRepeatMode(RepeatMode repeatMode);
  Future<void> setShuffleMode(ShuffleMode shuffleMode);
  Future<void> seek(Duration position);
  Future<void> playMedia(MediaModel media);
}
