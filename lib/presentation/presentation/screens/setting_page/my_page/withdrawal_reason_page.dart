import 'package:finutss/domain/controller/social_controller.dart';
import 'package:finutss/domain/controller/withdrawal_controller.dart';
import 'package:finutss/presentation/widgets/common_widgets/appbars/simple_appbar.dart';
import 'package:finutss/presentation/widgets/common_widgets/confirmation_card.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/expandable_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';

class WithdrawalReasonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(text: "WITHDRAWAL".tr, automaticallyImplyLeading: true) as PreferredSizeWidget?,
      body: GetBuilder<WithdrawalController>(builder: (withdrawalController) {
        return Container(
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
                      // height: 480,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xFFFFFFFF),
                      ),
                      child: Column(
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
                                  text: 'PLEASE_SELECT_A_REASON_FOR_WITHDRAWAL'.tr,
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
                          options(5, controller: withdrawalController.otherReasonTextController),
                          SizedBox(height: 24.h),
                        ],
                      )),
                ),
                confirmationCard(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  child: Row(
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
                              withdrawalController.withdrawal();
                            },
                            radius: 16,
                            height: 48,
                            text: 'WITHDRAWAL'.tr,
                            fontWeight: FontWeight.w700,
                            textSize: 16,
                            color: withdrawalController.isConfirm ? colorBlue : colorLightSilver),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget options(int optionIndex, {controller}) {
    final socialController = Get.put(SocialController());
    return GetBuilder<WithdrawalController>(builder: (withdrawalController) {
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(10.r),
                height: 18.h,
                width: 18.w,
                child: new Radio(
                  value: optionIndex,
                  groupValue: withdrawalController.radioValue,
                  onChanged: withdrawalController.handleRadioValueChange,
                ),
              ),
              Expanded(
                child: customText(
                    text: socialController.withdrawalReasons[optionIndex],
                    fontColor: Color(0xFF7F8391),
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 40.0.w, right: 23.w),
            child: socialController.withdrawalReasons[optionIndex] != 'OTHER_REASONS'.tr
                ? Container(
                    height: 1,
                    color: Color(0xFF7F8391),
                  )
                : expandableTextField(
                    enabled: withdrawalController.radioValue == 5 ? true : false,
                    controller: controller,
                    height: 94,
                    maxLine: 8,
                    hintText: "",
                    showBorder: true,
                    padding: 10),
          ),
        ],
      );
    });
  }
}
