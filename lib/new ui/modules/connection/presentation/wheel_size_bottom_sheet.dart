import 'package:finutss/new%20ui/controller/new_sensor_controller.dart';
import 'package:finutss/new%20ui/modules/connection/controller/connection_controller.dart';
import 'package:finutss/new%20ui/modules/connection/widget/close_button.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/cancel_save_button.dart';
import 'package:finutss/new%20ui/widget/custom_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> wheelSizeBottomSheet(BuildContext context) {
  ConnectionController controller = Get.find();
  NewSensorController sensorController=Get.find();
  /*List<String> wheelList = [
    '[Indooe-Auto]',
    '700 x 18c',
    '700 x 19c',
    '700 x 20c',
    '700 x 21c',
    '700 x 22c',
    '700 x 23c',
    '700 x 24c',
    '700 x 25c',
    '700 x 26c',
    '700 x 27c',
    '700 x 28c',
    '700 x 29c',
    '700 x 30c',
    '700 x 31c',
  ];*/
  RxInt selectIndex = sensorController.wheelSizesList
      .indexWhere((note) {
        return note[0].toLowerCase() ==
          controller.selectWheelSize.value.toLowerCase();
      })
      .obs;

  return showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(12),
      ),
    ),
    enableDrag: false,
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: Colors.black.withOpacity(0.2),
    builder: (context) {
      return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12),
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            CloseButtonCustom(
              onTap: (){
                Get.back();
              },
        ),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.elliptical(
                      MediaQuery.of(context).size.width,
                      100.0,
                    ),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(
                  horizontal: 32.w,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 26.h,
                    ),
                    Text(
                      'WHEEL_SIZE'.tr.toUpperCase(),
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
                        CustomVIew.selectDecorationPurple(),
                        Obx(() {
                          return Container(
                            child: CupertinoPicker(
                              scrollController:
                                  FixedExtentScrollController(
                                      initialItem: selectIndex.value),
                              onSelectedItemChanged: (index) {
                                selectIndex.value = index;
                              },
                              itemExtent: 60.h,
                              looping: false,
                              diameterRatio: 50,
                              selectionOverlay: Container(),
                              backgroundColor: Colors.transparent,
                              children: [
                                for (var index = 0;
                                index < sensorController.wheelSizesList.length;
                                index++)
                                  CustomVIew.customSelectWheelItem(
                                    text: sensorController.wheelSizesList[index][0],
                                    height: 45.h,
                                    isSelect: selectIndex.value ==
                                        index
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
                    CancelSaveButton(
                      onTapCancel: () {
                        Navigation.pop();
                      },
                      onTapSave: () {
                        sensorController.selectWheelSize(
                            sensorController.wheelSizesList[selectIndex.value][1]);
                        controller.selectWheelSize.value= sensorController.wheelSizesList[selectIndex.value][0].toString();
                       // controller.selectWheelSize.value = wheelList[selectIndex.value].toString();
                        Navigation.pop();
                      },
                    ),
                    SizedBox(
                      height: 34.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
