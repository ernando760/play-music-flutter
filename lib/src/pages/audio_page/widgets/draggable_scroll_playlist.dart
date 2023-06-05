import 'package:flutter/material.dart';
import 'package:play_music/main.dart';
import 'package:play_music/src/extensions/context_theme_extension.dart';

import '../../audio_dashboard_page/widgets/card_audio_info.dart';

class DraggableScrollPlaylist extends StatefulWidget {
  const DraggableScrollPlaylist({super.key});

  @override
  State<DraggableScrollPlaylist> createState() =>
      _DraggableScrollPlaylistState();
}

class _DraggableScrollPlaylistState extends State<DraggableScrollPlaylist> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: DraggableScrollableSheet(
          initialChildSize: 0.1,
          minChildSize: .1,
          maxChildSize: 1,
          builder: (context, scrollController) {
            return Stack(
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: context.theme.colorScheme.background,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20))),
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: audioHandler.queue.value.length,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 80),
                            child: CardAudioInfo(
                              mediaItem: audioHandler.queue.value[index],
                            ),
                          );
                        }
                        return CardAudioInfo(
                          mediaItem: audioHandler.queue.value[index],
                        );
                      },
                    )),

                //this section is your header
                IgnorePointer(
                    child: Container(
                  decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20))),
                  height: 70,
                  child: AppBar(
                    shadowColor: context.theme.shadowColor,
                    shape: const UnderlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(10))),
                    backgroundColor: context.theme.appBarTheme.backgroundColor,
                    clipBehavior: Clip.hardEdge,
                    title: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: context.theme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(10)),
                        width: 70,
                        height: 5,
                      ),
                    ),

                    automaticallyImplyLeading:
                        false, //this prevents the appBar from having a close button (that button wouldn't work because of IgnorePointer)
                  ),
                )),
              ],
            );
          }),
    );
  }
}
