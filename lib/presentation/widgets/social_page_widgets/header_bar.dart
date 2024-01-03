import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget headerBar() {
  return Container(
    height: 90,
    width: Get.width,
    color: Color(0xFFFFFFFF),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(26.w, 0, 0, 14.h),
          child: Container(
            child: Text(
              'SOCIAL'.tr,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 26.w, 14.h),
          child: Container(
            child: Icon(
              Icons.search,
              color: Color(0xFF3BCCE1),
            ),
          ),
        ),
      ],
    ),
  );
}
