import 'package:get/get.dart';

class ConnectionController extends GetxController {
  RxBool isRescan = false.obs;
  RxBool isSelectedType = false.obs;
  RxInt selectedOption = 0.obs;
  RxInt selectedIndex = 0.obs;
  RxBool male = false.obs;
  RxBool female = false.obs;
  RxString selectWheelSize = '[Indooe-Auto]'.obs;
  // Rx<MobileDevice> selectedType = MobileDevice.defaults.obs;

}
