import 'package:play_music/src/modules/shared/services/audio/i_audio_services.dart';

class SkipMediaController {
  final IAudioServices _audioServices;

  SkipMediaController(this._audioServices);

  Future<void> skipToNext() async => await _audioServices.skipToNext();

  Future<void> skipToPrevious() async => await _audioServices.skipToPrevious();
}
