import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:finutss/main.dart';
import 'package:finutss/new%20ui/modules/app_setting/controller/app_setting_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/widget/custom_slider_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> noInternetDialog(BuildContext context) async {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 200),
    pageBuilder: (_, __, ___) {
      AppSettingController controller = Get.find();

      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: NoInternetWidget(),
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

Widget NoInternetWidget() {
  return Scaffold(
    backgroundColor: AppColor.grayColor.withOpacity(0.5),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 272.h,
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 15.h),
          child: Column(
            children: [
              SizedBox(
                height: 5.h,
              ),
              Image.asset(
                IconAssets.noInternetGif,
                height: 140.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text(
                  "NETWORK_ERROR".tr,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    height: 1.2.h,
                    fontSize: 13.sp,
                  ),
                ),
              ),
              Spacer(),
              CustomSliderButton(
                height: 40.h,
                isCancelButton: false,
                title: 'TRY_AGAIN'.tr,
                onTap: () async {
                  var connectivityResult = await (Connectivity().checkConnectivity());
                  if (connectivityResult == ConnectivityResult.mobile ||
                      connectivityResult == ConnectivityResult.wifi) {
                    // Navigation.pop();
                    isNoInternetConnected.value=false;
                  }
                },
              ),
            ],
          ),
          margin: EdgeInsets.symmetric(horizontal: 30.w),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
        ),
      ],
    ),
  );
}
