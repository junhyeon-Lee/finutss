import 'package:finutss/new%20ui/controller/new_sensor_controller.dart';
import 'package:finutss/new%20ui/modules/app_setting/controller/black_list_controller.dart';
import 'package:finutss/new%20ui/modules/connection/controller/connection_controller.dart';
import 'package:finutss/new%20ui/controller/login_controller.dart';
import 'package:finutss/new%20ui/modules/photo_video/controller/photo_video_controller.dart';
import 'package:finutss/new%20ui/modules/privacy_policy_terms_condition/controller/policy_controller.dart';
import 'package:finutss/new%20ui/modules/profile/controller/edit_profile_controller.dart';
import 'package:finutss/new%20ui/modules/record/controller/bmi_slider_controller.dart';
import 'package:finutss/new%20ui/modules/store/controller/store_controller.dart';
import 'package:finutss/new%20ui/modules/user_guide/controller/user_guide_controller.dart';
import 'package:get/get.dart';

class AppBidding extends Bindings {
  @override
  void dependencies() {
    Get.put<ConnectionController>(ConnectionController());
    Get.put<LoginController>(LoginController());
    Get.put<UserGuideController>(UserGuideController());
    Get.put<EditProfileController>(EditProfileController());
    Get.put<BlackListController>(BlackListController());
    Get.put<NewSensorController>(NewSensorController());
    Get.put<BmiSliderController>(BmiSliderController());
    Get.put<PolicyController>(PolicyController());
    Get.put<PhotoVideoController>(PhotoVideoController());
  }
}
