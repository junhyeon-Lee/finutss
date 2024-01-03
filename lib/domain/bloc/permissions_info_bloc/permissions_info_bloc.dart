import 'package:finutss/domain/bloc/permissions_info_bloc/permissions_info_event.dart';
import 'package:finutss/domain/bloc/permissions_info_bloc/permissions_info_state.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PermissionsInfoBloc extends Bloc<PermissionsInfoEvent, PermissionsInfoState> {

  PermissionsInfoBloc() : super(PermissionsInfoInitialState()) {
    on<PermissionsInfoGetPermission>(_mapInitialState);
  }


  void _mapInitialState(PermissionsInfoGetPermission event,
      Emitter<PermissionsInfoState> emit) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.microphone,
      Permission.bluetooth,
      Permission.notification,
      Permission.camera,
    ].request();
  }
}