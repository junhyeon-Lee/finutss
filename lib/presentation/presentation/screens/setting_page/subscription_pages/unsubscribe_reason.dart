import 'package:finutss/domain/controller/social_controller.dart';
import 'package:finutss/presentation/widgets/common_widgets/appbars/simple_appbar.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/expandable_text_field.dart';
import 'package:finutss/presentation/widgets/dialogs/settings_dialogs/unsubscribe_complete_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';

class UnsubscribeReason extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(text: 'UNSUBSCRIBE'.tr, automaticallyImplyLeading: true) as PreferredSizeWidget?,
      body: Container(
        height: Get.height,
        // width: Get.width,
        color: Color(0xFFF5F7FA),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /* -------------------------------------------------------------------------- */
              /*                            reason to unsubscribe                           */
              /* -------------------------------------------------------------------------- */
              size10,
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                ),
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xFFFFFFFF),
                  ),
                  child: GetBuilder<SocialController>(
                      init: SocialController(),
                      builder: (socialController) {
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 16.h,
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  child: customText(
                                    text:
                                        "PLEASE_SELECT_A_REASON_FOR_UNSUBSCRIBE"
                                            .tr,
                                    fontColor: Color(0xFF303443),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            options(0),
                            SizedBox(height: 24.h),
                            options(1),
                            SizedBox(height: 24.h),
                            options(2),
                            SizedBox(height: 24.h),
                            options(3),
                            SizedBox(height: 24.h),
                            options(4),
                            SizedBox(height: 24.h),
                            options(5),
                            SizedBox(height: 24.h),
                          ],
                        );
                      }),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r), border: Border.all(color: Colors.black)),
                        child: customButton(
                            onTapFunction: () {},
                            radius: 16,
                            height: 48,
                            text: 'DO_LATER'.tr,
                            fontWeight: FontWeight.w700,
                            color: Color(0xffffffff),
                            textColor: Colors.black,
                            textSize: 16),
                      ),
                    ),
                    size15,
                    Expanded(
                      child: customButton(
                          onTapFunction: () {
                            // Get.back();
                            Get.dialog(UnsubscribeCompleteDialog());
                          },
                          radius: 16,
                          height: 48,
                          text: 'AUTO_PAYMENT_UNSUBSCRIBE'.tr,
                          fontWeight: FontWeight.w700,
                          textSize: 16,
                          color: Color(0xFF3BCCE1)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget options(int optionIndex) {
    SocialController socialController = Get.find();
    return Column(
      children: [
        Row(
          children: [
            new Radio(
              value: optionIndex,
              groupValue: socialController.radioValue,
              onChanged: socialController.handleRadioValueChange,
            ),
            customText(
                text: socialController.withdrawalReasons[optionIndex],
                fontColor: Color(0xFF7F8391),
                fontSize: 14,
                fontWeight: FontWeight.normal),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 40.0.w, right: 23.w),
          child: socialController.withdrawalReasons[optionIndex] != "Other reason"
              ? Container(
                  height: 1,
                  color: Color(0xFF7F8391),
                )
              : expandableTextField(
                  enabled: socialController.radioValue == 5 ? true : false,
                  height: 94,
                  maxLine: 8,
                  hintText: "",
                  showBorder: true,
                  padding: 10),
        ),
      ],
    );
  }
}
