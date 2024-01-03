import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class CustomHomeAppBar extends StatelessWidget {
  final String? imagePath;
  final String? title;
  final String? lastImagePath;
  final VoidCallback? onTap;
  final VoidCallback onTapLastIcon;

  CustomHomeAppBar({
    Key? key,
    this.imagePath,
    this.title,
    this.lastImagePath,
    this.onTap,
    required this.onTapLastIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
      ),
      child: Row(
        children: [
          if (imagePath != null)
            GestureDetector(
              onTap: onTap,
              child: SvgPicture.asset(
                imagePath ?? IconAssets.runGroupBoy,
                height: 18.h,
              ),
            )
          else
            InkWell(
              onTap: () {
                Navigation.pop();
              },
              child: Icon(
                Icons.arrow_back,
                color: AppColor.backIconColor,
              ),
            ),
          Spacer(),
          Text(
            title ?? "RECORD".tr,
            style: TextStyle(
              color: AppColor.blueTextColor,
              fontWeight: FontWeight.w700,
              fontSize: 20.sp,
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: onTapLastIcon,
            child: lastImagePath == null
                ? Image.asset(
                    IconAssets.notification,
                    height: 20.h,
                  )
                : SvgPicture.asset(
                    lastImagePath ?? "",
                    height: 20.h,
                  ),
          ),
        ],
      ),
    );
  }
}
