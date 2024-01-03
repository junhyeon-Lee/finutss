import 'package:finutss/new%20ui/modules/app_setting/widget/custom_setting_row.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/app_string.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class ReceiptScreen extends StatelessWidget {
  const ReceiptScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backGroundColor,
        body: Column(
          children: [
            CustomSettingRow(
              title: 'RECEIPT'.tr.toUpperCase(),
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
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(12.w),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.cardGradiant1.withOpacity(0.06),
                              spreadRadius: 1.4,
                              blurRadius: 14,
                              offset:
                                  Offset(0, 4), // changes position of shadow
                            ),
                          ],
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 12.h),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: AppColor.calibrationCardColor,
                                borderRadius: BorderRadius.circular(8.w),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Column(
                                children: [
                                  receiptItem(
                                      'ORDER_NO'.tr, 'P314n-456-225-235', true),
                                  receiptItem('DATE'.tr, '2021/12/25', false),
                                  receiptItem('PRODUCT'.tr,
                                      'Monthly Subscription', false),
                                  receiptItem('PRICE'.tr, 'W 9,150', false),
                                  receiptItem(
                                      'COMPANY'.tr, '9ieces.Inc', false),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 14.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 9.w),
                              child: Text(
                                'RECEIPT_USAGE_INFO'.tr,
                                style: TextStyle(
                                  color:
                                      AppColor.subTitleColor.withOpacity(0.8),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13.5.sp,
                                  height: 1.6,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 80.h,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            IconAssets.companyLogo,
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          Expanded(
                            child: Text(
                              AppString.companyInfo,
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  height: 1.7,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.subTitleColor
                                      .withOpacity(0.8)),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16.h,
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

  Widget receiptItem(String title, String value, bool isFirst) {
    return Column(
      children: [
        isFirst
            ? Container()
            : Container(
                height: 0.8.w,
                color: AppColor.receiptDivider,
              ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: SizedBox(
            height: 40.h,
            child: Row(
              children: [
                SizedBox(
                  width: 80.w,
                  child: Text(
                    title,
                    style: TextStyle(
                      color: AppColor.subTitleColor.withOpacity(0.7),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.1,
                    ),
                  ),
                ),
                Container(
                  width: 0.8.w,
                  color: AppColor.receiptDivider,
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: Text(
                    value,
                    style: TextStyle(
                      color: AppColor.subTitleColor,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.1,
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
