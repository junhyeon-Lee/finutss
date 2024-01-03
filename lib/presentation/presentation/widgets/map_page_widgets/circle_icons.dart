import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

Widget circleIcons(
    {onPressedFunction,
    icon = Icons.light_mode_outlined,
    double height = 45,
    double width = 45,
    backgroundColor = Colors.white,
    iconColor = Colors.white,
    double iconSize = 30}) {
  return InkWell(
    onTap: onPressedFunction,
    child: Container(
      height: height.r,
      width: width.r,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Center(
        child: Icon(
          icon,
          size: iconSize.r,
          color: iconColor,
        ),
      ),
    ),
  );
}
