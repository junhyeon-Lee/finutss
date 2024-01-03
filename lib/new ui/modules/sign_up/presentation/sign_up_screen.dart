import 'package:finutss/new%20ui/controller/login_controller.dart';
import 'package:finutss/new%20ui/utils/api_constant.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/widget/custom_auth_screen.dart';
import 'package:finutss/new%20ui/widget/custom_login_button.dart';
import 'package:finutss/new%20ui/widget/custom_textfield.dart';
import 'package:finutss/new%20ui/widget/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColor.green[100],
      ),
      child: CustomAuthScreen(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 28.w,
                  vertical: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Size20(),
                    Title(),
                    Size20(),
                    Obx(() {
                      return CustomTextField(
                        title: "USER_NAME".tr,
                        controller: loginController.usernameController,
                        errorMsg: loginController.usernameErrorMsg.value,
                      );
                    }),
                    Size20(),
                    Obx(() {
                      return CustomTextField(
                        title: "EMAIL".tr,
                        inputType: TextInputType.emailAddress,
                        errorMsg: loginController.emailErrorMsg_Signup.value,
                        controller: loginController.signupEmailController,
                      );
                    }),
                    Size20(),
                    Obx(
                      () => CustomTextField(
                        obscureText: loginController.showSignup.value,
                        title: 'PASSWORD'.tr,
                        errorMsg: loginController.passwordErrorMsg_Signup.value,
                        suffixIcon: IconButton(
                          icon: Icon(
                            loginController.showSignup.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColor.eyeColor,
                            size: 17.h,
                          ),
                          onPressed: () {
                            loginController.showSignup.value =
                                !loginController.showSignup.value;
                          },
                        ),
                        controller: loginController.signupPassController,
                      ),
                    ),
                    Size20(),
                    Obx(
                      () => CustomTextField(
                        obscureText: loginController.showSignupConfirm.value,
                        title: 'CONFIRM_PASSWORD'.tr,
                        errorMsg: loginController
                            .confirmPasswordErrorMsg_Signup.value,
                        suffixIcon: IconButton(
                          icon: Icon(
                            loginController.showSignupConfirm.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColor.eyeColor,
                            size: 17.h,
                          ),
                          onPressed: () {
                            loginController.showSignupConfirm.value = !loginController.showSignupConfirm.value;
                          },
                        ),
                        controller: loginController.confirmPassController,
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.w),
                      child: CustomLoginButton(
                        title: 'NEXT'.tr,
                        isCancelButton: true,
                        onTap: () {
                          loginController.validationSignUpScreen();
                          Constants.isGuest = false;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                  ],
                ),
              ),
              OrDivider(),
              Column(
                children: [
                  SizedBox(
                    height: 19.h,
                  ),
                  CustomVIew.socialRowView(
                    onTapGoggle: () {
                      Navigation.pushNamed(Routes.socialLoginScreen, arg: {
                        'url': ApiConstants.baseUrl+ApiConstants.googleSignUp,
                      });
                      Constants.isGuest = false;
                    },
                    onTapKakao: () {
                      Navigation.pushNamed(Routes.socialLoginScreen, arg: {
                        'url': ApiConstants.baseUrl+ApiConstants.kaKaoRegister,
                      });
                      Constants.isGuest = false;
                    },
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  SigninText(() {
                    Navigation.pushNamed(Routes.signIn);
                  }),
                  Size20(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ForgotPass() {
    return Align(
      alignment: Alignment.topRight,
      child: Text(
        "FORGOT_PASSWORD".tr,
        style: TextStyle(
          fontStyle: FontStyle.italic,
          color: AppColor.lightBlue,
          fontSize: 12.h,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget Title() {
    return Align(
      alignment: Alignment.center,
      child: Text(
        "SIGN_UP".tr,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w800,
          fontSize: 25.sp,
        ),
      ),
    );
  }

  Widget OrDivider() {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: AppColor.dividerColor,
            thickness: 0.7,
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(
          'OR'.tr,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: AppColor.subTitleColor.withOpacity(0.3),
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Expanded(
          child: Divider(
            color: AppColor.dividerColor,
            thickness: 0.7,
          ),
        ),
      ],
    );
  }

  Widget SigninText(VoidCallback? signinOnTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'SIGN_IN_ALREADY_HAVE_ACCOUNT'.tr,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
          ),
        ),
        SizedBox(
          width: 4.w,
        ),
        GestureDetector(
          onTap: signinOnTap,
          child: Text(
            "SIGN_IN".tr,
            style: TextStyle(
              color: AppColor.orangeColor,
              fontWeight: FontWeight.w700,
              fontSize: 12.sp,
            ),
          ),
        ),
      ],
    );
  }

  Widget Size20() {
    return SizedBox(
      height: 20.h,
    );
  }
}
