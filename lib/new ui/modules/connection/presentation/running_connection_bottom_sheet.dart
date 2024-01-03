import 'package:finutss/new%20ui/modules/connection/controller/connection_controller.dart';
import 'package:finutss/new%20ui/modules/connection/widget/close_button.dart';
import 'package:finutss/new%20ui/modules/connection/widget/device_tile.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/app_string.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/widget/bluetooth_connection_tile.dart';
import 'package:finutss/new%20ui/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> RunningConnectionBottomSheet(BuildContext context,
    {String? title, String? icon}) {
  final ConnectionController connectionController = Get.find();
  connectionController.isRescan.value = false;
  return showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(12),
      ),
    ),
    useRootNavigator: true,
    enableDrag: false,
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.black.withOpacity(0.2),
    builder: (context) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 3.w),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12),
          ),
        ),
        height: MediaQuery.of(context).size.height * 2,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Spacer(),
                Container(
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
                  height: MediaQuery.of(context).size.height * 0.92,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 15.w, right: 15.w, top: 15.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        HeaderWidget(
                          icon: icon,
                          title: title,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            primary: true,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        Constants.connectionModelList.length -
                                            1,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return BluetoothConnectionTile(
                                        bluetoothName: Constants
                                            .connectionModelList[index]
                                            .bluetoothName,
                                        bluetoothNumber: Constants
                                            .connectionModelList[index]
                                            .bluetoothNumber,
                                        isConnect: Constants
                                            .connectionModelList[index]
                                            .isConnect
                                            .value,
                                        networkIcon: Constants
                                            .connectionModelList[index]
                                            .networkIcon,
                                        topPrefixIcon: Constants
                                            .connectionModelList[index]
                                            .topPrefixIcon,
                                        isBluetooth: false,
                                        onTap: () {},
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 25.h,
                                ),
                                Flexible(
                                  flex: 5,
                                  child: Obx(
                                    () => Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: AppColor.whiteColor[100],
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 20.h, horizontal: 25.w),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "SEARCH".tr,
                                                    style: TextStyle(
                                                        color: AppColor
                                                            .blueTextColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16.sp),
                                                  ),
                                                  Image.asset(
                                                    IconAssets.information,
                                                    height: 25.h,
                                                  ),
                                                ],
                                              ),
                                              connectionController
                                                      .isRescan.value
                                                  ? SizedBox(
                                                      height: 25.h,
                                                    )
                                                  : SizedBox(
                                                      height: 13.h,
                                                    ),
                                              connectionController
                                                      .isRescan.value
                                                  ? SizedBox()
                                                  : Text(
                                                      AppString
                                                          .searchDescription,
                                                      style: TextStyle(
                                                          color: AppColor
                                                                  .blueTextColor[
                                                              100],
                                                          height: 1.8,
                                                          fontSize: 13.sp),
                                                    ),
                                              connectionController
                                                      .isRescan.value
                                                  ? SizedBox()
                                                  : SizedBox(
                                                      height: 30.h,
                                                    ),
                                              CustomButton(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 14.h),
                                                onTap: () {
                                                  connectionController
                                                      .isRescan.value = true;
                                                },
                                                showIcon: true,
                                                isShowBorder:
                                                    connectionController
                                                            .isRescan.value
                                                        ? true
                                                        : false,
                                                backGroundColor:
                                                    connectionController
                                                            .isRescan.value
                                                        ? AppColor.orangeColor
                                                        : Colors.transparent,
                                                icon: connectionController
                                                        .isRescan.value
                                                    ? IconAssets.whiteRescan
                                                    : IconAssets.rescan,
                                                title: "RESCAN".tr,
                                                fontColor: connectionController
                                                        .isRescan.value
                                                    ? AppColor.whiteColor
                                                    : AppColor
                                                        .lightBlueTextColor,
                                              ),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              if (connectionController
                                                  .isRescan.value)
                                                ...List.generate(
                                                  Constants
                                                      .availableDevicesModelList
                                                      .length,
                                                  (index) {
                                                    return DeviceTileWidget(
                                                      netWorkIcon: Constants
                                                          .availableDevicesModelList[
                                                              index]
                                                          .networkIcon,
                                                      index: index,
                                                      bluetoothNumber: Constants
                                                          .availableDevicesModelList[
                                                              index]
                                                          .bluetoothNumber,
                                                    );
                                                  },
                                                )
                                            ],
                                          ),
                                        ),
                                        if (connectionController.isRescan.value)
                                          Column(
                                            children: [
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              Text(
                                                'PRESS_THE_CONNECT_BUTTON_TO_CONNECT_THE_SENSOR'
                                                    .tr,
                                                style: TextStyle(
                                                    color: AppColor
                                                        .blueTextColor[100],
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14.sp),
                                              ),
                                              SizedBox(
                                                height: 20.h,
                                              ),

                                              ///wheel size card
                                              // Row(
                                              //   mainAxisAlignment:
                                              //       MainAxisAlignment
                                              //           .spaceBetween,
                                              //   children: [
                                              //     CustomCardWidget(
                                              //       title: "WHEEL_SIZE".tr,
                                              //       size: AppString.wheelSize,
                                              //     ),
                                              //     CustomCardWidget(
                                              //       title: "CALIBRATE_SPEED".tr,
                                              //       size: AppString
                                              //           .calibrateSpeed,
                                              //     ),
                                              //   ],
                                              // ),
                                              // SizedBox(
                                              //   height: 15.h,
                                              // ),
                                            ],
                                          )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 55.h,
              right: 0,
              child:  CloseButtonCustom(
                onTap: () {
                  Get.back();
                },
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
      padding: EdgeInsets.only(top: 20.0.h, bottom: 20.h),
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
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
            ],
          ),
        ],
      ),
    );
  }
}
