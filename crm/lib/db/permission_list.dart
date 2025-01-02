import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../function/repository/app_permission.dart';
import '../utils/app_string_constant.dart';

class PermissionList {
  String headerText;
  String descriptionText;
  bool isExpanded;
  PermissionStatus? permissionState;
  String icon;

  PermissionList({
    required this.headerText,
    required this.descriptionText,
    required this.isExpanded,
    required this.permissionState,
    required this.icon,
  });

  static Future<List<PermissionList>> generatePermissionList() async {

    List<Permission> permissionList = await getPermissionList();
    List<PermissionList> genPermissionList = [];

    for (Permission permission in permissionList) {
      String headerText;
      String descriptionText;
      String icon;

      if (permission == Permission.contacts) {
        headerText = 'Contact';
        descriptionText = AppString.permissionPageContact;
        icon = AppString.contactIcon;
      } else if (permission == Permission.locationWhenInUse) {
        headerText = 'Location';
        descriptionText = AppString.permissionPageLocation;
        icon = AppString.locationIcon;
      } else if (permission == Permission.reminders) {
        headerText = 'Reminder';
        descriptionText = AppString.permissionPageStorage;
        icon = AppString.reminderIcon;
      } else if (permission == Permission.photos) {
        headerText = 'Photo';
        descriptionText = AppString.permissionPhotos;
        icon = AppString.photoIcon;
      } else if (permission == Permission.notification){
        headerText = 'Notification';
        descriptionText = AppString.permissionPageStorage;
        icon = AppString.notificationIcon;
      }else {
        continue;
      }

      genPermissionList.add(PermissionList(
          headerText: headerText,
          descriptionText: descriptionText,
          isExpanded: false,
          permissionState: await permission.status,
          icon: icon));
    }

    return genPermissionList;
  }
}
