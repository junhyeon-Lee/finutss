import 'dart:developer';

import 'package:finutss/new%20ui/modules/app_setting/model/success_model.dart';
import 'package:finutss/new%20ui/modules/home/controller/home_screen_controller.dart';
import 'package:finutss/new%20ui/modules/photo_video/model/photo_video_model.dart';
import 'package:finutss/new%20ui/modules/track/model/filter_chips.dart';
import 'package:finutss/new%20ui/modules/track/model/trackAnalysisModel.dart';
import 'package:finutss/new%20ui/modules/track/model/track_detail_model.dart';
import 'package:finutss/new%20ui/modules/track/service/track_service.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/widget/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrackController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  RxList<FilterChipData> choiceChips = <FilterChipData>[].obs;
  RxDouble speedValue = 24.0.obs;
  RxDouble locationValue = 50.0.obs;
  RxInt tag = (-1).obs;
  Rx<TrackDetailModel> trackDetailModel = TrackDetailModel().obs;

  RxList<TracksArray> mostPopularTrack = RxList([]);
  RxBool isLoadingMostPopular = false.obs;
  RxBool isSearchEnable = false.obs;
  TextEditingController searchController = TextEditingController();

  RxList<TracksArray> recommendedTrackList = RxList([]);
  RxBool isLoadingRecommendedTrack = false.obs;

  List<PhotoVideoModel> photosList = [];

  final HomeScreenController controller = Get.find();

  @override
  void onInit() {
    tabController = TabController(
      length: 4,
      vsync: this,
    );
    tabController.addListener(
      () {},
    );

    choiceChips.add(
      FilterChipData(color: AppColor.whiteColor[200]!, label: '#health', isSelected: false),
    );
    choiceChips.add(
      FilterChipData(color: AppColor.whiteColor[200]!, label: '#fitness', isSelected: false),
    );
    choiceChips.add(
      FilterChipData(color: AppColor.whiteColor[200]!, label: '#running', isSelected: false),
    );
    choiceChips.add(
      FilterChipData(color: AppColor.whiteColor[200]!, label: '#fitnesstracker', isSelected: false),
    );
    choiceChips.add(
      FilterChipData(color: AppColor.whiteColor[200]!, label: '#track', isSelected: false),
    );
    choiceChips.add(
      FilterChipData(color: AppColor.whiteColor[200]!, label: '#bmi', isSelected: false),
    );
    choiceChips.add(
      FilterChipData(color: AppColor.whiteColor[200]!, label: '##fitnessmotivation', isSelected: false),
    );
    choiceChips.add(
      FilterChipData(color: AppColor.whiteColor[200]!, label: '#weightloss', isSelected: false),
    );
    choiceChips.add(
      FilterChipData(color: AppColor.whiteColor[200]!, label: '#riding', isSelected: false),
    );
    choiceChips.add(
      FilterChipData(color: AppColor.whiteColor[200]!, label: '#indoor bike', isSelected: false),
    );

    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  Future getTrackDetail(String id) async {
    try {
      AppLoader(Get.context!);
      Constants.trackDistance = 0;
      trackDetailModel.value = await TrackService.getTrackDetail(trackId: id);
      if (trackDetailModel.value.statusCode == Constants.successCode200) {
        photosList.clear();
        Constants.trackDistance = double.parse(Constants.meterToKmConvert(((trackDetailModel.value.data?.parsedGpx?.tracks?.length ?? 0) == 0
                    ? 0
                    : trackDetailModel.value.data?.parsedGpx?.tracks?[0].distance?.total ?? 0)
                .toString())
            .toString());
        Constants.currentTrackImage = trackDetailModel.value.data?.previewImage ?? '';

        photosList.add(PhotoVideoModel(
            url: trackDetailModel.value.data?.previewImage,
            type: Constants.typePhoto,
            pinPointId: trackDetailModel.value.data?.id ?? '',
            serialNumber: 0,
            isTrackThumbnail: true));
        if (trackDetailModel.value.data?.pinPoints?.pinPointArray != null) {
          for (int i = 0; i < (trackDetailModel.value.data?.pinPoints?.pinPointArray?.length ?? 0); i++) {
            if (trackDetailModel.value.data?.pinPoints?.pinPointArray?[i].image != null &&
                (trackDetailModel.value.data?.pinPoints?.pinPointArray?[i].image ?? '').isNotEmpty &&
                trackDetailModel.value.data?.pinPoints?.pinPointArray?[i].image != 'undefined') {
              if (trackDetailModel.value.data?.pinPoints?.pinPointArray?[i].image
                      ?.substring((trackDetailModel.value.data?.pinPoints?.pinPointArray?[i].image?.length ?? 0) - 4)
                      .toLowerCase() ==
                  ".mp4") {
                photosList.add(PhotoVideoModel(
                    url: trackDetailModel.value.data?.pinPoints?.pinPointArray?[i].image,
                    type: Constants.typeVideo,
                    pinPointId: trackDetailModel.value.data?.pinPoints?.pinPointArray?[i].id,
                    serialNumber: trackDetailModel.value.data?.pinPoints?.pinPointArray?[i].serialNumber ?? 0));
              } else {
                photosList.add(PhotoVideoModel(
                    url: trackDetailModel.value.data?.pinPoints?.pinPointArray?[i].image,
                    type: Constants.typePhoto,
                    pinPointId: trackDetailModel.value.data?.pinPoints?.pinPointArray?[i].id,
                    serialNumber: trackDetailModel.value.data?.pinPoints?.pinPointArray?[i].serialNumber ?? 0));
              }
            }
            if (trackDetailModel.value.data?.pinPoints?.pinPointArray?[i].video != null &&
                (trackDetailModel.value.data?.pinPoints?.pinPointArray?[i].video ?? '').isNotEmpty &&
                trackDetailModel.value.data?.pinPoints?.pinPointArray?[i].video != 'undefined') {
              photosList.add(PhotoVideoModel(
                  url: trackDetailModel.value.data?.pinPoints?.pinPointArray?[i].image,
                  type: Constants.typeVideo,
                  pinPointId: trackDetailModel.value.data?.pinPoints?.pinPointArray?[i].id,
                  serialNumber: trackDetailModel.value.data?.pinPoints?.pinPointArray?[i].serialNumber ?? 0));
            }
          }
        }
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {
      RemoveAppLoader();
    }
  }

  Future getRecommendedTrack() async {
    try {
      isLoadingRecommendedTrack.value = true;
      TrackAnalysisModel model = await TrackService.getRecommendedTrack();
      if (model.statusCode == Constants.successCode200) {
        recommendedTrackList.value = model.data?.tracksArray ?? [];
        isLoadingRecommendedTrack.value = false;
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {}
  }

  Future getMostPopularTrack() async {
    try {
      isLoadingMostPopular.value = true;
      Map<String, dynamic> body = {
        //"limit": 10,
        // "offset": 0,
        'sort': 'popular'
      };
      TrackAnalysisModel model = await TrackService.getPopularLatestTrack(body: body);

      if (model.statusCode == Constants.successCode200) {
        mostPopularTrack.value.clear();
        mostPopularTrack.value = model.data?.tracksArray ?? [];
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {
      isLoadingMostPopular.value = false;
    }
  }

  Future likeUnlike({required String status, required String trackID, required int screenCode, int? index}) async {
    try {
      Map<String, dynamic> body = {
        "trackId": trackID,
        "type": status,
      };
      SuccessModel model = await TrackService.setLikeUnlike(body: body);
      if (model.statusCode == Constants.successCode200) {
        if (screenCode == Constants.trackDetailScreen) {
          if (trackDetailModel.value.data?.isTrackLiked ?? false) {
            if (trackDetailModel.value.data?.reactions?.count != 0) {
              trackDetailModel.value.data?.reactions?.count = (trackDetailModel.value.data?.reactions?.count ?? 0) - 1;
            }
          } else {
            trackDetailModel.value.data?.reactions?.count = (trackDetailModel.value.data?.reactions?.count ?? 0) + 1;
          }
          trackDetailModel.value.data?.isTrackLiked = !(trackDetailModel.value.data?.isTrackLiked ?? false);
          trackDetailModel.refresh();
        } else if (screenCode == Constants.mostPopularScreen) {
          if (controller.mostPopularTrackList[index!].isTrackLiked ?? false) {
            if (controller.mostPopularTrackList[index].totalReactionCount != 0) {
              controller.mostPopularTrackList[index].totalReactionCount = (controller.mostPopularTrackList[index].totalReactionCount ?? 0) - 1;
            }
          } else {
            controller.mostPopularTrackList[index].totalReactionCount = (controller.mostPopularTrackList[index].totalReactionCount ?? 0) + 1;
          }
          controller.mostPopularTrackList[index].isTrackLiked = !(controller.mostPopularTrackList[index].isTrackLiked ?? false);

          if (controller.dailyTrack.value.id == controller.mostPopularTrackList[index].id) {
            controller.dailyTrack.value.totalReactionCount = controller.mostPopularTrackList[index].totalReactionCount;
            controller.dailyTrack.value.isTrackLiked = controller.mostPopularTrackList[index].isTrackLiked;
          }

          controller.mostPopularTrackList.refresh();
        } else if (screenCode == Constants.dailyTrackScreen) {
          if (controller.dailyTrack.value.isTrackLiked ?? false) {
            if (controller.dailyTrack.value.totalReactionCount != 0) {
              controller.dailyTrack.value.totalReactionCount = (controller.dailyTrack.value.totalReactionCount ?? 0) - 1;
            }
          } else {
            controller.dailyTrack.value.totalReactionCount = (controller.dailyTrack.value.totalReactionCount ?? 0) + 1;
          }
          controller.dailyTrack.value.isTrackLiked = !(controller.dailyTrack.value.isTrackLiked ?? false);
          controller.dailyTrack.refresh();
        }
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {}
  }
}
