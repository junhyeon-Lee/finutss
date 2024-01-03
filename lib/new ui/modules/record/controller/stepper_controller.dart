import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class StepperController extends GetxController {
  int stepLength = 7;
  RxInt currentStep = 1.obs;


  next() {
    if (currentStep.value <= stepLength) {
      currentStep.value++;
    }
  }

}
