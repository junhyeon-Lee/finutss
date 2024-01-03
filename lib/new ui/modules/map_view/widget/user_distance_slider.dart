import 'package:finutss/constants.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/log_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

Widget runDistance({
  double ratio = 5,
  double goal = 15,
}) {

  LogUtils.logMSG('runDistance goal===>${goal}', StackTrace.empty);
  LogUtils.logMSG('runDistance ratio===>${ratio}', StackTrace.empty);

  double current = (goal) * ratio;
  double currrentPercent = (current * 337) / (goal);
  double currentPositionPointer = 337 * (((currrentPercent / 337) * 100) / 100);


  if(currentPositionPointer.isNaN){
    currentPositionPointer=0;
  }


  LogUtils.logMSG('runDistance ratio= current.toStringAsFixed(2) km==>${current.toStringAsFixed(2)} km', StackTrace.empty);
  return Padding(
    padding: EdgeInsets.all(2.r),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 337,
              width: 10,
            ),
            Positioned(
              top: -10,
              left: -15,
              child: Text(
                '${(goal).toStringAsFixed(2)}'+"KM".tr,
                style: TextStyle(color: Color(0xff303443), fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
            ),
            Positioned(
              bottom: -10,
              left: -15,
              child: Text(
                '0.0' + "KM".tr,
                style: TextStyle(color: Color(0xff303443), fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
            ),
            Positioned(
              bottom: currentPositionPointer,
              left: -23,
              child: Text(
                '\n'+'${current.toStringAsFixed(2)}'+ "KM".tr,
                style: TextStyle(color: Color(0xff303443), fontSize: 14.sp, fontWeight: FontWeight.w500),
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
        height: 337,
        width: 10,
        color: Color(0xFFDBDFEA),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        child: Container(
          height: currentPositionPointer,
          width: 10,
          color: AppColor.blue,
        ),
      ),
      Positioned(
        top: -10,
        left: -2,
        // right: -2.w,
        child: Container(
          height: 14,
          width: 14,
          decoration: BoxDecoration(color: AppColor.whiteColor, borderRadius: BorderRadius.circular(50.r)),
        ),
      ),
      Positioned(
        bottom: -10,
        left: -2,
        // right: -2.w,
        child: Container(
          height: 14,
          width: 14,
          decoration: BoxDecoration(color: AppColor.whiteColor, borderRadius: BorderRadius.circular(50.r)),
        ),
      ),
      Positioned(
        bottom: currentPositionPointer - 10,
        left: -5,
        child: Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
              color: AppColor.blue,
              border: Border.all(color: Colors.white, width: 1.5),
              borderRadius: BorderRadius.circular(50)),
        ),
      ),
    ],
  );
}
