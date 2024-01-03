import 'package:finutss/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

Widget cardButton(
    {icon = Icons.chat_bubble,
    String text = '',
    onPressedFunction,
    textColor = Colors.black,
    color: Colors.white,
    double fontSize = 16}) {
  return InkWell(
    onTap: onPressedFunction,
    child: Card(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        child: Padding(
          padding: EdgeInsets.all(8.r),
          child: Container(
            width: 85,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 24.r,
                  color: Color(0xff3BCCE1),
                ),
                size10,
                Text(
                  text,
                  style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: fontSize.sp),
                )
              ],
            ),
          ),
        )),
  );
}
