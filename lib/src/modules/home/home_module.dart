import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:play_music/src/modules/home/controllers/media_controller.dart';
import 'package:play_music/src/modules/home/controllers/play_and_pause_controller.dart';
import 'package:play_music/src/modules/home/controllers/playlist_controller.dart';
import 'package:play_music/src/modules/home/controllers/repeat_mode_controller.dart';
import 'package:play_music/src/modules/home/controllers/seek_controller.dart';
import 'package:play_music/src/modules/home/controllers/shuflle_mode_controller.dart';
import 'package:play_music/src/modules/home/controllers/skip_media_controller.dart';
import 'package:play_music/src/modules/home/pages/home_page.dart';
import 'package:play_music/src/modules/home/pages/media_page.dart';
import 'package:play_music/src/modules/shared/services/audio/i_audio_services.dart';
import 'package:play_music/src/modules/shared/services/permissions/handler_permission.dart';
import 'package:play_music/src/modules/shared/services/permissions/i_permission_service.dart';
import 'package:play_music/src/modules/shared/services/songs/i_songs_service.dart';
import 'package:play_music/src/modules/shared/shared_module.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports => [SharedModule()];
  @override
  void binds(Injector i) async {
    i.addSingleton<MediaController>(MediaController.new,
        config:
            BindConfig(onDispose: (value) async => await value.lazyDispose()));
    i.addSingleton<PlaylistController>(PlaylistController.new);
    i.add<PlayAndPauseController>(PlayAndPauseController.new,
        config: BindConfig(onDispose: (value) => value.lazyDispose()));
    i.add<SkipMediaController>(SkipMediaController.new);
    i.add<ShuffleModeController>(ShuffleModeController.new,
        config: BindConfig(onDispose: (value) => value.lazyDispose()));
    i.add<RepeatModeController>(RepeatModeController.new,
        config: BindConfig(onDispose: (value) => value.lazyDispose()));
    i.add<SeekController>(SeekController.new,
        config: BindConfig(onDispose: (value) => value.lazyDispose()));
  }

  @override
  void routes(RouteManager r) {
    final permission = Modular.get<IPermissionService>();
    r.child(
      Modular.initialRoute,
      child: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          final status =
              await permission.requestPermission({RequestPermission.storage});

          if (status == RequestPermissionStatus.granted) {
            await Modular.get<IAudioServices>().addMediasInPlaylist(
                await Modular.get<ISongsService>().querySongs());
          }
          log(status.toString(), name: "Permission Status");
          Modular.get<PlaylistController>().getPlaylist();
        });

        return const HomePage();
      },
    );
    r.child(
      "/media",
      child: (context) {
        return const MediaPage();
      },
    );
  }
}
