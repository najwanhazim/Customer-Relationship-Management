import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_permission.dart';

class AsyncHelper {
  AsyncHelper._();

 
}

Future<SharedPreferences> getSharedPreference() => SharedPreferences.getInstance();

Future<bool>checkPermissionList() async {

  List<Permission> permissionList = await getPermissionList();

  bool isGranted = true;
  for(Permission permission in permissionList) {
    isGranted = isGranted && await permission.isGranted;
  }

  return isGranted;
}