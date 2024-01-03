import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

Widget centerIcon({onPressedFunction}) {
  return InkWell(
    onTap: onPressedFunction,
    child: Container(
      height: 48.h,
      width: 41.w,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/center_icon.png'),
            fit: BoxFit.contain),
      ),
    ),
  );
}
