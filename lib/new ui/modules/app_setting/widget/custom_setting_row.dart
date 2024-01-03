import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class CustomSettingRow extends StatelessWidget {
  final String? title;
  final double? fontsize;
  final double? horizontalPadding;
  final FontWeight? fontWeight;
  final bool? showShareIcon;
  final String? lastImagePath;
  final Widget? child;
  final double? height;

  const CustomSettingRow({
    Key? key,
    this.title,
    this.fontsize,
    this.fontWeight,
    this.height,
    this.horizontalPadding,
    this.showShareIcon = false,
    this.lastImagePath,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 52.h,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 22.w),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: InkWell(
                onTap: () {
                  Navigation.pop();
                },
                child: SizedBox(
                  width: 50.w,
                  height : 52.h,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColor.backIconColor,
                      size: 21.w,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 20.w,
              right: 20.w,
              top: 0,
              bottom: 0,
              child: Center(
                child: Text(
                  title ?? 'LANGUAGE'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColor.subTitleColor,
                    fontWeight: fontWeight ?? FontWeight.w600,
                    letterSpacing: 0.2,
                    fontSize: fontsize ?? 20.sp,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: child ?? SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
