import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/domain/controller/setting_controller.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/screens/setting_page/widget/app_setting.dart';
import 'package:finutss/presentation/screens/setting_page/widget/customer.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:finutss/presentation/screens/setting_page/widget/user_account.dart';

class SettingPage extends StatelessWidget {
  final settingController = Get.put(SettingController());
  final ScrollController scrollController;

  SettingPage({required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      return Padding(
        padding: EdgeInsets.all(16.0.r),
        child: Column(
          children: [
            userAccount(context, authController),
            size15,
            appSetting(settingController),
            size15,
            customer(),
            size30,
          ],
        ),
      );
    });
  }
}

Widget sectionHeading({required String heading, buttonText, buttonFunction}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      customText(text: heading, fontWeight: FontWeight.w600, fontSize: 20),
      if (buttonText != null)
        customButton(
          color: colorPink,
          width: 121,
          height: 34,
          text: '$buttonText',
          fontWeight: FontWeight.bold,
          onTapFunction: buttonFunction,
          textSize: 10,
        )
    ],
  );
}