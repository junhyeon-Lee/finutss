import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCardWidget extends StatelessWidget {
  final String title;
  final String size;
  final VoidCallback? onTap;

  const CustomCardWidget({required this.title, required this.size, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              color: AppColor.connectCardBg,
              borderRadius: BorderRadius.circular(12)),
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          child: Column(
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColor.blueTextColor[100],
                    fontSize: 13.sp),
              ),
              SizedBox(
                height: 12.h,
              ),
              Text(
                size,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColor.orangeColor,
                    fontSize: 16.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
