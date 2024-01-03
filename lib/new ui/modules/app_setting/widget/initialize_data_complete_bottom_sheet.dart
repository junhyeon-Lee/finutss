import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/custom_slider_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> InitializeDataCompleteBottomSheet(BuildContext context) {
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
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 12.w),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Image.asset(
                          IconAssets.close,
                          scale: 4,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
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
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 10.w,
                            right: 10.w,
                            top: 38.h,
                          ),
                          child: Column(
                            children: [
                              Text(
                                'COMPLETE'.tr,
                                style: TextStyle(
                                  color: AppColor.blueTextColor,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: 34.h,
                              ),
                              Padding(padding: EdgeInsets.symmetric(horizontal: 24.w),
                              child: Text(
                                "APP_DATA_INITIALIZATION_COMPLETE_INFO".tr,
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                style: TextStyle(
                                  color: AppColor.blueTextColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                  height: 1.6,
                                  letterSpacing: 0.1,
                                ),
                              ),),
                              SizedBox(
                                height: 30.h,
                              ),
                             /* Text(
                                "Please log in again to provide stable service.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color:
                                      AppColor.blueTextColor.withOpacity(0.7),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                  letterSpacing: 0.1,
                                ),
                              ),*/
                              SizedBox(
                                height: 54.h,
                              ),
                              Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 30.w),
                                  child: CustomSliderButton(
                                    height: 42.h,
                                    title: "SURE".tr,
                                    isCancelButton: false,
                                    onTap: () {
                                      Navigation.pop();
                                    },
                                  )),
                              SizedBox(
                                height: 66.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
