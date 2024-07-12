import 'package:play_music/src/modules/shared/state/base_state.dart';

abstract class PlaylistState extends BaseState {}

class InitialPlaylistState extends PlaylistState {}

class LoadingPlaylistState extends PlaylistState {}

class SuccessPlaylistState<T> extends PlaylistState {
  final T data;

  SuccessPlaylistState({required this.data});
}

class FailurePlaylistState extends PlaylistState {}
