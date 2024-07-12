import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:play_music/src/modules/home/controllers/repeat_mode_controller.dart';
import 'package:play_music/src/modules/shared/services/enums/repeat_mode_enum.dart';
import 'package:play_music/src/modules/shared/widgets/play_music_notifier_builder_widget.dart';

class RepeatModeButtonWidget extends StatelessWidget {
  const RepeatModeButtonWidget({
    Key? key,
    this.size = 30,
  }) : super(key: key);
  final double size;

  @override
  Widget build(BuildContext context) {
    final repeatControler = Modular.get<RepeatModeController>();
    return PlayMusicNotifierBuilderWidget(
      controller: repeatControler,
      onSuccess: (repeatMode) {
        return IconButton(
            iconSize: size,
            onPressed: () async {
              await repeatControler.setRepeatMode(repeatMode);
            },
            icon: repeatMode == RepeatMode.none
                ? const Icon(Icons.repeat)
                : const Icon(
                    Icons.repeat_one,
                    size: 32,
                    color: Colors.white,
                  ));
      },
    );
  }
}
