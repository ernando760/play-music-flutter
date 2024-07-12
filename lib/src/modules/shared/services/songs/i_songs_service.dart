import 'package:play_music/src/modules/shared/models/media_model.dart';

abstract class ISongsService {
  Future<List<MediaModel>> querySongs();
}
