import 'package:finutss/constants.dart';
import 'package:finutss/data/data_service/lib_helper.dart';
import 'package:finutss/data/models/users_model.dart';
import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/presentation/screens/social_pages/other_user_profile_page.dart';
import 'package:finutss/presentation/widgets/map_page_widgets/user_circle_avatar.dart';
import 'package:finutss/presentation/widgets/user_notic_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget userCard(
    {borderColor = Colors.black,
    double height = 65,
    double width = 65,
    rank = '102',
    required context,
    userName = 'Emma',
    imagePath = 'assets/images/finutss_default_profile.png',
    User? userInfo}) {
  if (userInfo != null) {
    userName = userInfo.username;
    imagePath = userInfo.image?.url != null ? userInfo.image?.url : AuthController.userProfileDefaultPath;
  }
  return InkWell(
    onTap: () async {
      var guest = await LocalDB.getInt("userAsGuest");
      guest == null ? Get.to(UserNoticeDialog()) : Get.to(() => OtherUserProfilePage(), arguments: userInfo);
    },
    child: Container(
      height: 105.h,
      width: 105.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(clipBehavior: Clip.none, children: [
            userAvatar(imagePath: imagePath, borderColor: colorPink, height: 60, width: 60, userInfo: userInfo),

            ///#75
            /*Positioned(
                bottom: -5.h,
                right: 10.r,
                left: 10.r,
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
          size5,
          Text(
            userName,
            style: TextStyle(color: Color(0xff303443), fontSize: 12.sp, fontWeight: FontWeight.w500),
          )
        ],
      ),
    ),
  );
}
