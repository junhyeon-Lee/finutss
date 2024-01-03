import 'package:cached_network_image/cached_network_image.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:finutss/new%20ui/controller/login_controller.dart';
import 'package:finutss/new%20ui/modules/app_setting/controller/app_setting_controller.dart';
import 'package:finutss/new%20ui/modules/channel_track/presentation/channel_track_screen.dart';
import 'package:finutss/new%20ui/modules/connection/presentation/connection_connect_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/report_screen/presentation/report_screen.dart';
import 'package:finutss/new%20ui/modules/track/controller/track_detail_controller.dart';
import 'package:finutss/new%20ui/modules/track/presentation/posts_screen.dart';
import 'package:finutss/new%20ui/modules/track/widget/energy_point_dialog.dart';
import 'package:finutss/new%20ui/modules/track/widget/most_popular_card.dart';
import 'package:finutss/new%20ui/modules/track/widget/track_detail_appbar.dart';
import 'package:finutss/new%20ui/modules/workout/precautions_bottomsheet.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/widget/custom_circle_imageview.dart';
import 'package:finutss/new%20ui/widget/custom_slider_button.dart';
import 'package:finutss/new%20ui/widget/custom_view.dart';
import 'package:finutss/new%20ui/widget/mode_select_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class TrackDetailScreen extends StatefulWidget {
  TrackDetailScreen({Key? key, required this.trackId}) : super(key: key);
  String trackId;

  @override
  State<TrackDetailScreen> createState() => _TrackDetailScreenState();
}

class _TrackDetailScreenState extends State<TrackDetailScreen> {
  // final TrackController controller = Get.find();
  late TrackDetailController controller;
  final LoginController loginController = Get.find();
  final AppSettingController settingController = Get.find();

