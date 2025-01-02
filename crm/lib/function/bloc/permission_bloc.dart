import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../db/permission_list.dart';

part 'permission_event.dart';
part 'permission_state.dart';

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  PermissionBloc() : super(PermissionInitial()) {
    on<PermissionListener>((event, emit) async {
      try {
        if (event.permissionList == null) {
          emit(PermissionLoading());
        }
        List<PermissionList> permissionList = await PermissionList.generatePermissionList();
        emit(PermissionLoaded(permissionList));
      } on Exception catch (e) {
        emit(PermissionError(e.toString()));
      }
    });
  }
}
