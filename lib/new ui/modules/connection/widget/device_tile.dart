import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/presentation/animation/bouncing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DeviceTileWidget extends StatelessWidget {
  final String bluetoothNumber;
  final String netWorkIcon;
  final int index;
  final VoidCallback? onTap;

  DeviceTileWidget(
      {required this.index,
      required this.bluetoothNumber,
      required this.netWorkIcon,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 6.h),
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    bluetoothNumber,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColor.textColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: index == 1 ? 10.h : 0),
                  child: Image.asset(
                    netWorkIcon,
                    height: 21.h,
                  ),
                ),
                SizedBox(
                  width: 14.w,
                ),
                Bouncing(
                  onPressed: onTap,
                  duration: Duration(milliseconds: 100),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      border: Border.all(
                        width: 1,
                        color: AppColor.lightBlueTextColor,
                      ),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 7.h),
                    child: Text(
                      "CONNECT".tr,
                      style: TextStyle(
                          color: AppColor.lightBlueTextColor,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 6.h,
            ),
            index == 2
                ? SizedBox()
                : Divider(
                    thickness: 0.7,
                    color: AppColor.dividerColor,
                  )
          ],
        ),
      ),
    );
  }
}
