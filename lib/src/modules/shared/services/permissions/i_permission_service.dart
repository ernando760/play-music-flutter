import 'package:play_music/src/modules/shared/services/permissions/handler_permission.dart';

abstract class IPermissionService {
  RequestPermissionStatus get status;
  Future<RequestPermissionStatus> requestPermission(
      Set<RequestPermission> permissions);

  Future<bool> isGranted(RequestPermission requestPermission);
  Future<bool> isDenied(RequestPermission requestPermission);
  Future<bool> isPermanentlyDenied(RequestPermission requestPermission);
}
