import 'package:finutss/new%20ui/modules/record/controller/bmi_slider_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/widget/custom_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HeightSelectionScreen extends StatelessWidget {
  HeightSelectionScreen({Key? key}) : super(key: key);

  final BmiSliderController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "HEIGHT".tr,
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
                      initialItem: controller.selectIndexHeight.value),
                  onSelectedItemChanged: (index) {
                    controller.selectIndexHeight.value = index;
                    controller.selectHeight = controller
                        .heightList[controller.selectIndexHeight.value]
                        .toString();
                  },
                  itemExtent: 60.h,
                  looping: false,
                  diameterRatio: 50,
                  selectionOverlay: Container(),
                  backgroundColor: Colors.transparent,
                  children: [
                    for (var index = 0;
                        index < controller.heightList.length;
                        index++)
                      CustomVIew.customSelectWheelItem(
                        text: controller.selectIndexHeight == index
                            ? controller.heightList[index].toString() + " " + "CM".tr
                            : controller.heightList[index].toString(),
                        height: 45.h,
                        isSelect: controller.selectIndexHeight == index
                            ? true
                            : false,
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
          'HEIGHT_INFO'.tr,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 12.5.sp,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.2,
              height: 1.65,
              color: AppColor.subTitleColor.withOpacity(0.8)),
        )
      ],
    );
  }
}
