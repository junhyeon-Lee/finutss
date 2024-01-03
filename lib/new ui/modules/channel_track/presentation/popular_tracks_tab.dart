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

class PopularTracksTab extends StatelessWidget {
  PopularTracksTab({Key? key,required this.controller}) : super(key: key);
  ChannelController controller;

  final HomeScreenController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child:
      Obx(() {
        return controller.popularTrackList.length==0 ? CustomVIew.trackShimmer(): ListView.separated(
          physics: BouncingScrollPhysics(),
         // controller: controller.scrollControllerPopular,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          itemBuilder: (context, i) {
            return TrackCard(
              onTap: () {
                Get.to(TrackDetailScreen(trackId: controller.popularTrackList[i].id ?? ''),  transition: Routes.defaultTransition);
              },
              imageUrl:  controller.popularTrackList[i].previewImage ?? '',
              circleImagePath:  controller.popularTrackList[i].channel?.image ?? '',
              titleText:  controller.popularTrackList[i].name ?? '',
              subTitleText:  controller.popularTrackList[i].description ?? '',
              view: (controller.popularTrackList[i].totalUses ?? 0).toString(),
              like: (controller.popularTrackList[i].totalReactionCount ?? 0).toString(),
              comment: (controller.popularTrackList[i].totalCommentsCount ?? 0).toString(),
              galleryView: (controller.popularTrackList[i].totalPhotosCount ?? 0).toString(),
              energyPoint: (controller.popularTrackList[i].monetizationDetails?.energyPointsRequired ?? 0),
              isFree:  (controller.popularTrackList[i].channel?.settings?.isOfficial ?? false),
              isLiked: (controller.popularTrackList[i].isTrackLiked ?? false),
              kmtr: Constants.meterToKmConvert(
                  (controller.popularTrackList[i].distanceInMetres ?? 0)
                      .toString()),
              createdDate: controller.popularTrackList[i].createdAt,
              isDoneMarkShow: false,
              onTapComment: (){
                homeController.getTrackDetail(id :controller.popularTrackList[i].id ?? '',type: Constants.channelPopularTrack,index: i,controller: homeController,channelController: controller);
              },
              onTapLike: (){
                if(controller.popularTrackList[i].isTrackLiked ?? false){
                  controller.likeUnlike(status : Constants.unlike,trackID : controller.popularTrackList[i].id ?? '',screenCode: Constants.channelPopularTrack,index: i);
                }else{
                  controller.likeUnlike(status : Constants.like, trackID: controller.popularTrackList[i].id ?? '',screenCode: Constants.channelPopularTrack,index: i);
                }
              },
              onTapPhoto: (){
                Get.to(PhotoVideoListScreen(isApiCall: true,trackId: controller.popularTrackList[i].id, isOpenThroughWorkoutScreen: true,));
              },
            );
          },
          separatorBuilder: (context, i) {
            return SizedBox(
              height: 14.h,
            );
          },
          itemCount: controller.popularTrackList.value.length);
      }),
    );
  }
}
