import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:play_music/src/modules/home/controllers/media_controller.dart';
import 'package:play_music/src/modules/home/widgets/media_widgets/artwork_media_widget.dart';
import 'package:play_music/src/modules/shared/extensions/context_theme_extension.dart';
import 'package:play_music/src/modules/shared/models/media_model.dart';

class CardMediaInfoWidget extends StatelessWidget {
  const CardMediaInfoWidget({
    Key? key,
    required this.media,
    required this.isPlayingMedia,
  }) : super(key: key);
  final MediaModel media;
  final bool isPlayingMedia;

  @override
  Widget build(BuildContext context) {
    final mediaController = Modular.get<MediaController>();
    return InkWell(
      onTap: () async {
        Modular.to.pushNamed("/media");
        if (isPlayingMedia == false) {
          await mediaController.playMedia(media);
          return;
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: context.width,
        height: 70,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ArtworkMediaWidget(
              art: media.artUri!.data!.contentAsBytes(),
              width: context.width * .2,
              height: context.height * .2,
              cacheWidth: (context.width * .6).toInt(),
              cacheHeight: (context.height * .6).toInt(),
              boxFit: BoxFit.cover,
            ),
            SizedBox(
              width: context.height * .01,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      media.title,
                      style: TextStyle(
                          fontSize: 18,
                          overflow: TextOverflow.ellipsis,
                          color: isPlayingMedia
                              ? context.theme.colorScheme.primary
                              : null),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      media.artist ?? "",
                      style: TextStyle(
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                          color: isPlayingMedia
                              ? context.theme.colorScheme.primary
                              : context.theme.colorScheme.onSecondaryContainer),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
