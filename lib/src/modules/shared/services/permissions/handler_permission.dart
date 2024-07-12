import 'dart:developer';
import 'package:permission_handler/permission_handler.dart';
import 'package:play_music/src/modules/shared/services/permissions/i_permission_service.dart';

enum RequestPermission {
  storage,
  audio;
}

enum RequestPermissionStatus {
  none,
  granted,
  denied,
  permanentlyDenied;
}

class HandlerPemissionService implements IPermissionService {
  final RequestPermissionStatus _status = RequestPermissionStatus.none;
  @override
  RequestPermissionStatus get status => _status;
  final Map<RequestPermission, Permission> _permissions = {
    RequestPermission.storage: Permission.storage,
    RequestPermission.audio: Permission.audio
  };
  @override
  Future<bool> isGranted(RequestPermission requestPermission) async {
    final permission = _permissions[requestPermission];
    if (permission != null) {
      return await permission.isGranted;
    }
    return false;
  }

  @override
  Future<bool> isDenied(RequestPermission requestPermission) async {
    final permission = _permissions[requestPermission];
    if (permission != null) {
      return await permission.isDenied;
    }
    return false;
  }

  @override
  Future<bool> isPermanentlyDenied(RequestPermission requestPermission) async {
    final permission = _permissions[requestPermission];
    if (permission != null) {
      return await permission.isPermanentlyDenied;
    }
    return false;
  }

  @override
  Future<RequestPermissionStatus> requestPermission(
      Set<RequestPermission> permissions) async {
    try {
      PermissionStatus permissionStatus = PermissionStatus.denied;
      for (var requestPermission in permissions) {
        final permission = _permissions[requestPermission]!;
        permissionStatus = await permission.request();
        switch (permissionStatus) {
          case PermissionStatus.granted:
            return RequestPermissionStatus.granted;

          case PermissionStatus.denied:
            return RequestPermissionStatus.denied;
          case PermissionStatus.permanentlyDenied:
            return RequestPermissionStatus.permanentlyDenied;
          default:
            return RequestPermissionStatus.none;
        }
      }
      return RequestPermissionStatus.none;
    } catch (e, s) {
      log(e.toString(), error: "ERROR PERMISSIONS", stackTrace: s);
      return RequestPermissionStatus.none;
    }
  }
}
