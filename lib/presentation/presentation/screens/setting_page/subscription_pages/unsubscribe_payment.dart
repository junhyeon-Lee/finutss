import 'package:finutss/constants.dart';
import 'package:finutss/domain/controller/social_controller.dart';
import 'package:finutss/presentation/screens/setting_page/subscription_pages/unsubscribe_history.dart';
import 'package:finutss/presentation/widgets/common_widgets/appbars/simple_appbar.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/payment_information_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class UnsubscribePayment extends StatelessWidget {
  final SocialController socialController = Get.put(SocialController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar:
          simpleAppBar(text: "UNSUBSCRIBE".tr, automaticallyImplyLeading: true)
              as PreferredSizeWidget?,
      body: Container(
        // height: Get.height,
        // width: Get.width,
        color: Color(0xFFF5F7FA),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 14.h,
                ),
                child: Container(
                  // height: 282,
                  // width: Get.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.r),
                        child: paymentInformationCard(
                            paymentType: "PAY_AUTO_MONTH".tr,
                            duration: '',
                            fromDate: "14.07.1947",
                            toDate: "7.8.2021",
                            backGroundColor: Color(0xFFF73A6B),
                            foreGroundColor: Color(0xFFF73A6B),
                            subscriptionId: "P314N-3457-4284-1234",
                            function: () {
                              Get.to(UnsubscribeHistory());
                              // Get.to(WithdrawalPage());
                            }),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.r),
                        child: Center(
                          child: Container(
                            height: 155,
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: Color(0xFFF5F7FA),
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          16.w, 20.h, 0, 10.h),
                                      child: customText(
                                        text: "PAYMENT".tr,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                divider,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          16.w, 20.h, 16.w, 10.h),
                                      child: customText(
                                        text: "PAYMENT".tr,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontColor: Color(0xFF7F8391),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          16.w, 20.h, 16.w, 10.h),
                                      child: customText(
                                          text: "₩9900",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          fontColor: Color(0xFF303443)),
                                    ),
                                  ],
                                ),
                                divider,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          16.w, 20.h, 16.w, 10.h),
                                      child: customText(
                                          text: "₩9900",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          fontColor: Color(0xFF303443)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      customButton(
                          onTapFunction: () {
                            Get.back();
                            Get.dialog(Padding(
                                padding: EdgeInsets.all(16.0.r),
                                child: UnsubscribeHistory()));
                          },
                          width: 200,
                          radius: 16,
                          height: 48,
                          text: 'UNSUBSCRIBE'.tr,
                          fontWeight: FontWeight.w700,
                          textSize: 16,
                          color: Color(0xFF3BCCE1)),
                      size20,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget divider = Padding(
    padding: EdgeInsets.symmetric(
      horizontal: 16.w,
    ),
    child: Container(
      color: Color(0xFF7F8391),
      height: 1,
      width: Get.width,
    ),
  );
}
