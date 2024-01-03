import 'package:finutss/constants.dart';
import 'package:finutss/domain/controller/withdrawal_controller.dart';
import 'package:finutss/presentation/widgets/common_widgets/confirmation_text_field.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget confirmationCard({selectFieldType = 0}) {
  return GetBuilder<WithdrawalController>(builder: (withdrawalController) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color(0xFFFFFFFF),
        ),
        // height: 265,
        width: Get.width,
        child: Column(
          children: [
            size10,
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                // vertical: 10,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: customText(
                    text: 'LEAVE_THE_FINUTSS_SERVICE_ENTER_THE_APPROVE_TEXT_AND_PRESS_THE_OK_BUTTON'.tr,
                    fontColor: Color(0xFF7F8391),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: confirmationTextField(
                  isButtonInTextField: true,
                  buttonText: 'ENTER'.tr,
                  controller: withdrawalController.confirmTextController,
                  onPressFunction: () {
                    withdrawalController.checkConfirmText();
                  }),
            ),
            // selectFieldType == 0
            //     ? Padding(
            //         padding: EdgeInsets.symmetric(
            //           horizontal: 16,
            //           vertical: 10,
            //         ),
            //         child: Row(
            //           children: [
            //             Padding(
            //               padding: EdgeInsets.symmetric(
            //                 horizontal: 0,
            //                 vertical: 16,
            //               ),
            //               child: Container(
            //                 height: 50,
            //                 width: (Get.width - 32) * (1.7 / 3),
            //                 child: customTextField(
            //                   hintText: "Approve",
            //                 ),
            //               ),
            //             ),
            //             Expanded(
            //               child: customButton(
            //                   onTapFunction: () {
            //                     // Get.back();
            //                     // Get.dialog(ConfirmBlock());
            //                   },
            //                   radius: 16,
            //                   height: 48,
            //                   text: 'Enter',
            //                   fontWeight: FontWeight.w700,
            //                   textSize: 16,
            //                   color: Color(0xFFCDD5E9)),
            //             ),
            //           ],
            //         ),
            //       )
            //     : Container(),
          ],
        ),
      ),
    );
  });
}
