import 'package:play_music/src/modules/shared/models/media_model.dart';

class PositionState {
  final MediaModel mediaModel;
  final Duration position;

  PositionState({required this.mediaModel, required this.position});

  @override
  String toString() =>
      "$runtimeType(mediaModel: ${mediaModel.title}, position: $position)";
}
