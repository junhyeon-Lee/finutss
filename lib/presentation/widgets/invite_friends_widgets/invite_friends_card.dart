import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/domain/controller/invite_friends_controller.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/map_page_widgets/user_circle_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget inviteFriendsCard(f2f) {
  // ignore: unused_local_variable
  final InviteFriendsController inviteFriendsController = Get.put(InviteFriendsController());
  final authController = Get.put(AuthController());

  var user = f2f['users'].firstWhere((user) => user['id'] != authController.user?.userId);
  String userName = user['nickName'];
  String text = user['memo'] != null ? user['memo'] : "";
  String imagePath = user["image"] != null ? user['image']['url'] : AuthController.userProfileDefaultPath;
  bool isInvited = f2f["isInvite"];
  Color backgroundColor = colorBackgroundSilver;
  return Padding(
    padding: EdgeInsets.only(bottom: 14.h),
    child: Container(
      height: 100.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: backgroundColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 15.h),
        child: Row(
          children: [
            userAvatar(imagePath: imagePath, borderColor: colorPink, userInfo: user),
            size10,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          // Container(
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(12.r),
                          //     color: colorLightGrey,
                          //   ),
                          //   height: 18.h,
                          //   width: 45.w,
                          //   child: Center(
                          //     child: customText(
                          //       text: '83',
                          //       fontColor: colorBackgroundSilver,
                          //       fontSize: 10,
                          //       fontWeight: FontWeight.bold,
                          //     ),
                          //   ),
                          // ),
                          // size10,
                          customText(
                            text: userName,
                            fontColor: colorWhitish,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),

                      // Spacer(),
                    ],
                  ),
                  size10,
                  /* --------------------------------- message -------------------------------- */
                  customText(
                    text: text,
                    fontSize: 12,
                    height: 1,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w600,
                    fontColor: colorDarkGrey,
                  ),
                ],
              ),
            ),
            /* ------------------------------ invite button ----------------------------- */
            isInvited
                ? customButton(
                    onTapFunction: () {},
                    text: 'SENT',
                    height: 20,
                    color: Colors.white,
                    textColor: colorLightSilver,
                    fontWeight: FontWeight.bold)
                : customButton(
                    onTapFunction: () {
                      inviteFriendsController.onInvitedPressed(user['id']);
                    },
                    text: 'INVITE',
                    height: 20,
                    fontWeight: FontWeight.bold)
          ],
        ),
      ),
    ),
  );
}
