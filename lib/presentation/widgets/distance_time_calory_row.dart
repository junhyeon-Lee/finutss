import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'common_widgets/custom_text.dart';

Widget distanceTimeCaloryRow({
  String distance = '3.70 km',
  String time = '6.78 min',
  String calories = '15.4 kcal',
  distanceImage = 'assets/images/destination.png',
  timeImage = 'assets/images/time.png',
  caloryImage = 'assets/images/calories.png',
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _iconCard(text: distance, imagePath: distanceImage),
      Container(
        height: 50.h,
        child: VerticalDivider(
          thickness: 1,
          color: Color(0xffE4EDFF),
        ),
      ),
      // size10,
      _iconCard(text: time, imagePath: timeImage),
      Container(
        height: 50.h,
        child: VerticalDivider(
          thickness: 1,
          color: Color(0xffE4EDFF),
        ),
      ),
      // size10,
      _iconCard(text: calories, imagePath: caloryImage),
    ],
  );
}

_iconCard({String text = '', String imagePath = ''}) {
  return Container(
    height: 60.h,
    width: 100.w,
    child: Column(
      children: [
        Image.asset(imagePath),
        size10,
        customText(
          text: text,
          fontColor: colorDarkGrey,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        )
      ],
    ),
  );
}
