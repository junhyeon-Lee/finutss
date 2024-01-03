import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:finutss/new%20ui/modules/map_view/controller/map_view_controller.dart';
import 'package:finutss/new%20ui/modules/map_view/model/pinpoint_model.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/log_utils.dart';
import 'package:finutss/new%20ui/widget/audio_player/voice_message_custom.dart';
import 'package:finutss/new%20ui/widget/custom_circle_imageview.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pod_player/pod_player.dart';

// import 'package:pod_player_new/pod_player_new.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PinPointScreen extends StatefulWidget {
  PinPointScreen({Key? key, required this.pinPointModel}) : super(key: key);
  PinPointModel pinPointModel;

  @override
  State<PinPointScreen> createState() => _PinPointScreenState();
}

class _PinPointScreenState extends State<PinPointScreen> {
  final MapViewController mapController = Get.find();

  @override
  void initState() {
    super.initState();

    LogUtils.logMSG('---Map Screen----PinPointScreen  initState------>', StackTrace.empty);

    if (widget.pinPointModel.image != null &&
        (widget.pinPointModel.image ?? '') != "" &&
        (widget.pinPointModel.image ?? '') != "undefined" &&
        widget.pinPointModel.image?.substring((widget.pinPointModel.image?.length ?? 0) - 4).toLowerCase() == ".mp4") {
      LogUtils.logMSG('---Map Screen----PinPointScreen  isVideo------>', StackTrace.empty);
      try {
        mapController.flickManager = FlickManager(
          videoPlayerController: VideoPlayerController.network(
            widget.pinPointModel.image ?? '',
          ),
          autoPlay: true,
        );
        mapController.isFinishedVideo.value = true;

        mapController.flickManager?.flickVideoManager?.addListener(() {
          if (mapController.flickManager?.flickVideoManager?.videoPlayerValue?.position ==
              mapController.flickManager?.flickVideoManager?.videoPlayerValue?.duration) {
            mapController.isFinishedVideo.value = false;
            Navigator.of(context, rootNavigator: true).pop('dialog');
          }
        });
      } on Exception catch (e, st) {
        LogUtils.logMSG('---Map Screen----PinPointScreen  isVideo-Exception::${e.toString()}', st);
        // TODO
      }
    } else if ((widget.pinPointModel.video ?? '').contains('youtu') || (widget.pinPointModel.video ?? '').contains('youtube')) {
      try {
        LogUtils.logMSG('---Map Screen----PinPointScreen  isYoutubeVideo}', StackTrace.empty);
        print('---Map Screen----PinPointScreen  isYoutubeVideo ${widget.pinPointModel.video}');
        String? videoId = YoutubePlayer.convertUrlToId(widget.pinPointModel.video ?? '');
        print('---Map Screen----PinPointScreen  isYoutubeVideo ${videoId}');
        /*mapController.podController = PodPlayerController(
          playVideoFrom: PlayVideoFrom.youtube(videoId ?? ''),
          podPlayerConfig: const PodPlayerConfig(
            autoPlay: true,
            isLooping: false,
            videoQualityPriority: [720, 360,144],
          ),
        )..initialise();*/
        mapController.youtubePlayerController = YoutubePlayerController(
          initialVideoId: videoId!,
          /* podPlayerConfig: const PodPlayerConfig(
                autoPlay: false,
                isLooping: false,
                videoQualityPriority: [720, 360,144],
              ), ,*/
          flags: YoutubePlayerFlags(
            autoPlay: true,
            loop: false,
            controlsVisibleAtStart: false,
          ),
        );
        // initialized = true;
        mapController.youtubePlayerController?.play();
        bool isComplete = false;
        mapController.youtubePlayerController?.addListener(() {
          if (mapController.youtubePlayerController?.value.playerState == PlayerState.ended) {
            print(
              '---Map Screen----PinPointScreen  isYoutubeVideo ${(mapController.youtubePlayerController?.metadata.duration.inMilliseconds == mapController.youtubePlayerController?.value.position.inMilliseconds)}  ${mapController.youtubePlayerController?.metadata.duration.inMilliseconds} --- ${mapController.youtubePlayerController?.value.position.inMilliseconds}',
            );
            if (!isComplete) {
              print('---Map Screen----PinPointScreen  isYoutubeVideo isComplete${isComplete}');
              isComplete = true;
              Navigator.of(context, rootNavigator: true).pop('dialog');
              mapController.isFinishedVideo.value = false;
            }
          }
        });
      } on Exception catch (exception, st) {
        LogUtils.logMSG('---Map Screen----PinPointScreen  isYoutubeVideo  exception::${exception.toString()}', st);
        print('exception');
        print('---Map Screen----PinPointScreen  isYoutubeVideo ${exception.toString()}');
      }
    } else if (widget.pinPointModel.sound == 'undefined' || widget.pinPointModel.sound == null || widget.pinPointModel.sound == '') {
      log('여기로 모여');
      log(widget.pinPointModel.sound.toString());
      Future.delayed(const Duration(seconds: 15), () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      });
    } else {
      log(widget.pinPointModel.sound.toString());
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mapController.previewComments.value = widget.pinPointModel.previewComment ?? PreviewComment();
    });
  }

  @override
  void dispose() {
    super.dispose();

    if (mapController.videoController != null) {
      mapController.videoController?.dispose();
    }

    if (mapController.flickManager != null) {
      mapController.flickManager?.dispose();
    }

    if (mapController.podController != null) {
      //  mapController.podController?.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 80.w, left: 16.w),
      child: Column(
        children: [
          if (widget.pinPointModel.sound != null && (widget.pinPointModel.sound ?? '') != "" && widget.pinPointModel.sound != 'undefined') ...[
            VoiceMessageCustom(
              meBgColor: AppColor.whiteColor.withOpacity(0.75),
              meFgColor: AppColor.blueTextColor.withOpacity(0.36),
              mePlayIconColor: AppColor.whiteColor.withOpacity(0.9),
              audioSrc: widget.pinPointModel.sound ?? '',
              // audioSrc: 'http://commondatastorage.googleapis.com/codeskulptor-assets/sounddogs/thrust.mp3',
              played: true,
              me: true,
              onPlay: () {},
            ),
          ],
          SizedBox(
            height: 5.h,
          ),
          if (widget.pinPointModel.image != null &&
              (widget.pinPointModel.image ?? '') != "" &&
              (widget.pinPointModel.image ?? '') != "undefined") ...[
            if (widget.pinPointModel.image?.substring((widget.pinPointModel.image?.length ?? 0) - 4).toLowerCase() == ".mp4") ...[
              GestureDetector(
                onTap: () {
                  if (mapController.isVideoLoading.value) {
                    mapController.isVideoPlaying.value = !mapController.isVideoPlaying.value;
                    if (mapController.isVideoPlaying.value) {
                      mapController.videoController?.play();
                    } else {
                      mapController.videoController?.pause();
                    }
                  }
                },
                child: Container(
                  height: 142.h,
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 5.h),
                  decoration: BoxDecoration(
                    color: AppColor.whiteColor.withOpacity(0.75),
                    borderRadius: BorderRadius.circular(6.w),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 8.h,
                            horizontal: 10.w,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: FlickVideoPlayer(
                              flickManager: mapController.flickManager!,
                              flickVideoWithControls: FlickVideoWithControls(
                                closedCaptionTextStyle: TextStyle(fontSize: 8),
                                controls: FlickPortraitControls(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 18.w,
                        right: 18.w,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.white.withOpacity(0.5),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 3.h,
                              horizontal: 4.w,
                            ),
                            child: Icon(
                              Icons.edit,
                              size: 14.w,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ] else ...[
              Container(
                height: 140.h,
                margin: EdgeInsets.only(bottom: 5.h),
                decoration: BoxDecoration(
                  color: AppColor.whiteColor.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(6.w),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.h,
                        horizontal: 10.w,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: widget.pinPointModel.image ?? '',
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => Icon(
                            Icons.error,
                            color: AppColor.black,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 18.w,
                      right: 18.w,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 3.h,
                            horizontal: 4.w,
                          ),
                          child: Icon(
                            Icons.edit,
                            size: 14.w,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ]
          ] else if ((widget.pinPointModel.video ?? '').contains('youtube') || (widget.pinPointModel.video ?? '').contains('youtu')) ...[
            /*PodVideoPlayer(
              controller: mapController.podController!,
              videoAspectRatio: (widget.pinPointModel.video ?? '').contains('shorts') ? 9 / 16 : 16 / 9,
              backgroundColor: AppColor.black,
              // pinpointId: widget.pinPointModel.id ?? '',
              onToggleFullScreen: null,
            )*/
            YoutubePlayer(
              controller: mapController.youtubePlayerController!,
              showVideoProgressIndicator: true,
            ),
          ],
          SizedBox(
            height: 4,
          ),
          if ((widget.pinPointModel.text ?? '').isNotEmpty && widget.pinPointModel.text != null && widget.pinPointModel.text != 'null') ...[
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.whiteColor.withOpacity(0.75),
                borderRadius: BorderRadius.circular(6.w),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 15.w,
                vertical: 9.h,
              ),
              child: Text(
                widget.pinPointModel.text ?? '',
                maxLines: 8,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  height: 1.2.h,
                  color: AppColor.blueTextColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 10.sp,
                ),
              ),
            ),
          ],
          SizedBox(
            height: 4,
          ),
          if (widget.pinPointModel.previewComment != null) ...[
            commentView(),
          ],
        ],
      ),
    );
  }

  Widget commentView() {
    return Obx(() {
      String timeAgo = '';
      if (mapController.previewComments.value.createdAt != null) {
        timeAgo = Constants.convertToAgo(mapController.previewComments.value.createdAt ?? '');
      }
      return Container(
        padding: EdgeInsets.only(
          left: 13.w,
          bottom: 10.h,
          top: 12.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColor.whiteColor.withOpacity(0.75),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomCircleImageview(
              width: 36.w,
              imagePath: mapController.previewComments.value.user?.profilePhoto ?? '',
            ),
            SizedBox(
              width: 11.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 1.3.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        mapController.previewComments.value.user?.username ?? '',
                        style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600, color: AppColor.subTitleColor),
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Text(
                        timeAgo,
                        style: TextStyle(fontSize: 9.sp, fontWeight: FontWeight.w500, color: AppColor.subTitleColor.withOpacity(0.4)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                    mapController.previewComments.value.text ?? '',
                    style: TextStyle(fontSize: 10.sp, height: 1.4, fontWeight: FontWeight.w400, color: AppColor.subTitleColor.withOpacity(0.8)),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          if (mapController.previewComments.value.isReacted ?? false) {
                            mapController.likeUnlike(status: Constants.unlike, commentId: mapController.previewComments.value.id ?? '');
                          } else {
                            mapController.likeUnlike(status: Constants.like, commentId: mapController.previewComments.value.id ?? '');
                          }
                        },
                        child: Row(
                          children: [
                            Obx(() => postText(IconAssets.heartFill, (mapController.previewComments.value.reactionsCount ?? 0).toString(),
                                color: mapController.previewComments.value.isReacted ?? false ? AppColor.pink : AppColor.iconColor)),
                            SizedBox(
                              width: 18.w,
                            ),
                          ],
                        ),
                      ),
                      postText(IconAssets.chatFill, (mapController.previewComments.value.repliesCount ?? 0).toString()),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget postText(String icon, String text, {Color? color}) {
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          height: 9.8.h,
          color: color ?? AppColor.iconColor,
        ),
        SizedBox(
          width: 7.w,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500, color: AppColor.subTitleColor.withOpacity(0.5)),
        ),
      ],
    );
  }
}
