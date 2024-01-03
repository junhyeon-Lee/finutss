import 'dart:developer';

import 'package:finutss/new%20ui/controller/login_controller.dart';
import 'package:finutss/new%20ui/modules/connection/presentation/connection_connect_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/home/widget/custom_button.dart';
import 'package:finutss/new%20ui/modules/track/controller/track_controller.dart';
import 'package:finutss/new%20ui/modules/track/controller/track_detail_controller.dart';
import 'package:finutss/new%20ui/modules/workout/precautions_bottomsheet.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/seekbar_thumb_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> ModeSelectBottomSheet(BuildContext context,{required String trackId,required TrackDetailController trackDetailController}) {
  TrackController controller = Get.put(TrackController());
  LoginController loginController = Get.find();
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
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 3.w),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(12),
            ),
          ),
          height: MediaQuery.of(context).size.height * 2,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 15.w, top: 163.h),
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Image.asset(
                        IconAssets.close,
                        scale: 4,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.vertical(
                      top: Radius.elliptical(
                          MediaQuery.of(context).size.width, 74.0)),
                ),
                height: MediaQuery.of(context).size.height * 0.92,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 10.w, right: 10.w, top: 32.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "MODE_SELECT".tr,
                          style: TextStyle(
                            color: AppColor.blueTextColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 19.h,
                        ),
                        Text(
                          "TRACK_CREATORS_DO_NOT_INCUR_ANY_ADDITIONAL_FEES".tr,
                          style: TextStyle(
                              height: 1.5,
                              fontWeight: FontWeight.w400,
                              color: AppColor.subTitleColor.withOpacity(0.7),
                              fontSize: 13.sp),
                        ),
                        SizedBox(
                          height: 19.h,
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 14.w, vertical: 16.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.w),
                              color: AppColor.commentCardBg),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "NORMAL".tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.subTitleColor,
                                    fontSize: 16.sp),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                "CONNECT_THE_SENSOR_AND_TEST_IT".tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.subTitleColor
                                        .withOpacity(0.7),
                                    fontSize: 11.sp),
                              ),
                              SizedBox(
                                height: 25.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomButton(
                                    title: "START_NOW".tr.toUpperCase(),
                                    backgroundColor: AppColor.orangeColor,
                                    fontColor: AppColor.whiteColor,
                                    borderColor: AppColor.orangeColor,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                    borderRadius: 9.w,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 40.w, vertical: 9.3.h),
                                    onTap: () async {
                                      String type = await loginController.getCurrentType();
                                      if(type==IconAssets.ridingSensor||type==IconAssets.runGroupBoy||type==IconAssets.mobileSensor){
                                        precautionsBottomSheet(context,trackId: trackId,trackDetailController: trackDetailController);
                                      }else{
                                        connectionConnectBottomSheet(context);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 18.h,
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 14.w, vertical: 16.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.w),
                              color: AppColor.commentCardBg),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "AUTO_DRIVING".tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.subTitleColor,
                                    fontSize: 16.sp),
                              ),
                              SizedBox(
                                height: 6.h,
                              ),
                              Text(
                                'IT_AUTOMATICALLY_DRIVES_AT_THE_SPECIFIED_SPEED'
                                    .tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.subTitleColor
                                        .withOpacity(0.7),
                                    fontSize: 11.sp),
                              ),
                              SizedBox(
                                height: 25.h,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "SPEED".tr,
                                    style: TextStyle(
                                        color: AppColor.subTitleColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp),
                                  ),
                                  Spacer(),
                                  Obx(
                                      ()=> Text(
                                      controller.speedValue.value.toInt().toString(),
                                      style: TextStyle(
                                          color: AppColor.subTitleColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13.sp),
                                    ),
                                  ),
                                  Text(
                                    "KMH".tr,
                                    style: TextStyle(
                                        color: AppColor.subTitleColor
                                            .withOpacity(0.7),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11.sp),
                                  ),
                                ],
                              ),



                              SizedBox(
                                height: 7.h,
                              ),
                              Obx(() => SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      activeTrackColor: AppColor.greenSliderBg,
                                      inactiveTrackColor:
                                          AppColor.inActiveSliderBg,
                                      thumbColor: AppColor.greenSliderBg,
                                      overlayShape: RoundSliderOverlayShape(
                                          overlayRadius: 0),
                                      trackHeight: 3.2,
                                      trackShape: CustomTrackShape(),
                                      thumbShape: SeekBarThumbShape(
                                        thumbRadius: 7,
                                        roundness: 5,
                                        thickness: 2,
                                        color: AppColor.greenSliderBg,
                                      ),
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(0.0),
                                      child: Slider(
                                        min: 1,
                                        max: 60,
                                        value: controller.speedValue.value,
                                        onChanged: (newValue) {
                                          controller.speedValue.value =
                                              newValue;
                                        },
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                height: 2.h,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '1',
                                    style: TextStyle(
                                        color: AppColor.subTitleColor
                                            .withOpacity(0.6),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp),
                                  ),
                                  Spacer(),
                                  Text(
                                    '60',
                                    style: TextStyle(
                                        color: AppColor.subTitleColor
                                            .withOpacity(0.6),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp),
                                  ),
                                ],
                              ),
                              // SizedBox(
                              //   height: 31.h,
                              // ),
                              // Row(
                              //   children: [
                              //     Text(
                              //       "LOCATION".tr,
                              //       style: TextStyle(
                              //           color: AppColor.subTitleColor,
                              //           fontWeight: FontWeight.w500,
                              //           fontSize: 14.sp),
                              //     ),
                              //     Spacer(),
                              //     Text(
                              //       "12 ",
                              //       style: TextStyle(
                              //           color: AppColor.subTitleColor,
                              //           fontWeight: FontWeight.w600,
                              //           fontSize: 13.sp),
                              //     ),
                              //     Text(
                              //       "KM".tr,
                              //       style: TextStyle(
                              //           color: AppColor.subTitleColor
                              //               .withOpacity(0.7),
                              //           fontWeight: FontWeight.w500,
                              //           fontSize: 11.sp),
                              //     ),
                              //   ],
                              // ),
                              // SizedBox(
                              //   height: 7.h,
                              // ),
                              // Obx(() => SliderTheme(
                              //       data: SliderTheme.of(context).copyWith(
                              //         activeTrackColor: AppColor.greenSliderBg,
                              //         inactiveTrackColor:
                              //             AppColor.inActiveSliderBg,
                              //         thumbColor: AppColor.greenSliderBg,
                              //         overlayShape: RoundSliderOverlayShape(
                              //             overlayRadius: 0),
                              //         trackHeight: 3.2,
                              //         trackShape: CustomTrackShape(),
                              //         thumbShape: SeekBarThumbShape(
                              //           thumbRadius: 7,
                              //           roundness: 5,
                              //           thickness: 2,
                              //           color: AppColor.greenSliderBg,
                              //         ),
                              //       ),
                              //       child: Container(
                              //         width: double.infinity,
                              //         padding: EdgeInsets.all(0.0),
                              //         child: Slider(
                              //           min: 0,
                              //           max: 100,
                              //           value: controller.locationValue.value,
                              //           onChanged: (newValue) {
                              //             controller.locationValue.value =
                              //                 newValue;
                              //           },
                              //         ),
                              //       ),
                              //     )),
                              // SizedBox(
                              //   height: 2.h,
                              // ),
                              // Row(
                              //   children: [
                              //     Text(
                              //       '1',
                              //       style: TextStyle(
                              //           color: AppColor.subTitleColor
                              //               .withOpacity(0.6),
                              //           fontWeight: FontWeight.w500,
                              //           fontSize: 12.sp),
                              //     ),
                              //     Spacer(),
                              //     Text(
                              //       '50',
                              //       style: TextStyle(
                              //           color: AppColor.subTitleColor
                              //               .withOpacity(0.6),
                              //           fontWeight: FontWeight.w500,
                              //           fontSize: 12.sp),
                              //     ),
                              //   ],
                              // ),
                              SizedBox(
                                height: 32.h,
                              ),



                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomButton(
                                    title: "START_NOW".tr.toUpperCase(),
                                    backgroundColor: AppColor.orangeColor,
                                    fontColor: AppColor.whiteColor,
                                    borderColor: AppColor.orangeColor,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                    borderRadius: 9.w,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 40.w, vertical: 9.3.h),
                                    onTap: () async {
                                      precautionsBottomSheet(context,trackId: trackId,trackDetailController: trackDetailController);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
            ],
          ),
        ),
      );
    },
  );
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double? trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
