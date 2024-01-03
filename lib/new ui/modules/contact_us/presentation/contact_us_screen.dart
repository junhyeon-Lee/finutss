import 'package:finutss/new%20ui/modules/app_setting/widget/custom_setting_row.dart';
import 'package:finutss/new%20ui/modules/contact_us/controller/contact_us_controller.dart';
import 'package:finutss/new%20ui/modules/contact_us/presentation/payment_dialog.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ContactUsScreen extends StatelessWidget {
  ContactUsScreen({Key? key}) : super(key: key);
  final ContactUsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backGroundColor,
        body: Column(
          children: [
            CustomSettingRow(
              title: "CONTACT_US".tr,
              horizontalPadding: 20.w,
              fontsize: 18.sp,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 18.h,
                      ),
                      cardItem('ABOUT_PAYMENT'.tr, () {
                        paymentBottomSheet(context, "ABOUT_PAYMENT", Constants.typePayment);
                      }),
                      cardItem("HISTORY_SYSTEM".tr, () {
                        paymentBottomSheet(context, "HISTORY_SYSTEM", Constants.typeHistorySystem);
                      }),
                      cardItem("BUG_REPORTING".tr, () {
                        paymentBottomSheet(context, "BUG_REPORTING", Constants.typeBugReport);
                      }),
                      cardItem("OTHER".tr, () {
                        paymentBottomSheet(context, "OTHER", Constants.typeOther);
                      }),
                      SizedBox(
                        height: 16.h,
                      ),
                      textItem("CONTACT_US_INFO".tr, false),
                      SizedBox(
                        height: 36.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: InkWell(
                          onTap: () {
                            Navigation.pushNamed(Routes.inquiryHistoryScreen);
                          },
                          child: Container(
                            height: 42.h,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColor.blue, width: 1.w),
                                borderRadius: BorderRadius.circular(14)),
                            child: Center(
                              child: Text(
                                "HISTORY".tr,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.blue),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
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

  Widget cardItem(String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(5.w),
          boxShadow: [
            BoxShadow(
              color: AppColor.cardGradiant1.withOpacity(0.06),
              spreadRadius: 1.4,
              blurRadius: 10,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 14.5.h),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColor.subTitleColor,
                  fontSize: 15.sp,
                  letterSpacing: 0.1,
                ),
              ),
            ),
            SvgPicture.asset(
              IconAssets.rightArrow,
              height: 11.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget textItem(String text, bool isReachText) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 5.w,
          ),
          Expanded(
            child: isReachText
                ? Text.rich(
                    TextSpan(
                      children: <InlineSpan>[
                        TextSpan(
                          text:
                              "You can check the answers to your inquiries in ",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AppColor.subTitleColor.withOpacity(0.7),
                            fontSize: 12.sp,
                            height: 1.8,
                            letterSpacing: 0.1,
                          ),
                        ),
                        TextSpan(
                          text: "[Contact Us > Inquiry History]",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColor.subTitleColor.withOpacity(0.7),
                            fontSize: 12.sp,
                            height: 1.8,
                            letterSpacing: 0.1,
                          ),
                        ),
                      ],
                    ),
                  )
                : Text(
                    text,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColor.subTitleColor.withOpacity(0.7),
                      fontSize: 12.sp,
                      height: 1.8,
                      letterSpacing: 0.1,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
