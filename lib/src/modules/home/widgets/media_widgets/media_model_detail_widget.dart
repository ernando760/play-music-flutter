import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:play_music/src/modules/home/widgets/animated_widgets/animated_title_media_widget.dart';
import 'package:play_music/src/modules/home/widgets/media_controls_buttons_widgets.dart/media_controls_buttons_widget.dart';
import 'package:play_music/src/modules/home/widgets/media_widgets/artwork_media_widget.dart';
import 'package:play_music/src/modules/home/widgets/progess_bar_widget/progress_bar_widget.dart';
import 'package:play_music/src/modules/shared/extensions/context_theme_extension.dart';
import 'package:play_music/src/modules/shared/models/media_model.dart';

class MediaModelDetailWidget extends StatelessWidget {
  const MediaModelDetailWidget({super.key, required this.media});
  final MediaModel media;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Artwork audio
          Center(
              child: ArtworkMediaWidget(
            art: media.artUri!.data!.contentAsBytes(),
            width: context.width * .9,
            height: context.height * .5,
            cacheHeight: (context.height * .5).toInt(),
            boxFit: BoxFit.cover,
            cacheWidth: (context.width * .8).toInt(),
          )),

          SizedBox(
            height: context.height * .02,
          ),
          // Animated Title
          AnimatedTitleMediaWidget(
            title: media.title,
            style: const TextStyle(
                fontSize: 20,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: context.height * .02,
          ),
          // Pregress Bar
          ProgressBarWidget(media: media),
          // Media Controls,
          const MediaControlsButtonsWidget(),
        ],
      ),
    );
  }
}
