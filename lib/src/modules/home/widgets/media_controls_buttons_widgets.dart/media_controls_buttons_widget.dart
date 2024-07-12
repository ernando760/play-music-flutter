import 'package:flutter/material.dart';
import 'package:play_music/src/modules/home/widgets/media_controls_buttons_widgets.dart/play_and_pause_button_widget.dart';
import 'package:play_music/src/modules/home/widgets/media_controls_buttons_widgets.dart/repeat_mode_button_widget.dart';
import 'package:play_music/src/modules/home/widgets/media_controls_buttons_widgets.dart/shuffle_mode_button_widget.dart';
import 'package:play_music/src/modules/home/widgets/media_controls_buttons_widgets.dart/skip_to_next_button_widget.dart';
import 'package:play_music/src/modules/home/widgets/media_controls_buttons_widgets.dart/skip_to_previous_button_widget.dart';

class MediaControlsButtonsWidget extends StatelessWidget {
  const MediaControlsButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShuffleModeButtonWidget(),
        SkipToPreviousButtonWidget(),
        PlayAndPauseButton(),
        SkipToNextButtonWidget(),
        RepeatModeButtonWidget()
      ],
    );
  }
}
