import 'package:finutss/new%20ui/controller/new_sensor_controller.dart';
import 'package:finutss/new%20ui/modules/connection/presentation/bluetooth_connection_screen.dart';
import 'package:finutss/new%20ui/modules/connection/presentation/calibration_guide_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/connection/presentation/mobile_device_connection.dart';
import 'package:finutss/new%20ui/modules/connection/widget/close_button.dart';
import 'package:finutss/new%20ui/modules/home/widget/custom_card_widget.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/app_string.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/custom_slider_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

Future<void> connectionNoticeBottomSheet(BuildContext context,{required int index}) {
  NewSensorController sensorController = Get.find();

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
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [

            Spacer(),

            CloseButtonCustom(
              onTap: (){
                Get.back();
              },
            ),

            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  alignment: Alignment.center,
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
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 15.w, right: 15.w, top: 38.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'NOTICE'.tr.toUpperCase(),
                          style: TextStyle(
                            color: AppColor.subTitleColor,
                            fontSize: 21.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 22.h,
                        ),
                        SvgPicture.asset(
                          IconAssets.wifiIconSvg,
                          height: 62.h,
                        ),
                        SizedBox(
                          height: 19.h,
                        ),
                        Text(
                          'SENSOR_IS_ALREADY_CONNECTED'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColor.purple,
                            fontSize: 14.5.sp,
                            fontFamily: 'MontserratItalic',
                            letterSpacing: 0.2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "THERE_IS_ALREADY_A_SENSOR_CONNECTED_PLEASE_DISCONNECT_THE_EXISTING_SENSOR_AND_TRY_TO_RECONNECT"
                              .tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColor.subTitleColor
                                .withOpacity(0.7),
                            fontSize: 13.sp,
                            height: 1.9,
                            letterSpacing: 0.2,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 39.h,
                        ),
                        Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 30.w),
                          child: CustomSliderButton(
                            title: 'RECONNECT'.tr,
                            isCancelButton: false,
                            onTap: () {
                              Navigation.pop();
                              if(index==0){
                                sensorController
                                    .setWorkoutType(Constants.riding);
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    opaque: false,
                                    pageBuilder:
                                        (BuildContext context, _, __) =>
                                        BluetoothConnectionScreen(
                                          title: Constants
                                              .exerciserList[index].title,
                                          icon: Constants
                                              .exerciserList[index].topPrefixIcon,
                                          searchDes: 'ATTEMPT_TO_CONNECT_TO_THE_SENSOR_RIDE',
                                          isShowWheelSize: true,
                                          isRiding: true,
                                        ),
                                  ),
                                );
                              }else if(index==1){
                                sensorController
                                    .setWorkoutType(Constants.running);
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    opaque: false,
                                    pageBuilder:
                                        (BuildContext context, _, __) =>
                                        BluetoothConnectionScreen(
                                          title: Constants.exerciserList[1].title,
                                          icon: Constants
                                              .exerciserList[1].topPrefixIcon,
                                          searchDes: 'ATTEMPT_TO_CONNECT_TO_THE_SENSOR_RUN',
                                          isShowWheelSize: false,
                                          isRiding: false,
                                        ),
                                  ),
                                );
                              }else if(index==2){
                                mobileDeviceConnectionBottomSheet(
                                  context,
                                  title: Constants.exerciserList[2].title,
                                  icon: Constants
                                      .exerciserList[2].topPrefixIcon,
                                );
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 49.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      );
    },
  );
}
