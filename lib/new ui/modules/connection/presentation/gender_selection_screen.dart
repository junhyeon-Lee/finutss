import 'package:finutss/new%20ui/modules/record/controller/bmi_slider_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class GenderSelectionScreen extends StatelessWidget {
  GenderSelectionScreen({Key? key}) : super(key: key);
  final BmiSliderController connectionController = Get.find();


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "GENDER".tr,
          style: TextStyle(
            color: AppColor.subTitleColor,
            fontSize: 22.sp,
            letterSpacing: 0.2,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 18.h,
        ),
        Container(
          height: 322.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Obx(() {
                return InkWell(
                  onTap: () {
                    connectionController.female.value =
                        !connectionController.female.value;
                    Constants.isSelectMaleFemale.value = false;
                    connectionController.selectGender = Constants.FEMALE;
                  },
                  child: SvgPicture.asset(
                    IconAssets.femaleSvg,
                    color: !Constants.isSelectMaleFemale.value
                        ? AppColor.pink
                        : AppColor.unSelectFemaleColor,
                  ),
                );
              }),
              Obx(() {
                return InkWell(
                  onTap: () {
                    connectionController.male.value =
                        !connectionController.male.value;
                    Constants.isSelectMaleFemale.value = true;
                    connectionController.selectGender = Constants.MALE;
                  },
                  child: SvgPicture.asset(
                    IconAssets.maleSvg,
                    color: Constants.isSelectMaleFemale.value
                        ? AppColor.blue
                        : AppColor.unSelectMaleColor,
                  ),
                );
              })
            ],
          ),
        ),
        SizedBox(
          height: 18.h,
        ),
        Flexible(
          child: Text(
            "GENDER_INFO".tr,
            style: TextStyle(
              color: AppColor.subTitleColor.withOpacity(0.6),
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
          ),
        ),
      ],
    );
  }
}
