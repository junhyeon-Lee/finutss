import 'package:finutss/new%20ui/modules/app_setting/widget/custom_setting_row.dart';
import 'package:finutss/new%20ui/modules/subcription/presentation/passed_by_users_bottom_sheet.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/widget/cancel_save_button.dart';
import 'package:finutss/new%20ui/widget/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class UnSubscribeHistoryScreen extends StatelessWidget {
  UnSubscribeHistoryScreen({Key? key}) : super(key: key);

  final List<Color> colorList = [
    AppColor.green,
    AppColor.purple,
    AppColor.blue,
    AppColor.pink,
    AppColor.green,
    AppColor.purple,
    AppColor.blue,
    AppColor.pink,
  ];

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
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 18.h,
                      ),
                      Container(
                        height: 136.h,
                        padding:
                            EdgeInsets.only(left: 18.w, right: 12.w, top: 19.h),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomRight,
                              stops: [
                                0.1,
                                0.3,
                                0.7,
                                0.9
                              ],
                              colors: [
                                AppColor.unSubscribegradiant1,
                                AppColor.unSubscribegradiant2,
                                AppColor.unSubscribegradiant2,
                                AppColor.unSubscribegradiant3
                              ]),
                          borderRadius: BorderRadius.circular(10.w),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Flexible(
                                    child: Text(
                                      'DO_YOU_WANT_TO_STOP_WORKOUT_FOR_A_WHILE'
                                          .tr
                                          .toUpperCase(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13.8.sp,
                                        color: AppColor.whiteColor,
                                        letterSpacing: 0.2,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 11.h,
                                  ),
                                  Flexible(
                                    child: Text(
                                      'SOMTIMES_YOU_NEED_TO_TAKE_YOUR_TIME'.tr,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp,
                                        color: AppColor.whiteColor,
                                        letterSpacing: 0.1,
                                        height: 1.4,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Image.asset(
                              IconAssets.unsubscribeCardImage,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        child: Text(
                          "WHO_WORKOUT_HISTORY".tr.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                            letterSpacing: 0.4,
                            color: AppColor.subTitleColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      CustomVIew.yourWorkoutHistoryCard(),
                      SizedBox(
                        height: 13.h,
                      ),
                      CustomVIew.passedRecentlyCard(colorList, () {
                        PassByUsersBottomSheet(
                          context,
                          "controller.BlackList[index].image",
                          "controller.BlackList[index].name",
                          AppColor.red,
                        );
                      }),
                      SizedBox(
                        height: 13.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(11.w),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.cardGradiant1.withOpacity(0.06),
                              spreadRadius: 7,
                              blurRadius: 15,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 22.w,
                          vertical: 18.h,
                        ),
                        child: Column(
                          children: [
                            Text(
                              'WOULD_YOU_LIKE_TO_CANCEL_THE_AUTOMATIC_PAYMENT'
                                  .tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColor.subTitleColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 15.sp,
                                height: 1.7,
                              ),
                            ),
                            SizedBox(
                              height: 31.h,
                            ),
                            CancelSaveButton(
                              height: 36.h,
                              cancelTitle: 'DO_LATER'.tr.toUpperCase(),
                              saveTitle: 'NEXT'.tr.toUpperCase(),
                              onTapCancel: (){
                                Navigation.pop();
                              },
                              onTapSave: () {
                                Navigation.pushNamed(
                                    Routes.unSubscribeReasonScreen);
                              },
                            ),
                          ],
                        ),
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
}
