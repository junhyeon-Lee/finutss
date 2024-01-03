import 'package:finutss/presentation/screens/workout_screens/declare_category_screen.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/heading_widget.dart';
import 'package:finutss/presentation/widgets/dialogs/social_dialogs/block_user.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DeclareBlockDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userInfo = Get.arguments;
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      content: Container(
          height: 390.h,
          // width: 343,
          child: Stack(
            children: [
              Positioned.fill(
                top: 36.h,
                bottom: 30.h,
                left: 24.w,
                right: 24.w,
                child: Column(
                  children: [
                    Center(child: headingWidget(title: 'NOTICE'.tr)),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          customText(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.visible,
                              fontColor: colorWhitish,
                              height: 2,
                              textAlign: TextAlign.center,
                              text: 'DECLARE_BLOCK_INFO'.tr),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r), border: Border.all(color: Colors.black)),
                            child: customButton(
                                onTapFunction: () {
                                  Get.back();
                                  Get.dialog(BlockUserDialog(), arguments: userInfo);
                                },
                                radius: 16,
                                height: 48,
                                text: 'BLOCK'.tr,
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
                                Get.back();
                                Get.to(() => DeclareCategoryScreen(), arguments: userInfo);
                              },
                              radius: 16,
                              height: 48,
                              text: 'REPORT'.tr,
                              fontWeight: FontWeight.w700,
                              textSize: 16,
                              color: Color(0xFFF73A6B)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              // Align(
              //   alignment: Alignment.topRight,
              //   child: Padding(
              //     padding: EdgeInsets.only(top: 25.h, right: 16.w),
              //     child: CircleAvatar(
              //       radius: 20.r,
              //       backgroundColor: backgroundSilverColor,
              //       child: IconButton(
              //           onPressed: () {
              //             Get.back();
              //           },
              //           padding: EdgeInsets.zero,
              //           icon: Icon(
              //             CommunityMaterialIcons.window_close,
              //             size: 24.r,
              //             color: darkGreyColor,
              //           )),
              //     ),
              //   ),
              // )
            ],
          )),
    );
  }
}
