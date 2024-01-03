import 'package:finutss/new%20ui/controller/login_controller.dart';
import 'package:finutss/new%20ui/modules/map_view/controller/map_view_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/cancel_save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> workoutExitBottomSheet({required BuildContext context, required double distance, Function()? ontap}) {
  MapViewController mapViewController = Get.find();
  LoginController loginController = Get.find();
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
                        Navigation.pop();
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
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 26.h,
                                ),
                                Text(
                                  "EXIT".tr.toUpperCase(),
                                  style: TextStyle(
                                    color: AppColor.subTitleColor,
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  height: 19.h,
                                ),
                                Text(
                                  'WORKOUT_EXIT_WARNING'.tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColor.subTitleColor.withOpacity(0.8),
                                    fontSize: 14.sp,
                                    height: 1.63,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 56.h,
                                ),
                                CancelSaveButton(
                                  cancelTitle: 'CANCEL'.tr.toUpperCase(),
                                  saveTitle: "EXIT".tr,
                                  onTapCancel: () {
                                    Navigation.pop();
                                  },
                                  onTapSave: ontap ?? () async {
                                    mapViewController.isExist = true;
                                    print("distance < 1 --- ${distance < 1} ---- ${distance}");
                                    if (distance < 1) {
                                      mapViewController.pausedRecord(false,status: Constants.deleted);
                                    } else {
                                      print("distance < 1 --- ");
                                      mapViewController.pausedRecord(true,status: Constants.dropped);
                                    }

                                    Navigation.pop();
                                    Navigation.pop();
                                  },
                                ),
                                SizedBox(
                                  height: 50.h,
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
