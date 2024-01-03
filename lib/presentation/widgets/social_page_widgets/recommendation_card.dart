import 'package:finutss/constants.dart';
import 'package:finutss/data/data_service/lib_helper.dart';
import 'package:finutss/data/models/users_model.dart';
import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/domain/controller/follow_controller.dart';
import 'package:finutss/domain/controller/recommand_controller.dart';
import 'package:finutss/domain/controller/social_controller.dart';
import 'package:finutss/presentation/screens/social_pages/other_user_profile_page.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/map_page_widgets/user_circle_avatar.dart';
import 'package:finutss/presentation/widgets/user_notic_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget recommendationCard(
    {borderColor = Colors.black,
    double height = 204,
    double width = 155,
    rank = '102',
    userName = 'Emma',
    memo = '',
    imagePath = 'assets/images/user_image.png',
    User? userInfo}) {
  if (userInfo != null) {
    userName = userInfo.username;
    memo = userInfo.biography != null ? userInfo.biography : "";
    imagePath = userInfo.image?.url != null ? userInfo.image?.url : "assets/images/finutss_default_profile.png";
  }
  final authController = Get.put(AuthController());
  final followController = Get.put(FollowController());
  final recommandController = Get.put(RecommandController());
  return InkWell(
    onTap: () async {
      var guest = await LocalDB.getInt("userAsGuest");
      guest == null ? Get.dialog(UserNoticeDialog()) : Get.to(() => OtherUserProfilePage(), arguments: userInfo);
    },
    child: Container(
      height: height.h,
      width: width.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r), color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(clipBehavior: Clip.none,
              //alignment: Alignment.center,
              children: [
                userAvatar(imagePath: imagePath, borderColor: colorPink, height: 60, width: 60, userInfo: userInfo),

                ///#75
                /*   Positioned(
                    bottom: -5.h,
                    right: 0,
                    left: 0,
                    child: Container(
                      height: 18.h,
                      width: 45.w,
                      decoration: BoxDecoration(
                        color: Color(0xff41465C),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          rank,
                          style: TextStyle(color: Colors.white, fontSize: 8.sp, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ))*/
              ]),
          size10,
          customText(text: userName, fontColor: Color(0xff7F8391), fontSize: 14, fontWeight: FontWeight.w500),
          customText(text: memo, fontColor: Color(0xff7F8391), fontSize: 10, fontWeight: FontWeight.normal),
          size10,
          customButton(
              onTapFunction: () {
                TabFollowBtn(userInfo, authController, followController, recommandController);
              },
              width: 107,
              height: 34,
              text: "FOLLOW".tr,
              textSize: 10,
              fontWeight: FontWeight.bold),
        ],
      ),
    ),
  );
}

Future<void> TabFollowBtn(User? userInfo, AuthController authController, FollowController followController,
    RecommandController recommandController) async {
  await SocialController.callFollow(authController.user?.userId, userInfo?.userId);
  await authController.callApiMyUserInfo();
  followController.init();
  await followController.callFollowPaginate(authController.user?.userId);

  recommandController.init();
  await recommandController.callPaginateApi();
}
