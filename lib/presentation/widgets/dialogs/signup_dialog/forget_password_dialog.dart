import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/heading_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ForgetPasswordDialog extends StatelessWidget {
  String title, description;
  ForgetPasswordDialog({
    required this.title,
    required this.description,
  });
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
                left: 15.w,
                right: 15.w,
                child: Column(
                  children: [
                    Center(child: headingWidget(title: '$title')),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          customText(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.visible,
                              fontColor: colorWhitish,
                              height: 1.5,
                              textAlign: TextAlign.center,
                              text: '$description'),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: customButton(
                              onTapFunction: () {
                                // Get.offAll(SignInScreen(), opaque: false); //resolve this*****
                                Get.back();
                                Get.back();
                                Get.back();
                              },
                              radius: 15,
                              height: 48,
                              text: 'OK'.tr,
                              color: Color(0xff3BCCE1),
                              textColor: Colors.white,
                              textSize: 16),
                        ),
                      ],
                    ),
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
