import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

Widget timerWidget({int duration = 0}) {
  return Container(
    height: 40.h,
    width: 143.w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(37.r),
      color: Color(0xffF73A6B),
    ),
    child: Center(
      child: StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 1)),
        builder: (context, snapshot) {
          return Center(
            child: Text(
              Duration(seconds: duration).toString().substring(0, 7),
              // DateFormat('hh:mm:ss').format(count++),
            ),
          );
        },
      ),
      // Text(
      //   timerText,
      //   style: TextStyle(
      //       color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w600),
      // ),
    ),
  );
}
