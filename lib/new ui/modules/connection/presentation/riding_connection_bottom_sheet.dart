import 'package:finutss/new%20ui/modules/connection/presentation/calibration_guide_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/connection/presentation/wheel_size_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/connection/widget/close_button.dart';
import 'package:finutss/new%20ui/modules/home/widget/custom_card_widget.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/app_string.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/bluetooth_connection_tile.dart';
import 'package:finutss/new%20ui/widget/rescan_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> RidingConnectionBottomSheet(BuildContext context,
    {String? title, String? icon}) {
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
                          icon: icon ?? IconAssets.bike,
                          title: title ?? "EXERCISER_RIDING".tr,
                          onTap: () {
                            Navigation.pop();
                          },
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
                                        Constants.connectionModelList.length,
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
                                  height: 5.h,
                                ),
                                Flexible(
                                  flex: 5,
                                  child: Column(
                                    children: [
                                      RescanWidget(),
                                      Text(
                                        'PRESS_THE_CONNECT_BUTTON_TO_CONNECT_THE_SENSOR'
                                            .tr,
                                        style: TextStyle(
                                          color: AppColor.blueTextColor[100],
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomCardWidget(
                                            onTap: () {
                                              wheelSizeBottomSheet(context);
                                            },
                                            title: "WHEEL_SIZE".tr,
                                            size: AppString.wheelSize,
                                          ),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          CustomCardWidget(
                                            onTap: () {
                                              calibrationGuideBottomSheet(
                                                  context);
                                            },
                                            title: "CALIBRATE_SPEED".tr,
                                            size: AppString.calibrateSpeed,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                    ],
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
              top: 50.h,
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
  final VoidCallback onTap;

  HeaderWidget({this.icon, this.title, required this.onTap});

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
                onTap: onTap,
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
