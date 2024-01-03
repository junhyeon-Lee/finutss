import 'package:finutss/new%20ui/controller/login_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/widget/custom_auth_screen.dart';
import 'package:finutss/new%20ui/widget/custom_login_button.dart';
import 'package:finutss/new%20ui/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CreatePasswordScreen extends StatelessWidget {
  CreatePasswordScreen({Key? key}) : super(key: key);
  final LoginController loginController = Get.find();

  String token='';
  String email='';

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context) != null) {
      final arg = ModalRoute.of(context)?.settings.arguments as Map;
      if (arg != null) {
        token = arg['token'];
        email = arg['email'];
      }
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColor.green[100],
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: CustomAuthScreen(
          showBackIcon: true,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 36.h,
                  ),
                  Title(),
                  SizedBox(
                    height: 9.h,
                  ),
                  Text(
                    "PLEASE_INCLUDE_614_CHARACTERS_ENGLISHNUMBERSPECIAL_CHARACTERS"
                        .tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'MontserratItalic',
                        color: AppColor.subTitleColor.withOpacity(0.5),
                        fontWeight: FontWeight.w500,
                        fontSize: 11.5.sp,
                        height: 1.8),
                  ),
                  SizedBox(
                    height: 44.h,
                  ),
                  Obx(() {
                    return CustomTextField(
                      obscureText: loginController.showCreatePassword.value,
                      controller: loginController.createPassPasswordController,
                      title: 'PASSWORD'.tr,
                      errorMsg: loginController.createPassPasswordErrorMsg.value,
                      suffixIcon: IconButton(
                        icon: Icon(
                          loginController.showCreatePassword.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColor.eyeColor,
                          size: 17.h,
                        ),
                        onPressed: () {
                          loginController.showCreatePassword.value =
                          !loginController.showCreatePassword.value;
                        },
                      ),
                    );
                  }),
                  SizedBox(
                    height: 20.h,
                  ),
                  Obx(() {
                    return CustomTextField(
                      obscureText:
                      loginController.showCreateConfirmPassword.value,
                      controller:
                      loginController.createPassConfirmPasswordController,
                      title: 'CONFIRM_PASSWORD'.tr,
                      errorMsg:
                      loginController.createPassConfirmPasswordErrorMsg.value,
                      suffixIcon: IconButton(
                        icon: Icon(
                          loginController.showCreateConfirmPassword.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColor.eyeColor,
                          size: 17.h,
                        ),
                        onPressed: () {
                          loginController.showCreateConfirmPassword.value =
                          !loginController.showCreateConfirmPassword.value;
                        },
                      ),
                    );
                  }),
                  SizedBox(
                    height: 110.h,
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: CustomLoginButton(
                      height: 41.h,
                      fontsize: 15.sp,
                      onTap: () {
                        loginController.validationCreatePassword(token : token,email: email);
                      },
                      title: 'CHANGE_PASSWORD'.tr.toUpperCase(),
                      isCancelButton: true,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget Title() {
    return Align(
      alignment: Alignment.center,
      child: Text(
        'CHANGE_PASSWORD'.tr,
        style: TextStyle(
          color: AppColor.subTitleColor,
          fontWeight: FontWeight.w700,
          fontSize: 20.sp,
        ),
      ),
    );
  }
}
