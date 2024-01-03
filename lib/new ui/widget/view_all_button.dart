import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/presentation/presentation/animation/bouncing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class ViewAllButton extends StatelessWidget {
  ViewAllButton({Key? key, required this.title, required this.onTap}) : super(key: key);
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 12.w,
        ),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
              color: AppColor.subTitleColor,
              letterSpacing: 0.4,
            ),
          ),
        ),
        Bouncing(
          duration: Duration(milliseconds: 100),
          onPressed: onTap,
          child: Container(
            height: 24.h,
            width: 80.w,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColor.greenSliderBg,
              ),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Center(
              child: Text(
                "VIEW".tr,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColor.greenSliderBg,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
