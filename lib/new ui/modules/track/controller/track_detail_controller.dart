import 'dart:developer';

import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/new%20ui/modules/app_setting/model/success_model.dart';
import 'package:finutss/new%20ui/modules/history/model/history_record_model.dart';
import 'package:finutss/new%20ui/modules/home/controller/home_screen_controller.dart';
import 'package:finutss/new%20ui/modules/photo_video/model/photo_video_model.dart';
import 'package:finutss/new%20ui/modules/record/service/user_service.dart';
import 'package:finutss/new%20ui/modules/sign_in/model/login_model.dart';
import 'package:finutss/new%20ui/modules/track/model/trackAnalysisModel.dart';
import 'package:finutss/new%20ui/modules/track/model/track_detail_model.dart';
import 'package:finutss/new%20ui/modules/track/service/track_service.dart';
import 'package:finutss/new%20ui/modules/workout/service/workout_record_service.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/widget/loader.dart';
import 'package:get/get.dart';

import '../../../utils/log_utils.dart';

class TrackDetailController extends GetxController {
  RxList<TracksArray> recommendedTrackList = RxList([]);
  RxBool isLoadingRecommendedTrack = false.obs;

  Rx<TrackDetailModel> trackDetailModel = TrackDetailModel().obs;
  RxInt tag = (-1).obs;
  RxBool isFree = false.obs;
  RxBool isTrackCompleted = false.obs;
  RxBool isTrackCompletedTemp = false.obs;
  List<PhotoVideoModel> photosList = [];
  RxString pinSize = '0'.obs;

  @override
  void onInit() {
    getUserInfo();
    super.onInit();
  }

  Rx<LoginModel> userModel = LoginModel().obs;

  Future getUserInfo() async {
    try {
      userModel.value = await UserService.getUserInfo();
      if (userModel.value.statusCode == Constants.successCode200) {
        if (userModel.value.data?.bmi != null) {
          Constants.isBodyInfoSelected.value = true;
        }
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {}
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

  Future getWorkoutRecord({required String trackId}) async {
    try {
      isTrackCompleted.value = false;
      String userId = await SharedPrefs.getUserId();
      Map<String, dynamic> body = {"trackId": trackId, "userId": userId};
      LogUtils.logMSG('JavascriptChannel getWorkoutRecord-------->update body::${body},', StackTrace.empty);
      HistoryRecordModel model = await WorkoutRecordService.getWorkoutRecord(body: body);
      LogUtils.logMSG('JavascriptChannel getWorkoutRecord-------->update response::${model.message},', StackTrace.empty);
      print(
        'JavascriptChannel getWorkoutRecord-------->update response::${model.statusCode}  ${body},',
      );
      if (model.statusCode == Constants.successCode200) {
        List<RecordsArray> recordList = model.data?.recordsArray ?? [];

        for (int a = 0; a < recordList.length; a++) {
          if (recordList[a].status.toString().toUpperCase() == Constants.finished) {
            isTrackCompleted.value = true;
            isTrackCompletedTemp.value = true;
            break;
          }
        }
        print(
          'JavascriptChannel getWorkoutRecord-------->update response::${isTrackCompleted.value},',
        );
      }
    } catch (e, st) {
    } finally {}
  }

  Future getTrackDetail(String id) async {
    try {
      AppLoader(Get.context!);
      Constants.trackDistance = 0;
      isTrackCompleted.value = false;
      trackDetailModel.value = await TrackService.getTrackDetail(trackId: id);
      if (trackDetailModel.value.statusCode == Constants.successCode200) {
        photosList.clear();
        Constants.trackDistance = double.parse(Constants.meterToKmConvert(((trackDetailModel.value.data?.parsedGpx?.tracks?.length ?? 0) == 0
                    ? 0
                    : trackDetailModel.value.data?.parsedGpx?.tracks?[0].distance?.total ?? 0)
                .toString())
            .toString());
        Constants.currentTrackImage = trackDetailModel.value.data?.previewImage ?? '';

        isFree.value = (trackDetailModel.value.data?.channel?.settings?.isOfficial ?? false);
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
                  url: trackDetailModel.value.data?.pinPoints?.pinPointArray?[i].video,
                  type: Constants.typeVideo,
                  pinPointId: trackDetailModel.value.data?.pinPoints?.pinPointArray?[i].id,
                  serialNumber: trackDetailModel.value.data?.pinPoints?.pinPointArray?[i].serialNumber ?? 0));
            }

            if (trackDetailModel.value.data?.pinPoints?.pinPointArray?[i].image == null &&
                    trackDetailModel.value.data?.pinPoints?.pinPointArray?[i].video == null ||
                trackDetailModel.value.data?.pinPoints?.pinPointArray?[i].image == 'undefined' &&
                    trackDetailModel.value.data?.pinPoints?.pinPointArray?[i].video == 'undefined' ||
                (trackDetailModel.value.data?.pinPoints?.pinPointArray?[i].image ?? '').isEmpty &&
                    (trackDetailModel.value.data?.pinPoints?.pinPointArray?[i].video ?? '').isEmpty) {
              photosList.add(PhotoVideoModel(
                  url: trackDetailModel.value.data?.previewImage,
                  type: Constants.typePhoto,
                  pinPointId: trackDetailModel.value.data?.pinPoints?.pinPointArray?[i].id,
                  serialNumber: trackDetailModel.value.data?.pinPoints?.pinPointArray?[i].serialNumber ?? 0));
            }
          }

          photosList.sort((p1, p2) {
            return Comparable.compare(p1.serialNumber, p2.serialNumber);
          });
          pinSize.value = photosList.length.toString();
        }
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {
      RemoveAppLoader();
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

          HomeScreenController homeController = Get.find();
          int foundIndex = homeController.mostPopularTrackList.value.indexWhere((ele) => ele.id == trackDetailModel.value.data?.id);
          if (foundIndex != -1) {
            homeController.mostPopularTrackList.value[foundIndex].isTrackLiked = trackDetailModel.value.data?.isTrackLiked;
            homeController.mostPopularTrackList.value[foundIndex].totalReactionCount = trackDetailModel.value.data?.reactions?.count;

            if (homeController.dailyTrack.value.id == homeController.mostPopularTrackList.value[foundIndex].id) {
              homeController.dailyTrack.value.isTrackLiked = trackDetailModel.value.data?.isTrackLiked;
              homeController.dailyTrack.value.totalReactionCount = trackDetailModel.value.data?.reactions?.count;
            }
          }
          trackDetailModel.refresh();
        }
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {}
  }
}
