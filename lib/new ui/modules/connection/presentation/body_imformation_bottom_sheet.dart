import 'package:finutss/new%20ui/modules/record/controller/bmi_slider_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/widget/bmi_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BodyInformationScreen extends StatelessWidget {
  BodyInformationScreen({Key? key, this.title, this.icon}) : super(key: key);

  String? title;
  String? icon;
  final BmiSliderController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 22.h, top: 8.h),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "BODY_INFO".tr,
                  style: TextStyle(
                    color: AppColor.blueTextColor,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.basicInfoBg,
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 24.h,
                      horizontal: 22.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "BASIC_BODY_INFO".tr,
                          style: TextStyle(
                            color: AppColor.blueTextColor,
                            fontSize: 16.sp,
                            letterSpacing: 0.4,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        BasicInformationRow(
                          "GENDER".tr,
                          controller.selectGender,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        BasicInformationRow(
                          "YEAR_OF_BIRTH".tr,
                          controller.selectYearOfBirth,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        BasicInformationRow(
                          "HEIGHT".tr,
                          controller.selectHeight + " " + "CM".tr,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        BasicInformationRow(
                          "WEIGHT".tr,
                          controller.selectWeight + " " + "KG".tr,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.basicInfoBg,
                    borderRadius: BorderRadius.circular(
                      14,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 19.h,
                      horizontal: 20.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "BMI".tr,
                              style: TextStyle(
                                color: AppColor.blueTextColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                            Spacer(),
                            Obx(() {
                              return Text(
                                  '${double.parse("${controller.bmi.value}".substring(0, "${controller.bmi.value}".indexOf(".") + 2)).toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: AppColor.greenSliderBg,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
                                  ),
                                );
                            }),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Obx(() {
                          var sliderValue = "${controller.bmi.value}".substring(
                              0, "${controller.bmi.value}".indexOf(".") + 2);
                          return bmiSlider(
                            bmiSliderController: controller,
                            bmi: double.parse(sliderValue),
                            showLabel: false,
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

Widget BasicInformationRow(String? Name, String? Title) {
  return Row(
    children: [
      Expanded(
        flex: 3,
        child: Text(
          Name ?? "GENDER".tr,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: AppColor.subTitleColor.withOpacity(0.8),
          ),
        ),
      ),
      Expanded(
        flex: 5,
        child: Text(
          Title ?? "FEMALE".tr,
          style: TextStyle(
            letterSpacing: 0.4,
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
            color: AppColor.subTitleColor,
          ),
        ),
      ),
    ],
  );
}
