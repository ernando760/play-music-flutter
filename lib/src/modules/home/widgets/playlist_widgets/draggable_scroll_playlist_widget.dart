import 'package:flutter/material.dart';
import 'package:play_music/src/modules/home/widgets/playlist_widgets/playlist_widget.dart';
import 'package:play_music/src/modules/shared/extensions/context_theme_extension.dart';

class DraggableScrollPlaylistWidget extends StatelessWidget {
  const DraggableScrollPlaylistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final DraggableScrollableController controller =
        DraggableScrollableController();
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: DraggableScrollableSheet(
          controller: controller,
          initialChildSize: 0.1,
          minChildSize: .1,
          maxChildSize: 1,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                  color: context.theme.colorScheme.background,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20))),
              child: Stack(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: PlaylistWidget(
                        scrollController: scrollController,
                        separatorBuilder: (context, index) {
                          if (index == 0) {
                            return SizedBox(height: context.height * .03);
                          }
                          return SizedBox(height: context.height * .03);
                        },
                      )),
                  //This section is your header
                  SingleChildScrollView(
                    controller: scrollController,
                    child: Container(
                      decoration: BoxDecoration(
                          color: context.theme.colorScheme.primary,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(20))),
                      width: context.width,
                      height: 50,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                            width: 25,
                            height: 5,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                color: context.theme.colorScheme.onPrimary)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
