import 'package:finutss/presentation/screens/setting_page/subscription_pages/subscription_history.dart';
import 'package:finutss/presentation/screens/setting_page/subscription_pages/unsubscribe_payment.dart';
import 'package:finutss/presentation/widgets/common_widgets/action_card.dart';
import 'package:finutss/presentation/widgets/common_widgets/appbars/simple_appbar.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/rounded_decoration.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'coupon_registration_page.dart';

class SubscriptionInfoPge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackgroundSilver,
      appBar: simpleAppBar(text: 'SUBSCRIPTIONS'.tr) as PreferredSizeWidget?,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              size25,
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w),
                child: Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: roundedDecoration(),
                  child: Column(
                    children: [
                      Container(
                        decoration:
                            roundedDecoration(color: colorBackgroundSilver),
                        padding: EdgeInsets.all(16.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customText(
                                text: 'SUBSCRIPTIONS_INFO'.tr,
                                fontWeight: FontWeight.bold,
                                fontColor: Colors.black,
                                fontSize: 16),
                            size15,
                            _infoRow('SUBSCRIPTIONS_TYPE'.tr,
                                "STANDARD_SUBSCRIPTION".tr),
                            size15,
                            _infoRow('PERIOD'.tr, '2021/12/25'),
                            size15,
                            _infoRow('NEXT_PAY'.tr, '2021/12/25'),
                          ],
                        ),
                      ),
                      size15,
                      actionCard(
                          heading: 'SUBSCRIPTION_HISTORY'.tr,
                          onTapFunction: () {
                            Get.dialog(Padding(
                                padding: EdgeInsets.all(16.r),
                                child: SubscriptionHistoryPage()));
                          }),
                      size15,
                      actionCard(
                          heading: 'AUTO_PAYMENT_UNSUBSCRIBE'.tr,
                          onTapFunction: () {
                            Get.to(() => UnsubscribePayment());
                          }),
                      size15,
                      actionCard(
                          heading: 'COUPON_REGISTRATION'.tr,
                          onTapFunction: () {
                            Get.dialog(Padding(
                                padding: EdgeInsets.all(16.r),
                                child: CouponRegistrationPage()));
                          }),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _infoRow(title, value) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: customText(
                text: '$title',
                fontColor: Color(0xff7F8391),
                fontSize: 14,
                fontWeight: FontWeight.w500)),
        Expanded(
            flex: 3,
            child: customText(
                text: '$value',
                fontColor: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600))
      ],
    );
  }
}
