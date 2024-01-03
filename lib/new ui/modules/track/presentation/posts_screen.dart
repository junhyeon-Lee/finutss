import 'package:finutss/new%20ui/modules/app_setting/widget/custom_setting_row.dart';
import 'package:finutss/new%20ui/modules/channel_track/controller/channel_controller.dart';
import 'package:finutss/new%20ui/modules/invite_friends/report_block_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/photo_video/controller/photo_video_controller.dart';
import 'package:finutss/new%20ui/modules/photo_video/model/photo_video_model.dart';
import 'package:finutss/new%20ui/modules/photo_video/presentation/photo_video_list_screen.dart';
import 'package:finutss/new%20ui/modules/profile/presentation/fullScreen_image.dart';
import 'package:finutss/new%20ui/modules/profile/presentation/video_view_screen.dart';
import 'package:finutss/new%20ui/modules/track/controller/comment_controller.dart';
import 'package:finutss/new%20ui/modules/track/controller/track_controller.dart';
import 'package:finutss/new%20ui/modules/track/controller/track_detail_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/widget/comment_user_view.dart';
import 'package:finutss/new%20ui/widget/custom_view.dart';
import 'package:finutss/new%20ui/widget/send_message_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:preload_page_view/preload_page_view.dart';

class PostsScreen extends StatefulWidget {
  PostsScreen(
      {Key? key,
      this.pinpointId,
      this.index,
      this.channelController,
      this.isOpenThroughMapScreen,
      this.trackDetailController,
      required this.photosList,
      required this.trackId,
      required this.type,
      this.indexMostPopular})
      : super(key: key);
  final String? pinpointId;
  final String trackId;
  final int? index;
  final int type;
  final int? indexMostPopular;
  final TrackDetailController? trackDetailController;
  final ChannelController? channelController;
  List<PhotoVideoModel> photosList;
  bool? isOpenThroughMapScreen;

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final CommentController controller = Get.put(CommentController());
  TrackController trackController = Get.put(TrackController());
  final PhotoVideoController photoController = Get.put(PhotoVideoController());
  late PreloadPageController _controller;
  String currentPinpointId = '';
  bool isTrackThumbnail = false;

  int current = 0;

  void scrollListener() {
    if (controller.isOnPageTurning.value && _controller.page == _controller.page?.roundToDouble()) {
      current = _controller.page!.toInt();
      controller.isOnPageTurning.value = false;
    } else if (!controller.isOnPageTurning.value && current.toDouble() != _controller.page) {
      if ((current.toDouble() - _controller.page!).abs() > 0.1) {
        controller.isOnPageTurning.value = true;
      }
    }
  }

  @override
  void initState() {
    super.initState();

    controller.totalParentComment = 0;
    controller.totalRepliesComment = 0;
    currentPinpointId = widget.photosList[widget.index ?? 0].pinPointId ?? '';
    isTrackThumbnail = widget.photosList[widget.index ?? 0].isTrackThumbnail ?? false;

    controller.trackDetailController = widget.trackDetailController ?? Get.put<TrackDetailController>(TrackDetailController(), tag: widget.trackId);
    controller.trackDetailController.getWorkoutRecord(trackId: widget.trackId);

    if (widget.channelController != null) {
      controller.channelController = widget.channelController ?? Get.put(ChannelController());
    }

    controller.itemIndex = widget.index ?? -1;
    controller.itemIndexMostPopular = widget.indexMostPopular ?? -1;
    controller.currentScreenType = widget.type;
    controller.currentTrackId = widget.trackId;

    callAPIGetComment();

    _controller = PreloadPageController(initialPage: widget.index ?? 0);
    _controller.addListener(scrollListener);
    controller.currentPageIndex.value = (widget.index ?? 0) + 1;
  }

