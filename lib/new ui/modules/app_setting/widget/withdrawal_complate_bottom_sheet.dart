import 'package:finutss/new%20ui/modules/app_setting/controller/app_setting_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/widget/custom_slider_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> withdrawalComplateBottomSheet(BuildContext context) {
  final AppSettingController controller = Get.find();

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
      return WillPopScope(
        onWillPop: () async{
          return false;
        },
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(12),
            ),
          ),
          height: MediaQuery.of(context).size.height * 2,
          width: MediaQuery.of(context).size.width,
          child: SizedBox(
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
                          controller.goToSignInScreen();
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
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.elliptical(
                              MediaQuery.of(context).size.width,
                              100.0,
                            ),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 34.h,
                            ),
                            Text(
                              'COMPLETE'.tr.toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20.sp,
                                  color: AppColor.blueTextColor,
                                  letterSpacing: 0.2),
                            ),
                            SizedBox(
                              height: 26.h,
                            ),
                            SizedBox(
                              height: 83.h,
                              child: Image.asset(
                                IconAssets.complatePasswordIcon,
                              ),
                            ),
                            SizedBox(
                              height: 22.h,
                            ),
                            Text(
                              "YOUR_WITHDRAWAL_FROM_THE_MEMBERSHIP_HAS_BEEN_COMPLETED_THANK_YOU_FOR_EVERYTHING_YOUVE_DONE"
                                  .tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColor.subTitleColor,
                                fontSize: 16.sp,
                                letterSpacing: 0.1,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 74.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 42.w),
                              child: CustomSliderButton(
                                height: 43.h,
                                title: "GREAT".tr,
                                onTap: () {
                                  controller.goToSignInScreen();
                                },
                                isCancelButton: false,
                              ),
                            ),
                            SizedBox(
                              height: 60.h,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
