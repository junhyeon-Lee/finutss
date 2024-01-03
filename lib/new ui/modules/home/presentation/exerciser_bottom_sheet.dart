import 'package:finutss/new%20ui/controller/login_controller.dart';
import 'package:finutss/new%20ui/controller/new_sensor_controller.dart';
import 'package:finutss/new%20ui/modules/connection/presentation/bluetooth_connection_screen.dart';
import 'package:finutss/new%20ui/modules/connection/presentation/connection_notice_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/connection/presentation/mobile_device_connection.dart';
import 'package:finutss/new%20ui/modules/connection/widget/close_button.dart';
import 'package:finutss/new%20ui/modules/home/controller/home_screen_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/log_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> ExerciserBottomSheet(BuildContext context,
    {String? title, String? icon}) {
  final HomeScreenController homeController = Get.find();
  NewSensorController sensorController = Get.put(NewSensorController());
  LoginController loginController=Get.find();


  openScreen(int index){
    if((loginController.user?.data?.workoutType?.value ?? '')==Constants.riding ||  (loginController.user?.data?.workoutType?.value ?? '')==Constants.running || (loginController.user?.data?.workoutType?.value ?? '')==Constants.mobileSensor){
      connectionNoticeBottomSheet(Get.context!,index: index);
    }else{
      if(index==0){
        sensorController
            .setWorkoutType(Constants.riding);
        Navigator.of(Get.context!).push(
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
        Navigator.of(Get.context!).push(
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
          Get.context!,
          title: Constants.exerciserList[2].title,
          icon: Constants
              .exerciserList[2].topPrefixIcon,
        );
      }
    }
  }



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
                padding: EdgeInsets.symmetric(horizontal: 5.w),
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
                  padding: EdgeInsets.only(top: 35.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "EXERCISER".tr,
                        style: TextStyle(
                            color: AppColor.blueTextColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 21.sp),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 25.0.w, top: 14.h, right: 25.0.w),
                        child: Text(
                          'EXERCISE_CHOOSE_CONNECT'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColor.subTitleColor.withOpacity(0.7),
                            fontWeight: FontWeight.w400,
                            fontSize: 13.7.sp,
                            letterSpacing: 0.5,
                            height: 1.6,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Expanded(
                        child: GridView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(
                              horizontal: 14.w,),
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3 / 4.5,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 24,
                          ),
                          itemCount: Constants.exerciserList.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return InkWell(
                              onTap: () async {
                                homeController.selectedIndex.value = index;
                                if (index == 0) {

                                  LogUtils.logMSG('tapped on riding sensor', StackTrace.empty);
                                  await Permission.bluetooth.request();
                                  await Permission.bluetoothConnect.request();
                                  await Permission.bluetoothAdvertise.request();
                                  await Permission.bluetoothScan.request();
                                  await Permission.bluetoothScan
                                      .request()
                                      .isGranted;

                                  openScreen(0);
                                } else if (index == 1) {
                                  openScreen(1);
                                  LogUtils.logMSG('tapped on running sensor', StackTrace.empty);

                                } else if (index == 2) {
                                  //LogUtils.logMSG('tapped on mobile device sensor', StackTrace.empty);
                                  for (int a = 0;
                                      a < Constants.positionModelList.length;
                                      a++) {
                                    Constants.positionModelList[a].isSelected
                                        .value = false;
                                  }
                                  openScreen(2);
                                } else {
                                /*  sensorController
                                      .setWorkoutType(Constants.smartWatch);*/
                                }
                              },
                              child: Obx(
                                () => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.9),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColor.whiteColor,
                                      borderRadius: BorderRadius.circular(11),
                                      border: Border.all(
                                          width: 1.2,
                                          color: homeController
                                                      .selectedIndex.value ==
                                                  index
                                              ? AppColor.orangeColor
                                              : Colors.transparent),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColor.cardGradiant1
                                              .withOpacity(0.05),
                                          spreadRadius: 6,
                                          blurRadius: 20,
                                          offset: Offset(0,
                                              6), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.0.w,
                                          right: 10.0.w,
                                          top: 8.h),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Image.asset(
                                                Constants.exerciserList[index]
                                                    .topPrefixIcon,
                                                scale: 4,
                                              ),
                                              Image.asset(
                                                IconAssets.information,
                                                scale: 4,
                                              ),
                                            ],
                                          ),
                                          Image.asset(
                                            Constants
                                                .exerciserList[index].mainIcon,
                                            scale: 5,
                                          ),
                                          SizedBox(
                                            height: index == 3 ? 28.h : 17.h,
                                          ),
                                          Text(
                                            Constants
                                                .exerciserList[index].title.tr,
                                            style: TextStyle(
                                              color: AppColor.blueTextColor,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Flexible(
                                            child: Text(
                                              Constants.exerciserList[index]
                                                  .description.tr,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: AppColor
                                                      .blueTextColor[100]
                                                      ?.withOpacity(0.7),
                                                  fontSize: 13.sp,
                                                  height: 1.6),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      );
    },
  );
}

class HeaderWidget extends StatelessWidget {
  final String? icon;
  final String? title;

  HeaderWidget({this.icon, this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.0.h, bottom: 2.h),
      child: Column(
        children: [
          Text(
            "CONNECTION".tr,
            style: TextStyle(
              color: AppColor.blueTextColor,
              fontSize: 19.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 36.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "CONNECTION_STATUS".tr,
                style: TextStyle(
                  color: AppColor.blueTextColor[100],
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  decoration: BoxDecoration(
                      color: AppColor.lightPink,
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        icon ?? '',
                        scale: 3,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        title?.toLowerCase() ?? '',
                        style: TextStyle(
                            color: AppColor.darkPink,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
