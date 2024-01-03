import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/custom_slider_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> CompleteBottomSheet(
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
              padding: EdgeInsets.only(
                right: 15.w,
                top: 200.h,
              ),
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
                padding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.elliptical(
                      MediaQuery.of(context).size.width,
                      74.0,
                    ),
                  ),
                ),
                height: MediaQuery.of(context).size.height * 0.92,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 25.w,
                    right: 25.w,
                    top: 34.h,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        height: 6.h,
                      ),
                      SizedBox(
                        height: 83.h,
                        child: Image.asset(
                          IconAssets.complatePasswordIcon,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        "SUBSCRIPTION_COMPLETION_NOTICE".tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColor.subTitleColor,
                          fontSize: 15.sp,
                          height: 1.7,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "SUBSCRIPTIONS".tr +": 2021.10.05 to 2022.01.05",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColor.lightBlueTextColor,
                          fontSize: 12.sp,
                          height: 1.7,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: CustomSliderButton(
                            title: "GREAT".tr,
                            onTap: () {
                              Navigation.pop();
                            },
                            isCancelButton: false),
                      ),
                      SizedBox(
                        height: 44.h,
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
