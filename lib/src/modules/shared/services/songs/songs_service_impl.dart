import 'dart:developer';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:play_music/src/modules/shared/models/media_model.dart';
import 'package:play_music/src/modules/shared/services/songs/i_songs_service.dart';

class SongsServiceImpl implements ISongsService {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  Future<List<MediaModel>> querySongs() async {
    try {
      List<MediaModel> playlist = [];

      final querySongsfutures = [
        _audioQuery.querySongs(
          sortType: null,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        ),
        _audioQuery.querySongs(
          sortType: null,
          uriType: UriType.INTERNAL,
          orderType: OrderType.ASC_OR_SMALLER,
          ignoreCase: true,
        )
      ];
      final songsFull = await Future.wait(querySongsfutures);
      final songs = [...songsFull[0], ...songsFull[1]];

      for (var song in songs) {
        var artBytes = await _audioQuery.queryArtwork(
          song.id,
          ArtworkType.AUDIO,
        );

        if (artBytes != null) {
          final uri = Uri.dataFromBytes(artBytes);
          if (uri.data != null) {
            var mediaModel = MediaModel.fromSong(song).copyWith(
                id: song.data,
                artUri: () => uri,
                duration: () =>
                    Duration(microseconds: (song.duration! * 1000).toInt()));

            playlist.add(mediaModel);
          }
        }
      }
      return playlist;
    } catch (e) {
      log("ERROR getSongs: ${e.toString()}");
      return [];
    }
  }
}
