import 'package:finutss/domain/controller/sensor_controller.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_radio_tile.dart';
import 'package:finutss/presentation/widgets/common_widgets/heading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class WheelSizeDialog extends StatelessWidget {
  final sensorController = Get.put(SensorController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SensorController>(builder: (controller) {
      return AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 48.h),
        backgroundColor: Colors.white,
        content: Container(
            height: 650,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  size15,
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Center(child: headingWidget(title: 'WHEEL_SIZE'.tr)),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CircleAvatar(
                          backgroundColor: colorBackgroundSilver,
                          child: IconButton(
                              onPressed: () {
                                Get.back();
                                /*Get.back();
                                  Get.back();*/
                              },
                              icon: Icon(
                                CommunityMaterialIcons.window_close,
                                color: colorDarkGrey,
                              )),
                        ),
                      ),
                    ],
                  ),
                  size25,
                  Divider(
                    thickness: 1,
                  ),
                  Expanded(
                      child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 9.w),
                        child: Container(
                          height: 43,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: colorBlue,
                          ),
                        ),
                      ),
                      Container(
                        child: CupertinoPicker(
                          squeeze: 1.1,
                          onSelectedItemChanged: (index) {
                            sensorController.selectWheelSize(
                                sensorController.wheelSizesList[index][1]);
                            print(sensorController.circumference);
                          },
                          itemExtent: 43,
                          looping: true,
                          backgroundColor: Colors.transparent,
                          children: [
                            for (var index = 0;
                                index < sensorController.wheelSizesList.length;
                                index++)
                              customRadioTile(
                                text: sensorController.circumference ==
                                        sensorController.wheelSizesList[index]
                                            [1]
                                    ? '${sensorController.wheelSizesList[index][0]}'
                                    : '${sensorController.wheelSizesList[index][0]}',
                                color: sensorController.circumference ==
                                        sensorController.wheelSizesList[index]
                                            [1]
                                    ? Colors.transparent
                                    : Colors.transparent,
                                textColor: sensorController.circumference ==
                                        sensorController.wheelSizesList[index]
                                            [1]
                                    ? Colors.white
                                    : colorWhitish,
                                width: double.infinity,
                                // height: 20.0,
                                onTap: () {},
                              )
                          ],
                        ),
                      ),
                    ],
                  )),
                  size25,
                  Row(
                    children: [
                      Expanded(
                        child: customButton(
                            text: 'CANCEL'.tr,
                            onTapFunction: () {
                              Get.back();
                            },
                            textSize: 16,
                            height: 48,
                            textColor: Color(0xff303443),
                            color: Colors.transparent,
                            fontWeight: FontWeight.w700,
                            borderColor: Color(0xff303443)),
                      ),
                      size10,
                      Expanded(
                        child: customButton(
                            onTapFunction: () {
                              Get.back();
                            },
                            text: 'SAVE'.tr,
                            textSize: 16,
                            height: 48,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  size25
                ],
              ),
            )),
      );
    });
  }
}
