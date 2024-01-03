import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/presentation/presentation/animation/bouncing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RoundButton extends StatelessWidget {
  RoundButton(
      {Key? key,
      this.width,
      required this.iconPath,
      this.bgColor,
      required this.onTap,
      this.iconColor,
      this.iconSize,
      this.showShadow=false,})
      : super(key: key);

  double? width;
  double? iconSize;
  String iconPath;
  Color? bgColor;
  Color? iconColor;
  bool? showShadow;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Bouncing(
      duration: Duration(milliseconds: 100),
      onPressed: onTap,
      child: Container(
        height: width ?? 33.w,
        width: width ?? 33.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: bgColor ?? AppColor.whiteColor,
          boxShadow: showShadow! ? [
            BoxShadow(
              color: AppColor.cardGradiant1.withOpacity(0.06),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ] : [],
        ),
        child: Center(
          child: SvgPicture.asset(
            iconPath,
            color: iconColor ?? AppColor.whiteColor,
            width: iconSize ?? null,
          ),
        ),
      ),
    );
  }
}
