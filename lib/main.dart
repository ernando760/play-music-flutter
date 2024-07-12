import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:play_music/app.dart';
import 'package:play_music/app_module.dart';
import 'package:play_music/src/modules/shared/services/audio/audio_handler.dart';

late final MyAudioHandler audioHandler;

void main() async {
  audioHandler = await initAudioServices();
  runApp(ModularApp(
    module: AppModule(),
    child: const App(),
  ));
}
