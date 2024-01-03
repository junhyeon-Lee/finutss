import 'package:finutss/new%20ui/modules/app_setting/widget/custom_setting_row.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class UserGuideScreen extends StatelessWidget {
  const UserGuideScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColor.backGroundColor,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.backGroundColor,
          body: Column(
            children: [
              CustomSettingRow(
                title: "USER_GUIDE".tr.toUpperCase(),
                horizontalPadding: 20.w,
                fontsize: 18.sp,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 18.h,
                        ),
                        cardItem("TUTORIAL_1_TITLE_SENSOR".tr, () {
                          Navigation.pushNamed(Routes.sensorSliderScreen);
                        }),
                        cardItem("TUTORIAL_2_TITLE_WORKOUT".tr, () {
                          Navigation.pushNamed(Routes.workoutGuideScreen);
                        }),
                        cardItem("TUTORIAL_3_TITLE_BODY_INFO".tr, () {
                          Navigation.pushNamed(Routes.bodyInfoGuideScreen);
                        }),
                        cardItem("TUTORIAL_4_TITLE_RECORD".tr, () {
                          Navigation.pushNamed(Routes.recordGuideScreen);
                        }),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardItem(String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 9.h),
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(6.w),
          boxShadow: [
            BoxShadow(
              color: AppColor.cardGradiant1.withOpacity(0.06),
              spreadRadius: 2.4,
              blurRadius: 10,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 14.7.h),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColor.subTitleColor,
                  fontSize: 15.sp,
                  letterSpacing: 0.1,
                ),
              ),
            ),
            SvgPicture.asset(
              IconAssets.rightArrow,
              height: 11.h,
            ),
          ],
        ),
      ),
    );
  }
}
