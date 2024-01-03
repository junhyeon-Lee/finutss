import 'package:finutss/new%20ui/modules/app_setting/controller/payment_info_controller.dart';
import 'package:finutss/new%20ui/modules/app_setting/widget/custom_setting_row.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/widget/custom_slider_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PaymentInfoScreen extends StatelessWidget {
  PaymentInfoScreen({Key? key}) : super(key: key);
  final PaymentInfoController controller = Get.put(PaymentInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
            ),
            child: Column(
              children: [
                CustomSettingRow(
                  title: 'PAYMENT_INFO'.tr.toUpperCase(),
                  fontsize: 18.sp,
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
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 15.h,
                      horizontal: 20.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "GALAXY_FLIP_PROMOTION".tr,
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
                          title: 'PERIOD'.tr,
                          Date: "2021.10.04",
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        textRow(
                          title: 'NEXT_PAYMENT_DATE'.tr,
                          Date: "2021.10.04",
                        ),
                        receiptRow(
                          title: "",
                          title1: 'PRICE'.tr,
                          title2: "W29,700",
                          font: true,
                        ),
                        receiptRow(
                          title: 'DISCOUNT'.tr,
                          title1: "GALAXY_FLIP_PROMOTION".tr,
                          title2: "W29,700",
                          font: false,
                        ),
                        receiptRow(
                          title: 'TOTAL_PAYMENT'.tr,
                          title1: "(KAKAO PAY)",
                          title2: "W29,700",
                          font: false,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "THE_PAYMENT_WILL_BE_MADE_AUTOMATICALLY_AFTER_THE_SUBSCRIPTION_PERIOD_ENDS"
                              .tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            color: AppColor.blueTextColor.withOpacity(
                              0.8,
                            ),
                            letterSpacing: 0.4,
                          ),
                        ),
                      ],
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
                        offset: Offset(0, 3), // changes position of shadow
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
                          'PAY_WITH'.tr,
                          style: TextStyle(
                            color: AppColor.blueTextColor,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 10.w,
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.paymentInfoList.length,
                          itemBuilder: (context, index) {
                            return Obx(
                              () => InkWell(
                                onTap: () {
                                  controller.isSelect.value = index;
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 8.h,
                                    horizontal: 5.w,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        8.w,
                                      ),
                                      color: AppColor.couponTextFieldBg,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColor.cardGradiant1
                                              .withOpacity(0.05),
                                          spreadRadius: 0.1,
                                          blurRadius: 8,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10.h,
                                        horizontal: 20.w,
                                      ),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            controller.isSelect.value == index
                                                ? IconAssets.checkBoxSelect
                                                : IconAssets.checkBoxUnSelect,
                                            height: 17.h,
                                          ),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          Text(
                                            controller
                                                .paymentInfoList[index].name
                                                .toString().tr,
                                            style: TextStyle(
                                              color: AppColor.blueTextColor,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Spacer(),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5.w),
                                            child: Image.asset(
                                              controller
                                                  .paymentInfoList[index].image
                                                  .toString(),
                                              height: 30.h,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        dataRow("1.", "SUBSCRIPTION_GUIDANCE".tr),
                        dataRow("2.", "SUBSCRIPTION_GUIDANCE".tr),
                        SizedBox(
                          height: 8.h,
                        ),
                        Obx(
                          () => termsAndCondition(
                            subtitle:
                                "I_CHECKED_AND_AGREE_TO_THE_PRODUCT_INFORMATION_SUCH_AS_PRICE,_CONTENT,_CANCELLATION_REFUND,_AND_INCOME_DEDUCTION_POLICY"
                                    .tr,
                            onTap: () {
                              controller.termsSelect.value =
                                  !controller.termsSelect.value;
                            },
                            child: Image.asset(
                              controller.termsSelect.value
                                  ? IconAssets.checkBoxSelect
                                  : IconAssets.checkBoxUnSelect,
                              height: 16.h,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 15.h,
                            horizontal: 20.w,
                          ),
                          child: CustomSliderButton(
                            title: "ABOUT_PAYMENT".tr.toUpperCase(),
                            onTap: () {
                              Navigation.pushNamed(
                                Routes.couponRegistrationScreen,
                              );
                            },
                            isCancelButton: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dataRow(String? title, String? subtitle) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 7.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "1.",
            style: TextStyle(
              color: AppColor.blueTextColor.withOpacity(0.7),
              fontWeight: FontWeight.w600,
              fontSize: 12.sp,
              letterSpacing: 0.1,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Flexible(
            child: Text(
              subtitle ?? "",
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
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

  Widget termsAndCondition(
      {String? subtitle, Widget? child, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 5.w,
          vertical: 7.h,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: child,
            ),
            SizedBox(
              width: 3.w,
            ),
            Flexible(
              child: Text(
                subtitle ?? "INITIALIZE_APP_DATA_INFO".tr,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColor.blueTextColor.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  letterSpacing: 0.1,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget receiptRow({String? title, String? title1, String? title2, font}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 5.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? 'DISCOUNT'.tr,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13.sp,
              color: AppColor.blueTextColor.withOpacity(
                0.8,
              ),
              letterSpacing: 0.4,
            ),
          ),
          SizedBox(
            height: 7.h,
          ),
          Row(
            children: [
              Text(
                title1 ?? 'PRICE'.tr,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  color: AppColor.blueTextColor.withOpacity(
                    0.8,
                  ),
                  letterSpacing: 0.4,
                ),
              ),
              Spacer(),
              Text(
                title2 ?? "W29,700",
                style: TextStyle(
                  fontWeight: font ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 14.sp,
                  color: AppColor.blueTextColor.withOpacity(
                    0.8,
                  ),
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
          Divider(
            color: AppColor.receiptDivider,
            thickness: 0.5,
          ),
        ],
      ),
    );
  }

  Widget textRow({String? title, String? Date}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 1.5.h,
      ),
      child: Row(
        children: [
          Text(
            title ?? "",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13.sp,
              color: AppColor.blueTextColor,
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
            Date ?? "",
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
