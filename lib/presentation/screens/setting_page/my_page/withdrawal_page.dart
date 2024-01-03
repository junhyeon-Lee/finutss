import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/domain/controller/social_controller.dart';
import 'package:finutss/domain/controller/withdrawal_controller.dart';
import 'package:finutss/domain/controller/workout_record_controller.dart';
import 'package:finutss/presentation/screens/setting_page/my_page/withdrawal_reason_page.dart';
import 'package:finutss/presentation/widgets/common_widgets/appbars/simple_appbar.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/track_distance_widgets/user_avatar_with_stack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';

class WithdrawalPage extends StatelessWidget {
  final SocialController socialController = Get.put(SocialController());
  final authController = Get.put(AuthController());
  final _workoutRecordController = Get.put(WorkoutRecordController());
  final _withdrawalController = Get.put(WithdrawalController());
  @override
  Widget build(BuildContext context) {
    if (authController.user != null)
      _workoutRecordController.callApiMyRecordTotal(authController.user?.userId);
    return Scaffold(
      appBar: simpleAppBar(text: 'WITHDRAWAL'.tr, automaticallyImplyLeading: true) as PreferredSizeWidget?,
      body: GetBuilder<WorkoutRecordController>(builder: (workoutRecordController) {
        return GetBuilder<WithdrawalController>(builder: (withdrawalController) {
          return Container(
            // height: Get.height,
            // width: Get.width,
            color: Color(0xFFF5F7FA),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  /* -------------------------------------------------------------------------- */
                  /*                              Unsubscribe card                              */
                  /* -------------------------------------------------------------------------- */
                  size20,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: 343 / 150,
                        child: Container(
                            height: 160,
                            width: Get.width,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage("assets/images/withdrawal.png"),
                                ),
                                borderRadius: BorderRadius.circular(15.r),
                                color: Colors.white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 12.h,
                                  ),
                                  child: Container(
                                    width: 180,
                                    child: customText(
                                      text: 'WELL_BE_A_FINUTSS_WHO_TRIES_HARDER'.tr,
                                      fontColor: Color(0xFF303443),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                  ),
                                  child: Container(
                                    height: 34,
                                    width: 180,
                                    child: customText(
                                      text: 'WE_APOLOGIZE_FOR_THE_INCONVENIENCE_IN_USING_THE_SERVICE'.tr,
                                      fontColor: Color(0xFF303443),
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                )
                              ],
                            )),
                      ),
                    ),
                  ),

                  /* -------------------------------------------------------------------------- */
                  /*                            Your workout history                            */
                  /* -------------------------------------------------------------------------- */

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    child: Row(
                      children: [
                        customText(
                          text: ('WHO_WORKOUT_HISTORY'.tr)
                              .replaceAll("%d", authController.user?.username ?? ""),
                          fontColor: Color(0xFF303443),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        )
                      ],
                    ),
                  ),
                  /* -------------------------------------------------------------------------- */
                  /*                                history tiles                               */
                  /* -------------------------------------------------------------------------- */
                  historyTile(
                    first: 'THE_TIME_WITH_FINUTSS'.tr,
                    second: "0",
                    third: 'HOURS'.tr,
                  ),
                  size20,
                  historyTile(
                    first: 'THE_LENGTH_WITH_FINUTSS'.tr,
                    second:  "0",
                    third: 'KM'.tr,
                  ),
                  size20,
                  historyTile(
                    first: 'SWEAT_WITH_FINUTSS'.tr,
                    second: "0",
                    third: 'KCAL'.tr,
                  ),
                  size20,
                  /* -------------------------------------------------------------------------- */
                  /*                                who Passed by                               */
                  /* -------------------------------------------------------------------------- */

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Container(
                      // width: Get.width.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 16.h,
                            ),
                            child: Row(
                              children: [
                                customText(
                                  text: 'WHO_PASSED_BY_RECENTLY'.tr,
                                  fontColor: Color(0xFF303443),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                )
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  // width: Get.width - 20.w,
                                  height: 60.h,
                                  child: Stack(
                                    children: [
                                      for (var i = 1; i <= 6; i++)
                                        if (i != 14)
                                          Positioned(
                                            left: ((Get.width / 1.5) - 50) - i * (((Get.width / 1.5) - 55) / 6),

                                            // right: 0,
                                            // top: 0,
                                            bottom: 10.h,
                                            child: userAvatarWithStack(),
                                          ),
                                      Positioned(
                                        // alignment: Alignment.topRight,
                                        // left: 0,
                                        top: 0.h,
                                        bottom: 11.h,
                                        right: 16.w,
                                        child: Center(
                                          child: CircleAvatar(
                                              radius: 25.r,
                                              backgroundColor: colorBlue,
                                              child: Icon(
                                                CupertinoIcons.search,
                                                color: Colors.white,
                                                size: 22.r,
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  /* -------------------------------------------------------------------------- */
                  /*                          Cancel automatic payment                          */
                  /* -------------------------------------------------------------------------- */
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    child: Container(
                      width: Get.width,
                      child: customText(
                        text: 'WOULD_YOU_LIKE_TO_PROCEED_WITH_THE_WITHDRAWAL_FROM_THE_MEMBERSHIP'.tr,
                        fontColor: Color(0xFF303443),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.h,
                      horizontal: 16.w,
                    ),
                    child: Row(
                      children: [
                        customText(
                          text: 'WARNING'.tr,
                          fontColor: Color(0xFFF73A6B),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.h, left: 16.w, right: 16.w),
                    child: customText(
                      text: 'WITHDRAWAL_WARNING_INFO'.tr,
                      fontSize: 14,
                      fontColor: Color(0xFF7F8391),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.h, left: 16.w, right: 16.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 30.w,
                          height: 30.h,
                          child: Checkbox(
                              value: withdrawalController.isAcceptWithdrawl,
                              onChanged: (isCheck) {
                                withdrawalController.isAcceptWithdrawl = isCheck!;
                                withdrawalController.update();
                              }),
                        ),
                        Expanded(
                          child: Container(
                            // width: 270,
                            child: customText(
                              // textAlign: TextAlign.start,
                              text:
                                  'I_AM_FAMILIAR_WITH_ALL_THE_DETAILS_OF_WITHDRAWAL_FROM_THE_MEMBERSHIP_AND_APPLY_FOR_WITHDRAWAL_FROM_THE_MEMBERSHIP'
                                      .tr,
                              fontSize: 14,
                              fontColor: colorDarkGrey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r), border: Border.all(color: Colors.black)),
                            child: customButton(
                                onTapFunction: () {
                                  Get.back();
                                  // Get.dialog(BlockUser());
                                },
                                radius: 16,
                                height: 48,
                                text: 'LATER'.tr,
                                fontWeight: FontWeight.w700,
                                color: Color(0xffffffff),
                                textColor: Colors.black,
                                textSize: 16),
                          ),
                        ),
                        size15,
                        Expanded(
                          child: customButton(
                              onTapFunction: () {
                                if (withdrawalController.isAcceptWithdrawl) Get.off(() => WithdrawalReasonPage());
                              },
                              radius: 16,
                              height: 48,
                              text: 'NEXT'.tr,
                              fontWeight: FontWeight.w700,
                              textSize: 16,
                              color: withdrawalController.isAcceptWithdrawl ? Color(0xFF3BCCE1) : colorLightSilver),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
      }),
    );
  }

  Widget historyTile({
    first = "",
    second = "",
    third = "",
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        height: 64,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(8.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: customText(text: first, fontColor: Color(0xFF7F8391), fontWeight: FontWeight.w700, fontSize: 14),
              ),
              Row(
                children: [
                  customText(text: second, fontColor: Color(0xFF303443), fontWeight: FontWeight.bold, fontSize: 16),
                  size15,
                  customText(text: third, fontColor: Color(0xFF3BCCE1), fontWeight: FontWeight.w700, fontSize: 12),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
