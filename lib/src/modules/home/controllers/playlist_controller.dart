import 'package:play_music/src/modules/home/models/playlist_model.dart';
import 'package:play_music/src/modules/home/states/playlist_state.dart';
import 'package:play_music/src/modules/shared/controllers/base_play_music_controller.dart';
import 'package:play_music/src/modules/shared/services/audio/i_audio_services.dart';

class PlaylistController
    extends BaseNotifierPlayMusicController<PlaylistState> {
  PlaylistController(this._audioServices) : super(InitialPlaylistState());
  final IAudioServices _audioServices;
  PlaylistModel _playlist = PlaylistModel.empty();

  PlaylistModel get playlist => _playlist;

  void getPlaylist() {
    _playlist = _playlist.copyWith(medias: _audioServices.getMedias());
    updateValue(SuccessPlaylistState(data: _playlist));
  }
}
