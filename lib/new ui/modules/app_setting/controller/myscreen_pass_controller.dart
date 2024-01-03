import 'dart:developer';

import 'package:finutss/new%20ui/modules/change_password/presentation/complate_password_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/sign_in/model/login_model.dart';
import 'package:finutss/new%20ui/modules/sign_in/service/signin_service.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/validation_utils.dart';
import 'package:finutss/new%20ui/widget/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MyScreenPassController extends GetxController {
  TextEditingController currentPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  RxString passErrorMsg = ''.obs;
  RxString newPassErrorMsg = ''.obs;
  RxString confirmPassErrorMsg = ''.obs;
  RxBool show = true.obs;
  RxBool show1 = true.obs;
  RxBool show2 = true.obs;

  void validationChangePassScreen(context) {
    passErrorMsg.value =
        AppValidator.passwordValidator(currentPassController.text) ?? '';
    newPassErrorMsg.value =
        AppValidator.passwordValidator(newPassController.text) ?? '';
    confirmPassErrorMsg.value =
        AppValidator.confirmPasswordValidator(confirmPassController.text,newPassController.text) ?? '';
    if (passErrorMsg.value.isEmpty &&
        newPassErrorMsg.value.isEmpty &&
        confirmPassErrorMsg.value.isEmpty) {
      Map<String, dynamic> body = {
        "oldPassword": currentPassController.text,
        "newPassword": newPassController.text,
      };
      changePassword(body: body);
    }
  }




  Future<LoginModel> changePassword({required Map<String, dynamic> body}) async {
    try {
      AppLoader(Get.context!);
      LoginModel loginModel = await SignInService.changePassword(body: body);
      RemoveAppLoader();
      if (loginModel.statusCode == Constants.successCode200) {
        currentPassController.text='';
        newPassController.text='';
        confirmPassController.text='';
        completePasswordBottomSheet(Get.context!);
      }
      return loginModel;
    } catch (e, st) {
      RemoveAppLoader();
      log("Error Message: $e : $st");
    } finally {
    }
    return LoginModel();
  }

}
