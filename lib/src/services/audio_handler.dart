// ignore_for_file: avoid_print, avoid_renaming_method_parameters

import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';

import 'package:just_audio/just_audio.dart';

import 'dart:developer' as dev;

Future<AudioHandler> initAudioServices() async {
  return await AudioService.init(
      builder: () => MyAudioHandler(),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.ernando.play_music.channel.audio',
        androidNotificationChannelName: 'Play Music',
        androidNotificationOngoing: true,
        androidNotificationChannelDescription: "test",
      ));
}

class MyAudioHandler extends BaseAudioHandler
    with // mix in default queue callback implementations
        SeekHandler {
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
    print("Init session!");
  }

  @override
  Future<void> skipToQueueItem(int index) async {
    await playMediaItem(queue.value[index]);
    print('index page: $index');
  }

  @override
  Future<void> skipToPrevious() async {
    try {
      if (mediaItem.value != null) {
        _index =
            queue.value.indexWhere((media) => media.id == mediaItem.value!.id);
        if (_index > 0) {
          _index = queue.value.indexWhere(
            (media) => media.id == mediaItem.value!.id,
          );
          _index -= 1;
          print('skip to previous $_index');
          await playMediaItem(queue.value[_index]);
          return;
        }
        await playMediaItem(queue.value.last);
        _index =
            queue.value.indexWhere((media) => media.id == mediaItem.value!.id);
        print('skip to previous $_index');
      }
    } catch (e, s) {
      dev.log("Error on function: skip to previous", error: e, stackTrace: s);
    }
  }

  @override
  Future<void> skipToNext() async {
    try {
      if (mediaItem.value != null) {
        _index =
            queue.value.indexWhere((media) => media.id == mediaItem.value!.id);

        if (_index < queue.value.length - 1) {
          _index += 1;
          await playMediaItem(queue.value[_index]);
          print("skip to next: $_index");
          return;
        }
        await playMediaItem(queue.value.first);
        _index =
            queue.value.indexWhere((media) => media.id == mediaItem.value!.id);
        print("skip to next: $_index");
      }
    } catch (e, s) {
      dev.log("Error on function: skip to next", error: e, stackTrace: s);
    }
  }

  @override
  Future<void> play() async => await _audioPlayer.play();

  @override
  Future<void> click([MediaButton button = MediaButton.media]) async {
    switch (button) {
      case MediaButton.media:
        _audioPlayer.playing ? play() : pause();
        break;
      case MediaButton.next:
        skipToNext();
        break;
      case MediaButton.previous:
        skipToPrevious();
        break;
    }
  }

  @override
  Future<void> playMediaItem(MediaItem mediaItemC) async {
    try {
      mediaItem.add(mediaItemC);
      print(mediaItemC);
      await _audioPlayer.setAudioSource(
          AudioSource.uri(Uri.parse(mediaItemC.id), tag: mediaItem.value));
      await play();
    } catch (e, s) {
      dev.log("Error on function: playMediaItem", error: e, stackTrace: s);
    }
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
    switch (repeatMode) {
      case AudioServiceRepeatMode.none:
        await _audioPlayer.setLoopMode(LoopMode.off);
        break;
      case AudioServiceRepeatMode.one:
        await _audioPlayer.setLoopMode(LoopMode.one);
        break;
      default:
    }
    print("set loop mode: ${_audioPlayer.loopMode}");
    print("set repeat mode: $repeatMode");
  }

  @override
  Future<MediaItem?> getMediaItem(String mediaId) async {
    final mediaItem = queue.value.firstWhere((media) => media.id == mediaId);
    return mediaItem;
  }

  @override
  Future<void> setShuffleMode(AudioServiceShuffleMode shuffleMode) async {
    switch (shuffleMode) {
      case AudioServiceShuffleMode.all:
      case AudioServiceShuffleMode.group:
        await _audioPlayer.setShuffleModeEnabled(true);
        print(_audioPlayer.shuffleModeEnabled);

        break;
      case AudioServiceShuffleMode.none:
        await _audioPlayer.setShuffleModeEnabled(false);
        print(_audioPlayer.shuffleModeEnabled);
        break;
    }
  }

  @override
  Future<void> updateQueue(List<MediaItem> queueMediaItem) async {
    queue.add(queueMediaItem);
  }

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    final res = mediaItems
        .map((mediaItem) =>
            AudioSource.uri(Uri.parse(mediaItem.id), tag: mediaItem))
        .toList();
    _playlist.addAll(res);
    await _audioPlayer.setAudioSource(_playlist);
    queue.add(mediaItems);
  }

  @override
  Future<void> addQueueItem(MediaItem mediaItem) async {
    var audioSource = _createAudioSource(mediaItem);
    _playlist.add(audioSource);
    _audioPlayer.setAudioSource(_playlist);
    final newQueue = queue.value..add(mediaItem);
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
    _audioPlayer.processingStateStream.listen((processingState) {
      if (processingState == ProcessingState.completed) {
        if (_audioPlayer.loopMode == LoopMode.off) {
          if (_audioPlayer.shuffleModeEnabled) {
            setRepeatMode(AudioServiceRepeatMode.none);
            _shuffle();
            return;
          }
          setShuffleMode(AudioServiceShuffleMode.none);
          skipToNext();
        }
      }
    });
  }

  _shuffle() {
    final indexs = queue.value.map((e) => queue.value.indexOf(e)).toList();
    final indexRandom = Random().nextInt(indexs.length);
    playMediaItem(queue.value[indexRandom]);
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

  _handlerInterruption(AudioSession audioSession) {
    bool playInterrupted = false;
    audioSession.becomingNoisyEventStream.listen((_) {
      print('PAUSE');
      _audioPlayer.pause();
    });
    _audioPlayer.playingStream.listen((playing) {
      playInterrupted = false;
      if (playing) {
        audioSession.setActive(true);
      }
    });
    audioSession.interruptionEventStream.listen((event) {
      print('interruption begin: ${event.begin}');
      print('interruption type: ${event.type}');
      if (event.begin) {
        switch (event.type) {
          case AudioInterruptionType.duck:
            if (audioSession.androidAudioAttributes!.usage ==
                AndroidAudioUsage.game) {
              _audioPlayer.setVolume(_audioPlayer.volume / 2);
            }
            playInterrupted = false;
            break;
          case AudioInterruptionType.pause:
          case AudioInterruptionType.unknown:
            if (_audioPlayer.playing) {
              _audioPlayer.pause();
              playInterrupted = true;
            }
            break;
        }
      } else {
        switch (event.type) {
          case AudioInterruptionType.duck:
            _audioPlayer.setVolume(min(1.0, _audioPlayer.volume * 2));
            playInterrupted = false;
            break;
          case AudioInterruptionType.pause:
            if (playInterrupted) _audioPlayer.play();
            playInterrupted = false;
            break;
          case AudioInterruptionType.unknown:
            playInterrupted = false;
            break;
        }
      }
    });
    audioSession.devicesChangedEventStream.listen((event) {
      print('Devices added: ${event.devicesAdded}');
      print('Devices removed: ${event.devicesRemoved}');
    });
  }
}
