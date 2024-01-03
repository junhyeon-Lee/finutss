import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/widget/cancel_save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> GuestNotice(BuildContext context) async {

  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 200),
    pageBuilder: (_, __, ___) {
      return Center(
        child: Container(
          height: 248.h,
          padding: EdgeInsets.symmetric(horizontal: 22.w,vertical: 16.h),
          child: Column(
            children: [


              SizedBox(
                height: 10.h,
              ),
              Text(
                "NOTICE".tr.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 22.sp,
                ),
              ),


              SizedBox(
                height: 24.h,
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text(
                  "GUEST_SERVICE_LOG_IN".tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    height: 1.5.h,
                    fontSize: 15.sp,
                  ),
                ),
              ),


              Spacer(),


              CancelSaveButton(
                saveTitle: "SIGN_UP".tr,
                cancelTitle: "CANCEL".tr,
                onTapSave: () {
                  Navigation.pushNamed(
                    Routes.signUp,
                  );
                },
                onTapCancel: () {
                  Navigation.pop();
                },
              ),
              SizedBox(
                height: 4.h,
              ),
            ],
          ),
          margin: EdgeInsets.symmetric(horizontal: 30.w),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
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
