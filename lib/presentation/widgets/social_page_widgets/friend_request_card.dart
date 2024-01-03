import 'package:finutss/data/models/users_model.dart';
import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/domain/controller/find_friends_controller.dart';
import 'package:finutss/domain/controller/follow_controller.dart';
import 'package:finutss/domain/controller/recommand_controller.dart';
import 'package:finutss/domain/controller/social_controller.dart';
import 'package:finutss/presentation/screens/social_pages/other_user_profile_page.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/map_page_widgets/user_circle_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget friendRequestCard(
    {String userName = 'Farhan',
    String text = 'Moomin, long time no see. How have you been?',
    String imagePath = 'assets/images/user5.png',
    isMapPage = false,
    isBottomSheet = false,
    isBlackList = false,
    isDeclareBlock = false,
    context,
    isRecordScreen = false,
    backgroundColor = colorBackgroundSilver,
    User? userInfo}) {
  final authController = Get.put(AuthController());
  final followController = Get.put(FollowController());
  final recommandController = Get.put(RecommandController());
  final findFriendsController = Get.put(FindFriendsController());
  if (userInfo != null) {
    imagePath = (userInfo.image?.url != null
        ? userInfo.image?.url
        : AuthController.userProfileDefaultPath)!;
    userName = userInfo.username;
    text = (userInfo.biography != null ? userInfo.biography : "")!;
    print("imagePath $imagePath");
  }
  return Padding(
    padding: EdgeInsets.only(bottom: 8.0.h, left: 0, right: 0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color(0xFFF5F7FA),
      ),
      // width: 310,
      // height: 90,
      child: InkWell(
        onTap: () {
          Get.to(() => OtherUserProfilePage(), arguments: userInfo);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              userAvatar(
                  imagePath: imagePath,
                  borderColor: colorPink,
                  height: 60,
                  width: 60,
                  userInfo: userInfo),
              size10,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        // socialPageButton(color: Color(0xFF41465C), text: "83", height: 18, width: 45),
                        // size10,
                        customText(
                          text: userName,
                          fontSize: 12,
                          fontColor: Color(0xFF7F8391),
                        ),
                      ],
                    ),
                    size5,
                    Container(
                      child: customText(
                        maxLines: 3,
                        text: text,
                        fontColor: Color(0xFF303443),
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              size10,
              InkWell(
                onTap: () async {
                  await SocialController.callFollow(
                      authController.user?.userId, userInfo?.userId);

                  findFriendsController.init();
                  findFriendsController.callPaginateApi(
                      findFriendsController.searchText.text.trim());

                  await authController.callApiMyUserInfo();
                  await followController
                      .callFollowPaginate(authController.user?.userId);
                  await recommandController.callPaginateApi();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Color(0xFF3BCCE1),
                  ),
                  height: 42.h,
                  width: 42.w,
                  child: Icon(
                    Icons.person_add_alt,
                    color: Color(0xFFFFFFFF),
                    size: 23.r,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

textInfoBox(String top, String bottom, Color color) {
  return Column(
    children: [
      customText(
        text: top,
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
