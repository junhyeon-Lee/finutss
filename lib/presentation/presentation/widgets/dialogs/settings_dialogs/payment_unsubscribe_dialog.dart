import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/heading_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:get/get.dart';

class PaymentUnsubscribeDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      content: Container(
          height: 390,
          child: Stack(
            children: [
              Positioned.fill(
                top: 36.h,
                bottom: 30.h,
                left: 15.w,
                right: 15.w,
                child: Column(
                  children: [
                    Center(child: headingWidget(title: 'SUBSCRIPTION_COMPLETION'.tr)),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          customText(
                              text: 'SUBSCRIPTION_COMPLETION_NOTICE'.tr,
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
                                Get.back();
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
            ],
          )),
    );
  }
}
