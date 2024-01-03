import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

Widget switchButtonCard({title = '', value = true, required onChangeFunction}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 11.h),
    decoration: BoxDecoration(
        border: Border.all(color: Color(0xffCDD5E9)),
        borderRadius: BorderRadius.circular(8.r),
        color: colorBackgroundSilver),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        customText(text: '$title', fontSize: 16, fontWeight: FontWeight.bold, fontColor: Colors.black),
        FlutterSwitch(
          value: value,
          onToggle: onChangeFunction,
          width: 65.w,
          height: 31.h,
          inactiveColor: Color(0xffEAEAEA),
          activeColor: Color(0xff3BCCE1),
        )
      ],
    ),
  );
}
