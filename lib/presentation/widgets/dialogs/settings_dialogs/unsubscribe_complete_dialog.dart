import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/heading_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:get/get.dart';

class UnsubscribeCompleteDialog extends StatelessWidget {
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
                top: 20.h,
                bottom: 30.h,
                left: 15.w,
                right: 15.w,
                child: Column(
                  children: [
                    size5,
                    Center(
                        child: headingWidget(title: 'COMPLETE_UNSUBSCRIBE'.tr)),
                    Expanded(
                      child: Center(
                        child: customText(
                            text:
                                "AUTOMATIC_PAYMENT_CANCELLATION_HAS_BEEN_PROCESSED"
                                    .tr,
                            fontColor: colorWhitish,
                            fontSize: 14,
                            height: 1.5,
                            textAlign: TextAlign.center),
                      ),
                    ),
                    Column(
                      children: [
                        customText(
                            text: "SUBSCRIPTION_PERIOD".tr +
                                ":2021.10.05 to 2022.01.05",
                            fontColor: colorBlue,
                            fontSize: 14,
                            height: 2,
                            textAlign: TextAlign.center),
                        size10,
                        Row(
                          children: [
                            Expanded(
                              child: customButton(
                                  onTapFunction: () {
                                    Get.back();
                                    Get.back();
                                    Get.back();
                                  },
                                  radius: 15,
                                  height: 48,
                                  text: 'OK'.tr,
                                  fontWeight: FontWeight.w700,
                                  textSize: 16),
                            ),
                          ],
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
