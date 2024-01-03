import 'package:finutss/constants.dart';
import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/domain/controller/social_controller.dart';
import 'package:finutss/presentation/screens/setting_page/subscription_pages/unsubscribe_reason.dart';
import 'package:finutss/presentation/widgets/common_widgets/appbars/simple_appbar.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/track_distance_widgets/user_avatar_with_stack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UnsubscribeHistory extends StatelessWidget {
  final SocialController socialController = Get.put(SocialController());
  final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(text: 'UNSUBSCRIBE'.tr, automaticallyImplyLeading: true) as PreferredSizeWidget?,
      body: Container(
        // height: Get.height,
        // width: Get.width,
        color: Color(0xFFF5F7FA),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /* -------------------------------------------------------------------------- */
              /*                              Unsubscribe card                              */
              /* -------------------------------------------------------------------------- */
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
                              image: AssetImage("assets/images/unsubscribe.png"),
                            ),
                            borderRadius: BorderRadius.circular(15.r),
                            color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 12.h,
                              ),
                              child: Container(
                                width: 220,
                                height: 48,
                                child: customText(
                                  text: 'DO_YOU_WANT_TO_STOP_WORKOUT_FOR_A_WHILE'.tr,
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
                                height: 34.h,
                                width: 194.w,
                                child: customText(
                                  text: "SOMTIMES_YOU_NEED_TO_TAKE_YOUR_TIME".tr,
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
                      text: "${authController.user?.username} " + "WHO_WORKOUT_HISTORY".tr,
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
              Row(
                children: [
                  Expanded(
                    child: historyTile(
                      first: "THE_TIME_WITH_FINUTSS".tr,
                      second: "1781",
                      third: "Hour",
                    ),
                  ),
                ],
              ),
              size20,
              historyTile(
                first: "THE_LENGTH_WITH_FINUTSS".tr,
                second: "16,029",
                third: "km",
              ),
              size20,
              historyTile(
                first: "SWEAT_WITH_FINUTSS".tr,
                second: "1,017,307",
                third: "kcal",
              ),
              size20,
              /* -------------------------------------------------------------------------- */
              /*                                who Passed by                               */
              /* -------------------------------------------------------------------------- */

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Container(
                  height: 108.h,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.h),
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
                              text: "${authController.user?.username} " + "WHO_WORKOUT_HISTORY".tr,
                              fontColor: Color(0xFF303443),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            )
                          ],
                        ),
                      ),
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Container(
                                // width: Get.width - 20,
                                child: Stack(
                                  children: [
                                    for (var i = 1; i <= 8; i++)
                                      if (i != 14)
                                        Positioned(
                                          left: ((Get.width / 1.5) - 50) - i * (((Get.width / 1.5) - 55) / 8),

                                          // right: 0,
                                          // top: 0,
                                          // bottom: 0,
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
                    textAlign: TextAlign.center,
                    text: "WOULD_YOU_LIKE_TO_CANCEL_THE_AUTOMATIC_PAYMENT".tr,
                    fontColor: Color(0xFF303443),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0.w, right: 8.w),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r), border: Border.all(color: Colors.black)),
                        child: customButton(
                            onTapFunction: () {
                              // Get.back();
                              // Get.dialog(BlockUser());
                            },
                            radius: 16,
                            height: 48,
                            text: 'DO_LATER'.tr,
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
                            // Get.back();
                            Get.to(() => UnsubscribeReason());
                          },
                          radius: 16,
                          height: 48,
                          text: 'NEXT'.tr,
                          fontWeight: FontWeight.w700,
                          textSize: 16,
                          color: Color(0xFF3BCCE1)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
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
        height: 64.h,
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
