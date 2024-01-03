import 'package:equatable/equatable.dart';

abstract class PermissionsInfoEvent extends Equatable {
  const PermissionsInfoEvent();

  @override
  List<Object> get props => [];
}

class PermissionsInfoGetPermission extends PermissionsInfoEvent {
  const PermissionsInfoGetPermission();

  @override
  List<Object> get props => [];
}

class PermissionsInfoCheckPermission extends PermissionsInfoEvent {
  const PermissionsInfoCheckPermission();

  @override
  List<Object> get props => [];
}
