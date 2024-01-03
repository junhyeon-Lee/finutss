import 'package:finutss/constants.dart';
import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/presentation/screens/signup_screens/sign_in_screen/signin_screen.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/heading_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class WithdrawalCompleteDialog extends StatelessWidget {
  final authController = Get.put(AuthController());
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
                    // Expanded(
                    //   flex: 1,
                    //   child: Stack(
                    //     children: [
                    //       Positioned.fill(
                    //           child:
                    //               Center(child: headingWidget(title: 'Complete'))),
                    //       Align(
                    //         alignment: Alignment.centerRight,
                    //         child: CircleAvatar(
                    //           backgroundColor: backgroundSilverColor,
                    //           child: IconButton(
                    //               onPressed: () {
                    //                 Get.back();
                    //               },
                    //               icon: Icon(
                    //                 CommunityMaterialIcons.window_close,
                    //                 color: darkGreyColor,
                    //               )),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Center(child: headingWidget(title: 'COMPLETE'.tr)),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          customText(
                              text:
                                  "YOUR_WITHDRAWAL_FROM_THE_MEMBERSHIP_HAS_BEEN_COMPLETED_THANK_YOU_FOR_EVERYTHING_YOUVE_DONE"
                                      .tr,
                              fontColor: colorWhitish,
                              fontSize: 14,
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: customButton(
                              onTapFunction: () {
                                authController.callLogOutApi({"logout": true});
                                Get.back();
                                Get.offAll(SignInScreen());
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
