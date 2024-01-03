import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> GuestLoginBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(12),
      ),
    ),
    enableDrag: false,
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: Colors.black.withOpacity(0.2),
    builder: (context) {
      return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12),
          ),
        ),
        height: MediaQuery.of(context).size.height * 2,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 15.w, top: 128.h),
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Image.asset(
                      IconAssets.close,
                      scale: 4,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.vertical(
                      top: Radius.elliptical(
                          MediaQuery.of(context).size.width, 74.0)),
                ),
                height: MediaQuery.of(context).size.height * 0.92,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 34.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'NOTICE'.tr.toUpperCase(),
                        style: TextStyle(
                          color: AppColor.blueTextColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 64.h,
                      ),
                      SizedBox(
                        height: 81.h,
                        child: Image.asset(
                          IconAssets.noticeIcon,
                        ),
                      ),
                      SizedBox(
                        height: 22.h,
                      ),
                      Text(
                        "GUEST_LOGIN_GUIDES".tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColor.subTitleColor.withOpacity(0.8),
                          fontSize: 12.7.sp,
                          height: 2.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          children: [
                            cancelButton(),
                            SizedBox(
                              width: 23.w,
                            ),
                            startButton(),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 80.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget cancelButton() {
  return Expanded(
    child: GestureDetector(
      onTap: () {
        Navigation.pop();
      },
      child: Container(
        height: 38.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10.w,
          ),
          border: Border.all(
            width: 1.5,
            color: AppColor.cancelButtonBg,
          ),
        ),
        child: Center(
          child: Text(
            'CANCEL'.tr,
            style: TextStyle(
              color: AppColor.cancelButtonColor,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
              fontSize: 14.sp,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget startButton() {
  return Expanded(
    child: GestureDetector(
      onTap: () async {
        await SharedPrefs.guestLogin(true);
        Navigation.pushNamed(Routes.welcomeScreen);
      },
      child: Container(
        height: 38.h,
        decoration: BoxDecoration(
          color: AppColor.orangeColor,
          borderRadius: BorderRadius.circular(
            10.w,
          ),
        ),
        child: Center(
          child: Text(
            'CONTINUE'.tr,
            style: TextStyle(
              color: AppColor.whiteColor,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.04,
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
    ),
  );
}
