part of 'permission_bloc.dart';

abstract class PermissionEvent extends Equatable {
  const PermissionEvent();
}

class PermissionListener extends PermissionEvent {
  final List<PermissionList>? permissionList;

  const PermissionListener(this.permissionList);

  @override
  List<Object> get props => [];

}