import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/domain/controller/sensor_controller.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/dialogs/sensor_dialogs/speed_calibration_dialog.dart';
import 'package:finutss/presentation/widgets/dialogs/sensor_dialogs/wheel_size_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget addSensorRow() {
  return GetBuilder<AuthController>(builder: (authController) {
    return GetBuilder<SensorController>(builder: (sensorController) {
      print("sensorController.circumference ${sensorController.circumference}");
      return Column(
        children: [
          size10,
          RichText(
              text: TextSpan(
            text: 'PRESS_THE_CONNECT_BUTTON_TO_CONNECT_THE_SENSOR'.tr,
            style: TextStyle(
              color: Color(0xff303443),
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          )),
          size10,
           if ((authController.user?.workoutType ?? "Riding") == "Riding")
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.dialog(WheelSizeDialog(), barrierDismissible: false);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Color(0xffeff4ff),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 14.h,
                      ),
                      child: Column(
                        children: [
                          Text(
                            'WHEEL_SIZE'.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xff303443),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          size10,
                          Text(
                            sensorController.wheelSizesList
                                .firstWhere((element) => element[1] == sensorController.circumference)[0],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xfff73a6b),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                size15,
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.dialog(SpeedCalibrationDialog(), barrierDismissible: false);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Color(0xffeff4ff),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 14.h,
                      ),
                      child: Column(
                        children: [
                          Text(
                            "CALIBRATE_SPEED".tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xff303443),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          size10,
                          Text(
                            "(+${sensorController.sensitivity.toString()})",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xff3bcce1),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      );
    });
  });
}
