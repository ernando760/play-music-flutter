import 'package:audio_service/audio_service.dart';
import 'package:play_music/src/modules/shared/models/media_model.dart';
import 'package:play_music/src/modules/shared/services/audio/audio_handler.dart';
import 'package:play_music/src/modules/shared/services/audio/i_audio_services.dart';
import 'package:play_music/src/modules/shared/services/enums/media_processing_state_enum.dart';
import 'package:play_music/src/modules/shared/services/enums/repeat_mode_enum.dart';
import 'package:play_music/src/modules/shared/services/enums/shuffle_mode_enum.dart';

class AudioServicesImpl extends IAudioServices {
  final MyAudioHandler _audioHandler;

  AudioServicesImpl(this._audioHandler);

  IAudioServices call() => this;

  @override
  bool get playing => _audioHandler.playbackState.value.playing;

  @override
  Duration get position => _audioHandler.playbackState.value.position;

  @override
  MediaModel get mediaModelCurrent => _audioHandler.mediaItem.value != null
      ? MediaModel.fromMediaItem(_audioHandler.mediaItem.value!)
      : MediaModel.empty();

  @override
  Stream<List<MediaModel>> get queueMedia => _audioHandler.queue
      .map((mediasItems) => mediasItems
          .map((mediaItem) => MediaModel.fromMediaItem(mediaItem))
          .toList())
      .distinct();

  @override
  Stream<bool> get isPlayingStream =>
      _audioHandler.playbackState.map((event) => event.playing).distinct();

  @override
  Stream<Duration> get positionStream => _audioHandler.positionStream;

  @override
  Stream<MediaModel> get mediaModelStream => _audioHandler.mediaItem
      .map((value) =>
          value != null ? MediaModel.fromMediaItem(value) : MediaModel.empty())
      .distinct();

  @override
  Stream<RepeatMode> get repeatModeStream => _audioHandler.playbackState
      .map((event) => _convertToRepeatMode(event.repeatMode))
      .distinct();

  @override
  Stream<ShuffleMode> get shuffleModeStream => _audioHandler.playbackState
      .map((event) => _convertToShuffleMode(event.shuffleMode))
      .distinct();

  @override
  Stream<MediaProcessingState> get mediaProcessingStateStream =>
      _audioHandler.playbackState
          .map((event) => _convertToMediaProcessingState(event.processingState))
          .distinct();

  @override
  List<MediaModel> getMedias() {
    return _audioHandler.queue.value
        .map((media) => MediaModel.fromMediaItem(media))
        .toList();
  }

  @override
  Future<MediaModel?> getMedia(String id) async {
    final media = await _audioHandler.getMediaItem(id);
    if (media != null) {
      return MediaModel.fromMediaItem(media);
    }
    return null;
  }

  @override
  Future<void> playMedia(MediaModel media) async =>
      await _audioHandler.playMediaItem(media.toMediaItem());

  @override
  Future<void> pause() async => await _audioHandler.pause();

  @override
  Future<void> play() async => await _audioHandler.play();

  @override
  Future<void> stop() async => await _audioHandler.stop();

  @override
  Future<void> setRepeatMode(RepeatMode repeatMode) async => await _audioHandler
      .setRepeatMode(AudioServiceRepeatMode.values[repeatMode.index]);

  @override
  Future<void> setShuffleMode(ShuffleMode shuffleMode) async {
    await _audioHandler
        .setShuffleMode(AudioServiceShuffleMode.values[shuffleMode.index]);
  }

  @override
  Future<void> seek(Duration position) async =>
      await _audioHandler.seek(position);

  @override
  Future<void> skipToNext() async => await _audioHandler.skipToNext();

  @override
  Future<void> skipToPrevious() async => await _audioHandler.skipToPrevious();

  @override
  Future<void> addMediasInPlaylist(List<MediaModel> medias) async =>
      await _audioHandler
          .addQueueItems(medias.map((e) => e.toMediaItem()).toList());

  RepeatMode _convertToRepeatMode(
          AudioServiceRepeatMode audioServiceRepeatMode) =>
      RepeatMode.values[audioServiceRepeatMode.index];

  ShuffleMode _convertToShuffleMode(
          AudioServiceShuffleMode audioServiceShuffleMode) =>
      ShuffleMode.values[audioServiceShuffleMode.index];

  MediaProcessingState _convertToMediaProcessingState(
          AudioProcessingState audioProcessingState) =>
      MediaProcessingState.values[audioProcessingState.index];
}
