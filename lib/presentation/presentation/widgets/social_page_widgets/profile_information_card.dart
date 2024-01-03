import 'package:finutss/constants.dart';
import 'package:finutss/data/data_service/lib_helper.dart';
import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/domain/controller/social_controller.dart';
import 'package:finutss/presentation/screens/social_pages/follow_screen.dart';
import 'package:finutss/presentation/screens/social_pages/follower_screen.dart';
import 'package:finutss/presentation/screens/user_record_screens/profile_dialog.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/map_page_widgets/user_circle_avatar.dart';
import 'package:finutss/presentation/widgets/user_notic_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget profileInformationCard(context, AuthController authController) {
  SocialController socialController = Get.put(SocialController());
  print('profileInformationCard');
  var url = AuthController.userProfileDefaultPath;
  if (authController.user != null) {
    url = authController.user?.image?.url != null
        ? authController.user?.image?.url as String
        : AuthController.userProfileDefaultPath;
  }
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Color(0xFFFFFFFF),
      ),
      width: Get.width,
      height: 182.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () async {
              var guest = await LocalDB.getInt("userAsGuest");
              guest == null
                  ? Get.dialog(UserNoticeDialog())
                  : showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return SafeArea(
                            child: Padding(
                          padding: EdgeInsets.only(top: 40.0.h),
                          child: ProfileDialog(),
                        ));
                      });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xFFF5F7FA),
                ),
                width: Get.width,
                height: 90.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    userAvatar(
                        imagePath: url,
                        borderColor: Color(0xFF3BCCE1),
                        height: 60,
                        width: 60,
                        userInfo: authController.user),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            // socialPageButton(color: Color(0xFF41465C), text: "83", height: 18, width: 45),
                            // size10,
                            customText(
                              text: authController.user != null ? authController.user?.username as String : "GUEST",
                              fontSize: 12,
                              fontColor: Color(0xFF7F8391),
                            ),
                          ],
                        ),
                        size5,
                        Container(
                          height: 34.h,
                          width: 176.w,
                          child: customText(
                            text: authController.user != null
                                ? authController.user?.biography != null
                                    ? authController.user?.biography as String
                                    : ""
                                : "",
                            fontColor: Color(0xFF303443),
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      // color: Color(0xFF000000),
                      height: 24.r,
                      width: 24.r,
                      child: Icon(
                        Icons.more_vert,
                        size: 24.r,
                        color: Color(0xFF7F8391),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: 310,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return SafeArea(
                              child: Padding(
                            padding: EdgeInsets.only(top: 40.0.h),
                            child: FollowerScreen(),
                          ));
                        });
                  },
                  child: Row(
                    children: [
                      Obx(
                        () {
                          print(socialController.getFollowerCount.value);
                          return Container(
                            height: 48.r,
                            width: 48.r,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/followers.png'),
                              ),
                            ),
                          );
                        },
                      ),
                      textInfoBox(socialController.getFollowerCount.value, 'FOLLOWER'.tr, Color(0xFF3BCCE1)),
                    ],
                  ),
                ),
                size20,
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return SafeArea(
                              child: Padding(
                            padding: EdgeInsets.only(top: 40.0.h),
                            child: FollowScreen(),
                          ));
                        });
                  },
                  child: Row(
                    children: [
                      Obx(
                        () {
                          print(socialController.getFollowingCount.value);
                          return Container(
                            height: 48.r,
                            width: 48.r,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/icons/star_pink.png'),
                              ),
                            ),
                          );
                        },
                      ),
                      textInfoBox(socialController.getFollowingCount.value, 'FOLLOW'.tr, Color(0xFFF73A6B))
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

textInfoBox(int? top, String bottom, Color color) {
  return Column(
    children: [
      customText(
        text: top != null ? top.toString() : "0",
        fontColor: color,
        fontWeight: FontWeight.w700,
        fontSize: 24,
      ),
      customText(
        text: bottom,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      )
    ],
  );
}
