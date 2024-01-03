import 'package:finutss/domain/controller/sensor_controller.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/heading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:get/get.dart';

class SpeedCalibrationDialog extends StatefulWidget {
  @override
  State<SpeedCalibrationDialog> createState() => _SpeedCalibrationDialogState();
}

class _SpeedCalibrationDialogState extends State<SpeedCalibrationDialog> {
  final _sensorController = Get.put(SensorController());
  @override
  void dispose() {
    _sensorController.cancleNotification();
    super.dispose();
  }

  _SpeedCalibrationDialogState() {
    if (_sensorController.deviceCadence != null) {
      _sensorController.setCadenceNotification((p1) {
        print('$p1');
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SensorController>(builder: (sensorController) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.sp)),
        contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 48.h),
        backgroundColor: Colors.white,
        content: Container(
            // height: 700,
            width: Get.width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.w),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Center(child: headingWidget(title: 'CALIBRATE'.tr, textAlign: TextAlign.center)),
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
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  CommunityMaterialIcons.window_close,
                                  color: colorDarkGrey,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Center(
                                  child: Image.asset(
                                'assets/images/speed_calibration.png',
                                width: 250.w,
                                height: 130.h,
                                // width: MediaQuery.of(context).size.width * 0.45,
                                // height: MediaQuery.of(context).size.height / 3,
                              )),
                              RichText(
                                text: TextSpan(
                                  text: 'CALIBRATE_INFO'.tr,
                                  style: TextStyle(
                                    color: colorWhitish,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          size10,
                          Container(
                            height: 55.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.sp),
                              border: Border.all(
                                color: colorLightSilver,
                                width: 1,
                              ),
                              color: colorBackgroundSilver,
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "CUURNT_SPEED".tr,
                                  style: TextStyle(
                                    color: Color(0xff303443),
                                    fontSize: 14.sp,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${((sensorController.mCrank["crankCadence"] ?? 0.0) * sensorController.sensitivityList[sensorController.sensitivity]).toStringAsFixed(0)}',
                                      style: TextStyle(
                                        color: Color(0xff3bcce1),
                                        fontSize: 40.sp,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      "km/h",
                                      style: TextStyle(
                                        color: colorBlue,
                                        fontSize: 16.sp,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          size10,
                          Text(
                            "SPEED_CALIBRATION".tr,
                            style: TextStyle(
                              color: Color(0xff303443),
                              fontSize: 16.sp,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          size15,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              changeSpeedCalibration(
                                  text: 'DOWN'.tr,
                                  image: 'assets/images/arrow_down.png',
                                  onTap: () {
                                    sensorController.decreaseSpeedCalibration();
                                  }),
                              Text(
                                '+${sensorController.sensitivity.toString()}',
                                style: TextStyle(
                                  color: colorBlue,
                                  fontSize: 32.sp,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              changeSpeedCalibration(
                                  text: 'UP'.tr,
                                  image: 'assets/images/arrow_up.png',
                                  color: colorBlue,
                                  onTap: () {
                                    sensorController.increaseSpeedCalibration();
                                  }),
                            ],
                          ),
                          size25,
                          customButton(
                              text: 'SAVE'.tr,
                              textSize: 16.sp,
                              height: 48.h,
                              fontWeight: FontWeight.w700,
                              width: double.infinity,
                              onTapFunction: () {
                                Get.back();
                              }),
                          size25
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
      );
    });
  }

  changeSpeedCalibration({
    text = '',
    required image,
    color = const Color(0xfff73a6b),
    onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            child: Column(
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: color,
                    fontSize: 12.sp,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                size5,
                Image.asset(
                  image,
                ),
              ],
            ),
          ),
          Opacity(
            opacity: 0.1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: color,
              ),
              width: 75.w,
              height: 65.h,
            ),
          ),
        ],
      ),
    );
  }
}
