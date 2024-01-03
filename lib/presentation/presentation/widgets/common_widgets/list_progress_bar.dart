import 'package:finutss/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

listProgressBar({totalNumbers = 5, currentPage = 1}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      for (var i = 0; i < totalNumbers; i++)
        Padding(
          padding: EdgeInsets.only(left: 6.0.w),
          child: Container(
            height: 9.r,
            width: 9.r,
            decoration: BoxDecoration(
                color: currentPage == i + 1 ? colorBlue : Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(6.r)),
          ),
        )
    ],
  );
}
