import 'package:finutss/constants.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

Widget runDistance({
  double ratio = 5,
  double goal = 15,
}) {
  double current = (goal / 1000) * ratio;
  double currrentPercent = (current * 337) / (goal / 1000);
  double currentPositionPointer = 337 * (((currrentPercent / 337) * 100) / 100);
  return Padding(
    padding: EdgeInsets.all(8.r),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 337.h,
              width: 10.w,
            ),
            Positioned(
              top: -10.h,
              left: -3.w,
              child: Text(
                '${Constants.meterToKmConvert(goal.toString())} km',
                style: TextStyle(color: Color(0xff303443), fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              bottom: -10.h,
              left: -3.w,
              child: Text(
                '0.0 km',
                style: TextStyle(color: Color(0xff303443), fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              bottom: currentPositionPointer.h,
              left: -6.w,
              child: Text(
                '${current.toStringAsFixed(1)} km',
                style: TextStyle(color: Color(0xff303443), fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        size40,
        _customSlider(currentPositionPointer: currentPositionPointer)
      ],
    ),
  );
}

Widget _customSlider({double currentPositionPointer = 100}) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        height: 337.h,
        width: 10,
        color: Color(0xFFADADB1),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        child: Container(
          height: currentPositionPointer.h,
          width: 10,
          color: Color(0xff3BCCE1),
        ),
      ),
      Positioned(
        top: -10.h,
        left: -2.w,
        // right: -2.w,
        child: Container(
          height: 14,
          width: 14,
          decoration: BoxDecoration(color: Color(0xffF73A6B), borderRadius: BorderRadius.circular(50.r)),
        ),
      ),
      Positioned(
        bottom: -10.h,
        left: -2.w,
        // right: -2.w,
        child: Container(
          height: 14,
          width: 14,
          decoration: BoxDecoration(color: Color(0xffF73A6B), borderRadius: BorderRadius.circular(50.r)),
        ),
      ),
      Positioned(
        bottom: currentPositionPointer.h - 2,
        left: -5,
        child: Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
              color: Color(0xff3BCCE1),
              border: Border.all(color: Colors.white, width: 1.5),
              borderRadius: BorderRadius.circular(50)),
        ),
      ),
    ],
  );
}
