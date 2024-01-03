import 'package:finutss/helper/network_helper.dart';
import 'package:finutss/new%20ui/modules/app_setting/controller/app_setting_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

bool isShowDialog=false;

Future<void> sessionExpiredDialog(BuildContext context) async {
  AppSettingController controller=Get.find();

  if(!isShowDialog){
    isShowDialog=true;
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (_, __, ___) {

        return WillPopScope(
          onWillPop: () async{
            return false;
          },
          child: Center(
            child: Container(
              height: 150.h,
              padding: EdgeInsets.only(left: 22.w,right: 22.w,top: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  Text(
                    "Alert",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        height: 1.5.h,
                        fontSize: 17.sp,
                        color: AppColor.subTitleColor
                    ),
                  ),

                  SizedBox(
                    height: 8.h,
                  ),



                  Text(
                    "Session has been expired, please login again.",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        height: 1.2.h,
                        fontSize: 13.sp,
                        color: AppColor.subTitleColor
                    ),
                  ),


                  Spacer(),


                  Row(
                    children: [
                      Spacer(),

                      InkWell(
                        onTap: () async {
                          NetworkAPICall.httpClient.close();
                          controller.logout().then((value) {
                            isShowDialog=false;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 20.w,top: 5.h,bottom: 15.h),
                          child: Text(
                            "OK".tr,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14.sp,
                                color: AppColor.orangeColor
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
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
    ).then((value) {
      isShowDialog=false;
    });
  }

}
