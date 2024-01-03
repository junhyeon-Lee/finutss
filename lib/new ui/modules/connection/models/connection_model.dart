import 'package:get/get.dart';

class ConnectionModel {
  final String topPrefixIcon;
  final String bluetoothName;
  final String bluetoothNumber;
  final String networkIcon;
  RxBool isConnect = false.obs;
  ConnectionModel({
    required this.topPrefixIcon,
    required this.bluetoothName,
    required this.bluetoothNumber,
    required this.networkIcon,
    required this.isConnect,
  });
}

class ChoosePositionModel {
  final String position;
  final String positionDescription;
  final String buttonName;
  final String completeDes;
  final String completeButtonTitle;
  RxBool isSelected;
  RxBool icChoose;

  ChoosePositionModel({required this.position, required this.positionDescription, required this.buttonName,
      required this.completeDes, required this.completeButtonTitle, required this.isSelected,required this.icChoose});
}
