import 'package:finutss/domain/controller/edit_body_info_controller.dart';
import 'package:finutss/presentation/screens/edit_body_info_screens/basic_body_info.dart';
import 'package:finutss/presentation/screens/edit_body_info_screens/edit_gender.dart';
import 'package:finutss/presentation/screens/edit_body_info_screens/edit_height.dart';
import 'package:finutss/presentation/screens/edit_body_info_screens/edit_weight.dart';
import 'package:finutss/presentation/screens/edit_body_info_screens/edit_year_of_birth.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/heading_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BodyInfoNavigation extends StatelessWidget {
  final EditBodyInfoController editBodyInfoController = Get.put(EditBodyInfoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackgroundSilver,
      body: GetBuilder<EditBodyInfoController>(builder: (controller) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /* --------------------------------- heading -------------------------------- */
                Expanded(
                  flex: 10,
                  child: headingWidget(title: editBodyInfoController.titleList[editBodyInfoController.screenIndex]),
                ),

                /* -------------------------------------------------------------------------- */
                /*                                    body                                    */
                /* -------------------------------------------------------------------------- */
                Expanded(
                    flex: 80,
                    child: (editBodyInfoController.screenIndex == 0)
                        ? editGenderWidget()
                        : (editBodyInfoController.screenIndex == 1)
                            ? editYearOfBirthWidget()
                            : (editBodyInfoController.screenIndex == 2)
                                ? editHeightWidget()
                                : (editBodyInfoController.screenIndex == 3)
                                    ? editWeightWidget()
                                    : (editBodyInfoController.screenIndex == 4)
                                        ? basicBodyInfoWidget()
                                        : Container()),
                /* ---------------------------------- text ---------------------------------- */
                size30,
                Expanded(
                  flex: 15,
                  child: Text(
                    editBodyInfoController.textList[editBodyInfoController.screenIndex],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colorWhitish,
                      fontSize: 14.sp,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                /* -------------------- the additional text where needed -------------------- */

                Expanded(
                  flex: 15,
                  child: Padding(
                    padding: EdgeInsets.only(top: 15.h),
                    child: Row(
                      children: [
                     /*   if (editBodyInfoController.screenIndex == 1 || editBodyInfoController.screenIndex == 3)
                          Icon(
                            Icons.cancel_outlined,
                            size: 24.r,
                            color: colorPink,
                          ),*/
                        Expanded(
                          child: Text(
                            editBodyInfoController.screenIndex == 1
                                ? 'YEAR_OF_BIRTH_INFO2'.tr
                                : editBodyInfoController.screenIndex == 3
                                    ? 'WEIGHT_INPUT_RECOMMENDATION'.tr
                                    : '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: colorPink,
                              fontSize: 14.sp,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /* --------------------------------- button --------------------------------- */
                Expanded(
                  flex: 20,
                  child: Row(
                    children: [
                      Expanded(
                        child: customButton(
                            text: controller.isNavigatedFromEditBodyInfo ? 'PREV'.tr : 'CANCEL'.tr,
                            textSize: 16,
                            height: 48,
                            textColor: colorDarkGrey,
                            color: Colors.transparent,
                            fontWeight: FontWeight.w700,
                            borderColor: Colors.grey,
                            onTapFunction: editBodyInfoController
                                    .isNavigatedFromEditBodyInfo //to differentiate between navigation routes
                                ? () {
                                     editBodyInfoController.onPrevButtonPressed();
                                    /*if (editBodyInfoController.screenIndex >= 1)
                                      editBodyInfoController.onPrevButtonPressed();
                                    if (editBodyInfoController.screenIndex == 0)
                                      editBodyInfoController.onGenderPrevButtonPressed();*/
                                  }
                                : () {
                                    editBodyInfoController.onCancelButtonPressed();
                                  }),
                      ),
                      size10,
                      if (editBodyInfoController.screenIndex == 4)
                        Expanded(
                          child: customButton(
                              text: 'OK'.tr,
                              textColor: Colors.white,
                              textSize: 16,
                              height: 48,
                              fontWeight: FontWeight.w700,
                              color: colorBlue,
                              onTapFunction: () {
                                editBodyInfoController.onOKButtonPressed();
                              }),
                        ),
                      if (editBodyInfoController.screenIndex <= 3)
                        Expanded(
                          child: customButton(
                              text: controller.isNavigatedFromEditBodyInfo //to differentiate between navigation routes
                                  ? 'NEXT'.tr
                                  : 'CHANGING_WEIGHT'.tr,
                              textColor: Colors.white,
                              textSize: 16,
                              height: 48,
                              fontWeight: FontWeight.w700,
                              color: colorBlue,
                              onTapFunction: controller.isNavigatedFromEditBodyInfo
                                  ? () {
                                      if (editBodyInfoController.screenIndex == 3)
                                        editBodyInfoController.calculateBMI();
                                      editBodyInfoController.onNextButtonPressed();
                                    }
                                  : () {
                                      editBodyInfoController.onRecordButtonPressed();
                                    }),
                        )
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
}
