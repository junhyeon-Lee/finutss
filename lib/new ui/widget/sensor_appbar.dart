import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

// ignore: must_be_immutable
class SensorAppBar extends StatelessWidget {
  SensorAppBar({
    Key? key,
    required this.leftIconPath,
    required this.rightIconPath,
    required this.title,
    this.notificationOnTap,
    this.sensorOnTap,
  }) : super(key: key);

  String leftIconPath;
  String rightIconPath;
  String title;
  VoidCallback? notificationOnTap;
  VoidCallback? sensorOnTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: sensorOnTap,
                  child: leftIconPath.isEmpty
                      ? SizedBox()
                      : SvgPicture.asset(
                          leftIconPath,
                          width: 32.w,
                        ),
                ),
                InkWell(
                  onTap: notificationOnTap,
                  child: SvgPicture.asset(
                    rightIconPath,
                    width: 18.w,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Center(
              child:
              title=="HOME"
                  ?SizedBox(
                height: 24.h,
                  child: Image(image: AssetImage('new_assets/images/finutss_logo_new.png')))
                  :Text(
                title.tr.toUpperCase(),
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, color: AppColor.subTitleColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
