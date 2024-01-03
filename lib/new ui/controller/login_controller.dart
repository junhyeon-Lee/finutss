import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/helper/toast_helper.dart';
import 'package:finutss/new%20ui/modules/app_setting/model/success_model.dart';
import 'package:finutss/new%20ui/modules/change_password/presentation/complate_password_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/change_password/service/forgot_password_service.dart';
import 'package:finutss/new%20ui/modules/sign_in/model/login_model.dart';
import 'package:finutss/new%20ui/modules/sign_in/model/verification_model.dart';
import 'package:finutss/new%20ui/modules/sign_in/service/signin_service.dart';
import 'package:finutss/new%20ui/modules/sign_up/presentation/signup_service.dart';
import 'package:finutss/new%20ui/modules/sign_up/widget/error_msg_bottom_sheet.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/utils/validation_utils.dart';
import 'package:finutss/new%20ui/widget/loader.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController signupEmailController = TextEditingController();
  TextEditingController signupPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController nickNameController = TextEditingController();
  TextEditingController changePassEmailController = TextEditingController();
  TextEditingController verificationController = TextEditingController();

  TextEditingController createPassPasswordController = TextEditingController();
  TextEditingController createPassConfirmPasswordController =
      TextEditingController();
  final logInFormKey = GlobalKey<FormState>();
  final signUpFormKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  RxBool showSignin = true.obs;
  RxBool showSignup = true.obs;
  RxBool showSignupConfirm = true.obs;
  RxString emailErrorMsg = ''.obs;
  RxString passwordErrorMsg = ''.obs;
  RxString usernameErrorMsg = ''.obs;
  RxString emailErrorMsg_Signup = ''.obs;
  RxString passwordErrorMsg_Signup = ''.obs;
  RxString confirmPasswordErrorMsg_Signup = ''.obs;
  RxString changePassEmailErrorMsg = ''.obs;
  RxBool showCreatePassword = true.obs;
  RxBool showCreateConfirmPassword = true.obs;
  RxString createPassPasswordErrorMsg = ''.obs;
  RxString createPassConfirmPasswordErrorMsg = ''.obs;
  RxString nickNameErrorMsg = ''.obs;
  LoginModel? user;
  String? savedEmail;

  RxString verificationErrorMsg = ''.obs;

  late String deviceType;
  String deviceToken = '';
  var prefs;

  @override
  Future<void> onInit() async {
    super.onInit();

    String request = '{"statusCode":200,"message":"Success","data":{}}';
    user = LoginModel.fromJson(jsonDecode(request));
    prefs = await SharedPreferences.getInstance();

    if (Platform.isAndroid) {
      deviceType = 'android';
    } else {
      deviceType = 'ios';
    }

    getEmail();
  }


  getDeviceToken() async {
    await FirebaseMessaging.instance.deleteToken();
    await FirebaseMessaging.instance.getToken().then((value) {
      deviceToken = value ?? '';
    });
  }



  getEmail() async {
    savedEmail = await SharedPrefs.getUserEmail();
  }

  void validationLoginScreen() {
    emailErrorMsg.value =
        AppValidator.emailValidator(emailController.text) ?? '';
    passwordErrorMsg.value =
        AppValidator.passwordValidator(passController.text) ?? '';
    if (emailErrorMsg.value.isEmpty && passwordErrorMsg.value.isEmpty) {
      Map<String, dynamic> body = {
        "email": emailController.text.trim(),
        "password": passController.text,
        "deviceType": deviceType,
        "deviceToken": deviceToken ?? " ",
      };
      logIn(body: body);
    }
  }

  void validationSignUpScreen() {
    usernameErrorMsg.value =
        AppValidator.userNameValidator(usernameController.text) ?? '';
    emailErrorMsg_Signup.value =
        AppValidator.emailValidator(signupEmailController.text) ?? '';
    passwordErrorMsg_Signup.value =
        AppValidator.passwordValidator(signupPassController.text) ?? '';
    confirmPasswordErrorMsg_Signup.value =
        AppValidator.confirmPasswordValidator(
                confirmPassController.text, signupPassController.text) ??
            '';
    if (usernameErrorMsg.value.isEmpty &&
        emailErrorMsg_Signup.value.isEmpty &&
        passwordErrorMsg_Signup.value.isEmpty &&
        confirmPasswordErrorMsg_Signup.value.isEmpty) {
      Map<String, dynamic> body = {
        "email": signupEmailController.text.trim(),
        "username": usernameController.text,
        "password": signupPassController.text,
        "deviceType": deviceType,
        "deviceToken": deviceToken,
      };
      signUp(body: body);
    }
  }

  void validationChangePassword() {
    changePassEmailErrorMsg.value =
        AppValidator.emailValidator(changePassEmailController.text) ?? '';
    if (changePassEmailErrorMsg.value.isEmpty) {
      Map<String, dynamic> body = {
        "email": changePassEmailController.text.trim(),
      };
      forgotPassword(body: body);
    }
  }

  void validationCreatePassword({required String token, required String email}) {
    createPassPasswordErrorMsg.value =
        AppValidator.passwordValidator(createPassPasswordController.text) ?? '';
    createPassConfirmPasswordErrorMsg.value =
        AppValidator.confirmPasswordValidator(
                createPassConfirmPasswordController.text,
                createPassPasswordController.text) ??
            '';
    if (createPassPasswordErrorMsg.value.isEmpty &&
        createPassConfirmPasswordErrorMsg.value.isEmpty) {
      Map<String, dynamic> body = {
        "email": email,
        "token": token,
        "password": createPassPasswordController.text,
      };
      createPassword(body: body);
    }
  }

  void validationNickName() {
    nickNameErrorMsg.value =
        AppValidator.userNameValidator(nickNameController.text) ?? '';
    if (nickNameErrorMsg.value.isEmpty) {
      Navigation.pushNamed(Routes.welcomeScreen);
    }
  }


  clearTextField(){
    emailController.text = '';
    passController.text = '';
    usernameController.text = '';
    signupEmailController.text = '';
    signupPassController.text = '';
    confirmPassController.text = '';
  }

  Future<LoginModel> logIn({required Map<String, dynamic> body}) async {
    try {
      isLoading.value = true;
      AppLoader(Get.context!);
      user = await SignInService.logIn(body: body);
      RemoveAppLoader();

      if (user?.statusCode == Constants.successCode200) {
        clearTextField();
        var prefs = await SharedPreferences.getInstance();
        prefs.setBool("IsSocial", false);
        await SharedPrefs.saveUser(
            isLogin: true,
            email: user?.data?.email,
            userName: user?.data?.username,
            coverPicture: '',
            description: user?.data?.description,
            profilePicture: user?.data?.profilePhoto,
            token: 'Bearer ' + (user?.data?.token ?? ''),
            name: user?.data?.firstName,
            userId: user?.data?.id);

        prefs.setBool("IsVerification", true);
        Navigation.replaceAll(Routes.dashboardScreen);


      /*  prefs.setBool("IsVerification", (user?.data?.emailVerification?.isVerified ?? false));

        if((user?.data?.emailVerification?.isVerified ?? false)){
          Navigation.replaceAll(Routes.dashboardScreen);
        }else{
          getEmail();
          MessageBottomSheet(Get.context!,message: "UNAPPROVED_ACCOUNT_TXT",isSignInScreen: true);
        }*/

      }else if(user?.statusCode==Constants.successCode403 || user?.statusCode==Constants.successCode404){
        if((user?.error ?? '').toLowerCase().contains('email')){
          emailErrorMsg.value="INVALID_EMAIL".tr ?? '';
        }else{
          passwordErrorMsg.value="INVALID_PASSWORD".tr ?? '';
        }
      }
      return user!;
    } catch (e, st) {
      RemoveAppLoader();
      log("Error Message: $e : $st");
    } finally {
      isLoading.value = false;
    }
    return LoginModel();
  }

  Future<LoginModel> signUp({required Map<String, dynamic> body}) async {
    try {
      isLoading.value = true;
      AppLoader(Get.context!);
      user = await SignUpService.signUp(body: body);
      RemoveAppLoader();
      if (user?.statusCode == Constants.successCode201) {
        var prefs = await SharedPreferences.getInstance();
        prefs.setBool("IsSocial", false);
        await SharedPrefs.saveUser(
            isLogin: true,
            email: user?.data!.email,
            userName: user?.data!.username,
            coverPicture: '',
            description: user?.data?.description,
            profilePicture: user?.data!.profilePhoto,
            token: 'Bearer ' + (user?.data?.token ?? ""),
            name: user?.data!.firstName,
            userId: user?.data?.id);

        Navigation.pushNamed(Routes.welcomeScreen);
        await SharedPrefs.setIsVerification(true);

    /* getEmail();
        Navigation.pushNamed(Routes.verificationScreen);
        await SharedPrefs.setIsVerification(false);*/
        clearTextField();
      }else if(user?.statusCode==Constants.successCode403 || user?.statusCode==Constants.successCode404){
        if((user?.error ?? '').toLowerCase().contains('email')){
          emailErrorMsg_Signup.value=user?.error ?? '';
        }else if((user?.error ?? '').toLowerCase().contains('user')){
          usernameErrorMsg.value=user?.error ?? '';
        }else{
          passwordErrorMsg_Signup.value=user?.error ?? '';
        }
      }

      return user!;
    } catch (e, st) {
      RemoveAppLoader();
      log("Error Message: $e : $st");
    } finally {
      isLoading.value = false;
    }
    return LoginModel();
  }


  clearSignupTextField(){
    usernameController.text = '';
    signupEmailController.text = '';
    signupPassController.text = '';
    confirmPassController.text = '';
  }

  Future<LoginModel> forgotPassword(
      {required Map<String, dynamic> body}) async {
    try {
      isLoading.value = true;
      AppLoader(Get.context!);
      LoginModel loginModel =
          await ForgotPasswordService.forgotPassword(body: body);
      RemoveAppLoader();
      if (loginModel.statusCode == Constants.successCode200) {
        AppToast.toastMessage(loginModel.message.toString());
        Navigation.replaceAll(Routes.signIn);
        //Navigation.pushNamed(Routes.createPassword);
      }else if(loginModel.statusCode==Constants.successCode403 || loginModel.statusCode==Constants.successCode404){
        changePassEmailErrorMsg.value=loginModel.error ?? '';
      }

      return loginModel;
    } catch (e, st) {
      RemoveAppLoader();
      log("Error Message: $e : $st");
    } finally {
      isLoading.value = false;
    }
    return LoginModel();
  }

  Future<SuccessModel> createPassword(
      {required Map<String, dynamic> body}) async {
    try {
      isLoading.value = true;
      AppLoader(Get.context!);
      SuccessModel model =
          await ForgotPasswordService.createPassword(body: body);
      RemoveAppLoader();
      if (model.statusCode == Constants.successCode200) {
        completePasswordBottomSheet(Get.context!);
      }

      return model;
    } catch (e, st) {
      RemoveAppLoader();
      log("Error Message: $e : $st");
    } finally {
      isLoading.value = false;
    }
    return SuccessModel();
  }


  void validationVerification() {
    verificationErrorMsg.value =
        AppValidator.otpValidation(verificationController.text) ?? '';
    if (verificationErrorMsg.value.isEmpty) {
      Map<String, dynamic> body = {
        "email": savedEmail ?? "",
        "otp": verificationController.text.trim(),
      };
      print('=========>${body.toString()}');
      verification(body: body);
    }
  }

  Future<VerificationModel> verification(
      {required Map<String, dynamic> body}) async {
    try {
      AppLoader(Get.context!);
      VerificationModel loginModel =
          await SignInService.verification(body: body);
      RemoveAppLoader();
      if (loginModel.statusCode == Constants.successCode201) {
        Navigation.replaceAll(
          Routes.welcomeScreen,
        );
        await SharedPrefs.setIsVerification(true);
      }/*else if(loginModel.statusCode==403){
        verificationErrorMsg.value='Verification number is incorrect.';
      }*/
      return loginModel;
    } catch (e, st) {
      RemoveAppLoader();
      log("Error Message: $e : $st");
    } finally {}
    return VerificationModel();
  }

  String getCurrentType() {
    String workoutType = user?.data?.workoutType?.value ?? '';
    if (workoutType == Constants.riding) {
      return IconAssets.ridingSensor;
    } else if (workoutType == Constants.running) {
      return IconAssets.runGroupBoy;
    } else if (workoutType == Constants.mobileSensor) {
      return IconAssets.mobileSensor;
    } else if (workoutType == Constants.smartWatch) {
      return IconAssets.smartWatch;
    } else {
      return IconAssets.sensorConnectIcon;
    }
  }



  Future getResendOTP() async {
    try {
      AppLoader(Get.context!);
      SuccessModel loginModel = await SignInService.resendOTP();
      RemoveAppLoader();
      if (loginModel.statusCode == Constants.successCode200) {
        MessageBottomSheet(Get.context!,message: "SENT_YOU_AN_EMAIL_IF_YOU_DONT_SEE_THE_EMAIL_CHECK_THE_TRASH_SPAM_ADBOX_ETC",isSignInScreen: false);
        verificationController.text='';
      }
    } catch (e, st) {
      RemoveAppLoader();
      log("Error Message: $e : $st");
    } finally {}
  }
}