  @override
  void dispose() {
    super.dispose();
    controller.controller.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColor.backGroundColor,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColor.backGroundColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              children: [
                CustomSettingRow(
                  title: "POSTS".tr.toUpperCase(),
                  fontWeight: FontWeight.w700,
                  horizontalPadding: 5.w,
                  child: Obx(() => Center(
                        child: Text(
                          '(' + controller.currentPageIndex.value.toString() + '/' + widget.photosList.length.toString() + ')',
                          style: TextStyle(
                            color: AppColor.blueTextColor,
                            fontStyle: FontStyle.normal,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColor.whiteColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8.w),
                        bottomRight: Radius.circular(8.w),
                        topLeft: Radius.circular(12.w),
                        topRight: Radius.circular(12.w),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.cardGradiant1.withOpacity(0.06),
                          spreadRadius: 1.4,
                          blurRadius: 10,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: 150.h,
                          child: Obx(
                            () => PreloadPageView.builder(
                              controller: _controller,
                              scrollDirection: Axis.horizontal,
                              physics: controller.isCommentLoading.value || !(controller.trackDetailController.isTrackCompleted.value ?? true)
                                  ? NeverScrollableScrollPhysics()
                                  : ScrollPhysics(),
                              itemCount: widget.photosList.length,
                              onPageChanged: (page) {
                                currentPinpointId = widget.photosList[page].pinPointId ?? '';
                                isTrackThumbnail = widget.photosList[page].isTrackThumbnail ?? false;
                                controller.currentPageIndex.value = page + 1;
                                callAPIGetComment();
                              },
                              itemBuilder: (context, pageIndex) {
                                return InkWell(
                                  onTap: () {
                                    Get.to(
                                        FullScreenImage(
                                          url: widget.photosList[pageIndex].url,
                                          type: widget.photosList[pageIndex].type,
                                        ),
                                        transition: Routes.defaultTransition);
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12.w), topRight: Radius.circular(12.w)),
                                    child: VideoViewScreen(
                                      url: widget.photosList[pageIndex].url ?? '',
                                      type: widget.photosList[pageIndex].type,
                                      pageIndex: pageIndex,
                                      currentPageIndex: current,
                                      isPaused: controller.isOnPageTurning.value,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 19.h,
                                ),
                                Row(
                                  children: [
                                    Obx(() => iconTextBox(
                                          IconAssets.gallery,
                                          controller.currentPageIndex.value.toString() + '/' + widget.photosList.length.toString(),
                                          () {
                                            // if (controller.trackDetailController.isTrackCompleted.value ?? false) {
                                              photoController.limit = 21;
                                              photoController.startIndex = 0;

                                              photoController.setPhotos(widget.photosList);
                                              Get.to(PhotoVideoListScreen(
                                                isApiCall: true,
                                                trackId: widget.trackId,
                                                trackDetailController: widget.trackDetailController,
                                                isOpenThroughWorkoutScreen: false,
                                              ))?.then((value) {
                                                controller.trackDetailController.getWorkoutRecord(trackId: widget.trackId);
                                                if (value != null) {
                                                  int foundIndex = widget.photosList.indexWhere((ele) => ele.pinPointId == value);
                                                  if (foundIndex != -1) {
                                                    currentPinpointId = widget.photosList[foundIndex].pinPointId ?? '';
                                                    isTrackThumbnail = widget.photosList[foundIndex].isTrackThumbnail ?? false;
                                                    controller.currentPageIndex.value = foundIndex + 1;
                                                    _controller.jumpToPage(foundIndex);
                                                    callAPIGetComment();
                                                  }
                                                }
                                              });
                                            }
                                          // },
                                        )),
                                    Obx(() => iconTextBox(IconAssets.chatIc, controller.commentList.length.toString(), () {})),
                                    if (widget.type == Constants.trackDetailScreen) ...[
                                      Obx(() => iconTextBox(
                                              (controller.trackDetailController.trackDetailModel.value.data?.isTrackLiked ?? false)
                                                  ? IconAssets.heartFill
                                                  : IconAssets.unLike,
                                              (controller.trackDetailController.trackDetailModel.value.data?.reactions?.count ?? 0).toString(), () {
                                            if (controller.trackDetailController.trackDetailModel.value.data?.isTrackLiked ?? false) {
                                              controller.trackDetailController.likeUnlike(
                                                  status: Constants.unlike, trackID: widget.trackId, screenCode: Constants.trackDetailScreen);
                                            } else {
                                              controller.trackDetailController.likeUnlike(
                                                  status: Constants.like, trackID: widget.trackId, screenCode: Constants.trackDetailScreen);
                                            }
                                          })),
                                    ] else if (widget.type == Constants.mostPopularScreen) ...[
                                      Obx(() => iconTextBox(
                                              (controller.homeController.mostPopularTrackList[widget.indexMostPopular ?? 0].isTrackLiked ?? false)
                                                  ? IconAssets.heartFill
                                                  : IconAssets.unLike,
                                              (controller.homeController.mostPopularTrackList[widget.indexMostPopular ?? 0].totalReactionCount ?? 0)
                                                  .toString(), () {
                                            if (controller.homeController.mostPopularTrackList[widget.indexMostPopular ?? 0].isTrackLiked ?? false) {
                                              trackController.likeUnlike(
                                                  status: Constants.unlike,
                                                  index: widget.indexMostPopular,
                                                  trackID: controller.homeController.mostPopularTrackList[widget.indexMostPopular ?? 0].id ?? '',
                                                  screenCode: Constants.mostPopularScreen);
                                            } else {
                                              trackController.likeUnlike(
                                                  status: Constants.like,
                                                  index: widget.indexMostPopular,
                                                  trackID: controller.homeController.mostPopularTrackList[widget.indexMostPopular ?? 0].id ?? '',
                                                  screenCode: Constants.mostPopularScreen);
                                            }
                                          })),
                                    ] else if (widget.type == Constants.dailyTrackScreen) ...[
                                      Obx(() => iconTextBox(
                                              (controller.homeController.dailyTrack.value.isTrackLiked ?? false)
                                                  ? IconAssets.heartFill
                                                  : IconAssets.unLike,
                                              (controller.homeController.dailyTrack.value.totalReactionCount ?? 0).toString(), () {
                                            if (controller.homeController.dailyTrack.value.isTrackLiked ?? false) {
                                              trackController.likeUnlike(
                                                  status: Constants.unlike,
                                                  index: widget.indexMostPopular,
                                                  trackID: controller.homeController.dailyTrack.value.id ?? '',
                                                  screenCode: Constants.dailyTrackScreen);
                                            } else {
                                              trackController.likeUnlike(
                                                  status: Constants.like,
                                                  index: widget.indexMostPopular,
                                                  trackID: controller.homeController.dailyTrack.value.id ?? '',
                                                  screenCode: Constants.dailyTrackScreen);
                                            }
                                          })),
                                    ] else if (widget.type == Constants.channelPopularTrack) ...[
                                      Obx(() => iconTextBox(
                                              (controller.channelController.popularTrackList[widget.indexMostPopular ?? 0].isTrackLiked ?? false)
                                                  ? IconAssets.heartFill
                                                  : IconAssets.unLike,
                                              (controller.channelController.popularTrackList[widget.indexMostPopular ?? 0].totalReactionCount ?? 0)
                                                  .toString(), () {
                                            if (controller.channelController.popularTrackList[widget.indexMostPopular ?? 0].isTrackLiked ?? false) {
                                              controller.channelController.likeUnlike(
                                                  status: Constants.unlike,
                                                  index: widget.indexMostPopular,
                                                  trackID: controller.channelController.popularTrackList[widget.indexMostPopular ?? 0].id ?? '',
                                                  screenCode: Constants.channelPopularTrack);
                                            } else {
                                              controller.channelController.likeUnlike(
                                                  status: Constants.like,
                                                  index: widget.indexMostPopular,
                                                  trackID: controller.channelController.popularTrackList[widget.indexMostPopular ?? 0].id ?? '',
                                                  screenCode: Constants.channelPopularTrack);
                                            }
                                          })),
                                    ] else if (widget.type == Constants.channelLatestTrack) ...[
                                      Obx(() => iconTextBox(
                                              (controller.channelController.latestTrackList[widget.indexMostPopular ?? 0].isTrackLiked ?? false)
                                                  ? IconAssets.heartFill
                                                  : IconAssets.unLike,
                                              (controller.channelController.latestTrackList[widget.indexMostPopular ?? 0].totalReactionCount ?? 0)
                                                  .toString(), () {
                                            if (controller.channelController.latestTrackList[widget.indexMostPopular ?? 0].isTrackLiked ?? false) {
                                              controller.channelController.likeUnlike(
                                                  status: Constants.unlike,
                                                  index: widget.indexMostPopular,
                                                  trackID: controller.channelController.latestTrackList[widget.indexMostPopular ?? 0].id ?? '',
                                                  screenCode: Constants.channelLatestTrack);
                                            } else {
                                              controller.channelController.likeUnlike(
                                                  status: Constants.like,
                                                  index: widget.indexMostPopular,
                                                  trackID: controller.channelController.latestTrackList[widget.indexMostPopular ?? 0].id ?? '',
                                                  screenCode: Constants.channelLatestTrack);
                                            }
                                          })),
                                    ],
                                    GestureDetector(
                                      onTap: () {
                                        // moreOptionsBottomSheet(context);
                                        reportBlockBottomSheet(context, isOnlyReport: true, trackId: widget.trackId);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppColor.whiteColor,
                                          borderRadius: BorderRadius.circular(5.w),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.3),
                                              spreadRadius: 0.1,
                                              blurRadius: 8,
                                              offset: Offset(
                                                0,
                                                3,
                                              ), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        width: 33.w,
                                        height: 29.h,
                                        child: Center(
                                          child: SvgPicture.asset(
                                            IconAssets.sirenIcon,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 18.h,
                                ),
                                Obx(() => controller.isRepliesOpen.value
                                    ? InkWell(
                                        onTap: () {
                                          controller.parentCommentId = null;
                                          controller.isRepliesOpen.value = false;

                                          WidgetsBinding.instance.addPostFrameCallback((_) {
                                            controller.scrollController.jumpTo(controller.scrollPosition);
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 6.w,
                                            ),
                                            SvgPicture.asset(
                                              IconAssets.leftArrow,
                                              width: 9.w,
                                            ),
                                            SizedBox(
                                              width: 12.w,
                                            ),
                                            Text(
                                              controller.selectUsername + "'s " + "COMMENT".tr,
                                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp, color: AppColor.subTitleColor),
                                            ),
                                          ],
                                        ),
                                      )
                                    : SizedBox()),
                                Expanded(
                                  child: Obx(() => controller.isRepliesOpen.value ? repliesCommentView() : commentView()),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 14.h,
                ),
                Obx(()=>controller.trackDetailController.isTrackCompleted.value ?? true
                    ? SendMessageView(
                        onTap: () {
                          if (controller.controller.text.isNotEmpty) {
                            FocusScope.of(context).requestFocus(new FocusNode());
                            controller.addComment(
                                pinpointId: currentPinpointId,
                                text: controller.controller.text,
                                trackId: widget.trackId,
                                isAddCommentForTrack: isTrackThumbnail);
                          }
                        },
                      )
                    : SizedBox.shrink()),
                SizedBox(
                  height: 16.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget iconTextBox(String path, String text, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 29.h,
          margin: EdgeInsets.only(right: 11.w),
          padding: EdgeInsets.only(left: 10.w),
          decoration: BoxDecoration(
            color: AppColor.whiteColor[200],
            // color: Color(0xFFF2F7FF),
            borderRadius: BorderRadius.all(
              Radius.circular(5.w),
            ),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                path,
                height: 13.h,
                width: 13.h,
              ),
              SizedBox(
                width: 14.w,
              ),
              Text(
                text,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: AppColor.blueTextColor.withOpacity(0.85),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget postText(String icon, String text) {
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          height: 10.h,
          color: AppColor.iconColor,
        ),
        SizedBox(
          width: 8.w,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500, color: AppColor.subTitleColor.withOpacity(0.5)),
        ),
      ],
    );
  }

  Widget commentView() {
    print("controller.commentList.length ${controller.commentList.length}");
    return Obx(() => controller.isCommentLoading.value
        ? CustomVIew.listViewShimmer()
        : controller.commentList.length == 0
            ? CustomVIew.errorMessageShow('THERE_ARE_NO_COMMENTS_YET')
            : ListView.separated(
                controller: controller.scrollController,
                padding: EdgeInsets.only(bottom: 12.h),
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, i) {
                  return CommentUserView(
                    commentId: controller.commentList[i].id ?? '',
                    id: controller.commentList[i].user?.id ?? '',
                    currentUserId: controller.homeController.userId,
                    profileImage: controller.commentList[i].user?.profilePhoto ?? '',
                    userName: controller.commentList[i].user?.username ?? '',
                    description: controller.commentList[i].text,
                    date: controller.commentList[i].createdAt,
                    commentCount: (controller.commentList[i].repliesCount ?? 0).toString(),
                    reactionCount: (controller.commentList[i].reactionsCount ?? 0).toString(),
                    bgColor: AppColor.commentCardBg,
                    isLiked: (controller.commentList[i].isReacted ?? false),
                    isRepliesComment: false,
                    onTap: () {
                      controller.scrollPosition = controller.scrollController.position.pixels;
                      controller.selectUsername = controller.commentList[i].user?.username ?? '';
                      controller.isRepliesOpen.value = true;
                      controller.parentCommentId = controller.commentList[i].id;
                      controller.replieyCommentList.value = [];
                      controller.replieyCommentList.value = controller.commentList[i].replies ?? [];
                      controller.totalRepliesComment = controller.commentList[i].repliesCount ?? 0;
                      controller.sortingReplaiesComment();
                    },
                    onTapLike: () {
                      if (controller.commentList[i].isReacted ?? false) {
                        controller.likeUnlike(
                            status: Constants.unlike,
                            commentID: controller.commentList[i].id ?? '',
                            index: i,
                            isOpenMapScreen: widget.isOpenThroughMapScreen ?? false);
                      } else {
                        controller.likeUnlike(
                            status: Constants.like,
                            commentID: controller.commentList[i].id ?? '',
                            index: i,
                            isOpenMapScreen: widget.isOpenThroughMapScreen ?? false);
                      }
                    },
                  );
                },
                separatorBuilder: (context, i) {
                  return SizedBox(
                    height: 12.h,
                  );
                },
                itemCount: controller.commentList.length));
  }

  Widget repliesCommentView() {
    return Obx(() => controller.replieyCommentList.length == 0
        ? CustomVIew.errorMessageShow('THERE_ARE_NO_COMMENTS_YET')
        : ListView.separated(
            controller: controller.repliesScrollController,
            padding: EdgeInsets.symmetric(
              vertical: 10.h,
            ),
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, i) {
              return CommentUserView(
                commentId: controller.replieyCommentList[i].id ?? '',
                id: controller.replieyCommentList[i].user?.id ?? '',
                currentUserId: controller.homeController.userId,
                profileImage: controller.replieyCommentList[i].user?.profilePhoto ?? '',
                userName: controller.replieyCommentList[i].user?.username ?? '',
                description: controller.replieyCommentList[i].text,
                date: controller.replieyCommentList[i].createdAt,
                commentCount: '',
                isRepliesComment: true,
                bgColor: AppColor.commentCardBg,
                isLiked: false,
              );
            },
            separatorBuilder: (context, i) {
              return SizedBox(
                height: 12.h,
              );
            },
            itemCount: controller.replieyCommentList.length));
  }

  callAPIGetComment() {
    controller.parentCommentId = null;
    controller.isRepliesOpen.value = false;

    controller.getComment(trackId: widget.trackId, pinpointId: currentPinpointId, isTrackThumbnail: isTrackThumbnail);
  }
}
