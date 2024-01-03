import 'package:finutss/new%20ui/modules/channel_track/controller/channel_controller.dart';
import 'package:finutss/new%20ui/modules/home/controller/home_screen_controller.dart';
import 'package:finutss/new%20ui/modules/photo_video/presentation/photo_video_list_screen.dart';
import 'package:finutss/new%20ui/modules/track/presentation/track_detail_screen.dart';
import 'package:finutss/new%20ui/modules/track/widget/track_card.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/widget/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LatestTracksTab extends StatelessWidget {
  LatestTracksTab({Key? key, required this.controller}) : super(key: key);

  ChannelController controller;
  final HomeScreenController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Obx(() {
        return controller.latestTrackList.length == 0
            ? CustomVIew.trackShimmer()
            : ListView.separated(
                // controller: controller.scrollControllerLatest,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                itemBuilder: (context, i) {
                  return TrackCard(
                    onTap: () {
                      Get.to(TrackDetailScreen(trackId: controller.latestTrackList[i].id ?? ''), transition: Routes.defaultTransition);
                    },
                    imageUrl: controller.latestTrackList[i].previewImage ?? '',
                    circleImagePath: controller.latestTrackList[i].channel?.image ?? '',
                    titleText: controller.latestTrackList[i].name ?? '',
                    subTitleText: controller.latestTrackList[i].description ?? '',
                    view: (controller.latestTrackList[i].totalUses ?? 0).toString(),
                    like: (controller.latestTrackList[i].totalReactionCount ?? 0).toString(),
                    comment: (controller.latestTrackList[i].totalCommentsCount ?? 0).toString(),
                    galleryView: (controller.latestTrackList[i].totalPhotosCount ?? 0).toString(),
                    energyPoint: (controller.latestTrackList[i].monetizationDetails?.energyPointsRequired ?? 0),
                    isFree: (controller.latestTrackList[i].channel?.settings?.isOfficial ?? false),
                    isLiked: (controller.latestTrackList[i].isTrackLiked ?? false),
                    kmtr: Constants.meterToKmConvert(
                      (controller.latestTrackList[i].distanceInMetres ?? 0).toString(),
                    ),
                    createdDate: controller.latestTrackList[i].createdAt,
                    onTapComment: () {
                      homeController.getTrackDetail(
                          id: controller.popularTrackList[i].id ?? '',
                          type: Constants.channelLatestTrack,
                          index: i,
                          controller: homeController,
                          channelController: controller);
                    },
                    onTapLike: () {
                      if (controller.latestTrackList[i].isTrackLiked ?? false) {
                        controller.likeUnlike(
                            status: Constants.unlike,
                            trackID: controller.latestTrackList[i].id ?? '',
                            screenCode: Constants.channelLatestTrack,
                            index: i);
                      } else {
                        controller.likeUnlike(
                            status: Constants.like,
                            trackID: controller.latestTrackList[i].id ?? '',
                            screenCode: Constants.channelLatestTrack,
                            index: i);
                      }
                    },
                    onTapPhoto: () {
                      Get.to(PhotoVideoListScreen(
                        isApiCall: true,
                        trackId: controller.latestTrackList[i].id,
                        isOpenThroughWorkoutScreen: true,
                      ));
                    },
                    isDoneMarkShow: false,
                  );
                },
                separatorBuilder: (context, i) {
                  return SizedBox(
                    height: 14.h,
                  );
                },
                itemCount: controller.latestTrackList.length,
              );
      }),
    );
  }
}
