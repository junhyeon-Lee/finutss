import 'package:finutss/constants.dart';
import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/domain/controller/black_list_controller.dart';
import 'package:finutss/presentation/screens/social_pages/other_user_profile_page.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/heading_widget.dart';
import 'package:finutss/presentation/widgets/map_page_widgets/user_circle_avatar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class UnBlockUserDialog extends StatelessWidget {
  final blockListController = Get.put(BlockListController());
  var userInfo;
  UnBlockUserDialog(userInfo) {
    this.userInfo = userInfo;
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      content: Container(
          height: 390.h,
          child: Stack(
            children: [
              Positioned.fill(
                top: 36.h,
                bottom: 30.h,
                left: 24.w,
                right: 24.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(child: headingWidget(title: 'UNBLOCK'.tr)),
                    // liveUserCard(
                    //     backgroundColor: Colors.white,
                    //     imagePath: unlockUserImage,
                    //     isBottomSheet: true),
                    _userCard(),
                    Center(
                      child: customText(
                          fontSize: 14,
                          textAlign: TextAlign.center,
                          text: 'ARE_YOU_SURE_YOU_WANT_TO_UNBLOCK_THIS_USER'.tr),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: customButton(
                              onTapFunction: () {
                                Get.to(() => OtherUserProfilePage(), arguments: userInfo);
                              },
                              borderColor: colorDarkGrey,
                              radius: 16,
                              height: 48,
                              text: 'VIEW_PROFILE'.tr,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              textColor: colorDarkGrey,
                              textSize: 16),
                        ),
                        size5,
                        Expanded(
                          child: customButton(
                              onTapFunction: () {
                                final blockItem = blockListController.blockList
                                    .firstWhere((item) => userInfo["id"] == item["targetId"]["id"]);
                                blockListController.unlock(blockItem["id"]);

                                Get.back();
                              },
                              radius: 16,
                              height: 48,
                              text: 'UNBLOCK'.tr,
                              fontWeight: FontWeight.bold,
                              color: colorPink,
                              textColor: Colors.white,
                              textSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget _userCard() {
    var imageUrl = userInfo["image"] != null ? userInfo["image"]["url"] : AuthController.userProfileDefaultPath;
    var nickName = userInfo["nickName"];
    var memo = userInfo["memo"];

    return Container(
      height: 95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          userAvatar(userInfo: userInfo),
          size10,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Container(
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(12),
                    //     color: colorLightGrey,
                    //   ),
                    //   height: 20,
                    //   width: 40,
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
                    Expanded(
                      child: customText(
                        text: nickName,
                        fontColor: colorWhitish,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                size10,
                customText(
                  text: memo ?? "",
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
        ],
      ),
    );
  }
}
