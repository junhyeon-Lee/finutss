import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:finutss/constants.dart';

import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/heading_widget.dart';
import 'package:get/get.dart';
class UnApprovedAccountDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
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
                    Center(child: headingWidget(title: 'UNAPPROVED_ACCOUNT'.tr, size: 24)),
                    Expanded(
                        child: Center(
                          child: customText(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.visible,
                              fontColor: colorWhitish,
                              height: 1.5,
                              textAlign: TextAlign.center,
                              text: 'UNAPPROVED_ACCOUNT_TXT'.tr),
                        )),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                border: Border.all(color: Colors.black)),
                            child: customButton(
                                onTapFunction: () {
                                  Get.back();
                                },
                                radius: 16,
                                height: 48,
                                text: 'CLOSE'.tr,
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
                              },
                              radius: 16,
                              height: 48,
                              color: colorBlue,
                              text: 'RE_SEND'.tr,
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