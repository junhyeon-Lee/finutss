import 'package:finutss/new%20ui/controller/login_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/widget/custom_auth_screen.dart';
import 'package:finutss/new%20ui/widget/custom_login_button.dart';
import 'package:finutss/new%20ui/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);
  final LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return CustomAuthScreen(
      showBackIcon: true,
      child: LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                  ),
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
                        "EMAIL_AUTHENTICATION_GUIDE".tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'MontserratItalic',
                            color: AppColor.subTitleColor.withOpacity(0.5),
                            fontWeight: FontWeight.w500,
                            fontSize: 11.5.sp,
                            height: 1.8),
                      ),
                      SizedBox(
                        height: 48.h,
                      ),
                      Obx(() {
                        return CustomTextField(
                          controller: loginController.changePassEmailController,
                          inputType: TextInputType.emailAddress,
                          title: "EMAIL".tr,
                          errorMsg:
                              loginController.changePassEmailErrorMsg.value,
                        );
                      }),
                      SizedBox(
                        height: 20.h,
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32.w),
                        child: CustomLoginButton(
                          height: 40.h,
                          fontsize: 15.sp,
                          onTap: () {
                            loginController.validationChangePassword();
                          },
                          title: 'VERIFICATION'.tr.toUpperCase(),
                          isCancelButton: true,
                        ),
                      ),
                      SizedBox(
                        height: 90.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget Title() {
    return Align(
      alignment: Alignment.center,
      child: Text(
        'CHANGE_PASSWORD'.tr.toUpperCase(),
        style: TextStyle(
          color: AppColor.subTitleColor,
          fontWeight: FontWeight.w700,
          fontSize: 20.sp,
        ),
      ),
    );
  }
}
