import 'package:flutter_modular/flutter_modular.dart';
import 'package:play_music/main.dart';
import 'package:play_music/src/modules/shared/services/audio/audio_services_impl.dart';
import 'package:play_music/src/modules/shared/services/permissions/handler_permission.dart';
import 'package:play_music/src/modules/shared/services/audio/i_audio_services.dart';
import 'package:play_music/src/modules/shared/services/permissions/i_permission_service.dart';
import 'package:play_music/src/modules/shared/services/songs/i_songs_service.dart';
import 'package:play_music/src/modules/shared/services/songs/songs_service_impl.dart';
import 'package:play_music/src/modules/shared/theme/theme_app.dart';

class SharedModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addSingleton<ThemeApp>(ThemeApp.new,
        config: BindConfig(onDispose: (value) => value.dispose()));
    i.addSingleton<IAudioServices>(AudioServicesImpl(audioHandler));
    i.add<ISongsService>(SongsServiceImpl.new);
    i.addSingleton<IPermissionService>(HandlerPemissionService.new);
  }
}
