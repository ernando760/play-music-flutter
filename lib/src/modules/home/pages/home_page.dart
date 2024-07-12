import 'package:flutter/material.dart';
import 'package:play_music/src/modules/home/widgets/media_widgets/bottom_bar_media_widget.dart';
import 'package:play_music/src/modules/home/widgets/playlist_widgets/playlist_widget.dart';
import 'package:play_music/src/modules/shared/widgets/change_theme_button_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerHeader(
              child: ChangeThemeButtonWidget(),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text(
          "Minhas Músicas",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [ChangeThemeButtonWidget()],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const SafeArea(
        child: Stack(
          children: [
            PlaylistWidget(),
            Align(
                alignment: Alignment.bottomCenter,
                child: BottomBarMediaWidget()),
          ],
        ),
      ),
      // bottomNavigationBar: ,
    );
  }
}
