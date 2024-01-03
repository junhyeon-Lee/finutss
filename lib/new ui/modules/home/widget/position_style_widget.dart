import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/presentation/presentation/animation/bouncing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class PositionStyleWidget extends StatelessWidget {
  final String position;
  final String positionDes;
  final String positionImage;
  final GestureTapCallback onTap;
  final GestureTapCallback editOnTap;
  final bool? isSelected;

  PositionStyleWidget({
    required this.positionImage,
    required this.position,
    required this.positionDes,
    required this.onTap,
    this.isSelected,
    required this.editOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.all(10.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                positionImage,
                scale: 4,
              ),
            ),
            SizedBox(
              width: 15.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isSelected == true
                      ? SizedBox(
                          height: 14.h,
                        )
                      : SizedBox(),
                  Text(
                    position.tr,
                    maxLines: 2,
                    style: TextStyle(
                        color: AppColor.blueTextColor[100],
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    positionDes.tr,
                    style: TextStyle(
                        color: AppColor.blueTextColor[100]?.withOpacity(0.7),
                        fontSize: 12.sp),
                  ),
                  SizedBox(
                    height: 9.h,
                  ),
                  (isSelected ?? false)
                      ? SizedBox()
                      : Bouncing(
                    duration: Duration(milliseconds: 100),
                    onPressed: onTap,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.h, vertical: 4.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    width: 1, color: AppColor.orangeColor)),
                            child: Text(
                              "SELECT".tr,
                              style: TextStyle(color: AppColor.orangeColor),
                            ),
                          ),
                        )
                ],
              ),
            ),
            isSelected == true
                ? Bouncing(
              duration: Duration(milliseconds: 100),
              onPressed: editOnTap,
                    child: Text(
                      "EDIT".tr,
                      style: TextStyle(
                          color: AppColor.orangeColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp),
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
