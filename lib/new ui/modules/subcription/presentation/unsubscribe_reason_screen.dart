import 'package:finutss/new%20ui/modules/app_setting/widget/custom_setting_row.dart';
import 'package:finutss/new%20ui/modules/app_setting/widget/unsubscribe_bottomsheet.dart';
import 'package:finutss/new%20ui/modules/subcription/controller/subscription_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/cancel_save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UnSubscribeReasonScreen extends StatelessWidget {
  UnSubscribeReasonScreen({Key? key}) : super(key: key);
  final SubSubscriptionController controller = Get.find();

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
              fontWeight: FontWeight.w600,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 16.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(12.w),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.cardGradiant1.withOpacity(0.08),
                              spreadRadius: 6,
                              blurRadius: 14,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        padding: EdgeInsets.only(
                            left: 20.w, top: 18.h, right: 10.w, bottom: 5.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "PLEASE_SELECT_A_REASON_FOR_UNSUBSCRIBE".tr,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15.sp,
                                letterSpacing: 0.1,
                                color: AppColor.subTitleColor,
                              ),
                            ),
                            ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.symmetric(vertical: 20.h),
                                itemBuilder: (context, i) {
                                  return Obx(() {
                                    return GestureDetector(
                                      onTap: () {
                                        controller.selectedIndex.value = i;
                                      },
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            controller.selectedIndex.value == i
                                                ? IconAssets.checkBoxSelect
                                                : IconAssets.checkBoxUnSelect,
                                            width: 21.w,
                                          ),
                                          SizedBox(
                                            width: 18.w,
                                          ),
                                          Expanded(
                                            child: Text(
                                              controller.reasonList[i].toString(),
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                                color: AppColor.alreadyTextColor,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  });
                                },
                                separatorBuilder: (context, i) {
                                  return SizedBox(
                                    height: 25.h,
                                  );
                                },
                                itemCount: controller.reasonList.length),
                            SizedBox(
                              height: 4.h,
                            ),
                            Container(
                              height: 60.h,
                              decoration: BoxDecoration(
                                color: AppColor.textFieldColor,
                                borderRadius: BorderRadius.circular(8.w),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 10.h),
                              child: TextField(
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.alreadyTextColor,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'PLEASE_STATE_YOUR_REASON_HERE'.tr,
                                  hintStyle: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.alreadyTextColor,
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                  isDense: true,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 42.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.w),
                        child: CancelSaveButton(
                          cancelTitle: 'DO_LATER'.tr.toUpperCase(),
                          saveTitle:
                              'AUTO_PAYMENT_UNSUBSCRIBE'.tr.toUpperCase(),
                          saveFontSize: 14.sp,
                          onTapCancel: (){
                            Navigation.pop();
                          },
                          onTapSave: () {
                            UnSubscribeBottomSheet(context);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
