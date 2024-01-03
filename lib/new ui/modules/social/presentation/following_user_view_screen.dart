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


class FollowingUserViewScreen extends StatefulWidget {
  FollowingUserViewScreen({Key? key,this.isCurrentUser,required this.userId}) : super(key: key);

  bool? isCurrentUser;
  String userId;

  @override
  State<FollowingUserViewScreen> createState() => _FollowingUserViewScreenState();
}

class _FollowingUserViewScreenState extends State<FollowingUserViewScreen> {
  final HomeScreenController controller = Get.find();
  final SocialController socialController = Get.find();
  late FollowingFollowersController followingController;

  @override
  void initState() {
    super.initState();
    followingController=Get.put(FollowingFollowersController(),tag: widget.userId);
    WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            followingController.clear();
            followingController.userId=widget.userId;
            followingController.getFollowing(widget.userId);
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
                      padding: EdgeInsets.only(top: 14.h,bottom: 10.h),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'FOLLOWING'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColor.subTitleColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Obx(() => Expanded(
                      child: followingController.isFirstLoadingFollowing.value
                          ? CustomVIew.shimmerUserListView()
                          : Obx(() => ListView.builder(
                        shrinkWrap: true,
                        controller: followingController.scrollControllerFollowing,
                        itemCount: followingController.followingList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              if (controller.userId != (followingController.followingList[index].followed?.id ?? '')) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserProfileScreen(
                                          userId: followingController.followingList[index].followed?.id ?? '',type: Constants.isFollowingScreen,index: index,specificUserId: widget.userId,
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
                                            followingController.followingList[index].followed?.profilePhoto ?? '',
                                          ),
                                          SizedBox(width: 16.w),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  followingController.followingList[index].followed?.username ?? '',
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
                                                  followingController.followingList[index].followed?.description ?? '',
                                                  overflow: TextOverflow
                                                      .ellipsis,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                      FontWeight
                                                          .w500,
                                                      color: AppColor
                                                          .subTitleColor
                                                          .withOpacity(
                                                          0.8),
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
                                    if((widget.isCurrentUser ?? false))...[
                                      GestureDetector(
                                        onTap: () {
                                          followingController.unFollow(
                                              userId: followingController.followingList[index].followed?.id ?? '',
                                              index: index,
                                              screenCode: Constants.isCurrentUser);
                                        },
                                        child: SizedBox(
                                          height: 55.w,
                                          width: 28.w,
                                          child: Center(
                                            child: SvgPicture.asset(
                                              IconAssets.addUserRightGray,
                                              width: 17.w,
                                            ),
                                          ),
                                        ),
                                      )
                                    ]else if(controller.userId==followingController.followingList[index].followed?.id)...[
                                      SizedBox()
                                    ]else...[
                                      if(followingController.userId==followingController.followingList[index].followed?.id)...[
                                        SizedBox()
                                      ]else...[
                                        GestureDetector(
                                          onTap: () {
                                            bool isFollow=followingController.followingList[index].isFollowing ?? false;
                                            if(isFollow){
                                              followingController.unFollow(userId: followingController.followingList[index].followed?.id ?? '',index: index,screenCode: Constants.isFollowingScreen);
                                            }else{
                                              followingController.follow(userId: followingController.followingList[index].followed?.id ?? '',index: index,screenCode: Constants.isFollowingScreen);
                                            }
                                          },
                                          child: SizedBox(
                                            height: 26.w,
                                            width: 26.w,
                                            child: Center(
                                              child: SvgPicture.asset(
                                                (followingController.followingList[index].isFollowing ?? false) ? IconAssets.addUserRightGray : IconAssets.addUser,
                                                width: 17.w,
                                              ),
                                            ),
                                          ),
                                        )
                                      ]
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )),
                    )),

                    Obx(() => followingController.isLoadingUser.value && !followingController.isFirstLoadingFollowing.value
                        ? Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 10.h),
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

