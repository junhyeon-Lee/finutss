import 'package:finutss/helper/snackbar_helper.dart';
import 'package:finutss/helper/toast_helper.dart';
import 'package:finutss/new%20ui/controller/login_controller.dart';
import 'package:finutss/new%20ui/modules/connection/widget/close_button.dart';
import 'package:finutss/new%20ui/modules/home/controller/home_screen_controller.dart';
import 'package:finutss/new%20ui/modules/home/presentation/exerciser_bottom_sheet.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/log_utils.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/cancel_save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> connectionConnectBottomSheet(BuildContext context) {
  final HomeScreenController homeController = Get.find();
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
                bottom: 0,
                child: Column(
                  children: [
                    CloseButtonCustom(
                      onTap: () {
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
                            padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 38.h),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "CONNECTION".tr,
                                  style: TextStyle(
                                    color: AppColor.subTitleColor,
                                    fontSize: 19.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                Text(
                                  "SENSOR_CONNECTION_REQUEST_INFO".tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColor.subTitleColor.withOpacity(0.7),
                                    fontSize: 13.sp,
                                    height: 1.9,
                                    letterSpacing: 0.2,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  height: 13.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                                  child: CancelSaveButton(
                                    cancelTitle: 'DO_LATER'.tr,
                                    saveTitle: "CONNECT".tr.toUpperCase(),
                                    onTapCancel: () {
                                      Navigation.pop();
                                    },
                                    onTapSave: () async {
                                      await Permission.bluetooth.request();
                                      await Permission.bluetoothConnect.request();
                                      await Permission.bluetoothAdvertise.request();
                                      await Permission.bluetoothScan.request();

                                      bool isConnect = await checkDeviceBluetoothIsOn();
                                      if (isConnect) {
                                        String type = loginController.user?.data?.workoutType?.value ?? '';
                                        if (type == Constants.riding) {
                                          homeController.selectedIndex.value = 0;
                                        } else if (type == Constants.running) {
                                          homeController.selectedIndex.value = 1;
                                        } else if (type == Constants.mobileSensor) {
                                          homeController.selectedIndex.value = 2;
                                        }

                                        Navigation.pop();
                                        LogUtils.logMSG('Tapped on connect button in Connection dialog', StackTrace.empty);
                                        ExerciserBottomSheet(context);
                                      } else {
                                        AppToast.bluetoothSnackBar(message: 'BLUETOOTH_IS_OFF'.tr,bgColor: AppColor.backGroundColor,textColor: AppColor.red);
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 46.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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
}

Future<bool> checkDeviceBluetoothIsOn() async {
  return await FlutterBlue.instance.isOn;
}
