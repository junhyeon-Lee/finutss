import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BackButtonSlider extends StatelessWidget {
  BackButtonSlider({Key? key,this.bgColor,this.iconColor}) : super(key: key);

  final Color? bgColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(Get.context!);
      },
      child: Container(
        height: 30.h,
        width: 30.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: bgColor,
        ),
        child: Center(
          child: SvgPicture.asset(
            IconAssets.backIcon,
            height: 9.h,
            width: 9.h,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
