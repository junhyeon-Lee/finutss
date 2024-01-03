import 'package:cached_network_image/cached_network_image.dart';
import 'package:finutss/new%20ui/modules/app_setting/widget/custom_setting_row.dart';
import 'package:finutss/new%20ui/modules/invite_friends/report_block_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/live%20user/presentation/follow_user_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/profile/presentation/fullScreen_image.dart';
import 'package:finutss/new%20ui/modules/social/controller/social_controller.dart';
import 'package:finutss/new%20ui/modules/social/presentation/follower_user_view_screen.dart';
import 'package:finutss/new%20ui/modules/social/presentation/following_user_view_screen.dart';
import 'package:finutss/new%20ui/modules/user_profile/controller/controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/widget/custom_circle_imageview.dart';
import 'package:finutss/new%20ui/widget/shimmer/shimmer_from_colors.dart';
import 'package:finutss/presentation/presentation/animation/bouncing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UserProfileScreen extends StatefulWidget {
  UserProfileScreen({Key? key, this.isCurrentUser, required this.userId, this.index,this.type,this.specificUserId}) : super(key: key);

  final String? userId;
  final bool? isCurrentUser;
  final int? index;
  final int? type;
  final String? specificUserId;

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final userProfileController controller = Get.find();
  final SocialController socialController = Get.find();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Map<String, dynamic> body = {"id": widget.userId ?? ''};
      controller.isShowRecord.value = false;
      controller.todayRecordTempData.value = [];
      controller.getUserById(body: body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColor.backGroundColor,
      ),
      child: SafeArea(
        child: Container(
          color: AppColor.backGroundColor,
          child: Column(
            children: [

              CustomSettingRow(
                title: 'USER_PROFILE'.tr,
                horizontalPadding: 22.w,
                fontsize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(
                height: 5.h,
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                    ),
                    child: Column(
                      children: [
                        profileCard(context),
                        SizedBox(
                          height: 14.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget profileCard(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(
              14.w,
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.07),
                blurRadius: 20.0,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 17.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 11.h, horizontal: 10.w),
                  decoration: BoxDecoration(color: AppColor.backGroundColor, borderRadius: BorderRadius.circular(8.w)),
                  child: Obx(() => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 4.w,
                          ),
                          InkWell(
                            onTap: (){
                              if(controller.userArray.value.profilePhoto!=null){
                                 Get.to(FullScreenImage(url:controller.userArray.value.profilePhoto, type: Constants.typePhoto,));
                              }
                            },
                            child: SizedBox(
                              height: 54.w,
                              width: 54.w,
                              child: CustomCircleImageview(
                                width: 54.w,
                                imagePath: controller.userArray.value.profilePhoto ?? '',
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 14.w,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.userArray.value.username ?? '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                    color: AppColor.blueTextColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                Text(
                                  controller.userArray.value.description ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11.sp,
                                    color: AppColor.blueTextColor.withOpacity(0.8),
                                  ),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              reportBlockBottomSheet(context, userId: controller.userArray.value.id);
                            },
                            child: SizedBox(
                              width: 28.w,
                              height: 28.w,
                              child: Align(
                                alignment: Alignment.topRight,
                                child: SvgPicture.asset(
                                  IconAssets.sirenIcon,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5.h,
                  ),
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            if (controller.userArray.value.followersCount != 0) {
                              Navigator.of(Get.context!).push(
                                PageRouteBuilder(
                                  opaque: false,
                                  pageBuilder:
                                      (BuildContext context, _,
                                      __) =>
                                      FollowerUserViewScreen(userID: controller.userArray.value.id ?? '',),
                                ),
                              );
                            }
                          },
                          child: followRow(
                            IconAssets.follower,
                            Constants.numberCounter((controller.userArray.value.followersCount ?? 0).toString()),
                            "FOLLOWER".tr,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (controller.userArray.value.followingCount != 0) {
                              //socialController.getFollowersDetails(controller.userArray.value.id);

                              Navigator.of(Get.context!).push(
                                PageRouteBuilder(
                                  opaque: false,
                                  pageBuilder:
                                      (BuildContext context, _,
                                      __) =>
                                          FollowingUserViewScreen(userId: controller.userArray.value.id ?? '',),
                                ),
                              );
                            }
                          },
                          child: followRow(
                            IconAssets.following,
                            Constants.numberCounter((controller.userArray.value.followingCount ?? 0).toString()),
                            "FOLLOWING".tr,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 14.h,
                ),

                Obx(() => controller.isShowRecord.value
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    kmRow(
                      IconAssets.location,
                      (controller.userArray.value.totalDistanceInKm ?? 0).toString(),
                      "KM".tr,
                    ),
                    divider(),
                    kmRow(
                      IconAssets.time,
                      (controller.userArray.value.totalTimeInMin ?? 0).toString(),
                      "MIN".tr,
                    ),
                    divider(),
                    kmRow(
                      IconAssets.km,
                      (controller.userArray.value.avgSpeedInKmPerHour ?? 0).toString(),
                      "KMH".tr,
                    ),
                  ],
                )
                    : SizedBox(
                  height: 56.h,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(IconAssets.lockIcon),
                      SizedBox(
                        width: 15.w,
                      ),
                      Text(
                        'THIS_MEMBERS_INFORMATION_IS_PRIVATE'.tr,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 11.sp,
                          color: AppColor.subTitleColor,
                        ),
                      )
                    ],
                  ),
                )),
                SizedBox(
                  child: Obx(
                    () {
                      bool isFollowing = controller.userArray.value.isFollowing ?? false;
                      return Padding(
                        padding: EdgeInsets.only(left: 28.w, right: 28.w, top: 18.h, bottom: 3.h),
                        child: Bouncing(
                          duration: Duration(milliseconds: 100),
                          onPressed: () {
                            if (isFollowing) {
                              controller.unFollowApi(userId: controller.userArray.value.id ?? '',index: widget.index,type: widget.type, specificUserId: widget.specificUserId);
                            } else {
                              controller.FollowApi(
                                  userId: controller.userArray.value.id ?? '',
                                  type: widget.type,
                                  index: widget.index,
                                specificUserId: widget.specificUserId
                              );
                            }
                          },
                          child: Container(
                            height: 38.h,
                            decoration: BoxDecoration(
                              color: isFollowing ? AppColor.whiteColor : AppColor.orangeColor,
                              borderRadius: BorderRadius.circular(10.w),
                              boxShadow: [
                                BoxShadow(
                                  color: isFollowing ? AppColor.whiteColor : AppColor.orangeColor.withOpacity(0.30),
                                  blurRadius: 10.0,
                                  // soften the shadow
                                  spreadRadius: 0.2,
                                  //extend the shadow
                                  offset: Offset(
                                    0,
                                    9.0,
                                  ),
                                )
                              ],
                              border: Border.all(
                                width: 1.2,
                                color: isFollowing ? AppColor.cancelButtonBg : AppColor.orangeColor,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                isFollowing ? "UNFOLLOW".tr.toUpperCase() : "FOLLOW".tr.toUpperCase(),
                                style: TextStyle(
                                  color: isFollowing ? AppColor.cancelButtonColor : AppColor.whiteColor,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.4,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        recentActivity(),
      ],
    );
  }

  Widget divider() {
    return Container(
      height: 30.h,
      width: 1.w,
      color: AppColor.dividerColor,
    );
  }

  Widget kmMinCustomView(String iconPath, String title, String subtitle) {
    return Expanded(
      child: Column(
        children: [
          Image.asset(
            iconPath,
            height: 20.w,
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                  letterSpacing: 0.2,
                  color: AppColor.subTitleColor,
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 11.sp,
                  letterSpacing: 0.2,
                  color: AppColor.subTitleColor.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget appBar() {
    return Row(
      children: [
        Icon(
          Icons.arrow_back,
          color: AppColor.backIconColor,
        ),
        SizedBox(
          width: 80.w,
        ),
        Text(
          "USER_PROFILE".tr,
          style: TextStyle(
            color: AppColor.blueTextColor,
            fontWeight: FontWeight.w700,
            fontSize: 18.sp,
          ),
        ),
      ],
    );
  }

  Widget recentActivity() {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 22.h,
            ),
            !controller.isLoadingRecentActivity.value && controller.todayRecordTempData.length < 1
                ? SizedBox()
                : Text(
                    'RECENT_ACTIVITIES'.tr,
                    style: TextStyle(
                      color: AppColor.subTitleColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                      letterSpacing: 0.4,
                    ),
                  ),
            SizedBox(
              height: 12.h,
            ),

            Obx(() => controller.isShowRecord.value ?  recentActivityData() : privateView()),
            SizedBox(
              height: 10.h,
            ),
          ],
        ));
  }

  Widget recentActivityData() {
    return Obx(() {
      return controller.isLoadingRecentActivity.value
          ? shimmerRecentActivity()
          : controller.todayRecordTempData.length < 1
              ? SizedBox()
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.circular(10.w),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.06),
                        blurRadius: 18.0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Results',
                              style: TextStyle(
                                color: AppColor.subTitleColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 14.sp,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          Text(
                            Constants.convertToAgo(controller.todayRecordTempData[0].createdAt ?? ''),
                            style: TextStyle(
                              color: AppColor.subTitleColor.withOpacity(0.6),
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.2,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.calibrationCardColor,
                          borderRadius: BorderRadius.circular(6.w),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                        child: Row(
                          children: [
                            Image.asset(
                              IconAssets.locationTime,
                              height: 26.h,
                            ),
                            SizedBox(
                              width: 15.h,
                            ),
                            Expanded(
                              child: Text(
                                (controller.todayRecordTempData[0].track?.name ?? '').toString(),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: AppColor.blueTextColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 120.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.w),
                          child: Obx(() => CachedNetworkImage(
                            imageUrl: controller.trackImage.value,
                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                            errorWidget: (context, url, error) => Center(child: Icon(Icons.error,color: AppColor.gray,)),
                            fit: BoxFit.cover,
                          )),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          kmRow(
                            IconAssets.location,
                            (controller.todayRecordTempData[0].distanceInKm ?? '').toString(),
                            "KM".tr,
                          ),
                          divider(),
                          kmRow(
                            IconAssets.time,
                            (controller.todayRecordTempData[0].exerciseTimeInMin ?? 0).toString(),
                            "MIN".tr,
                          ),
                          divider(),
                          kmRow(
                            IconAssets.kcal,
                            (controller.todayRecordTempData[0].burnedCal ?? 0).toString(),
                            "KCAL".tr,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                    ],
                  ),
                );
    });
  }

  Widget privateView() {
    return Container(
      height: 260.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(10.w),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.06),
            blurRadius: 18.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(IconAssets.privateEyeIcon),
          SizedBox(
            height: 14.h,
          ),
          Text(
            "THIS_MEMBERS_INFORMATION_IS_PRIVATE".tr,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColor.subDescriptionTextColor,
            ),
          )
        ],
      ),
    );
  }

  Widget shimmerRecentActivity() {
    return CustomShimmer(
        child: Container(
      width: double.infinity,
      color: AppColor.whiteColor,
      height: 260.h,
    ));
  }
}
