import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:play_music/src/modules/home/controllers/shuflle_mode_controller.dart';
import 'package:play_music/src/modules/shared/services/enums/shuffle_mode_enum.dart';
import 'package:play_music/src/modules/shared/widgets/play_music_notifier_builder_widget.dart';

class ShuffleModeButtonWidget extends StatelessWidget {
  const ShuffleModeButtonWidget({super.key, this.size = 30});
  final double size;

  @override
  Widget build(BuildContext context) {
    final shuffleController = Modular.get<ShuffleModeController>();
    return PlayMusicNotifierBuilderWidget(
      controller: shuffleController,
      onSuccess: (shuffleMode) {
        return IconButton(
            iconSize: size,
            onPressed: () async => await shuffleController.setShuffleMode(
                shuffleMode: shuffleMode),
            icon: shuffleMode == ShuffleMode.none
                ? const Icon(
                    Icons.shuffle,
                  )
                : const Icon(
                    Icons.shuffle,
                    size: 32,
                    color: Colors.white,
                  ));
      },
    );
  }
}
