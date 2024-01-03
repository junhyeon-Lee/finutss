import 'package:finutss/new%20ui/modules/app_setting/widget/custom_setting_row.dart';
import 'package:finutss/new%20ui/modules/subcription/presentation/compelete_bottom_sheet.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/widget/custom_slider_button.dart';
import 'package:finutss/new%20ui/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class CouponRegistrationScreen extends StatelessWidget {
  final TextEditingController couponController = TextEditingController();

  CouponRegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backGroundColor,
        body: Column(
          children: [
            CustomSettingRow(
              title: 'COUPON_REGISTRATION'.tr.toUpperCase(),
              horizontalPadding: 20.w,
              fontsize: 18.sp,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 12.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            13.w,
                          ),
                          color: AppColor.whiteColor,
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.cardGradiant1.withOpacity(0.05),
                              spreadRadius: 0.1,
                              blurRadius: 8,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15.w,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 12.h,
                              ),
                              CustomTextField(
                                fillColor: AppColor.couponTextFieldBg,
                                hintText: "COUPON_CODE".tr,
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp,
                                  color: AppColor.blueTextColor.withOpacity(
                                    0.5,
                                  ),
                                ),
                                controller: couponController,
                              ),
                              SizedBox(
                                height: 25.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                ),
                                child: CustomSliderButton(
                                  title: "REGISTRATION".tr,
                                  onTap: () {},
                                  isCancelButton: false,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "IN_POSSESSION".tr,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                            color: AppColor.blueTextColor,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            15.w,
                          ),
                          color: AppColor.whiteColor,
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.cardGradiant1.withOpacity(0.05),
                              spreadRadius: 0.1,
                              blurRadius: 8,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15.w,
                            vertical: 10.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "GALAXY_FLIP_PROMOTION".tr+" - 3 "+"MONTHS".tr,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.sp,
                                  color: AppColor.blueTextColor,
                                  letterSpacing: 0.4,
                                ),
                              ),

                              SizedBox(
                                height: 10.h,
                              ),
                              textRow(
                                "REGISTRATION_DATA",
                                "2021.10.04",
                              ),
                              textRow(
                                "VALIDITY",
                                "2022.01.04",
                              ),
                              textRow(
                                "SUBSCRIPTION_PERIOD",
                                "3 "+"MONTHS".tr,
                              ),
                              textRow(
                                "COUPON_CODE",
                                "N/78A-4843-4121-5022",
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 2.w,
                                  vertical: 5.h,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColor.couponTextFieldBg,
                                    borderRadius:
                                        BorderRadiusDirectional.circular(
                                      10,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 10.h,
                                    ),
                                    child: Column(
                                      children: [
                                        dataRow("ABOUT_USING_SUBSCRIPTIONS".tr,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 10.h,
                                  horizontal: 14.w,
                                ),
                                child: CustomSliderButton(
                                  title: 'USE_SUBSCRIPTION'.tr,
                                  onTap: () {
                                    // Navigation.pushNamed(
                                    //   Routes.paymentInfoScreen,
                                    // );

                                    CompleteBottomSheet(context);
                                  },
                                  isCancelButton: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dataRow(String? subtitle) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 7.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              subtitle ?? "INITIALIZE_APP_DATA_INFO".tr,
              maxLines: 8,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                height: 1.5.h,
                color: AppColor.blueTextColor.withOpacity(0.7),
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
                letterSpacing: 0.1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget textRow(String title, String Date) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 1.8.h,
      ),
      child: Row(
        children: [
          Text(
            title.tr,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13.sp,
              color: AppColor.blueTextColor.withOpacity(
                0.8,
              ),
              letterSpacing: 0.4,
            ),
          ),
          Text(
            " : ",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13.sp,
              color: AppColor.blueTextColor.withOpacity(
                0.8,
              ),
              letterSpacing: 0.4,
            ),
          ),
          Text(
            Date,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13.sp,
              color: AppColor.blueTextColor.withOpacity(
                0.8,
              ),
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}
