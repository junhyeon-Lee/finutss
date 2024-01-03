import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/widget/back_button.dart';
import 'package:finutss/new%20ui/widget/skip_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class GuideSensorAppBar extends StatelessWidget {
  GuideSensorAppBar({Key? key,required this.iconColor,required this.title}) : super(key: key);

  final Color iconColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w,right: 16.w,bottom: 18.h,top: 11.h),
      child: Container(
        height: 40.h,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButtonSlider(
                    iconColor: iconColor,
                    bgColor: iconColor.withOpacity(0.1),
                  ),
                  SkipButton(
                    iconColor: iconColor,
                    bgColor: iconColor.withOpacity(0.1),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 34.h,
              right: 34.h,
              top: 0,
              bottom: 0,
              child: Center(
                child: Text(
                  title.tr.toUpperCase(),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    letterSpacing: 0.5,
                    color: AppColor.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
