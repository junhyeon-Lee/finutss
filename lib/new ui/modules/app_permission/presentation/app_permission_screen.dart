import 'package:finutss/new%20ui/modules/app_permission/controller/app_permission_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/widget/custom_slider_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AppPermissionScreen extends StatelessWidget {
  AppPermissionScreen({Key? key}) : super(key: key);

  final AppPermissionController controller = Get.put(AppPermissionController());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColor.backGroundColor,
      ),
      child: Material(
        child: SafeArea(
          child: Container(
            color: AppColor.backGroundColor,
            child: Column(
              children: [
                Container(
                  height: 50.h,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "APP_PERMISSIONS".tr.toUpperCase(),
                      style: TextStyle(
                          letterSpacing: 0.2,
                          color: AppColor.subTitleColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 18.sp),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          permissionListView(),
                          SizedBox(
                            height: 27.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  child: CustomSliderButton(
                    title: 'OK'.tr,
                    onTap: () {
                      controller.permissionRequest().then((value) {
                        Navigation.pushNamed(
                          Routes.onBoardingScreen,
                        );
                      });
                    },
                    isCancelButton: false,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget permissionListView() {
    return ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, i) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 17.h, horizontal: 18.w),
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(8.w),
              boxShadow: [
                BoxShadow(
                  color: AppColor.cardGradiant1.withOpacity(0.05),
                  spreadRadius: 0.1,
                  blurRadius: 8,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: controller.permissionList[i].bgColor),
                  child: Center(
                    child: SvgPicture.asset(
                      controller.permissionList[i].iconPath,
                      width: 17.w,
                    ),
                  ),
                ),
                SizedBox(
                  width: 18.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              controller.permissionList[i].title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: AppColor.subTitleColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17.sp),
                            ),
                          ),
                          // Text(
                          //   "OPTIONAL".tr,
                          //   style: TextStyle(
                          //       fontFamily: 'MontserratItalic',
                          //       color: AppColor.subTitleColor.withOpacity(0.5),
                          //       fontWeight: FontWeight.w500,
                          //       fontSize: 9.sp),
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        controller.permissionList[i].des,
                        style: TextStyle(
                            color: AppColor.subTitleColor.withOpacity(0.6),
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.1,
                            height: 1.6,
                            fontSize: 15.sp),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, i) {
          return SizedBox(
            height: 8.4.h,
          );
        },
        itemCount: controller.permissionList.length);
  }
}
