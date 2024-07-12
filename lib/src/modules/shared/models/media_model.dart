import 'package:flutter/material.dart';

import 'package:audio_service/audio_service.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MediaModel {
  final String id;
  final String title;
  final String? album;
  final Uri? artUri;
  final String? artist;
  final String? genre;
  final Duration? duration;
  MediaModel(
      {required this.id,
      required this.title,
      this.album,
      this.artist,
      this.genre,
      this.artUri,
      this.duration});

  factory MediaModel.fromMediaItem(MediaItem mediaItem) {
    return MediaModel(
        id: mediaItem.id,
        title: mediaItem.title,
        album: mediaItem.album,
        genre: mediaItem.genre,
        artist: mediaItem.artist,
        artUri: mediaItem.artUri,
        duration: mediaItem.duration);
  }
  factory MediaModel.fromSong(SongModel song) {
    return MediaModel(
        id: "${song.id}",
        title: song.title,
        album: song.album,
        genre: song.genre,
        artist: song.artist,
        artUri: Uri.tryParse(song.uri ?? ""),
        duration: Duration(seconds: song.duration ?? 0));
  }

  factory MediaModel.empty() {
    return MediaModel(
        id: "",
        title: "",
        album: null,
        genre: null,
        artist: null,
        artUri: null,
        duration: Duration.zero);
  }

  MediaItem toMediaItem() {
    return MediaItem(
        id: id,
        title: title,
        album: album,
        artist: artist,
        artUri: artUri,
        genre: genre,
        duration: duration);
  }

  @override
  String toString() =>
      "$runtimeType(id: $id,title: $title, album: $album, artist: $artist, artUri: $artUri, genre: $genre, duration: $duration)";

  MediaModel copyWith({
    String? id,
    String? title,
    ValueGetter<String?>? album,
    ValueGetter<Uri?>? artUri,
    ValueGetter<String?>? artist,
    ValueGetter<String?>? genre,
    ValueGetter<Duration?>? duration,
  }) {
    return MediaModel(
      id: id ?? this.id,
      title: title ?? this.title,
      album: album != null ? album() : this.album,
      artUri: artUri != null ? artUri() : this.artUri,
      artist: artist != null ? artist() : this.artist,
      genre: genre != null ? genre() : this.genre,
      duration: duration != null ? duration() : this.duration,
    );
  }
}
