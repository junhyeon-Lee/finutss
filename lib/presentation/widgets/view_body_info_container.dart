import 'package:finutss/domain/controller/edit_body_info_controller.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/user_bmi_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import 'common_widgets/custom_text.dart';

Widget viewBodyInfo({required gender, yearOfBirth, height, weight, bmi, width, isButton = false}) {
  final editBodyInfoController = Get.put(EditBodyInfoController());
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.r),
      color: Colors.white,
    ),
    padding: EdgeInsets.only(bottom: 20.h),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: colorLightGrey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              )),
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
          child: Text(
            "BASIC_BODY_INFO".tr,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 14.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  size15,
                  customText(
                    text: "${'GENDER'.tr} :",
                    fontColor: colorWhitish,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    // fontFamily: 'Montserrat-Medium.ttf'
                  ),
                  size15,
                  customText(
                    text: "${'YEAR_OF_BIRTH'.tr} :",
                    fontColor: colorWhitish,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    // fontFamily: 'Montserrat-Medium.ttf'
                  ),
                  size15,
                  customText(
                    text: "${'HEIGHT'.tr} :",
                    fontColor: colorWhitish,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    // fontFamily: 'Montserrat-Medium.ttf'
                  ),
                  size15,
                  customText(
                    text: "${'WEIGHT'.tr} :",
                    fontColor: colorWhitish,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    // fontFamily: 'Montserrat-Medium.ttf'
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 14.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  size15,
                  customText(
                    text: gender,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    // fontFamily: 'Montserrat-Medium.ttf'
                  ),
                  size15,
                  customText(
                    text: '$yearOfBirth',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    // fontFamily: 'Montserrat-Medium.ttf'
                  ),
                  size15,
                  customText(
                    text: "$height",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    // fontFamily: 'Montserrat-Medium.ttf'
                  ),
                  size15,
                  customText(
                    text: "$weight",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    // fontFamily: 'Montserrat-Medium.ttf'
                  ),
                ],
              ),
            ),
          ],
        ),
        size20,
        Container(
            color: colorLightGrey,
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customText(text: 'BMI'.tr, fontColor: Colors.white, fontWeight: FontWeight.w700),
                customText(
                    text: '${double.parse(bmi).toStringAsFixed(2)}',
                    fontColor: colorBlue,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ],
            )),
        size10,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0.w),
          child: bmiSlider(editBodyInfoController: editBodyInfoController, bmi: double.parse(bmi)),
        ),
        isButton
            ? Padding(
                padding: EdgeInsets.only(top: 18.h),
                child: customButton(
                    text: 'WEIGHT_EDIT'.tr,
                    textSize: 16,
                    fontWeight: FontWeight.bold,
                    height: 48,
                    width: 161,
                    radius: 15,
                    onTapFunction: () {
                      editBodyInfoController.onWeightEditButtonPressed();
                    }),
              )
            : Container()
      ],
    ),
  );
}
