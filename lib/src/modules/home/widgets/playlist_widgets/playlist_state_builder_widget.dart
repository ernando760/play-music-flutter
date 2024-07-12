import 'package:flutter/material.dart';
import 'package:play_music/src/modules/home/states/playlist_state.dart';
import 'package:play_music/src/modules/shared/controllers/base_play_music_controller.dart';

class PlaylistStateBuilderWidget<T> extends StatelessWidget {
  const PlaylistStateBuilderWidget({
    super.key,
    required this.controller,
    this.onInitial,
    this.onLoading,
    this.onSuccess,
    this.onError,
  });

  final BaseNotifierPlayMusicController<PlaylistState> controller;
  final Widget Function()? onInitial;
  final Widget Function()? onLoading;
  final Widget Function(T data)? onSuccess;
  final Widget Function()? onError;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return switch (controller.value) {
          InitialPlaylistState() =>
            onInitial != null ? onInitial!.call() : Container(),
          LoadingPlaylistState() =>
            onLoading != null ? onLoading!.call() : Container(),
          SuccessPlaylistState<T>(:final data) =>
            onSuccess != null ? onSuccess!.call(data) : Container(),
          FailurePlaylistState() =>
            onError != null ? onError!.call() : Container(),
          _ => Container()
        };
      },
    );
  }
}
