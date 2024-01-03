import 'package:finutss/new%20ui/modules/invite_friends/report_block_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/live%20user/controller/live_user_controller.dart';
import 'package:finutss/new%20ui/modules/user_profile/controller/controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/custom_circle_imageview.dart';
import 'package:finutss/presentation/presentation/animation/bouncing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../presentation/widgets/common_widgets/divider.dart';


class FollowBottomSheet extends StatefulWidget {
  FollowBottomSheet({Key? key,required this.userId,required this.index}) : super(key: key);
  String userId;
  int index;

  @override
  State<FollowBottomSheet> createState() => _FollowBottomSheetState();
}

class _FollowBottomSheetState extends State<FollowBottomSheet> {
  final userProfileController controller = Get.put(userProfileController());
  final LiveUserController liveUserController = Get.find();

  @override
  void initState() {
    super.initState();
    Constants.screenCloseCount=2;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Map<String, dynamic> body = {"id": widget.userId};
      controller.getUserById(body: body);
    });
  }

  @override
  void dispose() {
    super.dispose();
    Constants.screenCloseCount=1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.black.withOpacity(0.7),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                children: [
                  Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColor.whiteColor,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.h),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: AppColor.whiteColor[100],
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            margin: EdgeInsets.only(bottom: 1.4),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigation.pop();
                                    Navigation.pop();
                                    Constants.isOpenScreen=true;
                                    reportBlockBottomSheet(context,
                                        userId: controller.userArray.value.id).then((value) {
                                      Constants.isOpenScreen=false;
                                    });
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      
                                     Obx(() =>  CustomCircleImageview(
                                       width: 55.w,
                                       imagePath: controller.userArray.value.profilePhoto ?? '',
                                     )),
                                     
                                      SizedBox(width: 12.w),
                                      Expanded(
                                        child: Obx(() => Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              controller.userArray.value
                                                  .username ??
                                                  '',
                                              style: TextStyle(
                                                  color: AppColor
                                                      .subTitleColor,
                                                  fontSize: 13.sp,
                                                  fontWeight:
                                                  FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 6.h,
                                            ),
                                            Text(
                                              controller.userArray.value
                                                  .description ??
                                                  '',
                                              overflow:
                                              TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                color: AppColor
                                                    .subTitleColor
                                                    .withOpacity(0.8),
                                                fontSize: 11.sp,
                                              ),
                                            ),
                                          ],
                                        )),
                                      ),
                                      SvgPicture.asset(
                                        IconAssets.sirenIcon,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 13.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 5.h,
                            horizontal: 15.w,
                          ),
                          child: Obx(() => Row(
                            children: [
                              followRow(
                                IconAssets.follower,
                                (controller.userArray.value
                                    .followersCount ??
                                    0)
                                    .toString(),
                                "FOLLOWER".tr,
                              ),
                              Spacer(),
                              followRow(
                                IconAssets.following,
                                (controller.userArray.value
                                    .followingCount ??
                                    0)
                                    .toString(),
                                "FOLLOWING".tr,
                              ),
                            ],
                          )),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),

                        SizedBox(
                          height: 12.h,
                        ),

                       Obx(() => Column(
                         children: [
                           if(controller.userArray.value.historyDisclosure.toString().toLowerCase()=='all')...[
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceAround,
                               children: [
                                 kmRow(
                                   IconAssets.location,
                                   (controller.userArray.value
                                       .totalDistanceInKm ??
                                       0)
                                       .toString(),
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
                                   (controller.userArray.value
                                       .avgSpeedInKmPerHour ??
                                       0)
                                       .toString(),
                                   "KMH".tr,
                                 ),
                               ],
                             )
                           ]else if(controller.userArray.value.historyDisclosure.toString().toLowerCase()=='friends' && (controller.userArray.value.isFollowing ?? false))...[
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceAround,
                               children: [
                                 kmRow(
                                   IconAssets.location,
                                   (controller.userArray.value
                                       .totalDistanceInKm ??
                                       0)
                                       .toString(),
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
                                   (controller.userArray.value
                                       .avgSpeedInKmPerHour ??
                                       0)
                                       .toString(),
                                   "KMH".tr,
                                 ),
                               ],
                             )
                           ]else...[
                             SizedBox(
                               height: 56.h,
                               width: double.infinity,
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   SvgPicture.asset(IconAssets.lockIcon),

                                   SizedBox(width: 15.w,),

                                   Text(
                                     "THIS_MEMBERS_INFORMATION_IS_PRIVATE".tr,
                                     style: TextStyle(
                                       fontWeight: FontWeight.w500,
                                       fontSize: 11.sp,
                                       color: AppColor.subTitleColor,
                                     ),
                                   )
                                 ],
                               ),
                             )
                           ],
                         ],
                       )),
                        SizedBox(
                          height: 36.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.w),
                          child: Bouncing(
                            duration: Duration(milliseconds: 100),
                            onPressed: () {
                              if (controller.userArray.value.isFollowing ?? false) {
                                liveUserController.unFollow(
                                    userId: controller.userArray.value.id ??
                                        '',index: widget.index,type: Constants.isFollowDialog);
                              } else {

                                liveUserController.follow(
                                    userId: controller.userArray.value.id ??
                                        '',index: widget.index,type: Constants.isFollowDialog);
                              }
                            },
                            child: Obx(() {
                              return Container(
                                height: 40.h,
                                decoration: BoxDecoration(
                                  color: (controller.userArray.value.isFollowing ?? false)
                                      ? AppColor.whiteColor
                                      : AppColor.orangeColor,
                                  borderRadius: BorderRadius.circular(10.w),
                                  boxShadow: [
                                    BoxShadow(
                                      color: (controller.userArray.value.isFollowing ?? false)
                                          ? AppColor.whiteColor
                                          : AppColor.orangeColor
                                          .withOpacity(0.30),
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
                                    color: (controller.userArray.value.isFollowing ?? false)
                                        ? AppColor.cancelButtonBg
                                        : AppColor.orangeColor,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    (controller.userArray.value.isFollowing ?? false)
                                        ? "UNFOLLOW".tr.toUpperCase()
                                        : "FOLLOW".tr.toUpperCase(),
                                    style: TextStyle(
                                      color: (controller.userArray.value.isFollowing ?? false)
                                          ? AppColor.cancelButtonColor
                                          : AppColor.whiteColor,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.4,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: AppColor.orangeColor,
                        child: Image.asset(
                          IconAssets.close,
                          scale: 4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



Widget followRow(String? imagePath, String? followerCount, String? title) {
  return Row(
    children: [
      Image.asset(
        imagePath ?? IconAssets.follower,
        height: 35.h,
      ),
      SizedBox(
        width: 10.w,
      ),
      Column(
        children: [
          Text(
            followerCount ?? "0",
            style: TextStyle(
              color: AppColor.blueTextColor,
              fontSize: 19.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            title ?? "",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 10.sp,
              color: AppColor.blueTextColor.withOpacity(
                0.5,
              ),
            ),
          )
        ],
      ),
    ],
  );
}

Widget kmRow(String? ImagePath, String? km, String? kmString) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
        ),
        child: Image.asset(
          ImagePath ?? " ",
          height: 19.h,
        ),
      ),
      SizedBox(
        height: 7.h,
      ),
      Row(
        children: [
          Text(
            km ?? "",
            style: TextStyle(
              color: AppColor.blueTextColor,
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            width: 5.w,
          ),
          Text(
            kmString ?? "",
            style: TextStyle(
              color: AppColor.blueTextColor.withOpacity(0.6),
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ],
  );
}
