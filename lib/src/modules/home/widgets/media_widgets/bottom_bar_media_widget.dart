import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:play_music/src/modules/home/controllers/media_controller.dart';
import 'package:play_music/src/modules/home/widgets/animated_widgets/animated_title_media_widget.dart';
import 'package:play_music/src/modules/home/widgets/media_controls_buttons_widgets.dart/play_and_pause_button_widget.dart';
import 'package:play_music/src/modules/home/widgets/media_controls_buttons_widgets.dart/skip_to_next_button_widget.dart';
import 'package:play_music/src/modules/home/widgets/media_controls_buttons_widgets.dart/skip_to_previous_button_widget.dart';
import 'package:play_music/src/modules/home/widgets/media_widgets/artwork_media_widget.dart';
import 'package:play_music/src/modules/shared/extensions/context_theme_extension.dart';
import 'package:play_music/src/modules/shared/widgets/play_music_stream_builder_widget.dart';

class BottomBarMediaWidget extends StatelessWidget {
  const BottomBarMediaWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<MediaController>();
    return PlayMusicStreamBuilderWidget(
      streamController: controller,
      onSuccess: (media) {
        return Visibility(
          visible: media.id.isNotEmpty,
          child: BottomAppBar(
            child: InkWell(
                onTap: () => Modular.to.pushNamed("/media"),
                child: Container(
                  padding: const EdgeInsets.all(3),
                  child: Row(
                    children: [
                      media.artUri != null
                          ? ArtworkMediaWidget(
                              art: media.artUri!.data!.contentAsBytes(),
                              width: context.width * .2,
                              height: context.height * .6,
                              boxFit: BoxFit.cover,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                            )
                          : Container(),
                      SizedBox(
                        width: context.width * .01,
                      ),
                      Expanded(
                        child: AnimatedTitleMediaWidget(
                          title: media.title,
                          aspectRatio: 4 / .5,
                          style: const TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SkipToPreviousButtonWidget(
                        size: 20,
                      ),
                      const PlayAndPauseButton(
                        size: 20,
                      ),
                      const SkipToNextButtonWidget(
                        size: 20,
                      )
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }
}
