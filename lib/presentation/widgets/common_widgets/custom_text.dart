import 'package:finutss/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

Widget customText(
    {String text = '',
    double height = 1,
    textAlign,
    maxLines = 15,
    fontWeight = FontWeight.normal,
    double fontSize = 16.0,
    overflow = TextOverflow.ellipsis,
    fontColor = colorDarkGrey}) {
  return Text(
    text,
    maxLines: maxLines,
    textAlign: textAlign,
    style: TextStyle(
      height: height,
      fontSize: fontSize.sp,
      color: fontColor,
      fontWeight: fontWeight,
    ),
    overflow: overflow,
  );
}
