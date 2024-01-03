import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

Widget userAvatarWithStack({borderColor = Colors.black, double height = 50, double width = 50}) {
  return Container(
    child: Stack(
      children: [
        Container(
          height: height.h,
          width: width.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.r),
              border: Border.all(color: borderColor, width: 1),
              image: DecorationImage(image: AssetImage('assets/images/user5.png'), fit: BoxFit.cover)),
        ),
        Positioned(
          right: 0,
          top: 7.h,
          child: Container(
            height: 7.h,
            width: 7.h,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              color: Colors.green,
              borderRadius: BorderRadius.circular(50.r),
            ),
          ),
        )
      ],
    ),
  );
}
