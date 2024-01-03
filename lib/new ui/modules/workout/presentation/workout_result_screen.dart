import 'package:finutss/new%20ui/modules/app_setting/widget/custom_setting_row.dart';
import 'package:finutss/new%20ui/modules/home/controller/home_screen_controller.dart';
import 'package:finutss/new%20ui/modules/live%20user/controller/live_user_controller.dart';
import 'package:finutss/new%20ui/modules/live%20user/presentation/live_user_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/photo_video/controller/photo_video_controller.dart';
import 'package:finutss/new%20ui/modules/photo_video/presentation/photo_video_list_screen.dart';
import 'package:finutss/new%20ui/modules/track/controller/track_detail_controller.dart';
import 'package:finutss/new%20ui/modules/track/presentation/posts_screen.dart';
import 'package:finutss/new%20ui/modules/workout/controller/workout_result_controller.dart';
import 'package:finutss/new%20ui/modules/workout/precautions_bottomsheet.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/cache_network_image.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/widget/comment_user_view.dart';
import 'package:finutss/new%20ui/widget/custom_circle_imageview.dart';
import 'package:finutss/new%20ui/widget/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class WorkoutResultScreen extends StatefulWidget {
  WorkoutResultScreen({Key? key, required this.recordId, required this.trackId}) : super(key: key);

  final String recordId;
  final String trackId;

  @override
  State<WorkoutResultScreen> createState() => _WorkoutResultScreenState();
}

class _WorkoutResultScreenState extends State<WorkoutResultScreen> {
  final WorkoutResultController controller = Get.put(WorkoutResultController());
  late TrackDetailController trackController;
  final PhotoVideoController photoController = Get.put(PhotoVideoController());
  final LiveUserController liveUserController = Get.put(LiveUserController());
  final HomeScreenController homeController = Get.find();

