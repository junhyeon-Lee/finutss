import 'package:finutss/new%20ui/controller/login_controller.dart';
import 'package:finutss/new%20ui/modules/sign_in/presentation/guest_login_bottom_sheet.dart';
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

// ignore: must_be_immutable
class SignInScreen extends StatefulWidget {
  SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final LoginController loginController = Get.find();

  @override
  void initState() {
    super.initState();
    loginController.getDeviceToken();
  }

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
                padding: const EdgeInsets.symmetric(
                  horizontal: 35,
                  vertical: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "SIGN_IN".tr,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 25.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 22.h,
                    ),
                    Obx(
                      () {
                        return CustomTextField(
                          title: "EMAIL".tr,
                          inputType: TextInputType.emailAddress,
                          controller: loginController.emailController,
                          errorMsg: loginController.emailErrorMsg.value,
                        );
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Obx(
                      () => CustomTextField(
                        obscureText: loginController.showSignin.value,
                        title: 'PASSWORD'.tr,
                        errorMsg: loginController.passwordErrorMsg.value,
                        suffixIcon: IconButton(
                          icon: Icon(
                            loginController.showSignin.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColor.eyeColor,
                            size: 17.h,
                          ),
                          onPressed: () {
                            loginController.showSignin.value =
                                !loginController.showSignin.value;
                          },
                        ),
                        controller: loginController.passController,
                      ),
                    ),
                    SizedBox(
                      height: 9.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        loginController.changePassEmailController.text='';
                        Navigation.pushNamed(Routes.changePasswordWithOTP);
                      },
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "FORGOT_PASSWORD".tr,
                          style: TextStyle(
                            fontFamily: 'MontserratItalic',
                            color: AppColor.orangeColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CustomLoginButton(
                        height: 41.h,
                        fontsize: 15.sp,
                        title: 'SIGN_IN'.tr,
                        isCancelButton: false,
                        onTap: () {
                          Constants.isGuest = false;
                          loginController.validationLoginScreen();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 22.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        loginController.clearSignupTextField();
                        GuestLoginBottomSheet(Get.context!);
                        Constants.isGuest = true;
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'AS_GUEST'.tr,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColor.green,
                            fontSize: 13.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 26.h,
                    ),
                  ],
                ),
              ),
              OrDivider(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 23.h,
                    ),
                    CustomVIew.socialRowView(
                      onTapGoggle: () {
                        Navigation.pushNamed(
                          Routes.socialLoginScreen,
                          arg: {
                            'url': ApiConstants.baseUrl+ApiConstants.googleLogin,
                          },
                        );
                        Constants.isGuest = false;
                      },
                      onTapKakao: () {
                        Navigation.pushNamed(
                          Routes.socialLoginScreen,
                          arg: {
                            'url': ApiConstants.baseUrl+ApiConstants.kaKaoLogin,
                          },
                        );
                        Constants.isGuest = false;
                      },
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    SignUpText(
                      () {
                        loginController.clearSignupTextField();
                        Navigation.pushNamed(Routes.termsAgreeScreen);
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget TextFieldTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 13.sp,
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

  Widget SignUpText(VoidCallback? signUpOnTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'SIGN_UP_DONT_HAVE_ACCOUNT'.tr,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 13.sp,
          ),
        ),
        SizedBox(
          width: 4.w,
        ),
        GestureDetector(
          onTap: signUpOnTap,
          child: Text(
            "SIGN_UP".tr,
            style: TextStyle(
              color: AppColor.orangeColor,
              fontWeight: FontWeight.w700,
              fontSize: 13.sp,
            ),
          ),
        ),
      ],
    );
  }
}
