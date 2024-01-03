import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/presentation/presentation/animation/bouncing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class CancelSaveButton extends StatelessWidget {
  CancelSaveButton(
      {Key? key,
      this.cancelTitle,
      this.saveTitle,
      required this.onTapCancel,
      required this.onTapSave,
      this.hoeizontalSize,
      this.height,
      this.saveFontSize})
      : super(key: key);

  final String? cancelTitle;
  final String? saveTitle;
  final VoidCallback onTapCancel;
  final VoidCallback onTapSave;
  final double? hoeizontalSize;
  final double? height;
  final double? saveFontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Bouncing(
            duration: Duration(milliseconds: 100),
            onPressed: onTapCancel,
            child: Container(
              height: height ?? 38.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10.w,
                ),
                border: Border.all(
                  width: 1.2,
                  color: AppColor.cancelButtonBg,
                ),
              ),
              child: Center(
                child: Text(
                  cancelTitle ?? 'CANCEL'.tr,
                  style: TextStyle(
                    color: AppColor.cancelButtonColor,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                    fontSize: 15.sp,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: hoeizontalSize ?? 22.w,
        ),
        Expanded(
          child: Bouncing(
            duration: Duration(milliseconds: 100),
            onPressed: onTapSave,
            child: Container(
              height: height ?? 38.h,
              decoration: BoxDecoration(
                color: AppColor.orangeColor,
                borderRadius: BorderRadius.circular(
                  10.w,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.orangeColor.withOpacity(0.30),
                    blurRadius: 18.0, // soften the shadow
                    spreadRadius: 0.2, //extend the shadow
                    offset: Offset(
                      0, // Move to right 10  horizontally
                      6.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
              ),
              child: Center(
                child: Text(
                  saveTitle ?? 'SAVE'.tr,
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.04,
                    fontSize: saveFontSize ?? 17.sp,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
