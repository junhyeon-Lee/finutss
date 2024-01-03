import 'package:finutss/new%20ui/modules/app_setting/controller/withdrawal_screen_controller.dart';
import 'package:finutss/new%20ui/modules/app_setting/widget/custom_setting_row.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/cancel_save_button.dart';
import 'package:finutss/new%20ui/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WithdrawalApproveScreen extends StatelessWidget {
  WithdrawalApproveScreen({Key? key}) : super(key: key);
  final WithdrawalScreenController withdrawalScreenController = Get.find();

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
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: 33.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                      child: Card(
                        elevation: 1,
                        color: AppColor.whiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          height: 360.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 19.h),
                          decoration: BoxDecoration(
                            color: AppColor.whiteColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "PLEASE_SELECT_A_REASON_FOR_UNSUBSCRIBE".tr,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.subTitleColor,
                                ),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Expanded(
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: withdrawalScreenController
                                      .unsubscribeModelList.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.0.w, vertical: 16.h),
                                      child: GestureDetector(
                                        onTap: () {
                                          withdrawalScreenController
                                              .selectedUnsubscribeIndex
                                              .value = index;
                                        },
                                        child: Obx(
                                          () => Row(
                                            children: [
                                              Image.asset(
                                                withdrawalScreenController
                                                            .selectedUnsubscribeIndex
                                                            .value ==
                                                        index
                                                    ? IconAssets.checkBoxSelect
                                                    : IconAssets
                                                        .checkBoxUnSelect,
                                                scale: 3,
                                              ),
                                              SizedBox(
                                                width: 15.w,
                                              ),
                                              Text(withdrawalScreenController
                                                  .unsubscribeModelList[index]
                                                  .tittle)
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                      child: Card(
                        elevation: 1,
                        color: AppColor.whiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 21.h),
                          decoration: BoxDecoration(
                            color: AppColor.whiteColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                title: 'Password',
                                obscureText: true,
                                controller: TextEditingController(),
                              ),
                              SizedBox(
                                height: 17.h,
                              ),
                              Text(
                                "Last Accepted Text",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.subTitleColor),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),

                          Text(
                            'LEAVE_THE_FINUTSS_SERVICE_ENTER_THE_APPROVE_TEXT_AND_PRESS_THE_OK_BUTTON'.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: AppColor.titleColor,
                                fontSize: 14.sp),),
                            /*  RichText(
                                text: TextSpan(
                                  text: 'Enter the text ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.titleColor,
                                      fontSize: 14.sp),
                                  children: [
                                    TextSpan(
                                        text: '‘Approve’ ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.subtitleColor,
                                            fontSize: 13.sp)),
                                    TextSpan(text: 'and press the            '),
                                    TextSpan(
                                        text: ' Enter',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.subtitleColor,
                                            fontSize: 13.sp,
                                            height: 1.8)),
                                    TextSpan(text: ' button'),
                                  ],
                                ),
                              ),*/
                              Obx(
                                () => CustomTextField(
                                  hintText: "APPROVE".tr,
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.sp,
                                    color: AppColor.blueTextColor.withOpacity(
                                      0.5,
                                    ),
                                  ),
                                  maxLength: 7,
                                  onChanged: (_) {
                                    if ("approve" ==
                                        withdrawalScreenController
                                            .approveController.text.toLowerCase()) {
                                      withdrawalScreenController
                                          .initialColor.value = true;
                                    } else {
                                      withdrawalScreenController
                                          .initialColor.value = false;
                                    }
                                  },
                                  controller: withdrawalScreenController
                                      .approveController,
                                  title: "",
                                  suffixIcon: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10.w,
                                          ),
                                        ),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        withdrawalScreenController
                                                .initialColor.value
                                            ? AppColor.orangeColor
                                            : AppColor.lightorangeColor,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigation.pop();
                                    },
                                    child: Text(
                                      'OK'.tr,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16.sp,
                                        letterSpacing: 0.4,
                                        color: AppColor.whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: CancelSaveButton(
                        height: 44.h,
                        cancelTitle: 'DO_LATER'.tr.toUpperCase(),
                        saveTitle: 'WITHDRAWAL'.tr.toUpperCase(),
                        onTapSave: () {
                          // Navigation.pushNamed(Routes.withdrawalApproveScreen);
                        }, onTapCancel: () {  },
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*

Expanded(
child: ListView.builder(
itemCount: controller.CountryList.length,
itemBuilder: (context, index) {
return Obx(
() => InkWell(
onTap: () {
controller.selectedLanguage.value = index;
},
child: Padding(
padding: EdgeInsets.symmetric(
vertical: 3.h,
),
child: Container(
decoration: BoxDecoration(
color: AppColor.whiteColor,
borderRadius: BorderRadius.circular(
6,
),
),
child: Padding(
padding: EdgeInsets.symmetric(
vertical: 13.h,
horizontal: 10.w,
),
child: Row(
children: [
Image.asset(
index == controller.selectedLanguage.value
? IconAssets.checkBoxSelect
    : IconAssets.checkBoxUnSelect,
//IconAssets.checkBoxUnSelect,
width: 21.w,
),
SizedBox(
width: 10.w,
),
Text(
controller.CountryList[index].title,
style: TextStyle(
fontSize: 14.sp,
fontWeight: FontWeight.w500,
color: AppColor.blueTextColor,
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
),*/
