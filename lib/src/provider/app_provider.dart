import 'package:audio_service/audio_service.dart';
import 'package:play_music/src/pages/audio_dashboard_page/controllers/repeat_mode_controller.dart';
import 'package:play_music/src/pages/audio_dashboard_page/controllers/shuflle_mode_controller.dart';
import 'package:play_music/src/theme/theme_app.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppProvider {
  static final List<SingleChildWidget> children = [
    ChangeNotifierProvider(
      create: (context) => RepeatModeController(AudioServiceRepeatMode.none),
    ),
    ChangeNotifierProvider(
      create: (context) => ShuffleModeController(AudioServiceShuffleMode.none),
    ),
    ChangeNotifierProvider(
      create: (context) => ThemeApp(),
    )
  ];
}
