import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

Future<List<Permission>> getPermissionList() async {
  List<Permission> permissionList = [
    Permission.contacts,
    Permission.locationWhenInUse,
    Permission.reminders,
  ];

  if(Platform.isAndroid && (await DeviceInfoPlugin().androidInfo).version.sdkInt >= 33) {
    permissionList.add(Permission.photos);
    permissionList.add(Permission.notification);
  }

  return permissionList;
}