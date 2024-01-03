import 'package:finutss/new%20ui/modules/app_setting/widget/custom_setting_row.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/widget/custom_slider_button.dart';
import 'package:finutss/new%20ui/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class CouponCodeRegistrationScreen extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  CouponCodeRegistrationScreen({Key? key}) : super(key: key);

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
                                hintText: "COUPON-CODE".tr,
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp,
                                  color: AppColor.blueTextColor.withOpacity(
                                    0.5,
                                  ),
                                ),
                                controller: controller,
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
                                  onTap: () {
                                    Navigation.pushNamed(
                                      Routes.paymentInfoScreen,
                                    );
                                  },
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
}
