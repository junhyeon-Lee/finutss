import 'package:finutss/domain/controller/setting_controller.dart';
import 'package:finutss/presentation/screens/setting_page/subscription_pages/payment_info_page.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:get/get.dart';

class CouponRegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadiusDirectional.circular(20.r)),
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                children: [
                  size25,
                  /* --------------------------------- heading -------------------------------- */
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customText(text: 'COUPON'.tr, fontSize: 24, fontWeight: FontWeight.bold),
                    ],
                  ),
                  size30,

                  /* -------------------------------------------------------------------------- */
                  /*                                Notice list                               */
                  /* -------------------------------------------------------------------------- */
                  Expanded(
                      child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(16.r),
                      child: GetBuilder<SettingController>(
                          init: SettingController(),
                          builder: (settingController) {
                            return Column(
                              children: [
                                Center(
                                  child: Container(
                                      height: 148.h,
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15.r),
                                        color: Color(0xFFF5F7FA),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 8.0.w, right: 8.w, bottom: 10.h),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12.r),
                                                border: Border.all(
                                                  color: Color(0xffCDD5E9),
                                                ),
                                                color: Colors.white,
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                                child: Container(
                                                  height: 50.h,
                                                  child: Center(
                                                    child: TextField(
                                                      style: TextStyle(
                                                          fontSize: 16.sp,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.black),
                                                      decoration: InputDecoration(
                                                        isCollapsed: true,
                                                        hintText: 'COUPON-CODE'.tr,
                                                        border: InputBorder.none,
                                                        hintStyle: TextStyle(
                                                          fontSize: 16.sp,
                                                          fontWeight: FontWeight.w500,
                                                          color: Color(0xffCDD5E9),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 8.0.r, right: 8.r),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: customButton(
                                                      onTapFunction: () {
                                                        Get.back();
                                                        Get.dialog(Padding(
                                                            padding: EdgeInsets.all(16.0.r), child: PaymentInfoPage()));
                                                      },
                                                      radius: 16,
                                                      height: 48,
                                                      text: 'REGISTRATION'.tr,
                                                      fontWeight: FontWeight.w700,
                                                      textSize: 16,
                                                      color: Color(0xFF3BCCE1)),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    // horizontal: 16,
                                    vertical: 14.h,
                                  ),
                                  child: Row(
                                    children: [
                                      customText(
                                        text: 'IN_POSSESSION'.tr,
                                        fontColor: Color(0xFF303443),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Container(
                                      // height: 676,
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15.r),
                                        color: Color(0xFFF5F7FA),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 20.h,
                                          horizontal: 16.w,
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            customText(
                                              text: "Galaxy Flip 3 Promotion 3 Months",
                                              fontColor: Color(0xFF303443),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 16.0),
                                              child: customText(
                                                text: "${'REGISTRATION_DATA'.tr} 2021.10.04",
                                                fontColor: Color(0xFF7F8391),
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 8.0),
                                              child: customText(
                                                text: "${'VALIDITY'.tr} 2021.10.04",
                                                fontColor: Color(0xFF7F8391),
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 8.0),
                                              child: customText(
                                                text:
                                                    "${'SUBSCRIPTION_PERIOD'.tr}: ${'3_MONTHS_FROM_THE_DATE_OF_USE'.tr}",
                                                fontColor: Color(0xFF7F8391),
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 8.0),
                                              child: customText(
                                                text: "${'COUPON_CODE'.tr}: 1234-1234-1234-1234",
                                                fontColor: Color(0xFF7F8391),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 16.h,
                                              ),
                                              child: Container(
                                                // height: 360,
                                                width: Get.width,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15.r),
                                                  color: Colors.white,
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(14.r),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.only(bottom: 10.h),
                                                        child: customText(
                                                          text: 'ABOUT_USING_SUBSCRIPTIONS'.tr,
                                                          fontSize: 14,
                                                          height: 1.5,
                                                          fontColor: Color(0xFF7F8391),
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      ),
                                                      // Padding(
                                                      //   padding: EdgeInsets.only(bottom: 10),
                                                      //   child: customText(
                                                      //     // textAlign: TextAlign.start,
                                                      //     text: "STR eY TT rity tt ce LES",
                                                      //     fontSize: 14,
                                                      //     fontColor: Color(0xFF7F8391),
                                                      //     fontWeight: FontWeight.w500,
                                                      //   ),
                                                      // )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: customButton(
                                                      onTapFunction: () {
                                                        Get.back();
                                                      },
                                                      radius: 16,
                                                      height: 48,
                                                      text: 'USE_COUPON'.tr,
                                                      fontWeight: FontWeight.w700,
                                                      textSize: 16,
                                                      color: Color(0xFF3BCCE1)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                              ],
                            );
                          }),
                    ),
                  )),
                ],
              ),
            ),
            /* -------------------------------------------------------------------------- */
            /*                                cancel button                               */
            /* -------------------------------------------------------------------------- */
            Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 14.h, right: 16.w),
                    child: CircleAvatar(
                      radius: 20.r,
                      backgroundColor: colorBackgroundSilver,
                      child: Icon(
                        CommunityMaterialIcons.window_close,
                        color: Colors.black,
                        size: 24.r,
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
