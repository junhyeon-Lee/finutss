import 'package:finutss/new%20ui/modules/app_setting/controller/app_setting_controller.dart';
import 'package:finutss/new%20ui/modules/store/presentation/store.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/widget/cancel_save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> energyPointDialog(BuildContext context,{required int point}) async {
  AppSettingController controller = Get.find();

  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 200),
    pageBuilder: (_, __, ___) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 15.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                    "USE_TRACK".tr.replaceFirst(
                      "%d",
                      point.toString(),
                    ),
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      height: 1.2.h,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                CancelSaveButton(
                  cancelTitle: "CLOSE".tr,
                  saveTitle: "EARN_MORE_EP".tr,
                  saveFontSize: 14.sp,
                  hoeizontalSize: 16.w,
                  onTapSave: () {
                    Navigation.pop();
                    Navigation.pushNamed(Routes.storeScreen,arg: {"initIndex": '1'});
                  },
                  onTapCancel: () {
                    Navigation.pop();
                  },
                ),
              ],
            ),
            margin: EdgeInsets.symmetric(horizontal: 30.w),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
      } else {
        tween = Tween(begin: Offset(1, 0), end: Offset.zero);
      }

      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  );
}
