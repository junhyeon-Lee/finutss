
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/widget/custom_slider_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

Future<void> MessageBottomSheet(BuildContext context, {required String message, String? icon,required bool isSignInScreen}) {

  return showModalBottomSheet<void>(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(12),
      ),
    ),
    useRootNavigator: true,
    enableDrag: false,
    context: context,
    isDismissible: false,
    isScrollControlled: true,
    backgroundColor: Colors.black.withOpacity(0.2),
    builder: (context) {
      return WillPopScope(
          onWillPop: () async{
            if(isSignInScreen){
              return false;
            }else {
              return true;
            }
      },
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(12),
            ),
          ),
          height: MediaQuery.of(context).size.height * 2,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [

              Spacer(),

              SizedBox(
                height: 55.h,
              ),

              isSignInScreen ? SizedBox() : GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  margin: EdgeInsets.only(right: 12.w),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      IconAssets.close,
                      scale: 4,
                    ),
                  ),
                ),
              ),

              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
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
                      padding:
                      EdgeInsets.only(left: 26.w, right: 26.w, top: 15.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          HeaderWidget(
                            icon: icon,
                            title: 'NOTICE'.tr,
                          ),


                          Text(
                            message.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColor.subTitleColor,
                              letterSpacing: 0.1,
                            ),
                          ),


                          SizedBox(
                            height: 36.h,
                          ),


                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.w),
                            child: CustomSliderButton(
                                title: 'OK'.tr,
                                onTap: () {
                                  if(isSignInScreen){
                                    Navigation.replaceAll(Routes.verificationScreen);
                                  }else {
                                    Navigation.pop();
                                  }
                                },
                                isCancelButton: false),
                          ),
                          SizedBox(
                            height: 44.h,
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
      padding: EdgeInsets.only(top: 20.0.h, bottom: 20.h),
      child: Column(
        children: [
          Text(
            title ?? '',
            style: TextStyle(
              color: AppColor.blueTextColor,
              fontSize: 19.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 36.h,
          ),
        ],
      ),
    );
  }
}