import 'package:flutter/material.dart';
import 'package:play_music/src/modules/shared/controllers/base_play_music_controller.dart';
import 'package:play_music/src/modules/shared/widgets/base_play_music_builder_widget.dart';

class PlayMusicStreamBuilderWidget<T> extends BasePlayMusicBuilderWidget<T> {
  const PlayMusicStreamBuilderWidget({
    super.key,
    required this.streamController,
    super.onLoading,
    super.onSuccess,
    super.onError,
    this.initialData,
  });
  final T? initialData;
  final BaseStreamPlayMusicController<T> streamController;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: streamController.value,
      initialData: initialData,
      builder: (context, snapshot) {
        if (snapshot.hasError && onError != null) {
          return onError!();
        }
        return switch (snapshot.connectionState) {
          ConnectionState.waiting => onLoading?.call() ?? Container(),
          ConnectionState.active =>
            onSuccess?.call(snapshot.data as T) ?? Container(),
          _ => Container()
        };
      },
    );
  }
}
