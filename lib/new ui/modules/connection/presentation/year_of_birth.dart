import 'package:finutss/new%20ui/modules/record/controller/bmi_slider_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/widget/custom_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class YearOfBirthScreen extends StatelessWidget {
  YearOfBirthScreen({Key? key}) : super(key: key);

  final BmiSliderController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "YEAR_OF_BIRTH".tr,
          style: TextStyle(
            color: AppColor.subTitleColor,
            fontSize: 22.sp,
            letterSpacing: 0.2,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
        Expanded(
            child: Stack(
          alignment: Alignment.center,
          children: [
            CustomVIew.selectItemHeightWeight(),
            Obx(() {
              return Container(
                child: CupertinoPicker(
                  scrollController: FixedExtentScrollController(
                      initialItem: controller.selectIndexYear.value),
                  onSelectedItemChanged: (index) {
                    controller.selectIndexYear.value = index;
                    controller.selectYearOfBirth = controller
                        .yearList[controller.selectIndexYear.value]
                        .toString();
                  },
                  itemExtent: 60.h,
                  looping: false,
                  diameterRatio: 50,
                  selectionOverlay: Container(),
                  backgroundColor: Colors.transparent,
                  children: [
                    for (var index = 0;
                        index < controller.yearList.length;
                        index++)
                      CustomVIew.customSelectWheelItem(
                        text: controller.yearList[index].toString(),
                        height: 45.h,
                        isSelect:
                            controller.selectIndexYear == index ? true : false,
                        width: double.infinity,
                        onTap: () {},
                      )
                  ],
                ),
              );
            }),
          ],
        )),
        SizedBox(
          height: 16.h,
        ),
        Text(
          'YEAR_OF_BIRTH_INFO2'.tr,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 12.5.sp,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.2,
              height: 1.65,
              color: AppColor.sliderRedColor),
        )
      ],
    );
  }
}
