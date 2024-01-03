import 'package:finutss/helper/toast_helper.dart';
import 'package:finutss/new%20ui/modules/app_setting/controller/withdrawal_controller.dart';
import 'package:finutss/new%20ui/modules/app_setting/widget/custom_setting_row.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/cancel_save_button.dart';
import 'package:finutss/new%20ui/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WithdrawalReasonScreen extends StatelessWidget {
  WithdrawalReasonScreen({Key? key}) : super(key: key);

  final WithdrawalController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backGroundColor,
        body: Column(
          children: [
            CustomSettingRow(
              title: 'WITHDRAWAL'.tr.toUpperCase(),
              horizontalPadding: 22.w,
              fontsize: 18.sp,
              fontWeight: FontWeight.w700,
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
                          ],
                        ),
                      ),
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
                              spreadRadius: 1.4,
                              blurRadius: 14,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 18.h, horizontal: 14.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                () => CustomTextField(
                                  obscureText: controller.isShowPassword.value,
                                  title: 'PASSWORD'.tr,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      controller.isShowPassword.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: AppColor.iconColorBg,
                                    ),
                                    onPressed: () {
                                      controller.isShowPassword.value =
                                          !controller.isShowPassword.value;
                                    },
                                  ),
                                  controller: controller.passwordController,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'LAST_ACCEPTED_TEXT'.tr,
                                      style: TextStyle(
                                        color: AppColor.subTitleColor
                                            .withOpacity(0.9),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15.sp,
                                        letterSpacing: 0.1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      'LEAVE_THE_FINUTSS_SERVICE_ENTER_THE_APPROVE_TEXT_AND_PRESS_THE_OK_BUTTON'.tr,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: AppColor.titleColor,
                                          fontSize: 14.sp),),
                                  /*  RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "Enter the text ",
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0.1,
                                              height: 1.6,
                                              color: AppColor.subTitleColor
                                                  .withOpacity(0.8),
                                            ),
                                          ),
                                          TextSpan(
                                            text: "‘Approve’",
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0.1,
                                              height: 1.6,
                                              color: AppColor.subTitleColor
                                                  .withOpacity(0.8),
                                            ),
                                          ),
                                          TextSpan(
                                            text: " and press the ",
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0.1,
                                              height: 1.6,
                                              color: AppColor.subTitleColor
                                                  .withOpacity(0.8),
                                            ),
                                          ),
                                          TextSpan(
                                            text: "Enter",
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0.1,
                                              height: 1.6,
                                              color: AppColor.subTitleColor
                                                  .withOpacity(0.8),
                                            ),
                                          ),
                                          TextSpan(
                                            text: " Button",
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0.1,
                                              height: 1.6,
                                              color: AppColor.subTitleColor
                                                  .withOpacity(0.8),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),*/
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColor.textFieldColor,
                                  borderRadius: BorderRadius.circular(8.w),
                                ),
                                padding: EdgeInsets.all(4.w),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 14.w,
                                    ),
                                    Expanded(
                                      child: TextField(
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.alreadyTextColor),
                                        onChanged: (val) {
                                          if (val.toLowerCase() == 'approve') {
                                            controller.enableEnterBtn.value =
                                                true;
                                          } else {
                                            controller.enableEnterBtn.value =
                                                false;
                                          }
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Approve',
                                          hintStyle: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.alreadyTextColor
                                                  .withOpacity(0.5)),
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.zero,
                                          isDense: true,
                                          isCollapsed: true,
                                        ),
                                      ),
                                    ),
                                    Obx(() => Container(
                                          decoration: BoxDecoration(
                                            color:
                                                controller.enableEnterBtn.value
                                                    ? AppColor.orangeColor
                                                    : AppColor.lightorangeColor,
                                            borderRadius:
                                                BorderRadius.circular(8.w),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.w, vertical: 7.h),
                                          child: Text(
                                            'OK'.tr,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16.sp,
                                              letterSpacing: 0.4,
                                              color: AppColor.whiteColor,
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 36.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.w),
                        child: CancelSaveButton(
                          cancelTitle: 'DO_LATER'.tr.toUpperCase(),
                          saveTitle: 'WITHDRAWAL'.tr.toUpperCase(),
                          saveFontSize: 14.sp,
                          onTapCancel: (){
                            Navigation.pop();
                          },
                          onTapSave: () {
                            if(controller.selectedIndex==-1){
                              AppToast.showSnackBar(title: '', message: 'PLEASE_SELECT_A_REASON_FOR_WITHDRAWAL'.tr);
                            }else if(!controller.enableEnterBtn.value){
                              AppToast.showSnackBar(title: '', message: "PLEASE_TYPE_APPROVE_AFTER_YOU_CAN_WITHDRAWAL".tr);
                            }/*else if(controller.passwordController.text.isEmpty){
                              AppToast.showSnackBar(title: 'PASSWORD'.tr, message: 'PLEASE_ENTER_YOUR_PASSWORD'.tr);
                            }*/else{
                              controller.getWithdrawal();
                            }
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
