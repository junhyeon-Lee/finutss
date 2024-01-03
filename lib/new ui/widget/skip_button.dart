import 'package:finutss/new%20ui/modules/dash_board_bottom_navi/presentation/dash_bord_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SkipButton extends StatelessWidget {
  SkipButton({Key? key, this.bgColor, this.iconColor}) : super(key: key);

  final Color? bgColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.offAll(DashboardScreen());
      },
      child: Container(
        height: 30.h,
        padding: EdgeInsets.symmetric(horizontal: 17.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: bgColor,
        ),
        child: Center(
          child: Text(
            "SKIP".tr,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
