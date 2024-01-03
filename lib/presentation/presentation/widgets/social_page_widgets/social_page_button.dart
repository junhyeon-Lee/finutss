import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

Widget socialPageButton(
    {color = Colors.black,
    text = "",
    double height = 20.0,
    double width = 60.0,
    function}) {
  return InkWell(
    onTap: function,
    child: Container(
      height: height.h,
      width: width.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.r),
        color: color,
      ),
      child: Center(
        child: customText(
          text: text,
          fontSize: 12,
          fontColor: Color(0xFFF5F7FA),
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
