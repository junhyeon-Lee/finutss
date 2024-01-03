import 'package:finutss/domain/controller/setting_controller.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/dialogs/settings_dialogs/payment_unsubscribe_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:get/get.dart';

class PaymentInfoPage extends StatelessWidget {
  final String fromDate, toDate;
  PaymentInfoPage({
    this.fromDate = "-/-/-",
    this.toDate = "-/-/-",
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadiusDirectional.circular(20.r)),
        child: Stack(
          children: [
            Column(
              children: [
                size25,
                /* --------------------------------- heading -------------------------------- */
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customText(text: 'PAYMENT_INFO'.tr, fontSize: 24, fontWeight: FontWeight.bold),
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
                                  height: 387.h,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.r),
                                    color: Color(0xFFF5F7FA),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        customText(
                                          text: "Galaxy Flip 3 Promotion",
                                          fontColor: Color(0xFF303443),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 16.h),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              customText(
                                                text: "${'PERIOD'.tr}: ",
                                                fontColor: Color(0xFF303443),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              customText(
                                                text: "$fromDate  to  $toDate",
                                                fontColor: Color(0xFF7F8391),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 3.h),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              customText(
                                                text: "${'NEXT_PAY'.tr}: ",
                                                fontColor: Color(0xFF303443),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              customText(
                                                text: "$toDate",
                                                fontColor: Color(0xFF7F8391),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 14.h),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(12.r),
                                              border: Border.all(
                                                color: Color(0xffCDD5E9),
                                              ),
                                              color: Colors.white,
                                            ),
                                            child: SizedBox(
                                              height: 54.h,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 16.w,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    customText(
                                                      text: 'PRICE'.tr,
                                                      fontColor: Color(0xFF7F8391),
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 16,
                                                    ),
                                                    customText(
                                                      text: "W29.700",
                                                      fontColor: Color(0xFF303443),
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 16,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 14.h),
                                          child: customText(
                                            text: "DISCOUNT".tr,
                                            fontColor: Color(0xFF303443),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 12.h),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              customText(
                                                text: "Galaxy Flip 3 Promo",
                                                fontColor: Color(0xFF303443),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              customText(
                                                text: "(-)",
                                                fontColor: Color(0xFF303443),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              customText(
                                                text: "W29,700",
                                                fontColor: Color(0xFF7F8391),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 14.h,
                                          ),
                                          child: Container(
                                            height: 1.h,
                                            width: Get.width,
                                            color: Color(0xFFCDD5E9),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 14.h),
                                          child: customText(
                                            text: 'TOTAL_PAYMENT'.tr,
                                            fontColor: Color(0xFF303443),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 12.h),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              customText(
                                                text: "L (KAKAO Pay) OF!",
                                                fontColor: Color(0xFF303443),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              customText(
                                                text: "W29,700",
                                                fontColor: Color(0xFF7F8391),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Center(
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 14.h),
                                            child: customText(
                                              text:
                                                  "THE_PAYMENT_WILL_BE_MADE_AUTOMATICALLY_AFTER_THE_SUBSCRIPTION_PERIOD_ENDS"
                                                      .tr,
                                              fontColor: Color(0xFF7F8391),
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              size10,
                              Center(
                                child: Container(
                                    //height: 210.h,
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
                                            text: 'PAY_WITH'.tr,
                                            fontColor: Color(0xFF303443),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          size10,
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              paymentButton(topRight: 0.0, bottomRight: 0.0),
                                              divider(),
                                              paymentButton(topLeft: 0.0, bottomLeft: 0.0)
                                            ],
                                          ),
                                          size10,
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              paymentButton(topRight: 0.0, bottomRight: 0.0),
                                              divider(),
                                              paymentButton(topLeft: 0.0, bottomLeft: 0.0)
                                            ],
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 16.h,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(14.0.r),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 10.h),
                                        child: customText(
                                          text: 'SUBSCRIPTION_GUIDANCE'.tr,
                                          fontSize: 14,
                                          height: 1.5,
                                          fontColor: Color(0xFF7F8391),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 10.h),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 30,
                                              child: Checkbox(
                                                value: settingController
                                                    .isChecked.value,
                                                onChanged: (bool? value) {
                                                  settingController
                                                      .isChecked.value = value!;
                                                  settingController.update();
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                width: 270,
                                                child: customText(
                                                  // textAlign: TextAlign.start,
                                                  text:
                                                      "I_CHECKED_AND_AGREE_TO_THE_PRODUCT_INFORMATION_SUCH_AS_PRICE,_CONTENT,_CANCELLATION_REFUND,_AND_INCOME_DEDUCTION_POLICY"
                                                          .tr,
                                                  fontSize: 14,
                                                  height: 1.5,

                                                  fontColor: Color(0xFF7F8391),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: customButton(
                                        onTapFunction: () {
                                          Get.dialog(PaymentUnsubscribeDialog());
                                        },
                                        radius: 16,
                                        height: 48,
                                        text: 'COMPLETED'.tr,
                                        fontWeight: FontWeight.w700,
                                        textSize: 16,
                                        color: Color(0xFF3BCCE1)),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }),
                  ),
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
                    padding: EdgeInsets.only(top: 14.h, right: 16.w),
                    child: CircleAvatar(
                      backgroundColor: colorBackgroundSilver,
                      radius: 20.r,
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

  Widget paymentButton({
    topLeft = 15.0,
    bottomLeft = 15.0,
    topRight = 15.0,
    bottomRight = 15.0,
    imageIcon = "assets/images/social_accounts/apple.png",
    iconName = "Bank Example",
    function,
  }) {
    return Expanded(
      child: InkWell(
        onTap: function,
        child: Container(
          height: 59.h,
          // width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(bottomLeft),
              topLeft: Radius.circular(topLeft),
              topRight: Radius.circular(topRight),
              bottomRight: Radius.circular(bottomRight),
            ),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8.r),
                child: Container(
                  height: 24.r,
                  width: 24.r,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(imageIcon),
                      ),
                      borderRadius: BorderRadius.circular(15.r),
                      color: Colors.white),
                ),
              ),
              Expanded(
                child: Container(
                  height: 30.h,
                  child: customText(
                    text: iconName,
                    fontColor: Color(0XFF303443),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget divider() {
    return Container(
      height: 59.h,
      width: 1.w,
      color: Color(0xFFCDD5E9),
    );
  }
}
