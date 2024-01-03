import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget allUserRunDistance(List userList, int speed) {
  int level = 3;
  if ((speed / 10) > 3) {
    level = 3;
  } else if ((speed / 10 == 0)) {
    level = 0;
  } else {
    level = speed ~/ 10;
  }

  return Container(
    height: 7.h,
    width: Get.width - 40.w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: Color(0xFFADADB1),
    ),
    child: Stack(
      children: [
        for (var i = level; i > -1; i--)
          Container(
            decoration: BoxDecoration(
              color: userList[i]['color'],
              borderRadius: BorderRadius.only(topLeft: Radius.circular(5.r), bottomLeft: Radius.circular(5.r)),
            ),
            height: 7.h,
            width: Get.width * (userList[i]['percent'] / 100),
          )
      ],
    ),
  );
}
