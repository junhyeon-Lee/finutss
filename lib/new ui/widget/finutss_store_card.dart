import 'package:finutss/new%20ui/modules/store/presentation/store.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/app_string.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class FinutssStoreCard extends StatelessWidget {
  const FinutssStoreCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(right: 14.w, left: 20.w, top: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.w),
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                AppColor.withdrawGradiant2,
                AppColor.withdrawGradiant3,
                AppColor.withdrawGradiant1
              ],),
        ),
        child: SizedBox(width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                  right:0,child: Image.asset(ImageAssets.welcomeStore,width: 124.w,)),
              Padding(
                padding: EdgeInsets.only(right: 122.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(
                      height: 5.h,
                    ),
                    // Text(
                    //   'WITH_FINUTSS'.tr,
                    //   style: TextStyle(color: AppColor.whiteColor, fontWeight: FontWeight.w600, fontSize: 8.sp),
                    // ),
                    // SizedBox(
                    //   height: 3.h,
                    // ),
                    Text(
                      'WELCOME_FINUTSS_STORE'.tr,
                      style:
                          TextStyle(color: AppColor.whiteColor, fontWeight: FontWeight.w700, letterSpacing: 0.5, fontSize: 14.sp),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      'YOU_CAN_PURCHASE_FINUTSSS_MONTHLY_SUBSCRIPTION_PRODUCT_AND_EP_WHICH_IS_A_CHARGING_POINT'.tr,
                      style: TextStyle(
                          color: AppColor.whiteColor.withOpacity(0.7), fontWeight: FontWeight.w500, height: 1.5, fontSize: 12.sp),
                    ),
                  SizedBox(
                    height: 12.h,
                  ),
                  InkWell(
                    onTap: (){
                      Navigation.pushNamed(Routes.storeScreen,arg: {"initIndex": '0'});
                    },
                    child: Container(
                      width: 90.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9.w),
                        color: AppColor.whiteColor,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 7.5.h),
                      child: Center(
                        child: Text(
                          "LEARN_MORE".tr.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppColor.learnMoreTxtColor, fontSize: 10.sp, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h,)
                ],),
              ),
            ],
          ),
        ));
  }
}