  @override
  void initState() {
    super.initState();
    trackController = Get.put(TrackDetailController(),tag:widget.trackId);
    WidgetsBinding.instance.addPostFrameCallback((_) {

      if(widget.recordId.isNotEmpty){
        controller.getWorkoutRecord(widget.recordId);
      }
      controller.getWorkoutRecord(widget.recordId);
      trackController.getTrackDetail(widget.trackId).then((value) {
        liveUserController.getLiveUser(widget.trackId);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColor.backGroundColor,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.backGroundColor,
          body: Column(
            children: [
              CustomSettingRow(
                title: "RESULT".tr.toUpperCase(),
                horizontalPadding: 20.w,
                child: GestureDetector(
                  onTap: () {
                    Navigation.pushNamed(Routes.historyScreen);
                  },
                  child: SvgPicture.asset(
                    IconAssets.calendar,
                    width: 21.h,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 6.w,
                                ),
                                Text(
                                  "DAILY_TRACK".tr.toUpperCase(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.sp,
                                    color: AppColor.blueTextColor,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      6.w,
                                    ),
                                    border: Border.all(
                                      width: 1,
                                      color: AppColor.greenSliderBg,
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 19.w,
                                    vertical: 4.h,
                                  ),
                                  child: Center(
                                    child: Obx(() => Text(
                                          (controller.WorkoutRecord.value.type ?? Constants.ride) == Constants.ride
                                              ? 'WORKOUT_TYPE_RIDE'.tr
                                              : "WORKOUT_TYPE_RUN".tr,
                                          style: TextStyle(
                                            color: AppColor.greenSliderBg,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.4,
                                            fontSize: 12.sp,
                                          ),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: AppColor.whiteColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColor.cardGradiant1.withOpacity(0.06),
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 14.h),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppColor.calibrationCardColor,
                                        borderRadius: BorderRadius.circular(6.w),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 6.h),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            IconAssets.locationTime,
                                            height: 22.h,
                                          ),
                                          SizedBox(
                                            width: 12.h,
                                          ),
                                          Obx(() => Text(
                                                controller.WorkoutRecord.value.track?.name ?? '',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: AppColor.blueTextColor,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    CacheNetworkImageView(
                                      height: 96.h,
                                      imageUrl: Constants.currentTrackImage,
                                      imageTag: false,
                                      loader: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Obx(() => Row(
                                          children: [
                                            kmMinCustomView(
                                              IconAssets.location,
                                              (controller.WorkoutRecord.value.distanceInKm ?? 0).toString(),
                                              "KM".tr,
                                            ),
                                            divider(),
                                            kmMinCustomView(
                                              IconAssets.km,
                                              (controller.WorkoutRecord.value.exerciseTimeInMin ?? 0).toString(),
                                              "MIN".tr,
                                            ),
                                            divider(),
                                            kmMinCustomView(
                                              IconAssets.kcalIcon,
                                              (controller.WorkoutRecord.value.burnedCal ?? 0).toString(),
                                              "KCAL".tr,
                                            ),
                                          ],
                                        )),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: AppColor.whiteColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColor.cardGradiant1.withOpacity(0.06),
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 17.0.w,
                                  vertical: 18.h,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "POSTS".tr.toUpperCase(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.sp,
                                            color: AppColor.blueTextColor,
                                          ),
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              PageRouteBuilder(
                                                opaque: false,
                                                pageBuilder: (BuildContext context, _, __) => PostsScreen(
                                                    pinpointId: trackController.trackDetailModel.value.data?.pinPoints?.pinPointArray![0].id,
                                                    index: 0,
                                                    photosList: trackController.photosList,
                                                    trackDetailController: trackController,
                                                    type: Constants.trackDetailScreen,
                                                    trackId: widget.trackId),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            "VIEW".tr,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.sp,
                                              color: AppColor.orangeColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 25.h,
                                    ),
                                    Row(
                                      children: [
                                        Obx(() => card(
                                            title: trackController.pinSize.value,
                                            Image: IconAssets.gallery,
                                            onTap: () {
                                              photoController.setPhotos(trackController.photosList);
                                              Get.to(PhotoVideoListScreen(
                                                isApiCall: false,
                                                isOpenThroughWorkoutScreen: true,
                                                trackDetailController: trackController,
                                                trackId: widget.trackId,
                                              ));
                                              // Navigation.pushNamed(Routes.photoVideoListScreen,isApiCall: false,);
                                            })),
                                        SizedBox(
                                          width: 14.w,
                                        ),
                                        Obx(() => card(
                                              onTap: () {
                                                homeController.getTrackDetail(
                                                    id: widget.trackId ?? '', type: Constants.dailyTrackScreen, index: 0, controller: homeController);
                                              },
                                              title: (trackController.trackDetailModel.value.data?.comments?.count ?? 0).toString(),
                                              Image: IconAssets.chatIc,
                                            )),
                                        SizedBox(
                                          width: 14.w,
                                        ),
                                        Obx(
                                          () => card(
                                              onTap: () {
                                                if (trackController.trackDetailModel.value.data?.isTrackLiked ?? false) {
                                                  trackController.likeUnlike(
                                                      status: Constants.unlike, trackID: widget.trackId, screenCode: Constants.trackDetailScreen);
                                                } else {
                                                  trackController.likeUnlike(
                                                      status: Constants.like, trackID: widget.trackId, screenCode: Constants.trackDetailScreen);
                                                }
                                              },
                                              title: (trackController.trackDetailModel.value.data?.reactions?.count ?? 0).toString(),
                                              Image: (trackController.trackDetailModel.value.data?.isTrackLiked ?? false)
                                                  ? IconAssets.redHeart
                                                  : IconAssets.heart,
                                              iconColor: AppColor.pinkSlider),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 18.h,
                                    ),
                                    Obx(() => (trackController.trackDetailModel.value.data?.comments?.count ?? 0) > 1
                                        ? CommentUserView(
                                            onTap: () {
                                              // int index = v.photosList.indexWhere((item) =>
                                              // item.url == (pinpointModel.image ?? '') || item.url == (pinpointModel.video ?? ''));
                                              Navigator.of(context).push(
                                                PageRouteBuilder(
                                                  opaque: false,
                                                  pageBuilder: (BuildContext context, _, __) => PostsScreen(
                                                      pinpointId: trackController.trackDetailModel.value.data?.comments?.commentArray?[0].pinPointId,
                                                      index: 0,
                                                      photosList: trackController.photosList,
                                                      trackDetailController: trackController,
                                                      type: Constants.trackDetailScreen,
                                                      trackId: widget.trackId),
                                                ),
                                              );
                                            },
                                            commentId: trackController.trackDetailModel.value.data?.comments?.commentArray?[0].id ?? '',
                                            id: trackController.trackDetailModel.value.data?.comments?.commentArray?[0].user?.id ?? '',
                                            currentUserId: homeController.userId,
                                            profileImage:
                                                trackController.trackDetailModel.value.data?.comments?.commentArray?[0].user?.profilePhoto ?? '',
                                            userName: trackController.trackDetailModel.value.data?.comments?.commentArray?[0].user?.username ?? '',
                                            description: trackController.trackDetailModel.value.data?.comments?.commentArray?[0].text ?? '',
                                            date: trackController.trackDetailModel.value.data?.comments?.commentArray?[0].createdAt,
                                            commentCount: '',
                                            isRepliesComment: true,
                                            bgColor: AppColor.commentCardBg,
                                            isLiked: false,
                                          )
                                        : Row(
                                            children: [
                                              SizedBox(
                                                width: 6.w,
                                              ),
                                              Image.asset(
                                                IconAssets.chatPlus,
                                                width: 25.w,
                                              ),
                                              SizedBox(
                                                width: 16.w,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  "THERE_ARE_NO_COMMENTS_YET".tr,
                                                  maxLines: 4,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 11.sp,
                                                    height: 1.5,
                                                    color: AppColor.blueTextColor.withOpacity(
                                                      0.7,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ))
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: AppColor.whiteColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColor.cardGradiant1.withOpacity(0.06),
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 17.h,
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 6.w,
                                          ),
                                          Text(
                                            "ACTIVE_USER".tr.toUpperCase(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.sp,
                                              color: AppColor.blueTextColor,
                                            ),
                                          ),
                                          Obx(() => Text(
                                                " (" + liveUserController.liveUserList.length.toString() + ")",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 11.sp,
                                                  color: AppColor.blueTextColor.withOpacity(0.5),
                                                ),
                                              )),
                                          Spacer(),
                                          InkWell(
                                            onTap: () {
                                              liveUserBottomSheet(context, title: 'ACTIVE_USER', isSearchEnable: true);
                                            },
                                            child: Image.asset(
                                              IconAssets.search,
                                              width: 18.w,
                                              color: AppColor.orangeColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        liveUserBottomSheet(context, title: 'ACTIVE_USER');
                                        /*   liveUserBottomSheet(
                                          context,
                                          title: "ACTIVE_USER".tr,
                                        );*/
                                      },
                                      child: SizedBox(
                                        height: 40.h,
                                        child: Obx(() {
                                          int lastData = liveUserController.liveUserList.length - 8;
                                          int length = liveUserController.liveUserList.length > 9 ? 9 : liveUserController.liveUserList.length;
                                          return Stack(
                                            children: [
                                              for (var i = 0; i < length; i++)
                                                Positioned(
                                                  left: (i * (1 - .2) * 41).toDouble(),
                                                  top: 0,
                                                  child: CircleAvatar(
                                                    backgroundColor: Colors.green,
                                                    child: CircleAvatar(
                                                      radius: 18,
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(20),
                                                        child: i == 8
                                                            ? Text(
                                                                "+${lastData.toString()}",
                                                              )
                                                            : CustomCircleImageview(
                                                                borderSize: 0,
                                                                imagePath: liveUserController.liveUserList[i].user?.profilePhoto ?? '',
                                                              ),
                                                      ),
                                                    ),
                                                    radius: 19,
                                                  ),
                                                ),
                                            ],
                                          );
                                        }),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 10.h,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RoundButton(
                                    width: 50.w,
                                    iconPath: IconAssets.share,
                                    iconColor: AppColor.blue,
                                    showShadow: true,
                                    onTap: () async {
                                      await Share.share('https://finutss.page.link/App');
                                    },
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  RoundButton(
                                    width: 50.w,
                                    iconPath: IconAssets.refresh,
                                    iconColor: AppColor.greenSliderBg,
                                    showShadow: true,
                                    onTap: () {
                                      precautionsBottomSheet(context, trackId: widget.trackId, trackDetailController: trackController);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget card({String? Image, String? title, VoidCallback? onTap, Color? iconColor}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.whiteColor[200],
            borderRadius: BorderRadius.circular(
              4,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: 7.h,
            ),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.whiteColor[200],
                  ),
                  child: SvgPicture.asset(
                    Image ?? IconAssets.gallery,
                    color: iconColor ?? AppColor.orangeColor,
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Text(
                  title ?? "20",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColor.blueTextColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget divider() {
    return Container(
      width: 1.w,
      height: 26.h,
      color: AppColor.dividerColorKm,
    );
  }

  Widget kmMinCustomView(String iconPath, String title, String subtitle) {
    return Expanded(
      child: Center(
        child: Column(
          children: [
            Image.asset(
              iconPath,
              height: 22.w,
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
      ),
    );
  }
}
