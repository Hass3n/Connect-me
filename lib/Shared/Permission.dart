
import 'package:permission_handler/permission_handler.dart';
import 'package:socialapp/Shared/Components.dart';

class GetPermission
{
  // Permission Cemara

  static Future<bool> getCameraPermission() async
  {

    PermissionStatus permissionStatus=await Permission.camera.status;
    if(permissionStatus.isGranted)
      {
        return true;
      }
    else if(permissionStatus.isDenied)
      {
        PermissionStatus status=await Permission.camera.request();
        if(status.isGranted)
          {
            return true;
          }
        else
          {
            ShowToast(text: "Camera permission is required",state: Toaststate.WARNING);
            return false;

          }

      }

    return false;

  }
  static Future<bool> getStoragePermission() async
  {

    PermissionStatus permissionStatus=await Permission.storage.status;
    if(permissionStatus.isGranted)
      {
        return true;
      }
    else if(permissionStatus.isDenied)
      {
        PermissionStatus status=await Permission.storage.request();
        if(status.isGranted)
          {
            return true;
          }
        else
          {
            ShowToast(text: "Storage permission is required",state: Toaststate.WARNING);
            return false;

          }

      }

    return false;

  }
  static Future<bool> getNotifcationPermission() async
  {

    PermissionStatus permissionStatus=await Permission.notification.status;
    if(permissionStatus.isGranted)
    {
      return true;
    }
    else if(permissionStatus.isDenied)
    {
      PermissionStatus status=await Permission.notification.request();
      if(status.isGranted)
      {
        return true;
      }
      else
      {
        ShowToast(text: "Storage permission is required",state: Toaststate.WARNING);
        return false;

      }

    }

    return false;

  }
}