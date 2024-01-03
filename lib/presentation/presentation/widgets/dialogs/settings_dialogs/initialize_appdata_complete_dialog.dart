import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/heading_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class InitializeAppdataCompleteDialog extends StatelessWidget {
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
                left: 25.w,
                right: 25.w,
                child: Column(
                  children: [
                    Center(child: headingWidget(title: 'COMPLETE'.tr)),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          customText(
                              text: "APP_DATA_INITIALIZATION_COMPLETE_INFO".tr,
                              fontColor: colorWhitish,
                              fontSize: 14,
                              height: 1.5,
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: customButton(
                              onTapFunction: () {
                                Get.back(closeOverlays: true);
                              },
                              radius: 15,
                              height: 48,
                              text: 'OK'.tr,
                              fontWeight: FontWeight.w700,
                              textSize: 16),
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
