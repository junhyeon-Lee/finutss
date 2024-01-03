import 'package:finutss/presentation/screens/main_page.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/heading_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class LoginAsGuestDialog extends StatelessWidget {
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
                          text: 'GUEST_LOGIN_GUIDES'.tr),
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
                                text: 'CANCEL'.tr,
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
                                Get.to(() => MainPage());
                              },
                              radius: 16,
                              height: 48,
                              color: colorBlue,
                              text: 'CONFIRM'.tr,
                              fontWeight: FontWeight.w700,
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
            // child: Padding(
            //   padding: EdgeInsets.all(17.0.r),
            //   child: Column(
            //     // mainAxisAlignment: MainAxisAlignment.center,
            //     // crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       // size15,
            //       Expanded(
            //         flex: 10,
            //         child: Stack(
            //           children: [
            //             Positioned.fill(
            //                 child: Center(
            //                     child: headingWidget(title: 'Notice', size: 24))),
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
            //         flex: 30,
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             customText(
            //                 fontSize: 14,
            //                 fontWeight: FontWeight.w600,
            //                 overflow: TextOverflow.visible,
            //                 fontColor: whitishColor,
            //                 height: 1.5,
            //                 textAlign: TextAlign.center,
            //                 text:
            //                     'When a guest logs in, all personal data-based services and social services cannot be used smoothly. \nWould you like to proceed as it is?'),
            //           ],
            //         ),
            //       ),
            //       Expanded(
            //         flex: 10,
            //         child: Padding(
            //           padding: EdgeInsets.only(left: 8.0.w, right: 8.w),
            //           child: Row(
            //             children: [
            //               Expanded(
            //                 child: Container(
            //                   decoration: BoxDecoration(
            //                       borderRadius: BorderRadius.circular(15.r),
            //                       border: Border.all(color: Colors.black)),
            //                   child: customButton(
            //                       onTapFunction: () {
            //                         Get.back();
            //                       },
            //                       radius: 16,
            //                       height: 48,
            //                       text: 'CANCEL',
            //                       fontWeight: FontWeight.w700,
            //                       color: Color(0xffffffff),
            //                       textColor: Colors.black,
            //                       textSize: 16),
            //                 ),
            //               ),
            //               size15,
            //               Expanded(
            //                 child: customButton(
            //                     onTapFunction: () {
            //                       Get.to(() => MainPage());
            //                     },
            //                     radius: 16,
            //                     height: 48,
            //                     color: blueColor,
            //                     text: 'CONFIRM',
            //                     fontWeight: FontWeight.w700,
            //                     textSize: 16),
            //               ),
            //             ],
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // )
          ),
        ));
  }
}
