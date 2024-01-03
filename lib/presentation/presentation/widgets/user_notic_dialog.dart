import 'package:finutss/constants.dart';
import 'package:finutss/presentation/screens/signup_screens/sign_in_screen/signin_screen.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/heading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class UserNoticeDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.white,
        content: Container(
          height: 390.h,
          child: Stack(
            children: [
              Positioned.fill(
                top: 36.h,
                bottom: 30.h,
                left: 24.w,
                right: 24.w,
                child: Column(
                  children: [
                    Center(child: headingWidget(title: 'NOTICE'.tr, size: 24)),
                    Expanded(
                        child: Center(
                      child: customText(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.visible,
                          fontColor: colorWhitish,
                          height: 1.5,
                          textAlign: TextAlign.center,
                          text: 'GUEST_SERVICE_LOG_IN'.tr),
                    )),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r), border: Border.all(color: Colors.black)),
                            child: customButton(
                                onTapFunction: () {
                                  Get.back();
                                },
                                radius: 16,
                                height: 48,
                                text: 'LATER'.tr,
                                fontWeight: FontWeight.w700,
                                color: Color(0xffffffff),
                                textColor: Colors.black,
                                textSize: 16),
                          ),
                        ),
                        size5,
                        Expanded(
                          child: customButton(
                              onTapFunction: () {
                                // isGust = UserStatus.userWithLogin;
                                Get.offAll(() => SignInScreen());
                              },
                              radius: 16,
                              height: 48,
                              color: colorBlue,
                              text: 'SIGN_UP'.tr,
                              fontWeight: FontWeight.w700,
                              textSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
