import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

// ignore: non_constant_identifier_names
Widget userGuideCard({OnTap, required context}) {
  return Container(
    height: 135,
    width: MediaQuery.of(context).size.width / 2.3,

    // width: Get.width * 0.4,
    /* -------------------------------------------------------------------------- */
    /*                              background image                              */
    /* -------------------------------------------------------------------------- */
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      image: DecorationImage(image: AssetImage('assets/images/user_guide.png'), fit: BoxFit.cover),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        /* -------------------------------------------------------------------------- */
        /*                                    text                                    */
        /* -------------------------------------------------------------------------- */
        Padding(
          padding: EdgeInsets.only(right: 9.w),
          child: Text(
            'USER_GUIDE'.tr,
            style: TextStyle(color: colorBackgroundSilver, fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
        size10,
        /* -------------------------------------------------------------------------- */
        /*                                   button                                   */
        /* -------------------------------------------------------------------------- */
        Padding(
          padding: EdgeInsets.only(right: 9.w),
          child: customButton(
              text: 'CHECK_NOW'.tr,
              onTapFunction: OnTap,
              fontWeight: FontWeight.bold,
              color: colorBackgroundSilver,
              textColor: colorDarkGrey,
              radius: 8,
              height: 26,
              width: 90),
        ),
      ],
    ),
  );
}
