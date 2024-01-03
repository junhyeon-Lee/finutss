import 'package:finutss/presentation/screens/setting_page/subscription_pages/receipt_page.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/payment_information_card.dart';
import 'package:finutss/presentation/widgets/common_widgets/rounded_decoration.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:get/get.dart';

class SubscriptionHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadiusDirectional.circular(20)),
        child: Stack(
          children: [
            Column(
              children: [
                size25,
                /* --------------------------------- heading -------------------------------- */
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     customText(
                //         text: 'Subscription',
                //         fontSize: 24,
                //         fontWeight: FontWeight.bold),
                //   ],
                // ),
                size30,
                Expanded(
                    child: SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.all(16.r),
                      child: Column(
                        children: [
                          /* ---------------------------- fist payment card --------------------------- */
                          Container(
                            decoration: roundedDecoration(color: colorBackgroundSilver, radius: 8),
                            padding: EdgeInsets.all(16.r),
                            child: paymentInformationCard(
                                duration: 'Monthly',
                                paymentType: 'PAY_AUTO_MONTH'.tr,
                                fromDate: '2021.11.21',
                                toDate: '2021.11.21',
                                subscriptionId: 'P314N-3457-4248-1234',
                                useTickIcon: false),
                          ),
                          size15,
                          /* -------------------------- details payment card -------------------------- */
                          Container(
                            decoration: roundedDecoration(color: colorBackgroundSilver, radius: 8),
                            padding: EdgeInsets.all(16.r),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                paymentInformationCard(
                                    duration: 'Monthly',
                                    paymentType: 'PAY_AUTO_MONTH'.tr,
                                    fromDate: '2021.11.21',
                                    toDate: '2021.11.21',
                                    subscriptionId: 'P314N-3457-4248-1234',
                                    useTickIcon: true),
                                size45,
                                _amountRow('PRICE'.tr, 'W9,900'),
                                size25,
                                Divider(
                                  color: Colors.black,
                                ),
                                size20,
                                customText(
                                    fontColor: Colors.black,
                                    text: 'DISCOUNT'.tr,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                size10,
                                _amountRow('Octobor Promo', '(-) W9,900', headingSize: 14),
                                size15,
                                customText(
                                    fontColor: Colors.black,
                                    text: 'PAYMENT'.tr,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                size10,
                                _amountRow('Octobor (KAKAO PAY)', 'W9,900', headingSize: 14),
                                size15,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    customButton(
                                        text: 'RECEIPT'.tr,
                                        width: 107,
                                        onTapFunction: () {
                                          Get.back();
                                          Get.to(() => ReceiptPage());
                                        }),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          /* -------------------------------- erd card -------------------------------- */
                          size15,
                          Container(
                            decoration: roundedDecoration(color: colorBackgroundSilver, radius: 8),
                            padding: EdgeInsets.all(16.r),
                            child: paymentInformationCard(
                                duration: 'Monthly',
                                paymentType: 'PAY_AUTO_MONTH'.tr,
                                fromDate: '2021.11.21',
                                toDate: '2021.11.21',
                                subscriptionId: 'P314N-3457-4248-1234',
                                useTickIcon: true),
                          ),
                        ],
                      )),
                )),
              ],
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
                    padding: EdgeInsets.only(top: 17.h, right: 16.w),
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
                )),
            /* ---------------------------------- title --------------------------------- */
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 24.h),
                child: Container(
                  height: 35,
                  child: Center(
                    child: customText(text: 'SUBSCRIPTION_HISTORY'.tr, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _amountRow(heading, amount, {double headingSize = 16}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        customText(fontColor: Color(0xff7F8391), text: heading, fontSize: headingSize, fontWeight: FontWeight.w500),
        customText(fontColor: Colors.black, text: amount, fontSize: 16, fontWeight: FontWeight.bold)
      ],
    );
  }
}
