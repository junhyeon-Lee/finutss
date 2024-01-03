import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/custom_login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> completePasswordBottomSheet(
  BuildContext context,
) {
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
                  Navigation.pop();
                  Navigation.pop();
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
                        'COMPLETE'.tr.toUpperCase(),
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
                        height: 82.3.h,
                        child: Image.asset(
                          IconAssets.complatePasswordIcon,
                        ),
                      ),
                      SizedBox(
                        height: 22.h,
                      ),
                      Text(
                        'PASSWORD_CHANGE_COMPLETE_INFO'.tr,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: AppColor.subTitleColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        'PLEASE_LOGIN_TO_CONTINUE'.tr,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: AppColor.subTitleColor.withOpacity(0.7),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 9.h,
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32.w),
                        child: CustomLoginButton(
                          height: 40.h,
                          fontsize: 15.sp,
                          onTap: () {
                            Navigation.pop();
                            Navigation.pop();
                          },
                          title: "GREAT".tr,
                          isCancelButton: true,
                        ),
                      ),
                      SizedBox(
                        height: 84.h,
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
