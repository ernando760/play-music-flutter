import 'package:flutter/material.dart';
import 'package:play_music/src/modules/shared/controllers/base_play_music_controller.dart';
import 'package:play_music/src/modules/shared/widgets/base_play_music_builder_widget.dart';

class PlayMusicNotifierBuilderWidget<T> extends BasePlayMusicBuilderWidget<T> {
  const PlayMusicNotifierBuilderWidget({
    required this.controller,
    super.key,
    this.onInitial,
    super.onLoading,
    super.onSuccess,
    super.onError,
  });

  final BaseNotifierPlayMusicController<T> controller;
  final Widget Function()? onInitial;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        if (onInitial != null) {
          return onInitial!.call();
        }
        if (onLoading != null) {
          return onLoading!.call();
        }
        if (onSuccess != null) {
          return onSuccess!.call(controller.value);
        }
        if (onError != null) {
          return onError!.call();
        }
        return Container();
      },
    );
  }
}
