// ignore_for_file: avoid_print

import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../main.dart';

class HandlerPemission {
  static final OnAudioQuery _audioQuery = OnAudioQuery();
  static handlerPermission() async {
    try {
      var status = await Permission.storage.request();
      if (status.isDenied) {
        print("Negado");
        await Future.delayed(
          const Duration(seconds: 5),
          handlerPermission,
        );
      }
      if (status.isGranted) {
        print("aceito");

        await audioHandler.addQueueItems(await _loadAudio());
      }
    } catch (e) {
      debugPrint("Error on function: 'handlerPermission'");
      debugPrint(e.toString());
    }
  }

  static Future<List<MediaItem>> _loadAudio() async {
    try {
      List<MediaItem> playlist = [];

      var musics = await _audioQuery.querySongs(
        sortType: null,
        uriType: UriType.EXTERNAL,
        orderType: OrderType.ASC_OR_SMALLER,
        ignoreCase: true,
      );
      for (var music in musics) {
        var art = await _audioQuery.queryArtwork(
          music.id,
          ArtworkType.AUDIO,
        );

        if (art != null) {
          var image =
              await _getTemporaryFile(image: art, nameAudio: music.title);
          var audioModel = MediaItem(
              id: music.data,
              title: music.title,
              artUri: Uri.file(image.path),
              duration:
                  Duration(microseconds: (music.duration! * 1000).toInt()));
          // playlist.add(audioModel);
          playlist.add(audioModel);
        }
      }
      return playlist;
    } catch (e) {
      debugPrint("Error on function: 'loadAudio'");
      debugPrint(e.toString());

      return [];
    }
  }

  static Future<File> _getTemporaryFile(
      {Uint8List? image, String? nameAudio}) async {
    final tempDir = await getTemporaryDirectory();
    var regex = RegExp(r'[^a-zA-Z0-9]');
    var name = nameAudio?.replaceAll(regex, "");
    if (image != null) {
      File file = await File('${tempDir.path}/$name.png').create();
      // print(file.path);
      file.writeAsBytesSync(image);
      return file;
    } else {
      var file = await File("${tempDir.path}/$name.png").create();
      // print(file.path);
      var bytes = await rootBundle
          .load("lib/src/assets/images/backgroundMusicAudio.jpg");
      Uint8List imageBytes =
          bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);

      file.writeAsBytes(imageBytes);
      return file;
    }
  }
}
