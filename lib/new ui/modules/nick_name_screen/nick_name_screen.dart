import 'package:finutss/new%20ui/controller/login_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/app_string.dart';
import 'package:finutss/new%20ui/widget/custom_auth_screen.dart';
import 'package:finutss/new%20ui/widget/custom_login_button.dart';
import 'package:finutss/new%20ui/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NickNameScreen extends StatelessWidget {
  NickNameScreen({Key? key}) : super(key: key);
  final LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return CustomAuthScreen(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 15,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 21.h,
            ),
            Title(),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                AppString.subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColor.subTitleColor.withOpacity(0.5),
                    fontWeight: FontWeight.w400,
                    fontSize: 12.6.sp,
                    height: 1.8),
              ),
            ),
            SizedBox(
              height: 47.h,
            ),
            Obx(() {
              return CustomTextField(
                controller: loginController.nickNameController,
                title: "NICKNAME".tr,
                errorMsg: loginController.nickNameErrorMsg.value,
              );
            }),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomLoginButton(
                onTap: () {
                  loginController.validationNickName();
                },
                title: "REPORT_DONE".tr.toUpperCase(),
                isCancelButton: true,
              ),
            ),
            SizedBox(
              height: 60.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget Title() {
    return Align(
      alignment: Alignment.center,
      child: Text(
        "NICKNAME".tr,
        style: TextStyle(
          color: AppColor.subTitleColor,
          fontWeight: FontWeight.w700,
          fontSize: 21.sp,
        ),
      ),
    );
  }
}
