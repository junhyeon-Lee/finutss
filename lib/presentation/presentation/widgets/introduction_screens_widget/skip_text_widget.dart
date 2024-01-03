import 'package:finutss/constants.dart';
import 'package:finutss/presentation/screens/signup_screens/sign_in_screen/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common_widgets/custom_text.dart';

Widget skipText() {
  return InkWell(
    onTap: () {
      Get.off(() => SignInScreen());
    },
    child: customText(
        text: 'SKIP'.tr,
        fontSize: 16,
        fontColor: colorDarkGrey,
        fontWeight: FontWeight.w500),
  );
}
