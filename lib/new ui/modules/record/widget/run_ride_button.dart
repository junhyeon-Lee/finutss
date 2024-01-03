
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class RunRideButton extends StatelessWidget {
  RunRideButton({Key? key,required this.isRunMode,this.height,this.width}) : super(key: key);
  final bool isRunMode;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 26.h,
      width: width ?? 60.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: isRunMode ? AppColor.runBG : AppColor.rideBG,
      ),
      child: Center(
        child: Text(
          isRunMode ? 'WORKOUT_TYPE_RUN'.tr : 'WORKOUT_TYPE_RIDE'.tr,
          style: TextStyle(
            color: AppColor.whiteColor,
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
