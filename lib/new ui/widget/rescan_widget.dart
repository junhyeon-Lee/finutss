import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/app_string.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RescanWidget extends StatelessWidget {
  const RescanWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 11.h, bottom: 25.h),
      child: Container(
        decoration: BoxDecoration(
            color: AppColor.whiteColor[100],
            borderRadius: BorderRadius.circular(15)),
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 25.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "SEARCH".tr,
                  style: TextStyle(
                      color: AppColor.blueTextColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp),
                ),
                Image.asset(
                  IconAssets.information,
                  height: 25.h,
                ),
              ],
            ),
            SizedBox(
              height: 13.h,
            ),
            Text(
              AppString.searchDescription,
              style: TextStyle(
                  color: AppColor.blueTextColor[100],
                  height: 1.8,
                  fontSize: 13.sp),
            ),
            SizedBox(
              height: 30.h,
            ),
            CustomButton(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              showIcon: true,
              icon: IconAssets.rescan,
              title: "RESCAN".tr,
            )
          ],
        ),
      ),
    );
  }
}
