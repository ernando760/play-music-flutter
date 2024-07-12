import 'package:flutter_modular/flutter_modular.dart';
import 'package:play_music/src/modules/home/home_module.dart';
import 'package:play_music/src/modules/shared/shared_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [SharedModule()];

  @override
  void routes(RouteManager r) {
    r.module(Modular.initialRoute, module: HomeModule());
  }
}
