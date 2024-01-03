import 'package:finutss/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

Widget expandableTextField(
    {controller,
    enabled = true,
    double padding = 16,
    maxLine,
    bool showBorder = false,
    bordercolor = const Color(0xffCDD5E9),
    backgroundColor = colorBackgroundSilver,
    hintText = 'Type Here',
    double? height,
    double radius = 12.0}) {
  return Container(
      height: height != null ? height.h : height,
      padding: EdgeInsets.all(padding.r),
      decoration: BoxDecoration(
          border: Border.all(color: showBorder ? Color(0xffCDD5E9) : Colors.transparent, width: 1),
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius.r)),
      child: TextField(
        enabled: enabled,
        controller: controller,
        maxLines: maxLine,
        decoration: InputDecoration(
            hintMaxLines: 3,
            isDense: true,
            hintStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Color(0xff7F8391)),
            border: InputBorder.none,
            hintText: hintText),
      ));
}
