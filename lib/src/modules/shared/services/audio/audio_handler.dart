import 'dart:developer';
import 'dart:math' as math;

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';

import 'package:just_audio/just_audio.dart';

Future<MyAudioHandler> initAudioServices() async {
  log("Initialize services");
  return await AudioService.init(
      builder: () => MyAudioHandler(),
      config: const AudioServiceConfig(
        androidNotificationChannelId:
            'com.ernando.play_music_flutter.channel.audio',
        androidNotificationChannelName: 'Play Music',
        androidNotificationOngoing: true,
      ));
}

class MyAudioHandler extends BaseAudioHandler with SeekHandler, QueueHandler {
  final ConcatenatingAudioSource _playlist =
      ConcatenatingAudioSource(children: []);
  final AudioPlayer _audioPlayer = AudioPlayer(
    handleInterruptions: false,
  );

  int _index = 0;
  MyAudioHandler() {
    _audioPlayer.playbackEventStream
        .asBroadcastStream()
        .map(_broadcastState)
        .pipe(playbackState);
    _listenProcessingState();
    _initSession();
    _listenForCurrentSongIndexChanges();
  }

  Future<void> _initSession() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
    _handlerInterruption(session);
  }

  Stream<Duration> get positionStream => _audioPlayer.positionStream;

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    final audios = mediaItems
        .map((mediaItem) =>
            AudioSource.uri(Uri.parse(mediaItem.id), tag: mediaItem))
        .toList();
    _playlist.addAll(audios);
    await _audioPlayer.setAudioSource(_playlist);
    queue.add(mediaItems);
  }

  @override
  Future<void> addQueueItem(MediaItem mediaItem) async {
    var audioSource = _createAudioSource(mediaItem);
    _playlist.add(audioSource);
    await _audioPlayer.setAudioSource(_playlist);
    _audioPlayer.audioSource;
    final newQueue = queue.value..add(mediaItem);
    queue.add(newQueue);
  }

  @override
  Future<void> skipToQueueItem(int index) async =>
      await playMediaItem(queue.value[index]);

  @override
  Future<void> skipToPrevious() async {
    if (mediaItem.value != null) {
      _index =
          queue.value.indexWhere((media) => media.id == mediaItem.value!.id);
      if (_index > 0) {
        _index = queue.value.indexWhere(
          (media) => media.id == mediaItem.value!.id,
        );
        _index -= 1;

        await playMediaItem(queue.value[_index]);
        return;
      }
      await playMediaItem(queue.value.last);
      _index =
          queue.value.indexWhere((media) => media.id == mediaItem.value!.id);
    }
  }

  @override
  Future<void> skipToNext() async {
    if (mediaItem.value != null) {
      _index =
          queue.value.indexWhere((media) => media.id == mediaItem.value!.id);

      if (_index < queue.value.length - 1) {
        _index += 1;
        await playMediaItem(queue.value[_index]);
        return;
      }
      await playMediaItem(queue.value.first);
      _index =
          queue.value.indexWhere((media) => media.id == mediaItem.value!.id);
    }
  }

  @override
  Future<void> play() async => await _audioPlayer.play();

  @override
  Future<void> playMediaItem(MediaItem mediaItem) async {
    this.mediaItem.add(mediaItem);
    await _audioPlayer.setAudioSource(
        AudioSource.uri(Uri.parse(mediaItem.id), tag: this.mediaItem.value));
    await play();
  }

  @override
  Future<MediaItem?> getMediaItem(String mediaId) async {
    final mediaItem = queue.value.firstWhere((media) => media.id == mediaId);

    return mediaItem;
  }

  @override
  Future<void> pause() async => await _audioPlayer.pause();

  @override
  Future<void> stop() async => await _audioPlayer.stop();

  @override
  Future<void> seek(Duration position) async =>
      await _audioPlayer.seek(position);

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    await _audioPlayer.setLoopMode(LoopMode.values[repeatMode.index]);
  }

  @override
  Future<void> setShuffleMode(AudioServiceShuffleMode shuffleMode) async {
    switch (shuffleMode) {
      case AudioServiceShuffleMode.all:
      case AudioServiceShuffleMode.group:
        await _audioPlayer.setShuffleModeEnabled(true);
      case AudioServiceShuffleMode.none:
        await _audioPlayer.setShuffleModeEnabled(false);
      default:
        await _audioPlayer.setShuffleModeEnabled(false);
    }
  }

  @override
  Future<void> updateQueue(List<MediaItem> newQueue) async {
    queue.value.clear();
    queue.add(newQueue);
  }

  PlaybackState _broadcastState(
    PlaybackEvent event,
  ) {
    final playing = _audioPlayer.playing;

    final AudioServiceShuffleMode shuffle =
        _audioPlayer.shuffleModeEnabled == true
            ? AudioServiceShuffleMode.all
            : AudioServiceShuffleMode.none;

    return PlaybackState(
      controls: [
        MediaControl.skipToPrevious,
        if (playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
        MediaControl.skipToNext,
      ],
      systemActions: {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
        MediaAction.skipToNext,
        MediaAction.skipToPrevious,
      },
      shuffleMode: shuffle,
      repeatMode: _audioPlayer.loopMode == LoopMode.off
          ? AudioServiceRepeatMode.none
          : AudioServiceRepeatMode.one,
      androidCompactActionIndices: [0, 1, 3],
      processingState: {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_audioPlayer.processingState]!,
      playing: playing,
      updatePosition: _audioPlayer.position,
      bufferedPosition: _audioPlayer.bufferedPosition,
      speed: _audioPlayer.speed,
      queueIndex: event.currentIndex,
    );
  }

  void _listenProcessingState() {
    _audioPlayer.processingStateStream.listen((processingState) async {
      if (processingState == ProcessingState.completed) {
        if (_audioPlayer.loopMode == LoopMode.off) {
          if (_audioPlayer.shuffleModeEnabled) {
            await setRepeatMode(AudioServiceRepeatMode.none);
            _shuffle();
            return;
          }
          await setShuffleMode(AudioServiceShuffleMode.none);
          await skipToNext();
        }
      }
    });
  }

  Future<void> _shuffle() async {
    final indexs = queue.value.map((e) => queue.value.indexOf(e)).toList();
    final indexRandom = math.Random().nextInt(indexs.length);
    await playMediaItem(queue.value[indexRandom]);
  }

  void _listenForCurrentSongIndexChanges() {
    _audioPlayer.currentIndexStream.listen((index) {
      final playlist = queue.value;
      if (index == null || playlist.isEmpty) return;
      if (_audioPlayer.shuffleModeEnabled) {
        index = _audioPlayer.shuffleIndices![index];
      }
      mediaItem.add(playlist[index]);
    });
  }

  UriAudioSource _createAudioSource(MediaItem mediaItem) {
    return AudioSource.uri(
      Uri.parse(mediaItem.extras!['url']),
      tag: mediaItem,
    );
  }

  void _handlerInterruption(AudioSession audioSession) {
    bool playInterrupted = false;
    audioSession.becomingNoisyEventStream.listen((_) async {
      await _audioPlayer.pause();
    });
    _audioPlayer.playingStream.listen((playing) async {
      playInterrupted = false;
      if (playing) {
        await audioSession.setActive(true);
      }
    });
    audioSession.interruptionEventStream.listen((event) async {
      if (event.begin) {
        switch (event.type) {
          case AudioInterruptionType.duck:
            if (audioSession.androidAudioAttributes!.usage ==
                AndroidAudioUsage.game) {
              await _audioPlayer.setVolume(_audioPlayer.volume / 2);
            }
            playInterrupted = false;
            break;
          case AudioInterruptionType.pause:
          case AudioInterruptionType.unknown:
            if (_audioPlayer.playing) {
              await _audioPlayer.pause();
              playInterrupted = true;
            }
            break;
        }
      } else {
        switch (event.type) {
          case AudioInterruptionType.duck:
            await _audioPlayer
                .setVolume(math.min(1.0, _audioPlayer.volume * 2));
            playInterrupted = false;
            break;
          case AudioInterruptionType.pause:
            if (playInterrupted) await _audioPlayer.play();
            playInterrupted = false;
            break;
          case AudioInterruptionType.unknown:
            playInterrupted = false;
            break;
        }
      }
    });
  }
}
