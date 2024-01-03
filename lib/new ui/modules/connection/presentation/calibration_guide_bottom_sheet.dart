import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/widget/cancel_save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

Future<void> calibrationGuideBottomSheet(BuildContext context) {
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
        margin: EdgeInsets.symmetric(horizontal: 3.w),
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
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 20.w, right: 20.w, top: 35.h),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "SPEED_CALIBRATION".tr.toUpperCase(),
                                  style: TextStyle(
                                    color: AppColor.subTitleColor,
                                    fontSize: 22.sp,
                                    letterSpacing: 0.2,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  height: 28.h,
                                ),
                                SvgPicture.asset(
                                  IconAssets.calibrationShoesIcon,
                                  height: 55.h,
                                ),
                                SizedBox(
                                  height: 22.h,
                                ),
                                Text(
                                  'CADENCE_SENSORS_ARE_CONNECTED'.tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColor.darkPink,
                                    fontSize: 15.sp,
                                    fontFamily: 'MontserratItalic',
                                    letterSpacing: 0.2,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "CEDANCE_ONLY_CONNECTION_INFO".tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColor.subTitleColor
                                        .withOpacity(0.7),
                                    fontSize: 12.6.sp,
                                    height: 1.9,
                                    letterSpacing: 0.2,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  height: 54.h,
                                ),
                                CancelSaveButton(
                                  cancelTitle: 'DO_LATER'.tr.toUpperCase(),
                                  saveTitle: 'CALIBRATION'.tr,
                                  onTapSave: () {
                                    Navigation.pop();
                                    //speedCelibrationBottomSheet(context);
                                    Navigation.pushNamed(
                                        Routes.speedCalibration);
                                  },
                                  onTapCancel: () {
                                    Navigation.pop();
                                  },
                                ),
                                SizedBox(
                                  height: 42.h,
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
        ),
      );
    },
  );
}
