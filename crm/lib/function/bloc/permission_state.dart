part of 'permission_bloc.dart';

abstract class PermissionState extends Equatable {
  const PermissionState();
}

class PermissionInitial extends PermissionState {
  @override
  List<Object> get props => [];
}

class PermissionLoading extends PermissionState {
  @override
  List<Object> get props => [];
}

class PermissionLoaded extends PermissionState {
  final List<PermissionList> permissionList;

  const PermissionLoaded(this.permissionList);
  @override
  List<Object> get props => [permissionList];
}

class PermissionError extends PermissionState {
  final String message;

  const PermissionError(this.message);
  @override
  List<Object> get props => [message];
}
