import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/presentation/animation/bouncing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String? icon;
  final String? title;
  final double? fontSize;
  final double? height;
  final double? width;
  final Color? fontColor;
  final Color? borderColor;
  final FontWeight? fontWeight;
  final bool? showIcon;
  final VoidCallback? onTap;
  final bool? isShowBorder;
  final Color? backGroundColor;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;

  CustomButton(
      {this.icon,
      this.title,
      this.fontSize,
      this.fontColor,
      this.fontWeight,
      this.showIcon,
      this.onTap,
      this.borderColor,
      this.width,
      this.height,
      this.isShowBorder,
      this.backGroundColor,
      this.padding,
      this.borderRadius,
      BuildContext? context});

  @override
  Widget build(BuildContext context) {
    return Bouncing(
      onPressed: onTap,
      duration: Duration(milliseconds: 100),
      child: Container(
        height: height ?? null,
        width: width ?? null,
        decoration: BoxDecoration(
          color: backGroundColor ?? Colors.transparent,
          border: isShowBorder ?? false
              ? Border.all(color: Colors.transparent)
              : Border.all(
                  width: 1, color: borderColor ?? AppColor.lightBlueTextColor),
          borderRadius: BorderRadius.circular(borderRadius ?? 15),
        ),
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
        child: (showIcon ?? false)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    icon ?? "",
                    scale: 4,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    title ?? '',
                    style: TextStyle(
                        fontSize: fontSize ?? 16.sp,
                        color: fontColor ?? AppColor.lightBlueTextColor,
                        fontWeight: fontWeight ?? FontWeight.w600),
                  ),
                ],
              )
            : Center(
                child: Text(
                  title ?? '',
                  style: TextStyle(
                      fontSize: fontSize ?? 14.sp,
                      color: fontColor ?? AppColor.lightBlueTextColor,
                      fontWeight: fontWeight ?? FontWeight.w600),
                ),
              ),
      ),
    );
  }
}
