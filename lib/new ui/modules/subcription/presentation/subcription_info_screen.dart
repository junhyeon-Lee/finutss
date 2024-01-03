import 'package:finutss/new%20ui/modules/app_setting/widget/custom_setting_row.dart';
import 'package:finutss/new%20ui/modules/subcription/controller/subscription_controller.dart';
import 'package:finutss/new%20ui/modules/subcription/presentation/subscription_history_bottom_sheet.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SubscriptionInfoScreen extends StatelessWidget {
  SubscriptionInfoScreen({Key? key}) : super(key: key);
  final SubSubscriptionController controller =
      Get.put(SubSubscriptionController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backGroundColor,
        body: Column(
          children: [
            CustomSettingRow(
              title: 'SUBSCRIPTIONS_INFO'.tr.toUpperCase(),
              horizontalPadding: 20.w,
              fontsize: 18.sp,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 18.h,
                      ),
                      subscriptionInfoCard(),
                      SizedBox(
                        height: 19.h,
                      ),
                      cardItemView(
                        'SUBSCRIPTION_HISTORY'.tr,
                        () {
                          subscriptionHistoryBottomSheet(context);
                        },
                      ),
                      cardItemView(
                        'AUTO_PAYMENT_UNSUBSCRIBE'.tr,
                        () {
                          Navigation.pushNamed(
                              Routes.unSubscriptionPaymentScreen);
                        },
                      ),
                      cardItemView('COUPON_REGISTRATION'.tr, () {
                        Navigation.pushNamed(
                          Routes.couponCodeRegistrationScreen,
                        );
                      }),
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

  Widget subscriptionInfoCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SUBSCRIPTIONS_INFO'.tr.toUpperCase(),
          style: TextStyle(
            color: AppColor.subTitleColor,
            letterSpacing: 0.4,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(8.w),
            boxShadow: [
              BoxShadow(
                color: AppColor.cardGradiant1.withOpacity(0.06),
                spreadRadius: 1.4,
                blurRadius: 10,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 5.h),
          child: Column(
            children: [
              titleDescription('SUBSCRIPTIONS_TYPE'.tr,
                  "STANDARD_SUBSCRIPTION".tr, AppColor.orangeColor),
              divider(),
              titleDescription(
                  'PERIOD'.tr, '21.09.05', AppColor.subTitleColor),
              divider(),
              titleDescription(
                  'NEXT_PAY'.tr, '21.09.05', AppColor.subTitleColor),
            ],
          ),
        )
      ],
    );
  }

  Widget divider() {
    return Container(
      height: 1.h,
      color: AppColor.commentCardBg,
    );
  }

  Widget titleDescription(String title, String des, Color color) {
    return SizedBox(
      height: 43.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.sp,
                    color: AppColor.subTitleColor.withOpacity(0.9)),
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                des,
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 12.sp, color: color),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cardItemView(String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 8.5.h),
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 14.h),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.1,
              ),
            ),
            SvgPicture.asset(
              IconAssets.rightArrow,
              height: 11.h,
            )
          ],
        ),
      ),
    );
  }
}
