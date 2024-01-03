import 'package:finutss/helper/network_helper.dart';
import 'package:finutss/new%20ui/modules/app_setting/controller/app_setting_controller.dart';
import 'package:finutss/new%20ui/modules/sign_in/presentation/sign_in_screen.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/custom_slider_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
bool isShowDialog=false;

Future<void> tokenErrorDialog(BuildContext context) async {

  if(!isShowDialog) {
    NetworkAPICall.httpClient.close();
    isShowDialog=true;
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (_, __, ___) {
        AppSettingController controller = Get.find();

        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Container(
              height: 508.h,
              padding: EdgeInsets.symmetric(horizontal: 30.h),
              margin: EdgeInsets.symmetric(
                horizontal: 15.h,
              ),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(14)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(height: 100.h),
                      Text("NOTICE".tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.sp,
                        ),),
                      SizedBox(height: 30.h),
                      Image.asset(
                        IconAssets.noticeAlert,
                        height: 105.w,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "YOU_CANNOT_LOG_IN_NORMALLY_AT_THIS_TIME_IF_YOU_CONTINUE_TO_HAVE_PROBLEMS_USING_THE_SERVICE_PLEASE_CONTACT_THE_CUSTOMER_CENTER".tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13.sp,
                        ),),
                      SizedBox(height: 5.h),
                      Text("YOU_WILL_BE_TAKEN_TO_THE_LOGIN_SCREEN".tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),),
                      SizedBox(height: 30.h),
                      CustomSliderButton(
                        height: 50.h,
                        isCancelButton: false,
                        title: controller.selectedLanguage.value == "한국어"
                            ? '확인'
                            : 'OK',
                        onTap: () async {
                          controller.logout().then((value) {
                            isShowDialog=false;
                          });
                        },
                      ),
                      SizedBox(height: 30.h),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 78.h),
          ]),
        );
      },
    ).then((value) {
      isShowDialog=false;
    });
  }
}
