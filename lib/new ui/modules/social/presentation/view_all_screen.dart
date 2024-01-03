import 'package:finutss/new%20ui/modules/app_setting/widget/custom_setting_row.dart';
import 'package:finutss/new%20ui/modules/social/controller/social_controller.dart';
import 'package:finutss/new%20ui/modules/user_profile/presentation/user_profile_screen.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/widget/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../user_profile/controller/controller.dart';

class ViewAllScreen extends StatelessWidget {
  ViewAllScreen({Key? key, this.title, required this.isHotPeople})
      : super(key: key);

  final SocialController controller = Get.find();
  final userProfileController userController = Get.put(userProfileController());
  final String? title;
  final bool isHotPeople;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backGroundColor,
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            CustomSettingRow(
              title: title?.tr,
              horizontalPadding: 22.w,
              fontWeight: FontWeight.w700,
              fontsize: 18.sp,
            ),
            SizedBox(
              height: 5.h,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: isHotPeople
                    ? hotPeopleView()
                    : recommendedView(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget hotPeopleView() {
    return Obx(
      () => ListView.separated(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.only(bottom: 20.h),
        itemBuilder: (context, i) {
          return CustomVIew.userItemView(
            onTap: () {
              Get.to(UserProfileScreen(userId: controller.hotUserList[i].id,index: i,type: Constants.hotPeople),  transition: Routes.defaultTransition);
            },
            username: controller.hotUserList[i].username,
            des: controller.hotUserList[i].description,
            profilePhoto: controller.hotUserList[i].profilePhoto,
            onTapUser: () {
              controller.hotFollowApi(
                  i, controller.hotUserList[i].id.toString());
              /* if (controller.hotUserList[i].isFollowing ?? false) {
                controller.hotUserList[i].isFollowing = false;
                controller.unFollow(
                    userId: controller.hotUserList[i].id.toString(), index: i);
              } else {
                controller.hotUserList[i].isFollowing = true;
                controller.hotFollowApi(
                    i, controller.hotUserList[i].id.toString());
              }*/
            },
          );
        },
        separatorBuilder: (context, i) {
          return SizedBox(
            height: 10.h,
          );
        },
        itemCount: controller.hotUserList.length,
      ),
    );
  }

  Widget recommendedView() {
    return Obx(
      () => ListView.separated(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.only(bottom: 20.h),
        itemBuilder: (context, i) {
          return CustomVIew.userItemView(
            isFollowing: controller.recommendedUsers[i].isFollowing ?? false,
            onTap: () {
              Get.to(
                UserProfileScreen(
                  userId: controller.recommendedUsers[i].id,
                  index: i,
                  type: Constants.recommendedUser,
                ),
                  transition: Routes.defaultTransition
              );
            },
            onTapUser: () {
              controller.FollowApi(
                  i, controller.recommendedUsers[i].id.toString());
              /* if (controller.recommendedUsers[i].isFollowing ?? false) {
                controller.recommendedUsers[i].isFollowing = false;
                controller.unFollow(
                    userId: controller.recommendedUsers[i].id.toString(),
                    index: i);
              } else {
                controller.recommendedUsers[i].isFollowing = true;
                controller.FollowApi(
                    i, controller.recommendedUsers[i].id.toString());
              }*/
            },
            username: controller.recommendedUsers[i].username,
            des: controller.recommendedUsers[i].description,
            profilePhoto: controller.recommendedUsers[i].profilePhoto,
          );
        },
        separatorBuilder: (context, i) {
          return SizedBox(
            height: 10.h,
          );
        },
        itemCount: controller.recommendedUsers.length,
      ),
    );
  }
}
