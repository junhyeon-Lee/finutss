import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactNoise extends StatelessWidget {
  const ContactNoise({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [for (int i = 0; i < 27; i++) _singleNoise(context)],
    );
  }

  _singleNoise(BuildContext context) {
    final double height = 20.74.w * math.Random().nextDouble() + .26.w;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: .2.w),
      width: .56.w,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1000),
        color: AppColor.blueTextColor.withOpacity(0.36),
      ),
    );
  }
}
