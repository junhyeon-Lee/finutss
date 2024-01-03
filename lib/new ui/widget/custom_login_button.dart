import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/presentation/presentation/animation/bouncing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CustomLoginButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final double? height;
  final double? width;
  final double? fontsize;
  bool isCancelButton;
  bool? showShadow;
  FontWeight? fontWeight;
  Color? bgColor;

  CustomLoginButton({
    required this.title,
    required this.onTap,
    required this.isCancelButton,
    this.width,
    this.fontsize,
    this.fontWeight,
    this.height,
    this.bgColor,
    this.showShadow,
  });

  @override
  Widget build(BuildContext context) {
    return  Bouncing(
      duration: Duration(milliseconds: 100),
      onPressed: onTap,
      child: Container(
        height: height ?? 38.h,
        width: width ?? 273.w,
        decoration: BoxDecoration(
          color: bgColor ?? AppColor.orangeColor,
          borderRadius: BorderRadius.circular(10.w),
          border: isCancelButton
              ? Border.all(
                  width: 1.5,
                  color: bgColor ?? AppColor.orangeColor,
                )
              : null,
          boxShadow: (showShadow ?? false) ? [] : [
            BoxShadow(
              color: AppColor.orangeColor.withOpacity(0.30),
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
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontWeight: fontWeight ?? FontWeight.w700,
                fontSize: fontsize ?? 16.sp,
                letterSpacing: 0.4),
          ),
        ),
      ),
    );
  }
}
