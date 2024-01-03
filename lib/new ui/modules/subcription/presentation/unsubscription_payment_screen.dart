import 'package:finutss/new%20ui/modules/app_setting/widget/custom_setting_row.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/widget/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class UnSubscriptionPaymentScreen extends StatelessWidget {
  const UnSubscriptionPaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backGroundColor,
        body: Column(
          children: [
            CustomSettingRow(
              title: 'AUTO_PAYMENT_UNSUBSCRIBE'.tr.toUpperCase(),
              horizontalPadding: 22.w,
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
                      CustomVIew.unSubscriptionPaymentItem(onTapClose: () {
                        Navigation.pushNamed(Routes.unSubscribeHistoryScreen);
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
}
