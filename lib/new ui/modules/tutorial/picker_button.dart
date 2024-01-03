import 'package:finutss/new%20ui/modules/tutorial/tutorial_button.dart';
import 'package:finutss/new%20ui/modules/tutorial/tutorial_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:horizontal_picker/horizontal_picker.dart';

class HeightPicker extends StatelessWidget {
  const HeightPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TutorialController controller = Get.find();
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 40.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 45.h,
            decoration:BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12)),
                border: Border.all(color: Color(0xffff8c41), width: 1.5)),
            child: HorizontalPicker(
              minValue: 100,
              maxValue: 250,
              divisions: 150,
              suffix: "cm",
              showCursor: true,
              backgroundColor: Colors.transparent,
              activeItemTextColor: AppColor.orangeColor,
              passiveItemsTextColor: Colors.black,
              onChanged: (value) {
                controller.height.value = value;
              }, height: 70,
            ),
          ),
          SizedBox(height: 30.h,),
          GestureDetector(
              onTap: () {
                controller.chatFlow('${controller.height.value}cm',true);
                Future.delayed(const Duration(seconds: 1),(){
                  controller.chatFlow('User name님의\n몸무게를 알려주세요.',false);
                });
                controller.nextButton();
              },
              child: TutorialButton(title: '확인')),

        ],
      ),
    );
  }
}

class WeightPicker extends StatelessWidget {
  const WeightPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TutorialController controller = Get.find();
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 40.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 45.h,
            decoration:BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12)),
                border: Border.all(color: Color(0xffff8c41), width: 1.5)),
            child: HorizontalPicker(
              minValue: 30,
              maxValue: 300,
              divisions: 270,
              suffix: "kg",
              showCursor: true,
              backgroundColor: Colors.transparent,
              activeItemTextColor: AppColor.orangeColor,
              passiveItemsTextColor: Colors.black,
              onChanged: (value) {
                controller.weight.value = value;
              }, height: 50,
            ),
          ),
          SizedBox(height: 30.h,),
          GestureDetector(
              onTap: () {
                controller.chatFlow('${controller.weight.value}kg',true);
                Future.delayed(const Duration(seconds: 1),(){
                  controller.chatFlow('끝',false);
                });
                controller.nextButton();
                Get.back();
              },
              child: TutorialButton(title: '확인')),

        ],
      ),
    );
  }
}

