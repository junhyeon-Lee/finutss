import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/heading_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:get/get.dart';

class SignUpWelcomeDialog extends StatelessWidget {
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
                child: Column(children: [
                  Center(child: headingWidget(title: 'WELCOME'.tr)),
                  Expanded(
                    child: Center(
                      child: RichText(
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              style: TextStyle(
                                height: 1.5.h,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: colorWhitish,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      'AFTER_YOU_SIGN_UP_FOR_A_MEMBERSHIP_SIGN_UP_FOR_A_MEMBERSHIP_WILL_BE_COMPLETED_IF_YOU_AUTHENTICATE_YOUR_REGISTRATION_BY_EMAIL_WELCOME_TO_FINUTSS_OUR_SOCIAL_FITNESS_SERVICE'
                                          .tr,
                                ),
                              ])),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: customButton(
                            onTapFunction: () {
                              authController.loginFormKey = GlobalKey<FormState>();
                              Get.until((route) {
                                return route.isFirst;
                              });
                            },
                            radius: 15,
                            height: 48,
                            text: 'OK'.tr,
                            fontWeight: FontWeight.w700,
                            textSize: 16),
                      ),
                    ],
                  ),
                ]),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(top: 14.h, right: 16.w),
                  child: CircleAvatar(
                    radius: 20.r,
                    backgroundColor: colorBackgroundSilver,
                    child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          CommunityMaterialIcons.window_close,
                          size: 24.r,
                          color: colorDarkGrey,
                        )),
                  ),
                ),
              )
              // Padding(
              //   padding: EdgeInsets.all(17.0),
              //   child: Column(
              //     children: [
              //       size15,
              //       Expanded(
              //         flex: 1,
              //         child: Stack(
              //           children: [
              //             Positioned.fill(
              //                 child: Center(
              //                     child: headingWidget(title: 'Welcome'))),
              //             Align(
              //               alignment: Alignment.centerRight,
              //               child: CircleAvatar(
              //                 backgroundColor: backgroundSilverColor,
              //                 child: IconButton(
              //                     onPressed: () {
              //                       Get.back();
              //                     },
              //                     icon: Icon(
              //                       CommunityMaterialIcons.window_close,
              //                       color: darkGreyColor,
              //                     )),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //       Expanded(
              //         flex: 3,
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             RichText(
              //                 overflow: TextOverflow.visible,
              //                 textAlign: TextAlign.center,
              //                 text: TextSpan(
              //                     style: TextStyle(
              //                       height: 2,
              //                       fontSize: 14,
              //                       fontWeight: FontWeight.w400,
              //                       color: whitishColor,
              //                     ),
              //                     children: [
              //                       TextSpan(
              //                         text:
              //                             'After signing up, you can sign up by',
              //                       ),
              //                       TextSpan(
              //                           text: '\n email authentication.',
              //                           style: TextStyle(
              //                             color: pinkColor,
              //                           )),
              //                       TextSpan(
              //                         text:
              //                             '\n\nWelcome to Peanuts, \nour social fitness service.',
              //                       )
              //                     ])),
              //           ],
              //         ),
              //       ),
              //       Expanded(
              //         flex: 1,
              //         child: Row(
              //           children: [
              //             Expanded(
              //               child: customButton(
              //                   onTapFunction: () {
              //                     Get.to(() => MainPage());
              //                   },
              //                   radius: 15,
              //                   height: 48,
              //                   text: 'OK'.tr,
              //                   fontWeight: FontWeight.w700,
              //                   textSize: 16),
              //             ),
              //           ],
              //         ),
              //       )
              //     ],
              //   ),
              // ),
            ],
          )),
    );
  }
}
