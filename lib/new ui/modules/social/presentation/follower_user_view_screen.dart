import 'package:finutss/new%20ui/modules/connection/widget/close_button.dart';
import 'package:finutss/new%20ui/modules/home/controller/home_screen_controller.dart';
import 'package:finutss/new%20ui/modules/social/controller/following_followers_controller.dart';
import 'package:finutss/new%20ui/modules/social/controller/social_controller.dart';
import 'package:finutss/new%20ui/modules/user_profile/presentation/user_profile_screen.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/widget/custom_circle_imageview.dart';
import 'package:finutss/new%20ui/widget/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class FollowerUserViewScreen extends StatefulWidget {
  FollowerUserViewScreen({Key? key, required this.userID}) : super(key: key);
  String userID;

  @override
  State<FollowerUserViewScreen> createState() => _FollowerUserViewScreenState();
}


class _FollowerUserViewScreenState extends State<FollowerUserViewScreen> {
  final HomeScreenController controller = Get.find();
  final SocialController socialController = Get.put(SocialController());
  late FollowingFollowersController followersController;

  @override
  void initState() {
    super.initState();
    followersController=Get.put(FollowingFollowersController(),tag: widget.userID);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        followersController.clear();
        followersController.userId = widget.userID;
        followersController.getFollowers(widget.userID);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.6),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          CloseButtonCustom(
            onTap: () {
              Get.back();
            },
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.elliptical(
                    MediaQuery.of(context).size.width,
                    100.0,
                  ),
                ),
              ),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.h),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 14.0.h, bottom: 10.h),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'FOLLOWER'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColor.subTitleColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Obx(() => followersController.isFirstLoadingFollowers.value
                          ? CustomVIew.shimmerUserListView()
                          : Obx(() => ListView.builder(
                        shrinkWrap: true,
                        controller: followersController.scrollControllerFollowers,
                        itemCount: followersController.followerList.length,
                        itemBuilder: (context, index) {
                          return Obx(() => GestureDetector(
                            onTap: () {
                              if (controller.userId != (followersController.followerList[index].follower?.id ?? '')) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserProfileScreen(
                                          userId: followersController.followerList[index].follower?.id ?? '',index: index,type: Constants.isFollowerScreen,specificUserId: widget.userID,
                                        )));
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 5.h),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9.w),
                                  color: AppColor.whiteColor[100],
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10.7,
                                ),
                                margin: EdgeInsets.only(bottom: 1.4),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          CustomCircleImageview(
                                            width: 55.w,
                                            imagePath:
                                            followersController.followerList[index].follower?.profilePhoto ?? '',
                                          ),
                                          SizedBox(width: 16.w),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  followersController.followerList[index].follower?.username ?? '',
                                                  style: TextStyle(
                                                    color: AppColor.subTitleColor,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 7.h,
                                                ),
                                                Text(
                                                  followersController.followerList[index].follower?.description ?? '',
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight: FontWeight.w500,
                                                      color: AppColor.subTitleColor.withOpacity(0.8),
                                                      height: 1.5),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    if (controller.userId == followersController.followerList[index].follower?.id) ...[
                                      SizedBox()
                                    ] else ...[
                                      GestureDetector(
                                        onTap: () {
                                          if (followersController.followerList[index].isFollowing ?? false) {
                                            followersController.unFollow(
                                                userId: followersController.followerList[index].follower?.id ?? '',
                                                index: index,
                                                screenCode: Constants.isFollowerScreen);
                                          } else {
                                            followersController.follow(
                                                userId: followersController.followerList[index].follower?.id ?? '',
                                                index: index,
                                                screenCode: Constants.isFollowerScreen);
                                          }
                                        },
                                        child: SizedBox(
                                          height: 26.w,
                                          width: 26.w,
                                          child: Center(
                                            child: SvgPicture.asset(
                                              (followersController.followerList[index].isFollowing ?? false)
                                                  ? IconAssets.addUserRightGray
                                                  : IconAssets.addUser,
                                              width: 17.w,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ));
                        },
                      ))),
                    ),
                    Obx(() => followersController.isLoadingUser.value && !followersController.isFirstLoadingFollowers.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : SizedBox())
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
