// ignore_for_file: avoid_print, avoid_renaming_method_parameters

import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';

import 'package:just_audio/just_audio.dart';

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
  final AudioPlayer _audioPlayer = AudioPlayer(
    handleInterruptions: false,
  );
  int _index = 0;
  final ConcatenatingAudioSource _playlist =
      ConcatenatingAudioSource(children: []);
  MyAudioHandler() {
    _audioPlayer.playbackEventStream.map(_transformEvent).pipe(playbackState);
    _loadEmptyPlaylist();
    _initSession();
    _listenForCurrentSongIndexChanges();
  }
  _loadEmptyPlaylist() async {
    print("load playlist");
    await _audioPlayer.setAudioSource(_playlist);
  }

  Future<void> _initSession() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
    _handlerInterruption(session);
    print("Init session!");
  }

  @override
  Future<void> skipToQueueItem(int index) async {
    _audioPlayer.seek(Duration(
        milliseconds: queue.value[index].duration?.inMilliseconds ?? 0));
  }

  @override
  Future<void> skipToPrevious() async {
    try {
      if (_index < queue.value.length) {
        _index = queue.value.indexWhere(
          (media) => media.id == mediaItem.value?.id,
        );
        _index -= 1;
        await playMediaItem(queue.value[_index]);
        print(_index);
      } else if (_index == -1) {
        await playMediaItem(queue.value.last);
        _index =
            queue.value.indexWhere((media) => media.id == mediaItem.value?.id);
        print(_index);
      }
    } catch (e) {
      print("Error on function: skip to previous");
      print("$e");
    }
  }

  @override
  Future<void> skipToNext() async {
    try {
      _index =
          queue.value.indexWhere((media) => media.id == mediaItem.value?.id);
      print("skip to next index: $_index");

      if (_index < queue.value.length) {
        _index += 1;
        await playMediaItem(queue.value[_index]);
      } else {
        await playMediaItem(queue.value.first);
        _index =
            queue.value.indexWhere((media) => media.id == mediaItem.value?.id);
      }
    } catch (e) {
      print("Error on function: skip to next");
      print("$e");
    }
  }

  @override
  Future<void> play() async => await _audioPlayer.play();

  @override
  Future<void> playMediaItem(MediaItem mediaItemC) async {
    try {
      mediaItem.add(mediaItemC);
      await _audioPlayer.setAudioSource(
          AudioSource.uri(Uri.parse(mediaItemC.id), tag: mediaItem));

      await play();
    } catch (e) {
      print("Error om function: class playMediaItem");
      print("$e");
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
        print(_audioPlayer.loopMode);
        break;
      case AudioServiceRepeatMode.one:
        await _audioPlayer.setLoopMode(LoopMode.one);
        print(_audioPlayer.loopMode);
        break;
      case AudioServiceRepeatMode.all:
      case AudioServiceRepeatMode.group:
        await _audioPlayer.setLoopMode(LoopMode.all);
        print(_audioPlayer.loopMode);
        break;
    }
  }

  @override
  Future<void> setShuffleMode(AudioServiceShuffleMode shuffleMode) async {
    switch (shuffleMode) {
      case AudioServiceShuffleMode.all:
      case AudioServiceShuffleMode.group:
        await _audioPlayer.shuffle();
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
    print("Update list");
    queue.add(queueMediaItem);
  }

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    print("audio handler queue: $mediaItems");
    // final audioSource = mediaItems.map(_createAudioSource);
    // _playlist.addAll(audioSource.toList());
    queue.add(mediaItems);
  }

  @override
  Future<void> addQueueItem(MediaItem mediaItem) async {
    var audioSource = _createAudioSource(mediaItem);

    _playlist.add(audioSource);
    final newQueue = queue.value..add(mediaItem);
    queue.add(newQueue);
  }

  @override
  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      controls: [
        // MediaControl.rewind,
        MediaControl.skipToPrevious,
        if (_audioPlayer.playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
        // MediaControl.fastForward,
        MediaControl.skipToNext,
      ],
      systemActions: const {
        MediaAction.setShuffleMode,
        MediaAction.setRepeatMode,
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0, 1, 3],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_audioPlayer.processingState]!,
      playing: _audioPlayer.playing,
      updatePosition: _audioPlayer.position,
      bufferedPosition: _audioPlayer.bufferedPosition,
      speed: _audioPlayer.speed,
      queueIndex: event.currentIndex,
      repeatMode: const {
        LoopMode.off: AudioServiceRepeatMode.none,
        LoopMode.all: AudioServiceRepeatMode.all,
        LoopMode.one: AudioServiceRepeatMode.one,
      }[_audioPlayer.loopMode]!,
      shuffleMode: _audioPlayer.shuffleModeEnabled
          ? AudioServiceShuffleMode.all
          : AudioServiceShuffleMode.none,
    );
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
