import 'package:finutss/constants.dart';
import 'package:finutss/presentation/animation/bouncing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

Widget customButton(
    {onTapFunction,
    color = colorBlue,
    double radius = 12,
    double height = 34,
    double width = 60,
    textColor = Colors.white,
    text = '',
    double textSize = 10,
    fontWeight = FontWeight.normal,
    Color borderColor = Colors.transparent,
    icon}) {
  return Bouncing(
    duration: Duration(milliseconds: 100),
    // onTap: onTapFunction,
    // scaleFactor: 3.5,
    onPressed: onTapFunction,
    child: Container(
      height: height.h,
      width: width.w,
      //padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius.r),
        border: Border.all(color: borderColor, width: 1),
        color: color,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Image.asset(
                icon,
                height: 15.r,
              ),
            ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: textSize.sp,
              fontWeight: fontWeight,
              color: textColor,
            ),
          ),
        ],
      ),
    ),
  );
}
