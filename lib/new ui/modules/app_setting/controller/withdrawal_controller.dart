import 'dart:developer';

import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/helper/toast_helper.dart';
import 'package:finutss/new%20ui/modules/app_setting/model/success_model.dart';
import 'package:finutss/new%20ui/modules/app_setting/service/withdrawal_service.dart';
import 'package:finutss/new%20ui/modules/app_setting/widget/withdrawal_complate_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/record/model/workout_status_model.dart';
import 'package:finutss/new%20ui/modules/record/service/user_service.dart';
import 'package:finutss/new%20ui/modules/record/service/weight_record_service.dart';
import 'package:finutss/new%20ui/modules/sign_in/model/login_model.dart';
import 'package:finutss/new%20ui/modules/sign_in/model/user_model.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/widget/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WithdrawalController extends GetxController {
  Rx<WorkoutStatusModel> workoutModel = WorkoutStatusModel().obs;
  Rx<LoginModel> userModel = LoginModel().obs;

  TextEditingController passController = TextEditingController();
  TextEditingController initialCodeController = TextEditingController();
  RxBool initialColor = false.obs;
  RxBool isShow = false.obs;

  @override
  void onInit() {
    getUserName();
    getUserInfo().then((value) => getWorkoutStatus());
    super.onInit();
  }

  var userName = '...'.obs;

  Future<void> getUserName() async {
    LogInUser? user = await SharedPrefs.getUser();
    userName.value = user?.name ?? "";
  }

  List<Color> colorList = [
    AppColor.purple,
    AppColor.green,
    AppColor.blue,
    AppColor.pink,
    AppColor.green,
    AppColor.pink,
    AppColor.purple,
    AppColor.blue,
  ];

  List<String> reasonList = [
    "I_DONT_HAVE_TIME_TO_WORKOUT".tr,
    "LACK_OF_WORKOUT_CONTENT".tr,
    "SERVICE_DISRUPTIONS_A_LOT_OF_ERRORS".tr,
    "USE_OTHER_SERVICES".tr,
    "ITS_HARD_TO_USE_THE_SERVICE_AND_ITS_UNCOMFORTABLE".tr,
    "OTHER_REASONS".tr,
  ];
  RxInt selectedIndex = (-1).obs;
  RxBool isShowPassword = false.obs;
  RxBool enableEnterBtn = false.obs;
  TextEditingController passwordController = TextEditingController();
  TextEditingController approveController = TextEditingController();
  RxBool isFamiliar = false.obs;

  void getWithdrawal() async {
    try {
      AppLoader(Get.context!);
      Map<String, dynamic> body = {
        "reason": reasonList[selectedIndex.value].toString(),
      };
      if (passwordController.text.toString().isNotEmpty) {
        body['password'] = passwordController.text.toString();
      }
      SuccessModel model = await WithdrawalService.withdrawal(body: body);
      RemoveAppLoader();
      if (model.statusCode == Constants.successCode200) {
        withdrawalComplateBottomSheet(Get.context!);
      }else if(model.statusCode==403){
        AppToast.showSnackBar(title: '', message: model.error);
      }
    } catch (e, st) {
      RemoveAppLoader();
      log("Error Message: $e : $st");
    }
  }

  Future<WorkoutStatusModel> getWorkoutStatus() async {
    try {
      DateTime endDate = DateTime.now();
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String formattedEndDate = formatter.format(endDate);
      Map<String, dynamic> body = {
        "startDate": userModel.value.data?.createdAt ??
            formattedEndDate + 'T23:59:59.000',
        "endDate": formattedEndDate + 'T23:59:59.000'
      };
      WorkoutStatusModel model = await WeightRecordService.workoutStatus(body);

      if (model.statusCode == Constants.successCode200) {
        workoutModel.value = model;
      }
      return model;
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {}
    return WorkoutStatusModel();
  }

  Future getUserInfo() async {
    try {
      userModel.value = await UserService.getUserInfo();
      if (userModel.value.statusCode == Constants.successCode200) {
        if (userModel.value.data?.bmi != null) {
          Constants.isBodyInfoSelected.value = true;
        }
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {}
  }
}
