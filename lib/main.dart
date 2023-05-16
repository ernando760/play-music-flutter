// ignore_for_file: avoid_print

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:play_music/app.dart';
import 'package:play_music/src/provider/app_provider.dart';
import 'package:play_music/src/services/audio_handler.dart';
import 'package:play_music/src/services/handler_permission.dart';
import 'package:provider/provider.dart';

late final AudioHandler audioHandler;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;

  audioHandler = await initAudioServices();

  await HandlerPemission.handlerPermission();

  runApp(MultiProvider(
    providers: AppProvider.children,
    child: const App(),
  ));
}
