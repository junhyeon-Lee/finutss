import 'package:get/get.dart';

class AvailableDevicesModel {
  final String bluetoothNumber;
  final String networkIcon;
  RxBool isConnect = false.obs;
  AvailableDevicesModel({
    required this.bluetoothNumber,
    required this.networkIcon,
    required this.isConnect,
  });
}