  @override
  void initState() {
    super.initState();

    print('------trackId------>${widget.trackId}');
    controller = Get.put(TrackDetailController(), tag: widget.trackId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getTrackDetail(widget.trackId).then((value) {
        print('getTrackDetail call ${widget.trackId}');
        controller.getRecommendedTrack().then((value) {
          print('getRecommendedTrack call ${widget.trackId}');
          controller.getWorkoutRecord(trackId: widget.trackId);
          print('getWorkoutRecord call ${widget.trackId}');
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: AppColor.bgColor,
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColor.bgColor,
        body: CustomScrollView(
          slivers: <Widget>[
            TrackDetailAppBar(
              trackDetailController: controller,
              extent: 228.h,
              avatar: Container(),
              title: controller.trackDetailModel.value.data?.name ?? '',
            ),
            SliverList(
                delegate: SliverChildListDelegate(
              [
                ClipRRect(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(10.w), topLeft: Radius.circular(10.w)),
                  child: Container(
                    color: AppColor.whiteColor,
                    child: Column(
                      children: [
                        Obx(() => SizedBox(
                              width: double.infinity,
                              height: 158.h,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    top: 0,
                                    child: InkWell(
                                      onTap: () {
                                        if ((controller.trackDetailModel.value.data?.pinPoints?.pinPointArray?.length ?? 0) >= 1) {
                                          Navigator.of(context).push(
                                            PageRouteBuilder(
                                              opaque: false,
                                              pageBuilder: (BuildContext context, _, __) => PostsScreen(
                                                  pinpointId: controller.trackDetailModel.value.data?.pinPoints?.pinPointArray![0].id,
                                                  index: 0,
                                                  photosList: controller.photosList,
                                                  trackDetailController: controller,
                                                  type: Constants.trackDetailScreen,
                                                  trackId: widget.trackId),
                                            ),
                                          );
                                        }
                                      },
                                      child: Container(
                                        height: 110.h,
                                        width: double.infinity,
                                        child: CachedNetworkImage(
                                          imageUrl: controller.trackDetailModel.value.data?.previewImage ?? '',
                                          fit: BoxFit.fill,
                                          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                          errorWidget: (context, url, error) => Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(
                                            ChannelTrackScreen(
                                              channelId: controller.trackDetailModel.value.data?.channelId ?? '',
                                            ),
                                            transition: Routes.defaultTransition);
                                      },
                                      child: SizedBox(
                                        height: 50.h,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 86.w,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  controller.trackDetailModel.value.data?.channel?.name ?? '',
                                                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp, color: AppColor.alreadyTextColor),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  SvgPicture.asset(IconAssets.markerIcon),
                                                  SizedBox(
                                                    width: 6.w,
                                                  ),
                                                  Text(
                                                    "CHECK_IN".tr,
                                                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 10.sp, color: AppColor.alreadyTextColor),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 14.w,
                                    top: 90.h,
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(
                                            ChannelTrackScreen(
                                              channelId: controller.trackDetailModel.value.data?.channelId ?? '',
                                            ),
                                            transition: Routes.defaultTransition);
                                      },
                                      child: CustomCircleImageview(
                                        width: 70.w,
                                        borderColor: AppColor.whiteColor,
                                        imagePath: controller.trackDetailModel.value.data?.channel?.image ?? '',
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 4.h),
                          color: AppColor.whiteColor[100],
                          padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 10.h),
                          child: Obx(() => Row(
                                children: [
                                  SvgPicture.asset(IconAssets.user),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Text(
                                    (controller.trackDetailModel.value.data?.totalUses ?? 0).toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11.sp,
                                      color: AppColor.subTitleColor.withOpacity(0.5),
                                    ),
                                  ),
                                  Spacer(),
                                  Obx(() {
                                    String yearAgo = '';
                                    if (controller.trackDetailModel.value.data?.createdAt != null) {
                                      yearAgo = Constants.convertToAgo(controller.trackDetailModel.value.data?.createdAt ?? '');
                                    }
                                    return Text(
                                      yearAgo,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10.sp,
                                        color: AppColor.subTitleColor.withOpacity(0.5),
                                      ),
                                    );
                                  }),
                                ],
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Obx(() => iconTextView(
                                    (controller.trackDetailModel.value.data?.isTrackLiked ?? false) ? IconAssets.heartFill : IconAssets.unLike,
                                    (controller.trackDetailModel.value.data?.reactions?.count ?? 0).toString(),
                                    () {
                                      if (controller.trackDetailModel.value.data?.isTrackLiked ?? false) {
                                        controller.likeUnlike(
                                            status: Constants.unlike, trackID: widget.trackId, screenCode: Constants.trackDetailScreen);
                                      } else {
                                        controller.likeUnlike(
                                            status: Constants.like, trackID: widget.trackId, screenCode: Constants.trackDetailScreen);
                                      }
                                    },
                                  )),
                              Obx(() => iconTextView(
                                    IconAssets.chatFill,
                                    (controller.trackDetailModel.value.data?.comments?.count ?? 0).toString(),
                                    () {
                                      if ((controller.trackDetailModel.value.data?.pinPoints?.pinPointArray?.length ?? 0) >= 1) {
                                        /*Map<String, dynamic>? json =
                                    controller.trackDetailModel.value.data?.pinPoints?.pinPointArray?[0].toJson();
                                PinPointModel pinpointModel = PinPointModel.fromJson(json!);
                                int index = controller.photosList.indexWhere(
                                    (item) => item.url == (pinpointModel.image ?? '') || item.url == (pinpointModel.video ?? ''));*/

                                        Navigator.of(context).push(
                                          PageRouteBuilder(
                                            opaque: false,
                                            pageBuilder: (BuildContext context, _, __) => PostsScreen(
                                                pinpointId: controller.trackDetailModel.value.data?.pinPoints?.pinPointArray![0].id,
                                                index: 0,
                                                photosList: controller.photosList,
                                                trackDetailController: controller,
                                                type: Constants.trackDetailScreen,
                                                trackId: widget.trackId),
                                          ),
                                        );
                                      }
                                      // PostCommentsBottomSheet(context);
                                    },
                                  )),
                              iconTextView(
                                IconAssets.share,
                                "SHARE".tr,
                                () async {
                                  debugPrint('tap');
                                  await Share.share('https://finutss.page.link/App');
                                },
                              ),
                              iconTextView(
                                IconAssets.report,
                                "REPORT".tr,
                                () {
                                  Get.to(
                                      ReportScreen(
                                        trackId: widget.trackId,
                                      ),
                                      transition: Routes.defaultTransition);
                                },
                              ),
                            ],
                          ),
                        ),
                        divider(),
                        SizedBox(
                          height: 6.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
                          child: Obx(() {
                            int minutes = ((controller.trackDetailModel.value.data?.durationInSeconds ?? 0) / 60).truncate();
                            String minutesStr = (minutes % 60).toString().padLeft(2, '0');

                            return Row(
                              children: [
                                kmMinCustomView(
                                  IconAssets.location,
                                  Constants.meterToKmConvert(((controller.trackDetailModel.value.data?.parsedGpx?.tracks?.length ?? 0) == 0
                                          ? 0
                                          : controller.trackDetailModel.value.data?.parsedGpx?.tracks?[0].distance?.total ?? 0)
                                      .toString()),
                                  "KM".tr,
                                ),
                                dividerHorizontal(),
                                kmMinCustomView(
                                  IconAssets.km,
                                  minutesStr,
                                  "MIN".tr,
                                ),
                                dividerHorizontal(),
                                kmMinCustomView(
                                  IconAssets.kcalIcon,
                                  (controller.trackDetailModel.value.data?.kcal ?? 0).toString(),
                                  "KCAL".tr,
                                ),
                                dividerHorizontal(),
                                kmMinCustomView(
                                  IconAssets.userMultipleIcon,
                                  (controller.trackDetailModel.value.data?.usersCount ?? 0).toString(),
                                  "Users".tr,
                                ),
                              ],
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 14.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /* CommentUserView(
                bgColor: AppColor.whiteColor,
                onTap: () {
                  Navigation.pushNamed(
                    Routes.postsScreen,
                  );
                  // PostCommentsBottomSheet(context);
                },
              ),
              SizedBox(
                height: 8.h,
              ),*/
                      Container(
                        child: Obx(
                          () {
                            String date = controller.trackDetailModel.value.data?.tags ?? '';
                            List<String> tagList = date.split(",");

                            return ChipsChoice<int>.single(
                              value: controller.tag.value,
                              onChanged: (val) {
                                controller.tag.value = val;
                                /*   Navigation.pushNamed(Routes.mostPopularViewAllScreen,
                          arg: {
                            'title': tagList[val].toString(),
                            'isMostPopular': false,
                          });*/
                              },
                              choiceItems: C2Choice.listFrom<int, String>(
                                source: tagList,
                                value: (i, v) {
                                  return i;
                                },
                                label: (i, v) => "#" + v,
                              ),
                              choiceActiveStyle: C2ChoiceStyle(
                                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                                  showCheckmark: false,
                                  color: AppColor.whiteColor,
                                  borderColor: AppColor.blue,
                                  backgroundColor: AppColor.blue,
                                  borderRadius: BorderRadius.all(Radius.circular(25)),
                                  labelStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500)),
                              choiceStyle: C2ChoiceStyle(
                                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                                  showCheckmark: false,
                                  color: AppColor.blue,
                                  backgroundColor: AppColor.tagBg,
                                  borderColor: AppColor.tagBg,
                                  borderRadius: BorderRadius.all(Radius.circular(25)),
                                  labelStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500)),
                              wrapped: true,
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11.w),
                          color: AppColor.whiteColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'TRACK_DESCRIPTION'.tr.toUpperCase(),
                              style: TextStyle(
                                letterSpacing: 0.1,
                                color: AppColor.subTitleColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 9.h),
                            Obx(() => Text(
                                  controller.trackDetailModel.value.data?.description ?? '',
                                  style: TextStyle(
                                    height: 2.0,
                                    color: AppColor.subTitleColor.withOpacity(0.8),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )),
                            SizedBox(height: 5.h),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      controller.recommendedTrackList.length == 0
                          ? SizedBox()
                          : Container(
                              margin: EdgeInsets.only(bottom: 8.h),
                              child: Text(
                                'RECOMMENDED'.tr + 'TRACK'.tr,
                                style: TextStyle(fontWeight: FontWeight.w700, color: AppColor.subTitleColor, fontSize: 16.sp),
                              ),
                            ),
                      RecommendedTrackView(context),
                      SizedBox(
                        height: 40.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Obx(() => Container(
                                  height: 49.w,
                                  decoration: BoxDecoration(
                                      color: controller.isFree.value ? AppColor.greenSliderBg.withOpacity(0.05) : AppColor.pointBG,
                                      borderRadius: BorderRadius.circular(10.w),
                                      border: Border.all(
                                        width: 1,
                                        color: controller.isFree.value ? AppColor.greenSliderBg.withOpacity(0.10) : AppColor.pointBorder,
                                      )),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 12.w,
                                      ),
                                      SvgPicture.asset(
                                        controller.isFree.value ? IconAssets.energyPointGreenIcon : IconAssets.energyPointIcon,
                                        width: 24.w,
                                      ),
                                      SizedBox(
                                        width: 19.w,
                                      ),
                                      Text(
                                        controller.isFree.value
                                            ? 'FREE'.tr
                                            : (controller.trackDetailModel.value.data?.monetizationDetails?.energyPointsRequired ?? 0).toString() +
                                                ' ' +
                                                'EP'.tr,
                                        style: TextStyle(
                                          color: controller.isFree.value ? AppColor.greenSliderBg : AppColor.purple,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                          SizedBox(
                            width: 14.w,
                          ),
                          Expanded(
                            child: CustomSliderButton(
                              height: 49.w,
                              bgColor: AppColor.pinkSlider,
                              title: "START_NOW".tr.toUpperCase(),
                              onTap: () async {
                                //  loginController.user?.data?.workoutType?.value=Constants.riding;
                                if ((settingController.walletModel.value.data?.energyPointWallet?.balance ?? 0) >=
                                        (controller.trackDetailModel.value.data?.monetizationDetails?.energyPointsRequired ?? 0) ||
                                    (controller.trackDetailModel.value.data?.monetizationDetails?.energyPointsRequired ?? 0) == 0) {
                                  String type = await loginController.getCurrentType();
                                  if (controller.trackDetailModel.value.data?.userId == controller.userModel.value.data?.id) {
                                    //유저가 제작자라면
                                    print("trackId ----> ${widget.trackId} --- ${controller}");
                                    ModeSelectBottomSheet(context, trackId: widget.trackId, trackDetailController: controller);
                                  } else {
                                    //유저가 제작자가 아니라면
                                    if (type == IconAssets.ridingSensor || type == IconAssets.runGroupBoy || type == IconAssets.mobileSensor) {
                                      //센서가 연결되어 있다면
                                      print("trackId ----> ${widget.trackId} --- ${controller}");
                                      precautionsBottomSheet(context, trackId: widget.trackId, trackDetailController: controller);
                                    } else {
                                      //센서가 연결되어 있지 않다면
                                      connectionConnectBottomSheet(context);
                                    }
                                  }
                                } else {
                                  int point = (controller.trackDetailModel.value.data?.monetizationDetails?.energyPointsRequired ?? 0) -
                                      (settingController.walletModel.value.data?.energyPointWallet?.balance ?? 0);
                                  print("trackId ----> ${widget.trackId} --- ${controller}");
                                  energyPointDialog(context, point: point);
                                }
                              },
                              isCancelButton: false,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),

                // Scrollable horizontal widget here
              ],
            )),
          ],
        ),
        /*CustomScrollView(
          slivers: <Widget>[

            SliverAppBar(
              pinned: true,
              expandedHeight: 250.0,
              flexibleSpace: Stack(
                fit: StackFit.expand,
                children: [
                  mapImage(),
                  Positioned(
                    left: 0,
                    top: 0,
                    right: 0,
                    child: Image.asset(
                      ImageAssets.shadowBg,
                      height: 50.h,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    left: 20.w,
                    right: 20.w,
                    top: 1.h,
                    child: SizedBox(
                      height: 268.h,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 35.h,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 50.h,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  bottom: 0,
                                  child: Center(
                                    child: RoundButton(
                                      iconPath: IconAssets.backIcon,
                                      iconColor: AppColor.backIconColor,
                                      iconSize: 15.w,
                                      width: 40.w,
                                      onTap: () {
                                        Get.back();
                                      },
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  top: 0,
                                  bottom: 0,
                                  child: Center(
                                    child: Text(
                                      "TRACK_DETAIL".tr,
                                      style: TextStyle(
                                          letterSpacing: 0.4,
                                          color: AppColor.subTitleColor,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                       //   Spacer(),
                          Container(
                            height: 40.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.w),
                              color: AppColor.whiteColor,
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 22.w),
                            child: Row(
                              children: [
                                Center(child: SvgPicture.asset(IconAssets.trackingLine)),
                                SizedBox(
                                  width: 15.w,
                                ),
                                Expanded(
                                  child: Obx(() => Text(
                                    controller.trackDetailModel.value.data?.name ?? '',
                                    style: TextStyle(
                                        color: AppColor.subTitleColor, fontWeight: FontWeight.w500, fontSize: 12.sp),
                                  )),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),



            fitnessTrackView(context),
          ],
        )*/
      ),
    );
  }

  Widget fitnessTrackView(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(topRight: Radius.circular(10.w), topLeft: Radius.circular(10.w)),
          child: Container(
            color: AppColor.whiteColor,
            child: Column(
              children: [
                Obx(() => SizedBox(
                      width: double.infinity,
                      height: 158.h,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 0,
                            child: InkWell(
                              onTap: () {
                                if ((controller.trackDetailModel.value.data?.pinPoints?.pinPointArray?.length ?? 0) >= 1) {
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      opaque: false,
                                      pageBuilder: (BuildContext context, _, __) => PostsScreen(
                                          pinpointId: controller.trackDetailModel.value.data?.pinPoints?.pinPointArray![0].id,
                                          index: 0,
                                          photosList: controller.photosList,
                                          trackDetailController: controller,
                                          type: Constants.trackDetailScreen,
                                          trackId: widget.trackId),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                height: 110.h,
                                width: double.infinity,
                                child: CachedNetworkImage(
                                  imageUrl: controller.trackDetailModel.value.data?.previewImage ?? '',
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                Get.to(
                                    ChannelTrackScreen(
                                      channelId: controller.trackDetailModel.value.data?.channelId ?? '',
                                    ),
                                    transition: Routes.defaultTransition);
                              },
                              child: SizedBox(
                                height: 50.h,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 86.w,
                                      ),
                                      Expanded(
                                        child: Text(
                                          controller.trackDetailModel.value.data?.channel?.name ?? '',
                                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp, color: AppColor.alreadyTextColor),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(IconAssets.markerIcon),
                                          SizedBox(
                                            width: 6.w,
                                          ),
                                          Text(
                                            "CHECK_IN".tr,
                                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 10.sp, color: AppColor.alreadyTextColor),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 14.w,
                            top: 90.h,
                            child: GestureDetector(
                              onTap: () {
                                Get.to(
                                    ChannelTrackScreen(
                                      channelId: controller.trackDetailModel.value.data?.channelId ?? '',
                                    ),
                                    transition: Routes.defaultTransition);
                              },
                              child: CustomCircleImageview(
                                width: 70.w,
                                borderColor: AppColor.whiteColor,
                                imagePath: controller.trackDetailModel.value.data?.channel?.image ?? '',
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 4.h),
                  color: AppColor.whiteColor[100],
                  padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 10.h),
                  child: Obx(() => Row(
                        children: [
                          SvgPicture.asset(IconAssets.user),
                          SizedBox(
                            width: 8.w,
                          ),
                          Text(
                            (controller.trackDetailModel.value.data?.totalUses ?? 0).toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 11.sp,
                              color: AppColor.subTitleColor.withOpacity(0.5),
                            ),
                          ),
                          Spacer(),
                          Obx(() {
                            String yearAgo = '';
                            if (controller.trackDetailModel.value.data?.createdAt != null) {
                              yearAgo = Constants.convertToAgo(controller.trackDetailModel.value.data?.createdAt ?? '');
                            }
                            return Text(
                              yearAgo,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 10.sp,
                                color: AppColor.subTitleColor.withOpacity(0.5),
                              ),
                            );
                          }),
                        ],
                      )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Obx(() => iconTextView(
                            (controller.trackDetailModel.value.data?.isTrackLiked ?? false) ? IconAssets.heartFill : IconAssets.unLike,
                            (controller.trackDetailModel.value.data?.reactions?.count ?? 0).toString(),
                            () {
                              if (controller.trackDetailModel.value.data?.isTrackLiked ?? false) {
                                controller.likeUnlike(status: Constants.unlike, trackID: widget.trackId, screenCode: Constants.trackDetailScreen);
                              } else {
                                controller.likeUnlike(status: Constants.like, trackID: widget.trackId, screenCode: Constants.trackDetailScreen);
                              }
                            },
                          )),
                      Obx(() => iconTextView(
                            IconAssets.chatFill,
                            (controller.trackDetailModel.value.data?.comments?.count ?? 0).toString(),
                            () {
                              if ((controller.trackDetailModel.value.data?.pinPoints?.pinPointArray?.length ?? 0) >= 1) {
                                /*Map<String, dynamic>? json =
                                    controller.trackDetailModel.value.data?.pinPoints?.pinPointArray?[0].toJson();
                                PinPointModel pinpointModel = PinPointModel.fromJson(json!);
                                int index = controller.photosList.indexWhere(
                                    (item) => item.url == (pinpointModel.image ?? '') || item.url == (pinpointModel.video ?? ''));*/

                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    opaque: false,
                                    pageBuilder: (BuildContext context, _, __) => PostsScreen(
                                        pinpointId: controller.trackDetailModel.value.data?.pinPoints?.pinPointArray![0].id,
                                        index: 0,
                                        photosList: controller.photosList,
                                        trackDetailController: controller,
                                        type: Constants.trackDetailScreen,
                                        trackId: widget.trackId),
                                  ),
                                );
                              }
                              // PostCommentsBottomSheet(context);
                            },
                          )),
                      iconTextView(
                        IconAssets.share,
                        "SHARE".tr,
                        () async {
                          debugPrint('tap');
                          await Share.share('https://finutss.page.link/App');
                        },
                      ),
                      iconTextView(
                        IconAssets.report,
                        "REPORT".tr,
                        () {
                          Get.to(
                              ReportScreen(
                                trackId: widget.trackId,
                              ),
                              transition: Routes.defaultTransition);
                        },
                      ),
                    ],
                  ),
                ),
                divider(),
                SizedBox(
                  height: 6.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
                  child: Obx(() {
                    int minutes = ((controller.trackDetailModel.value.data?.durationInSeconds ?? 0) / 60).truncate();
                    String minutesStr = (minutes % 60).toString().padLeft(2, '0');

                    return Row(
                      children: [
                        kmMinCustomView(
                          IconAssets.location,
                          Constants.meterToKmConvert(((controller.trackDetailModel.value.data?.parsedGpx?.tracks?.length ?? 0) == 0
                                  ? 0
                                  : controller.trackDetailModel.value.data?.parsedGpx?.tracks?[0].distance?.total ?? 0)
                              .toString()),
                          "KM".tr,
                        ),
                        dividerHorizontal(),
                        kmMinCustomView(
                          IconAssets.km,
                          minutesStr,
                          "MIN".tr,
                        ),
                        dividerHorizontal(),
                        kmMinCustomView(
                          IconAssets.kcalIcon,
                          (controller.trackDetailModel.value.data?.kcal ?? 0).toString(),
                          "KCAL".tr,
                        ),
                        dividerHorizontal(),
                        kmMinCustomView(
                          IconAssets.userMultipleIcon,
                          (controller.trackDetailModel.value.data?.usersCount ?? 0).toString(),
                          "Users".tr,
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 14.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* CommentUserView(
                bgColor: AppColor.whiteColor,
                onTap: () {
                  Navigation.pushNamed(
                    Routes.postsScreen,
                  );
                  // PostCommentsBottomSheet(context);
                },
              ),
              SizedBox(
                height: 8.h,
              ),*/
              Container(
                child: Obx(
                  () {
                    String date = controller.trackDetailModel.value.data?.tags ?? '';
                    List<String> tagList = date.split(",");

                    return ChipsChoice<int>.single(
                      value: controller.tag.value,
                      onChanged: (val) {
                        controller.tag.value = val;
                        /*   Navigation.pushNamed(Routes.mostPopularViewAllScreen,
                          arg: {
                            'title': tagList[val].toString(),
                            'isMostPopular': false,
                          });*/
                      },
                      choiceItems: C2Choice.listFrom<int, String>(
                        source: tagList,
                        value: (i, v) {
                          return i;
                        },
                        label: (i, v) => "#" + v,
                      ),
                      choiceActiveStyle: C2ChoiceStyle(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          showCheckmark: false,
                          color: AppColor.whiteColor,
                          borderColor: AppColor.blue,
                          backgroundColor: AppColor.blue,
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          labelStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500)),
                      choiceStyle: C2ChoiceStyle(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          showCheckmark: false,
                          color: AppColor.blue,
                          backgroundColor: AppColor.tagBg,
                          borderColor: AppColor.tagBg,
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          labelStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500)),
                      wrapped: true,
                    );
                  },
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11.w),
                  color: AppColor.whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TRACK_DESCRIPTION'.tr.toUpperCase(),
                      style: TextStyle(
                        letterSpacing: 0.1,
                        color: AppColor.subTitleColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 9.h),
                    Obx(() => Text(
                          controller.trackDetailModel.value.data?.description ?? '',
                          style: TextStyle(
                            height: 2.0,
                            color: AppColor.subTitleColor.withOpacity(0.8),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        )),
                    SizedBox(height: 5.h),
                  ],
                ),
              ),
              SizedBox(
                height: 18.h,
              ),
              controller.recommendedTrackList.length == 0
                  ? SizedBox()
                  : Container(
                      margin: EdgeInsets.only(bottom: 8.h),
                      child: Text(
                        'RECOMMENDED'.tr + 'TRACK'.tr,
                        style: TextStyle(fontWeight: FontWeight.w700, color: AppColor.subTitleColor, fontSize: 16.sp),
                      ),
                    ),
              RecommendedTrackView(context),
              SizedBox(
                height: 40.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Obx(() => Container(
                          height: 49.w,
                          decoration: BoxDecoration(
                              color: controller.isFree.value ? AppColor.greenSliderBg.withOpacity(0.05) : AppColor.pointBG,
                              borderRadius: BorderRadius.circular(10.w),
                              border: Border.all(
                                width: 1,
                                color: controller.isFree.value ? AppColor.greenSliderBg.withOpacity(0.10) : AppColor.pointBorder,
                              )),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 12.w,
                              ),
                              SvgPicture.asset(
                                controller.isFree.value ? IconAssets.energyPointGreenIcon : IconAssets.energyPointIcon,
                                width: 24.w,
                              ),
                              SizedBox(
                                width: 19.w,
                              ),
                              Text(
                                controller.isFree.value
                                    ? 'FREE'.tr
                                    : (controller.trackDetailModel.value.data?.monetizationDetails?.energyPointsRequired ?? 0).toString() +
                                        ' ' +
                                        'EP'.tr,
                                style: TextStyle(
                                  color: controller.isFree.value ? AppColor.greenSliderBg : AppColor.purple,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                  SizedBox(
                    width: 14.w,
                  ),
                  Expanded(
                    child: CustomSliderButton(
                      height: 49.w,
                      bgColor: AppColor.pinkSlider,
                      title: "START_NOW".tr.toUpperCase(),
                      onTap: () async {
                        if ((settingController.walletModel.value.data?.energyPointWallet?.balance ?? 0) >=
                                (controller.trackDetailModel.value.data?.monetizationDetails?.energyPointsRequired ?? 0) ||
                            (controller.trackDetailModel.value.data?.monetizationDetails?.energyPointsRequired ?? 0) == 0) {
                          String type = await loginController.getCurrentType();
                          if (controller.trackDetailModel.value.data?.userId == controller.userModel.value.data?.id) {
                            //유저가 제작자라면
                            ModeSelectBottomSheet(context, trackId: widget.trackId, trackDetailController: controller);
                          } else {
                            //유저가 제작자가 아니라면
                            if (type == IconAssets.ridingSensor || type == IconAssets.runGroupBoy || type == IconAssets.mobileSensor) {
                              //센서가 연결되어 있다면
                              precautionsBottomSheet(context, trackId: widget.trackId, trackDetailController: controller);
                            } else {
                              //센서가 연결되어 있지 않다면
                              connectionConnectBottomSheet(context);
                            }
                          }
                        } else {
                          int point = (controller.trackDetailModel.value.data?.monetizationDetails?.energyPointsRequired ?? 0) -
                              (settingController.walletModel.value.data?.energyPointWallet?.balance ?? 0);
                          energyPointDialog(context, point: point);
                        }
                      },
                      isCancelButton: false,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }

  Widget iconTextView(String iconPath, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 80.w,
        child: Column(
          children: [
            SvgPicture.asset(
              iconPath,
              width: 21.w,
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 11.sp,
                letterSpacing: 0.2,
                color: AppColor.subTitleColor.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget divider() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      height: 0.6.h,
      color: AppColor.dividerColorKm,
    );
  }

  Widget dividerHorizontal() {
    return Container(
      width: 0.7,
      height: 30.h,
      color: AppColor.dividerColorKm,
    );
  }

  Widget kmMinCustomView(String iconPath, String title, String subtitle) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: Column(
          children: [
            Image.asset(
              iconPath,
              height: 23.w,
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
                Flexible(
                  child: Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 11.sp,
                      letterSpacing: 0.2,
                      color: AppColor.subTitleColor.withOpacity(0.6),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget RecommendedTrackView(context) {
    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      removeTop: true,
      removeLeft: true,
      removeRight: true,
      child: Obx(() => controller.isLoadingRecommendedTrack.value
          ? CustomVIew.mostPopularShimmer()
          : controller.recommendedTrackList.length == 0
              ? SizedBox()
              : GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.recommendedTrackList.length,
                  itemBuilder: (context, int index) {
                    double distanceInKiloMeters = (controller.recommendedTrackList[index].distanceInMetres ?? 0) / 1000;
                    return MostPopularCard(
                      isShowOnlyUser: true,
                      trackName: controller.recommendedTrackList[index].name ?? '',
                      description: controller.recommendedTrackList[index].description ?? '',
                      trackImage: controller.recommendedTrackList[index].previewImage ?? '',
                      userView: (controller.recommendedTrackList[index].totalUses ?? 0).toString(),
                      distanceInKm: distanceInKiloMeters.toString(),
                      energyPoint: 0,
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.2,
                  ),
                )),
    );
  }
}
