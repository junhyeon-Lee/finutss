import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String? icon;
  final String? title;
  final double? fontSize;
  final double? borderRadius;
  final Color? fontColor;
  final FontWeight? fontWeight;
  final bool? showIcon;
  final Color? backgroundColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  VoidCallback? onTap;

  CustomButton(
      {this.icon,
      this.title,
      this.fontSize,
      this.fontColor,
      this.fontWeight,
      this.showIcon,
      this.backgroundColor,
      this.borderColor,
      this.borderRadius,
      this.padding,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.transparent,
          border: Border.all(width: 0.8, color: borderColor ?? AppColor.lightBlueTextColor),
          borderRadius: BorderRadius.circular(borderRadius ?? 15),
        ),
        padding: padding ?? EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
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
                      fontSize: fontSize ?? 16.sp,
                      color: fontColor ?? AppColor.lightBlueTextColor,
                      fontWeight: fontWeight ?? FontWeight.w600),
                ),
              ),
      ),
    );
  }
}
