import 'package:finutss/new%20ui/modules/app_setting/controller/app_setting_controller.dart';
import 'package:finutss/new%20ui/modules/app_setting/controller/withdrawal_controller.dart';
import 'package:finutss/new%20ui/modules/app_setting/widget/custom_setting_row.dart';
import 'package:finutss/new%20ui/modules/subcription/presentation/passed_by_users_bottom_sheet.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/widget/cancel_save_button.dart';
import 'package:finutss/new%20ui/widget/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WithdrawalScreen extends StatelessWidget {
  WithdrawalScreen({Key? key}) : super(key: key);

  WithdrawalController controller = Get.put(WithdrawalController());
  AppSettingController settingController = Get.find();

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
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 18.h,
                      ),
                      SizedBox(
                        height: 150.h,
                        child: Stack(
                          children: [
                            Container(
                              height: 135.h,
                              padding: EdgeInsets.only(left: 18.w, right: 18.w),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                    colors: [AppColor.withdrawGradiant2, AppColor.withdrawGradiant1]),
                                borderRadius: BorderRadius.circular(10.w),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'ILL_TRY_HARDER'.tr,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14.sp,
                                            color: AppColor.whiteColor,
                                            letterSpacing: 0.2,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 12.h,
                                        ),
                                        Text(
                                          'WE_APOLOGIZE_FOR_THE_INCONVENIENCE_IN_USING_THE_SERVICE'.tr,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11.sp,
                                            color: AppColor.whiteColor,
                                            letterSpacing: 0.1,
                                            height: 1.7,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              top: 10.h,
                              left: 22.w,
                              child: Image.asset(
                                ImageAssets.withdrawCardImage,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        child: Obx(
                          () {
                            return Text(
                              "WHO_WORKOUT_HISTORY".tr.replaceAll('%d', controller.userName.value),
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp,
                                letterSpacing: 0.4,
                                color: AppColor.subTitleColor,
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      Obx(
                        () => CustomVIew.yourWorkoutHistoryCard(
                          hours: Constants.formatHHMMSS(controller.userModel.value.data?.totalTimeInMin ?? 0),
                          km: (double.parse(controller.userModel.value.data?.totalDistanceInKm.toString() ?? "0.0").toStringAsFixed(2)),
                          kcal: (controller.workoutModel.value.data?.totalBurntCaloriesCount ?? 0).toString(),
                        ),
                      ),
                      SizedBox(
                        height: 13.h,
                      ),
                      CustomVIew.passedRecentlyCard(controller.colorList, () {
                        PassByUsersBottomSheet(
                          context,
                          "controller.BlackList[index].image",
                          "controller.BlackList[index].name",
                          AppColor.red,
                        );
                      }),
                      SizedBox(
                        height: 14.h,
                      ),
                      warningView(),
                      SizedBox(
                        height: 44.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.w),
                        child: CancelSaveButton(
                          cancelTitle: 'DO_LATER'.tr.toUpperCase(),
                          saveTitle: 'NEXT'.tr.toUpperCase(),
                          onTapCancel: () {
                            Navigation.pop();
                          },
                          onTapSave: () {
                            if (controller.isFamiliar.value) {
                              controller.selectedIndex.value = (-1);
                              Navigation.pushNamed(Routes.withdrawalReasonScreen);
                            }
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

  Widget warningView() {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(11.w),
        boxShadow: [
          BoxShadow(
            color: AppColor.cardGradiant1.withOpacity(0.06),
            spreadRadius: 7,
            blurRadius: 15,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
        vertical: 16.h,
      ),
      child: Column(
        children: [
          Text(
            'WOULD_YOU_LIKE_TO_CANCEL_THE_AUTOMATIC_PAYMENT'.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.subTitleColor,
              fontWeight: FontWeight.w600,
              fontSize: 15.sp,
              height: 1.7,
            ),
          ),
          SizedBox(
            height: 28.h,
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColor.calibrationCardColor,
              borderRadius: BorderRadius.circular(8.w),
            ),
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
            child: Column(
              children: [
                SizedBox(
                  height: 6.h,
                ),
                Image.asset(
                  IconAssets.warningRoundIcon,
                  width: 87.w,
                ),
                SizedBox(
                  height: 11.h,
                ),
                Text(
                  'WARNING'.tr.toUpperCase(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                    color: AppColor.warningTextColor,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                text(
                  "WITHDRAWAL_WARNING_INFO".tr,
                ),
                SizedBox(
                  height: 14.h,
                ),
                GestureDetector(
                  onTap: () {
                    controller.isFamiliar.value = !controller.isFamiliar.value;
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => Image.asset(
                            controller.isFamiliar.value ? IconAssets.checkBoxSelect : IconAssets.checkBoxUnSelect,
                            width: 22.w,
                          )),
                      SizedBox(
                        width: 8.w,
                      ),
                      Expanded(
                        child: Text(
                          "I_AM_FAMILIAR_WITH_ALL_THE_DETAILS_OF_WITHDRAWAL_FROM_THE_MEMBERSHIP_AND_APPLY_FOR_WITHDRAWAL_FROM_THE_MEMBERSHIP".tr,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            color: AppColor.subTitleColor.withOpacity(0.7),
                            fontFamily: 'MontserratItalic',
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget text(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Text(
        title,
        style: TextStyle(
          color: AppColor.subTitleColor.withOpacity(0.7),
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.1,
          height: 1.7,
        ),
      ),
    );
  }
}
