import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/widget/custom_auth_screen.dart';
import 'package:finutss/new%20ui/widget/custom_login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAuthScreen(
      top: 320.h,
      titleChild: Container(
        height: 178.h,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Image.asset(
            ImageAssets.welcome,
            height: 178.h,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 28.w,
          vertical: 15.h,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 31.h,
              ),
              Title(),
              SizedBox(
                height: 9.h,
              ),
              Text(
                'A_SOCIAL_FITNESS_SERVICE_WITH_YOU'.tr,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: AppColor.green,
                  fontWeight: FontWeight.w500,
                  fontSize: 13.sp,
                ),
              ),
              SizedBox(
                height: 26.h,
              ),
              description(
                "AFTER_YOU_SIGN_UP_FOR_A_MEMBERSHIP_SIGN_UP_FOR_A_MEMBERSHIP_WILL_BE_COMPLETED_IF_YOU_AUTHENTICATE_YOUR_REGISTRATION_BY_EMAIL_WELCOME_TO_FINUTSS_OUR_SOCIAL_FITNESS_SERVICE".tr,
              ),
              SizedBox(
                height: 39.h,
              ),
              CustomLoginButton(
                onTap: () {
                  Navigation.replaceAll(Routes.dashboardScreen);
                },
                title: "GREAT".tr,
                isCancelButton: true,
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget description(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColor.subTitleColor.withOpacity(0.7),
        fontWeight: FontWeight.w400,
        height: 2.1,
        fontSize: 12.1.sp,
      ),
    );
  }

  Widget Title() {
    return Align(
      alignment: Alignment.center,
      child: Text(
        'WELCOME'.tr,
        style: TextStyle(
          color: AppColor.blueTextColor,
          fontWeight: FontWeight.w700,
          fontSize: 24.sp,
        ),
      ),
    );
  }
}
