import 'package:finutss/new%20ui/controller/new_sensor_controller.dart';
import 'package:finutss/new%20ui/modules/connection/widget/close_button.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/custom_slider_button.dart';
import 'package:finutss/presentation/presentation/animation/bouncing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class speedCalibrationBottomSheet extends StatefulWidget {
  @override
  State<speedCalibrationBottomSheet> createState() =>
      _SpeedCalibrationDialogState();
}

class _SpeedCalibrationDialogState extends State<speedCalibrationBottomSheet> {
  NewSensorController sensorController = Get.find();

  @override
  void dispose() {
    sensorController.cancleNotification();
    super.dispose();
  }

  _SpeedCalibrationDialogState() {
    if (sensorController.deviceCadence != null) {
      sensorController.setCadenceNotification((p1) {
        print('$p1');
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
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
                  horizontal: 18.w,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 26.h,
                              ),
                              Text(
                                'SPEED_CALIBRATION'.tr.toUpperCase(),
                                style: TextStyle(
                                    color: AppColor.subTitleColor,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.2,
                                    fontSize: 20.sp),
                              ),
                              SizedBox(
                                height: 13.h,
                              ),
                              Image.asset(
                                IconAssets.speedCalibrationIcon,
                                height: 158.h,
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.w),
                                  color: AppColor.calibrationCardColor,
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 14.5.h, horizontal: 14.w),
                                child: Column(
                                  children: [
                                    Text(
                                      "CALIBRATE_INFO".tr,
                                      style: TextStyle(
                                          color: AppColor.subTitleColor
                                              .withOpacity(0.7),
                                          fontSize: 12.8.sp,
                                          fontWeight: FontWeight.w400,
                                          height: 1.7),
                                    ),
                                    SizedBox(
                                      height: 11.h,
                                    ),
                                   /* Text(
                                      AppString.theCorrectionMayVery,
                                      style: TextStyle(
                                          color: AppColor.subTitleColor
                                              .withOpacity(0.7),
                                          fontSize: 12.8.sp,
                                          fontWeight: FontWeight.w400,
                                          height: 1.7),
                                    ),*/
                                    SizedBox(
                                      height: 19.h,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: AppColor.whiteColor,
                                        borderRadius:
                                            BorderRadius.circular(8.w),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 22.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'CUURNT_SPEED'.tr,
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600,
                                                color: AppColor
                                                    .subTitleColor),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(top: 7.h),
                                            child: Obx(() {
                                              String km =
                                                  '${((sensorController.mCrank["crankCadence"] ?? 0.0) * sensorController.sensitivityList[sensorController.sensitivity.value]).toStringAsFixed(0)}';
                                              return SleekCircularSlider(
                                                initialValue:
                                                    double.parse(km),
                                                innerWidget: null,
                                                appearance:
                                                    CircularSliderAppearance(
                                                  size: 56.h,
                                                  customWidths:
                                                      CustomSliderWidths(
                                                    trackWidth: 3,
                                                    progressBarWidth: 4,
                                                  ),
                                                  infoProperties:
                                                      InfoProperties(
                                                    bottomLabelStyle:
                                                        TextStyle(
                                                      color: AppColor
                                                          .subTitleColor,
                                                      fontSize: 10.sp,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontFamily:
                                                          'MontserratItalic',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    bottomLabelText:
                                                        "KMH".tr,
                                                    mainLabelStyle:
                                                        TextStyle(
                                                      color: AppColor
                                                          .orangeColor,
                                                      fontSize: 20.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    modifier:
                                                        (double value) {
                                                      String km =
                                                          '${((sensorController.mCrank["crankCadence"] ?? 0.0) * sensorController.sensitivityList[sensorController.sensitivity.value]).toStringAsFixed(0)}';
                                                      return km;
                                                    },
                                                  ),
                                                  customColors:
                                                      CustomSliderColors(
                                                    progressBarColor:
                                                        AppColor
                                                            .orangeColor,
                                                    trackColor:
                                                        AppColor.inActiveBg,
                                                    shadowColor:
                                                        AppColor.gray,
                                                  ),
                                                  animationEnabled: false,
                                                ),
                                                min: 0,
                                                max: 100,
                                                onChange: null,
                                                onChangeEnd: null,
                                              );
                                            }),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 22.h,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  " " + 'SPEED_CALIBRATION'.tr,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.subTitleColor),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 22.w),
                                child: Row(
                                  children: [
                                    UpDownCard(
                                      icon: IconAssets.downArrow,
                                      title: 'DOWN'.tr,
                                      bgColor: AppColor.pinkSlider
                                          .withOpacity(0.12),
                                      textColor: AppColor.pinkSlider,
                                      onTap: () {
                                        sensorController
                                            .decreaseSpeedCalibration();
                                      },
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Obx(() => Text(
                                              '+${sensorController.sensitivity.value.toString()}',
                                              style: TextStyle(
                                                color: AppColor.orangeColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 21.sp,
                                              ),
                                            )),
                                      ),
                                    ),
                                    UpDownCard(
                                      icon: IconAssets.upArrow,
                                      title: 'UP'.tr,
                                      bgColor:
                                          AppColor.blue.withOpacity(0.12),
                                      textColor: AppColor.blue,
                                      onTap: () {
                                        sensorController
                                            .increaseSpeedCalibration();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 30.w),
                      child: CustomSliderButton(
                        isCancelButton: false,
                        title: 'SAVE'.tr,
                        onTap: () {
                          Navigation.pop();
                        },
                        fontSize: 16.sp,
                        height: 42.h,
                      ),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*
Future<void> speedCelibrationBottomSheet(BuildContext context) {
  ConnectionController controller = Get.find();
  NewSensorController sensorController=Get.find();
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
        height: MediaQuery.of(context).size.height * 2,
        width: MediaQuery.of(context).size.width,
        child: SizedBox(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: 50.h,
                bottom: 0,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 12.w),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Image.asset(
                            IconAssets.close,
                            scale: 4,
                          ),
                        ),
                      ),
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
                          horizontal: 18.w,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 26.h,
                                ),
                                Text(
                                  AppString.speedCalibration.toUpperCase(),
                                  style: TextStyle(
                                      color: AppColor.subTitleColor,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.2,
                                      fontSize: 20.sp),
                                ),
                                SizedBox(
                                  height: 13.h,
                                ),
                                Image.asset(
                                  IconAssets.speedCalibrationIcon,
                                  height: 158.h,
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.w),
                                    color: AppColor.calibrationCardColor,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 14.5.h, horizontal: 14.w),
                                  child: Column(
                                    children: [
                                      Text(
                                        AppString.compareTheSpeed,
                                        style: TextStyle(
                                            color: AppColor.subTitleColor
                                                .withOpacity(0.7),
                                            fontSize: 12.8.sp,
                                            fontWeight: FontWeight.w400,
                                            height: 1.7),
                                      ),
                                      SizedBox(
                                        height: 11.h,
                                      ),
                                      Text(
                                        AppString.theCorrectionMayVery,
                                        style: TextStyle(
                                            color: AppColor.subTitleColor
                                                .withOpacity(0.7),
                                            fontSize: 12.8.sp,
                                            fontWeight: FontWeight.w400,
                                            height: 1.7),
                                      ),
                                      SizedBox(
                                        height: 19.h,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: AppColor.whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(8.w),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 22.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              AppString.currentSpeed,
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      AppColor.subTitleColor),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 7.h),
                                              child: SleekCircularSlider(
                                                initialValue: 0,
                                                innerWidget: null,
                                                appearance:
                                                    CircularSliderAppearance(
                                                  size: 56.h,
                                                  customWidths:
                                                      CustomSliderWidths(
                                                    trackWidth: 3,
                                                    progressBarWidth: 4,
                                                  ),
                                                  infoProperties: info03,
                                                  customColors:
                                                      CustomSliderColors(
                                                    progressBarColor:
                                                        AppColor.orangeColor,
                                                    trackColor:
                                                        AppColor.inActiveBg,
                                                    shadowColor: AppColor.gray,
                                                  ),
                                                  animationEnabled: false,
                                                ),
                                                min: 0,
                                                max: 100,
                                                onChange: (value) {},
                                                onChangeEnd: (value) {},
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 22.h,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    " " + AppString.currentCalibration,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.subTitleColor),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 22.w),
                                  child: Row(
                                    children: [
                                      UpDownCard(
                                        icon: IconAssets.downArrow,
                                        title: AppString.down,
                                        bgColor: AppColor.pinkSlider
                                            .withOpacity(0.12),
                                        textColor: AppColor.pinkSlider,
                                        onTap: () {
                                          sensorController.decreaseSpeedCalibration();
                                        },
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Obx(() => Text(
                                                "+ " +
                                                    '+${sensorController.sensitivity.toString()}',
                                                style: TextStyle(
                                                  color: AppColor.orangeColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 21.sp,
                                                ),
                                              )),
                                        ),
                                      ),
                                      UpDownCard(
                                        icon: IconAssets.upArrow,
                                        title: AppString.up,
                                        bgColor:
                                            AppColor.blue.withOpacity(0.12),
                                        textColor: AppColor.blue,
                                        onTap: () {
                                          sensorController.increaseSpeedCalibration();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 30.w),
                                  child: CustomSliderButton(
                                    isCancelButton: false,
                                    title: 'SAVE'.tr,
                                    onTap: () {
                                      Navigation.pop();
                                      Navigation.pop();
                                    },
                                    fontSize: 16.sp,
                                    height: 42.h,
                                  ),
                                ),
                                SizedBox(
                                  height: 14.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}*/

class UpDownCard extends StatelessWidget {
  final String? icon;
  final String? title;
  final VoidCallback onTap;
  final Color? bgColor;
  final Color? textColor;

  UpDownCard({this.icon, this.title, required this.onTap, this.bgColor, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Bouncing(
      duration: Duration(milliseconds: 100),
      onPressed: onTap,
      child: Container(
        height: 69.w,
        width: 73.w,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(5.w),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 6.w,
            ),
            SvgPicture.asset(
              icon!,
              height: 9.3.w,
            ),
            SizedBox(
              height: 13.w,
            ),
            Text(
              title!,
              style: TextStyle(
                color: textColor,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
