import 'dart:async';
import 'dart:developer';

import 'package:finutss/new%20ui/modules/app_setting/model/success_model.dart';
import 'package:finutss/new%20ui/modules/change_password/service/forgot_password_service.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/validation_utils.dart';
import 'package:finutss/new%20ui/widget/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {

  TextEditingController emailController=TextEditingController();
  TextEditingController otpController=TextEditingController();
  RxString sendTitle='SEND'.obs;
  RxBool isEnableResendButton=false.obs;
  RxBool isEnableButton=false.obs;
  RxBool isValidEmail=false.obs;
  RxBool isValidOTP=false.obs;
  RxBool isShowTimer=false.obs;
  RxBool isEnableOTPTextfield=false.obs;

  RxString emailErrorMsg=''.obs;
  RxString otpErrorMsg=''.obs;
  String? passwordToken;

  RxInt countSecond=30.obs;



  @override
  void onInit() {
    super.onInit();

  }


  @override
  void dispose() {
    super.dispose();
    emailController.text='';
    otpController.text='';
    sendTitle.value='SEND';
    isEnableResendButton.value=false;
    isEnableButton.value=false;
    isValidEmail.value=false;
    isValidOTP.value=false;
    isShowTimer.value=false;
    isEnableOTPTextfield.value=false;
    emailErrorMsg.value='';
    otpErrorMsg.value='';
  }


  bool emailValidation(){
    emailErrorMsg.value = AppValidator.emailValidator(emailController.text) ?? '';
    if (emailErrorMsg.value.isEmpty) {
      isValidEmail.value=true;
       return isValidEmail.value;
    } else {
      isValidEmail.value=false;
      return isValidEmail.value;
    }
  }

  Future sendOTP() async {
    try {
      Map<String, dynamic> body={
        'email' : emailController.text.trim().toString(),
        'authorizationType' : 'otp'
      };
      AppLoader(Get.context!);
      SuccessModel loginModel = await ForgotPasswordService.forgotPasswordWithOTP(body: body);


      if (loginModel.statusCode == Constants.successCode200) {
        otpErrorMsg.value = '';
        emailErrorMsg.value='';
        sendTitle.value='SENT';
        isValidEmail.value=false;
        isEnableOTPTextfield.value=true;
        isShowTimer.value=true;
        otpController.text='';
       // startTimer();

        counter();
      }else{
        if(loginModel.error!=null){
          emailErrorMsg.value=loginModel.error ?? '';
        }
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {
      RemoveAppLoader();
    }
  }


  Future verifyOTP() async {

      try {
        Map<String, dynamic> body = {
          'email': emailController.text.trim().toString(),
          'otp': otpController.text.trim().toString()
        };
        print('-------verify otp----->${body.toString()}');
        AppLoader(Get.context!);
        SuccessModel loginModel = await ForgotPasswordService.verifyOTP(body: body);
        print('-------verify otp su----->${loginModel.statusCode}');
        if (loginModel.statusCode == Constants.successCode200) {
          otpErrorMsg.value = '';
          isValidOTP.value = true;
          passwordToken=loginModel.data?.token ?? '';
        } else {
          if (loginModel.error != null) {
            otpErrorMsg.value = loginModel.error ?? '';
          }
        }
      } catch (e, st) {
        log("Error Message: $e : $st");
      } finally {
        RemoveAppLoader();
      }
  }


  counter() {
    countSecond.value=30;
    Timer.periodic(
      const Duration(seconds: 1),
          (timer) {
        if (countSecond.value <= 0) {
          sendTitle.value = "RE_SEND";
          isValidEmail.value=true;
          countSecond.value = 0;
          timer.cancel();
        } else {
          countSecond.value--;
        }
      },
    );
  }

}