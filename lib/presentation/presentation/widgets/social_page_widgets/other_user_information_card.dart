import 'package:community_material_icon/community_material_icon.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/data/models/users_model.dart';
import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/domain/controller/follow_controller.dart';
import 'package:finutss/domain/controller/other_user_profile_controller.dart';
import 'package:finutss/domain/controller/recommand_controller.dart';
import 'package:finutss/domain/controller/social_controller.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/divider.dart';
import 'package:finutss/presentation/widgets/dialogs/social_dialogs/declare_block_dialog.dart';
import 'package:finutss/presentation/widgets/map_page_widgets/user_circle_avatar.dart';
import 'package:finutss/presentation/widgets/social_page_widgets/info_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget otherUserProfileInformationCard(User? userInfo, OtherUserProfileController otherUserProfileController) {
  final authController = Get.put(AuthController());
  final followController = Get.put(FollowController());
  final recommandController = Get.put(RecommandController());
  return GetBuilder<SocialController>(builder: (_socialController) {
    ///TODO
    var isViewInfo = otherUserProfileController.infoDisclosure == "All" ||
        (otherUserProfileController.infoDisclosure == "Friends" && _socialController.isFollowed == true);

    return GetBuilder<OtherUserProfileController>(builder: (otherUserProfileController) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 16.h, top: 16.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: Color(0xFFFFFFFF),
              ),
              width: 343.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.r),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Color(0xFFF5F7FA),
                      ),
                      // width: 310.w,
                      // height: 90.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          userAvatar(
                              userInfo: otherUserProfileController.userInfo,
                              imagePath: otherUserProfileController.image,
                              borderColor: colorPink,
                              height: 60,
                              width: 60),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  // socialPageButton(color: Color(0xFF41465C), text: "83", height: 18.0, width: 45.0),
                                  // size10,
                                  customText(
                                    text: otherUserProfileController.nickName,
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
                                  text: otherUserProfileController.memo,
                                  fontColor: Color(0xFF303443),
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Get.dialog(DeclareBlockDialog(), arguments: userInfo);
                            },
                            child: Container(
                              // color: Color(0xFF000000),
                              // height: 24.r,
                              // width: 24.r,
                              child: Icon(
                                CommunityMaterialIcons.alarm_light_outline,
                                size: 24.r,
                                color: Color(0xFF7F8391),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    width: 310.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 48.r,
                          width: 48.r,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/followers.png'),
                            ),
                          ),
                        ),
                        textInfoBox(otherUserProfileController.follower, "FOLLOWER".tr, Color(0xFF3BCCE1)),
                        size20,
                        Container(
                          height: 48.r,
                          width: 48.r,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/icons/star_pink.png'),
                            ),
                          ),
                        ),
                        textInfoBox(otherUserProfileController.follow, "FOLLOW".tr, Color(0xFFF73A6B))
                      ],
                    ),
                  ),
                  isViewInfo
                      ? Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 32.h, right: 16.w, left: 16.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  customButton(
                                      height: 26,
                                      width: 90,
                                      radius: 4,
                                      fontWeight: FontWeight.bold,
                                      color: otherUserProfileController.workoutType == "all"
                                          ? colorDarkGrey
                                          : colorLightSilver,
                                      textColor: otherUserProfileController.workoutType == "all"
                                          ? colorLightSilver
                                          : colorDarkGrey,
                                      text: "WORKOUT_TYPE_ALL".tr,
                                      onTapFunction: () {
                                        otherUserProfileController.workoutType = "all";
                                        otherUserProfileController.update();
                                      },
                                      textSize: 10),
                                  customButton(
                                      height: 26,
                                      width: 90,
                                      radius: 4,
                                      fontWeight: FontWeight.bold,
                                      color: otherUserProfileController.workoutType == "riding"
                                          ? colorDarkGrey
                                          : colorLightSilver,
                                      textColor: otherUserProfileController.workoutType == "riding"
                                          ? colorLightSilver
                                          : colorDarkGrey,
                                      text: "WORKOUT_TYPE_RIDE".tr,
                                      onTapFunction: () {
                                        otherUserProfileController.workoutType = "riding";
                                        otherUserProfileController.update();
                                      },
                                      textSize: 10),
                                  customButton(
                                      height: 26,
                                      width: 90,
                                      radius: 4,
                                      fontWeight: FontWeight.bold,
                                      color: otherUserProfileController.workoutType == "running"
                                          ? colorDarkGrey
                                          : colorLightSilver,
                                      textColor: otherUserProfileController.workoutType == "running"
                                          ? colorLightSilver
                                          : colorDarkGrey,
                                      text: "WORKOUT_TYPE_RUN".tr,
                                      onTapFunction: () {
                                        otherUserProfileController.workoutType = "running";
                                        otherUserProfileController.update();
                                      },
                                      textSize: 10),
                                ],
                              ),
                            ),
                            Container(
                              width: 310.w,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    size5,
                                    infoCard(
                                      unitText: 'KM'.tr,
                                      header: "",
                                      footer:
                                          "${((otherUserProfileController.workOutTotal?[otherUserProfileController.workoutType]?["distance"] ?? 0) / 1000).toStringAsFixed(2)}",
                                      image: "destination.png",
                                    ),
                                    divider(),
                                    infoCard(
                                      unitText: 'MIN'.tr,
                                      header: "",
                                      footer:
                                          "${((otherUserProfileController.workOutTotal?[otherUserProfileController.workoutType]?["duration"] ?? 0) / 60).toStringAsFixed(2)} ",
                                      image: "time.png",
                                    ),
                                    divider(),
                                    infoCard(
                                      unitText: 'KCAL'.tr,
                                      header: "",
                                      footer:
                                          "${(otherUserProfileController.workOutTotal?[otherUserProfileController.workoutType]?["kcal"] ?? 0).toStringAsFixed(1)}",
                                      image: "calories.png",
                                    ),
                                    size5,
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      : Column(
                          children: [
                            size10,
                            Icon(
                              Icons.visibility_off,
                              size: 24.r,
                            ),
                            customText(
                              text: "THIS_MEMBER'S_INFORMATION_IS_PRIVATE".tr,
                              fontColor: Color(0xFF7F8391),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            size10
                          ],
                        ),
                  InkWell(
                    onTap: () async {
                      if (_socialController.isFollowed) {
                        await SocialController.callUnfollow(userInfo?.userId);
                      } else {
                        _socialController.socialInfo =
                            await SocialController.callFollow(authController.user?.userId, userInfo?.userId);
                      }
                      await authController.callApiMyUserInfo();
                      await followController.callFollowPaginate(authController.user?.userId);
                      await recommandController.callPaginateApi();

                      _socialController.isFollowed = !_socialController.isFollowed;
                      _socialController.update();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: _socialController.isFollowed == false ? Color(0xFF3BCCE1) : Color(0xFF41465C),
                      ),
                      height: 48.h,
                      width: 312.w,
                      child: Center(
                          child: customText(
                              text: _socialController.isFollowed == false ? "FOLLOW".tr : "UNFOLLOW".tr,
                              fontColor: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  });
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
