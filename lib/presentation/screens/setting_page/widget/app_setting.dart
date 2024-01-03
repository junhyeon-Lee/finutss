import 'package:finutss/constants.dart';
import 'package:finutss/domain/controller/setting_controller.dart';
import 'package:finutss/presentation/screens/setting_page/language_page.dart';
import 'package:finutss/presentation/screens/setting_page/push_notification_page.dart';
import 'package:finutss/presentation/widgets/common_widgets/action_card.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/rounded_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget appSetting(SettingController settingController) {
  return Container(
    decoration: roundedDecoration(),
    child: Padding(
      padding: EdgeInsets.all(16.0.r),
      child: Column(
        children: [
          _sectionHeading(
            heading: 'APP_SETTING'.tr,
          ),
          size15,
          actionCard(
            heading: 'LANGUAGE'.tr,
            activeValue: settingController.selectedValue,
            onTapFunction: () {
              Get.dialog(
                Padding(
                  padding: EdgeInsets.all(16.0.r),
                  child: LanguagePage(),
                ),
              );
            },
          ),
          size15,
          actionCard(
            heading: 'PUSH_NOTIFICATIONS'.tr,
            onTapFunction: () {
              Get.to(() => PushNotificationPage());
            },
          ),
        ],
      ),
    ),
  );
}

Widget _sectionHeading({required String heading, buttonText, buttonFunction}) {
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
