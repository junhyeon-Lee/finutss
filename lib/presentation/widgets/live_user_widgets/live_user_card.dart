import 'package:finutss/constants.dart';
import 'package:finutss/data/data_service/lib_helper.dart';
import 'package:finutss/data/models/users_model.dart';
import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/presentation/screens/social_pages/other_user_profile_page.dart';
import 'package:finutss/presentation/screens/user_record_screens/profile_dialog.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/dialogs/settings_dialogs/unblock_user_dialog.dart';
import 'package:finutss/presentation/widgets/dialogs/social_dialogs/declare_block_dialog.dart';
import 'package:finutss/presentation/widgets/live_user_widgets/live_user_profile_bottom_sheet.dart';
import 'package:finutss/presentation/widgets/map_page_widgets/user_circle_avatar.dart';
import 'package:finutss/presentation/widgets/user_notic_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget liveUserCard(
    {String userName = '',
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
  var borderColor = colorBlue;
  if (userInfo != null) {
    imagePath = (userInfo.image?.url != null ? userInfo.image?.url : AuthController.userProfileDefaultPath)!;
    imagePath = AuthController.userProfileDefaultPath;
    borderColor = userInfo.workoutType == "Riding" ? colorBlue : colorPink;
    borderColor = colorPink;
    userName = userInfo.username;
    text = (userInfo.biography != null ? userInfo.biography : "")!;
    text = "";
    print("imagePath $imagePath");
  } else {
    userName = 'GUEST';
  }
  return Padding(
    padding: EdgeInsets.only(bottom: 14.h),
    child: InkWell(
      onTap: isMapPage
          ? () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return SafeArea(
                        child: Padding(
                      padding: EdgeInsets.only(top: 40.0.h),
                      child: liveUserBottomSheet(imagePath: imagePath),
                    ));
                  });
            }
          : isBottomSheet
              ? () {}
              : () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //                     builder: (context) => OtherUserProfilePage()));
                  print("tap");
                  Get.off(() => OtherUserProfilePage(), arguments: userInfo);
                },
      child: Container(
        height: 95.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: backgroundColor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 15.h),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              userAvatar(imagePath: imagePath, borderColor: borderColor, height: 60, width: 60, userInfo: userInfo),
              size10,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        Expanded(
                          child: customText(
                            text: userName,
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
              Padding(
                padding: isBlackList ? EdgeInsets.only(right: 10.w) : EdgeInsets.only(right: 1.w),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: isBlackList
                      ? () {
                          Get.dialog(UnBlockUserDialog(userInfo));
                        }
                      : isRecordScreen
                          ? () async {
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
                                          padding: EdgeInsets.only(top: 25.0.h),
                                          child: ProfileDialog(),
                                        ));
                                      });
                              // Get.dialog(ProfileDialog(
                              // profileImage: imagePath,
                              // ));
                            }
                          : isDeclareBlock
                              ? () {
                                  Get.dialog(DeclareBlockDialog(), arguments: userInfo);
                                }
                              : () {},
                  icon: Icon(
                    Icons.more_vert_outlined,
                    size: 24.r,
                    color: colorWhitish,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
