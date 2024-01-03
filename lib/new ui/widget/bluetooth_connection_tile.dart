import 'dart:ui';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BluetoothConnectionTile extends StatelessWidget {
  final String topPrefixIcon;
  final String? bluetoothName;
  final String? bluetoothNumber;
  final String networkIcon;
  final bool isConnect;
  final bool isBluetooth;
  final VoidCallback onTap;

  BluetoothConnectionTile({
    required this.networkIcon,
    this.bluetoothNumber,
    this.bluetoothName,
    required this.topPrefixIcon,
    required this.isConnect,
    required this.isBluetooth,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.h),
      decoration: BoxDecoration(
          color: AppColor.calibrationCardColor,
          borderRadius: BorderRadius.circular(11)),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Image.asset(
                  isBluetooth ? IconAssets.bluetoothCancel : topPrefixIcon,
                  scale: 4,
                ),
                SizedBox(
                  width: 15.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              bluetoothName!,
                              style: TextStyle(
                                  color: AppColor.blueTextColor[100],
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Image.asset(
                            networkIcon,
                            scale: 4,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 9.h,
                      ),
                      Text(
                        bluetoothNumber!,
                        style: TextStyle(
                            color: AppColor.blueTextColor[100],
                            fontSize: 14.sp,
                            letterSpacing: 0.4,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: AppColor.cardGradiant1.withOpacity(0.06),
                  spreadRadius: 5,
                  blurRadius: 18,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],),
            child: InkWell(
              onTap: onTap,
              child: Column(
                children: [
                  Image.asset(
                    IconAssets.bluetoothOff,
                    scale: 4,
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                    "OFF",
                    style: TextStyle(
                      fontSize: 12.sp,
                        color: AppColor.blueTextColor[100],
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
