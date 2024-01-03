import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/widget/cancel_save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> workoutTrialNoticeBottomSheet(BuildContext context,
    {String? title, String? icon}) {
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
                top: 300.h,
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
                        'NOTICE'.tr.toUpperCase(),
                        style: TextStyle(
                          color: AppColor.darkPink,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Image.asset(
                        IconAssets.noticeAlert,
                        height: 75.h,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'YOUVE_EXHAUSTED_ALL_THE_FREE_TRAVEL_REMAINING_TODAY'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColor.darkPink,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        "WOULD_YOU_LIKE_TO".tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColor.blueTextColor.withOpacity(0.7),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      CancelSaveButton(
                        saveTitle: 'INFO'.tr,
                        cancelTitle: 'DO_LATER'.tr.toUpperCase(),
                        onTapSave: () {
                          Navigation.pushNamed(Routes.storeScreen,arg: {"initIndex": '0'});
                        },
                        onTapCancel: (){
                          Navigation.pop();
                        },
                      ),
                      SizedBox(
                        height: 30.h,
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

class HeaderWidget extends StatelessWidget {
  final String? icon;
  final String? title;

  HeaderWidget({this.icon, this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 14.0.h),
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "INVITE_FRIENDS".tr.toUpperCase(),
              style: TextStyle(
                color: AppColor.blueTextColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: 28.h,
          ),
        ],
      ),
    );
  }
}
