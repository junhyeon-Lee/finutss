import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/presentation/presentation/animation/bouncing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSliderButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final double? height;
  final double? width;
  final bool? isShowShadow;
  final bool? disableButton;
  final double? fontSize;
  final double? letterSpacing;
  final bool isCancelButton;
  final Color? bgColor;

  CustomSliderButton(
      {required this.title,
      required this.onTap,
      required this.isCancelButton,
      this.width,
      this.height,
      this.isShowShadow,
      this.letterSpacing,
      this.fontSize,
      this.bgColor,
      this.disableButton});

  @override
  Widget build(BuildContext context) {
    return Bouncing(
      duration: Duration(milliseconds: 100),
      onPressed: onTap,
      child: Container(
        height: height ?? 50.w,
        width: width,
        decoration: BoxDecoration(
          color: isCancelButton
              ? null
              : (disableButton ?? false)
                  ? bgColor ?? AppColor.orangeColor[100]
                  : bgColor ?? AppColor.orangeColor,
          borderRadius: BorderRadius.circular(10.w),
          border: isCancelButton ? Border.all(width: 1.5,color: AppColor.orangeColor) : null,
          boxShadow: [
            BoxShadow(
              color: isCancelButton
                  ? Colors.transparent
                  : (isShowShadow ?? false)
                      ? Colors.transparent
                      : (bgColor ?? AppColor.orangeColor).withOpacity(0.30),
              blurRadius: 18.0, // soften the shadow
              spreadRadius: 0.2, //extend the shadow
              offset: Offset(
                0, // Move to right 10  horizontally
                9.0, // Move to bottom 10 Vertically
              ),
            )
          ],
        ),
        child: Center(
          child: isCancelButton
              ? SvgPicture.asset(
                  IconAssets.backIcon,
                  width: 17.w,
                  color: AppColor.orangeColor,
                )
              : Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.w700,
                    fontSize: fontSize ?? 16.sp,
                    letterSpacing: letterSpacing ?? 0
                  ),
                ),
        ),
      ),
    );
  }
}
