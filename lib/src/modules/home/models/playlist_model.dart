import 'package:play_music/src/modules/shared/models/media_model.dart';

class PlaylistModel {
  final List<MediaModel> medias;

  PlaylistModel({required this.medias});

  PlaylistModel copyWith({
    List<MediaModel>? medias,
  }) {
    return PlaylistModel(
      medias: medias ?? this.medias,
    );
  }

  factory PlaylistModel.empty() {
    return PlaylistModel(medias: []);
  }
}
