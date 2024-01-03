import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/heading_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class DeleteRecordDialog extends StatelessWidget {
  String title, description;
  Function()? callback;
  DeleteRecordDialog({required this.title, required this.description, Null Function()? this.callback});
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
                    Center(child: headingWidget(title: '$title')),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40.0.w),
                            child: customText(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.visible,
                                fontColor: colorWhitish,
                                height: 1.5,
                                textAlign: TextAlign.center,
                                text: '$description'),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: customButton(
                              onTapFunction: () {
                                Get.back();
                              },
                              radius: 15,
                              height: 48,
                              text: 'CANCEL'.tr,
                              color: Colors.white,
                              textColor: colorDarkGrey,
                              borderColor: colorDarkGrey,
                              textSize: 16),
                        ),
                        size10,
                        Expanded(
                          child: customButton(
                              onTapFunction: () {
                                if (callback != null) callback!();
                                Get.back();
                              },
                              radius: 15,
                              height: 48,
                              text: 'DELETE'.tr,
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
