import 'package:finutss/new%20ui/modules/app_setting/controller/withdrawal_controller.dart';
import 'package:finutss/new%20ui/modules/app_setting/widget/custom_setting_row.dart';
import 'package:finutss/new%20ui/modules/app_setting/widget/initialize_data_complete_bottom_sheet.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/cancel_save_button.dart';
import 'package:finutss/new%20ui/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InitializeAppDataScreen extends StatelessWidget {
  const InitializeAppDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WithdrawalController controller = Get.put(WithdrawalController());

    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomSettingRow(
              title: 'INITIALIZE_APP_DATA'.tr,
              fontsize: 18.sp,
              horizontalPadding: 20.w,
              fontWeight: FontWeight.w700,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(10.w),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.cardGradiant1.withOpacity(0.06),
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 14.h,
                            ),
                            dataRow(
                              "INITIALIZE_APP_DATA_INFO".tr,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 12.w),
                              padding: EdgeInsets.symmetric(vertical: 9.h),
                              decoration: BoxDecoration(
                                color: AppColor.calibrationCardColor,
                                borderRadius: BorderRadius.circular(8.w),
                              ),
                              child: Obx(()=>Column(
                                children: [
                                  hourRow(
                                    'CUMULATIVE_TIME'.tr,
                                    Constants.formatHHMMSS(controller.userModel.value.data?.totalTimeInMin ?? 0).toString(),
                                    "HOURS".tr,
                                    true,
                                  ),
                                  hourRow(
                                    'CUMULATIVE_DISTANCE'.tr,
                                    (controller.userModel.value.data?.totalDistanceInKm ?? 0).toString(),
                                    "KM".tr,
                                    true,
                                  ),
                                  hourRow(
                                    'BURN_CALORIES'.tr,
                                    (controller.workoutModel.value.data?.totalBurntCaloriesCount ?? 0).toString(),
                                    "KCAL".tr,
                                    false,
                                  ),
                                ],
                              )),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(10.w),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.cardGradiant1.withOpacity(0.05),
                              spreadRadius: 0.1,
                              blurRadius: 8,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 12.h,
                              ),
                              Obx(
                                () => CustomTextField(
                                  obscureText: controller.isShow.value,
                                  controller: controller.passController,
                                  title: 'CURRENT_PASSWORD'.tr,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      controller.isShow.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: AppColor.iconColorBg,
                                    ),
                                    onPressed: () {
                                      controller.isShow.value =
                                          !controller.isShow.value;
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Text(
                                "INITIALIZATION_CONFIRMATION_TEXT".tr,
                                style: TextStyle(
                                  color:
                                      AppColor.blueTextColor.withOpacity(0.9),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                  letterSpacing: 0.1,
                                ),
                              ),
                              SizedBox(
                                height: 6.h,
                              ),
                              Text(
                                "INITIALIZATION_CONFIRMATION_TEXT_INFO".tr,
                                style: TextStyle(
                                  color:
                                      AppColor.blueTextColor.withOpacity(0.8),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13.sp,
                                  height: 1.6,
                                  letterSpacing: 0.1,
                                ),
                              ),
                              Obx(
                                () => CustomTextField(
                                  hintText: 'ENTER'.tr,
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.sp,
                                    color: AppColor.blueTextColor.withOpacity(
                                      0.5,
                                    ),
                                  ),
                                  maxLength: 6,
                                  onChanged: (_) {
                                    if (controller.initialCodeController.text
                                            .length ==
                                        6) {
                                      controller.initialColor.value = true;
                                    } else {
                                      controller.initialColor.value = false;
                                    }
                                  },
                                  controller: controller.initialCodeController,
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
                                        controller.initialColor.value
                                            ? AppColor.orangeColor
                                            : AppColor.lightorangeColor,
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      'ENTER'.tr,
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
                      SizedBox(
                        height: 40.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                        ),
                        child: CancelSaveButton(
                          saveTitle: "INITIALIZE".tr,
                          cancelTitle: 'DO_LATER'.tr.toUpperCase(),
                          onTapSave: () {
                            InitializeDataCompleteBottomSheet(context);
                          },
                          onTapCancel: () {
                            Navigation.pop();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
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

  Widget hourRow(String? title, String? intValue, String? name, bool divider) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 6.h,
            horizontal: 22.w,
          ),
          child: Row(
            children: [
              Text(
                title ?? "CUMULATIVE_TIME".tr,
                style: TextStyle(
                  color: AppColor.blueTextColor.withOpacity(0.7),
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                  letterSpacing: 0.1,
                ),
              ),
              Spacer(),
              Text(
                intValue ?? "17, 18",
                style: TextStyle(
                  color: AppColor.blueTextColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                  letterSpacing: 0.1,
                ),
              ),
              SizedBox(
                width: 2.w,
              ),
              Text(
                name ?? "hours",
                style: TextStyle(
                  color: AppColor.blueTextColor.withOpacity(0.5),
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                  letterSpacing: 0.1,
                ),
              ),
            ],
          ),
        ),
        divider
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Divider(
                  color: AppColor.dividerColor,
                  thickness: 0.7,
                ),
              )
            : SizedBox(),
      ],
    );
  }

  Widget dataRow(String? subtitle) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
        vertical: 7.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 8.w,
          ),
          Flexible(
            child: Text(
              subtitle ?? "INITIALIZE_APP_DATA_INFO".tr,
              style: TextStyle(
                color: AppColor.subTitleColor.withOpacity(0.8),
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
                height: 1.6,
                letterSpacing: 0.1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
