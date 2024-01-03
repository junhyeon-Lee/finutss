import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

roundedDecoration({color = Colors.white, double radius = 15.0}) {
  return BoxDecoration(
      color: color, borderRadius: BorderRadius.circular(radius.r));
}
