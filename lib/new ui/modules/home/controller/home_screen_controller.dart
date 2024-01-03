import 'dart:developer';

import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/new%20ui/modules/app_setting/model/success_model.dart';
import 'package:finutss/new%20ui/modules/channel_track/controller/channel_controller.dart';
import 'package:finutss/new%20ui/modules/home/model/home_model.dart';
import 'package:finutss/new%20ui/modules/home/model/slider_model.dart';
import 'package:finutss/new%20ui/modules/map_view/model/pinpoint_model.dart';
import 'package:finutss/new%20ui/modules/photo_video/model/photo_video_model.dart';
import 'package:finutss/new%20ui/modules/record/controller/bmi_slider_controller.dart';
import 'package:finutss/new%20ui/modules/record/model/workout_status_model.dart';
import 'package:finutss/new%20ui/modules/record/service/weight_record_service.dart';
import 'package:finutss/new%20ui/modules/sign_in/model/get_time_zone_model.dart';
import 'package:finutss/new%20ui/modules/track/model/track_detail_model.dart';
import 'package:finutss/new%20ui/modules/track/presentation/posts_screen.dart';
import 'package:finutss/new%20ui/modules/track/service/track_service.dart';
import 'package:finutss/new%20ui/modules/user_profile/service/user_profile_service.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/widget/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../record/service/user_service.dart';

class HomeScreenController extends GetxController {
  RxInt selectedIndex = (-1).obs;
  RxBool isDailyTraining = false.obs;
  Rx<DailyTrack> dailyTrack = DailyTrack().obs;
  RxList<PopularTrackArray> mostPopularTrackList = RxList([]);
  RxList<PopularTrackArray> tempMostPopularTrackList = <PopularTrackArray>[].obs;
  RxList<WorkoutUsersArray> workoutUserList = RxList([]);
  RxList<Banners> sliderImage = RxList([]);
  RxBool isLoading = false.obs;
  RxInt todayCal = 0.obs;
  String userId = '';
  BmiSliderController bmiSliderController = Get.find();
  GetTimeZoneModel getTimeZoneModel = GetTimeZoneModel();

  Future<void> getTimeZoneData() async {
    getTimeZoneModel = await UserService.getTimeZone();
    debugPrint(getTimeZoneModel.timezone);
    if (getTimeZoneModel.timezone?.isNotEmpty ?? false) {
      SharedPrefs.saveTimeZone(getTimeZoneModel.timezone ?? "Asia/Kolkata");
    }
  }

  Future<void> getUserId() async {
    userId = await SharedPrefs.getUserId();
  }

  Future getDailyTrack() async {
    debugPrint('그 뭐야 그거');
    try {
      isLoading.value = true;
      HomeModel model = await TrackService.getDailyTrack();
      print("model ${model}");
      if (model.statusCode == Constants.successCode200) {
        dailyTrack.value = model.data?.dailyTrack ?? DailyTrack();

        List<WorkoutUsersArray> tempWorkoutList = model.data?.workoutUsersArray ?? [];
        mostPopularTrackList.value = model.data?.popularTrackArray ?? [];
        /* for(int i=0; i<mostPopularTrackList.length; i++){
          if(mostPopularTrackList[i].status == 'in-progress'){
            mostPopularTrackList.removeAt(i);
          }
        }*/
        setTempList();
        print("getDailyTrack model ------> ${model.data?.popularTrackArray.toString()}");

        for (int i = 0; i < tempWorkoutList.length; i++) {
          int index = workoutUserList.value.indexWhere((item) => item.id == tempWorkoutList[i].id);
          if (index == -1) {
            workoutUserList.value.add(tempWorkoutList[i]);
          }
        }
        workoutUserList.refresh();
      }
    } catch (e, st) {
      log("getDailyTrack Error Message: $e :\n $st");
    } finally {
      isLoading.value = false;
    }
  }

  setTempList() {
    tempMostPopularTrackList.value = mostPopularTrackList.value;
  }

  searchTrack({required String text}) {
    tempMostPopularTrackList.value = [];
    if (text.isEmpty) {
      setTempList();
    } else {
      tempMostPopularTrackList.value =
          mostPopularTrackList.value.where((user) => user.name.toString().toLowerCase().contains(text.toLowerCase())).toList();
    }
  }

  Future likeUnlikePopularTrack({required String status, required String trackID, required int screenCode, int? index}) async {
    try {
      Map<String, dynamic> body = {
        "trackId": trackID,
        "type": status,
      };
      SuccessModel model = await TrackService.setLikeUnlike(body: body);
      if (model.statusCode == Constants.successCode200) {
        if (tempMostPopularTrackList[index!].isTrackLiked ?? false) {
          if (tempMostPopularTrackList[index].totalReactionCount != 0) {
            tempMostPopularTrackList[index].totalReactionCount = (tempMostPopularTrackList[index].totalReactionCount ?? 0) - 1;
          }
        } else {
          tempMostPopularTrackList[index].totalReactionCount = (tempMostPopularTrackList[index].totalReactionCount ?? 0) + 1;
        }
        tempMostPopularTrackList[index].isTrackLiked = !(tempMostPopularTrackList[index].isTrackLiked ?? false);
        int foundIndex = mostPopularTrackList.value.indexWhere((ele) => ele.id == tempMostPopularTrackList[index].id);
        if (foundIndex != -1) {
          mostPopularTrackList.value[foundIndex].isTrackLiked = tempMostPopularTrackList[index].isTrackLiked;
          mostPopularTrackList.value[foundIndex].totalReactionCount = tempMostPopularTrackList[index].totalReactionCount;
          if(dailyTrack.value.id == mostPopularTrackList.value[foundIndex].id){
            dailyTrack.value.isTrackLiked = mostPopularTrackList.value[index].isTrackLiked;
            dailyTrack.value.totalReactionCount = mostPopularTrackList.value[index].totalReactionCount;
          }
        }
        tempMostPopularTrackList.refresh();
        mostPopularTrackList.refresh();
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {}
  }

  Future getBanner() async {
    try {
      isLoading.value = true;
      SliderModel model = await TrackService.getBanner();
      sliderImage.value = model.banners ?? [];
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {
      isLoading.value = false;
    }
  }

  Future getDailyCal() async {
    try {
      String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      Map<String, dynamic> body = {"startDate": todayDate + 'T00:00:00.000', "endDate": todayDate + 'T23:59:59.000'};

      WorkoutStatusModel model = await WeightRecordService.workoutStatus(body);

      if (model.statusCode == Constants.successCode200) {
        if ((model.data?.dailyStatus?.length ?? 0) >= 1) {
          todayCal.value = int.parse((model.data?.dailyStatus?[0].burntCaloriesCount ?? 0).toString());
        } else {
          todayCal.value = 0;
        }
        if (todayCal.value > 2000) {
          todayCal.value = 2000;
        }
        if (todayCal.value == 2000) {
          isDailyTraining.value = true;
        } else {
          isDailyTraining.value = false;
        }
      }
      return model;
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {}
    return WorkoutStatusModel();
  }

  Future follow({required String userId, required int index}) async {
    try {
      AppLoader(Get.context!);
      Map<String, dynamic> body = {"userId": userId};

      SuccessModel model = await UserProfileService.follow(body);
      if (model.statusCode == Constants.successCode201) {
        workoutUserList[index].isFollowing = true;
        workoutUserList.refresh();
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {
      RemoveAppLoader();
    }
  }

  Future unFollowWorkout({required String userId, required int index}) async {
    try {
      AppLoader(Get.context!);
      Map<String, dynamic> body = {"userId": userId};
      SuccessModel model = await UserProfileService.unFollow(body);
      if (model.statusCode == Constants.successCode200) {
        workoutUserList[index].isFollowing = false;
        //   workoutUserList.removeAt(index);
        workoutUserList.refresh();
      }
    } catch (e, st) {
      log("UnFollow Error Message: $e : $st");
    } finally {
      RemoveAppLoader();
    }
  }

  Future likeUnlike({required String status, required String trackID}) async {
    try {
      Map<String, dynamic> body = {
        "trackId": trackID,
        "type": status,
      };
      SuccessModel model = await TrackService.setLikeUnlike(body: body);
      if (model.statusCode == Constants.successCode200) {
        if (dailyTrack.value.isTrackLiked ?? false) {
          if (dailyTrack.value.totalReactionCount != 0) {
            dailyTrack.value.totalReactionCount = (dailyTrack.value.totalReactionCount ?? 0) - 1;
          }
        } else {
          dailyTrack.value.totalReactionCount = (dailyTrack.value.totalReactionCount ?? 0) + 1;
        }

        dailyTrack.value.isTrackLiked = !(dailyTrack.value.isTrackLiked ?? false);
        mostPopularTrackList.forEach((element) {
          if (trackID == element.id) {
            element.isTrackLiked = dailyTrack.value.isTrackLiked;
            element.totalReactionCount = dailyTrack.value.totalReactionCount;
          }
        });
        dailyTrack.refresh();
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {}
  }

  Future getTrackDetail(
      {required String id, required int type, required int index, HomeScreenController? controller, ChannelController? channelController}) async {
    try {
      AppLoader(Get.context!);
      Constants.trackDistance = 0;
      TrackDetailModel model = await TrackService.getTrackDetail(trackId: id);
      RemoveAppLoader();
      if (model.statusCode == Constants.successCode200) {
        List<PhotoVideoModel> photosList = [];
        photosList.add(PhotoVideoModel(
            url: model.data?.previewImage, type: Constants.typePhoto, pinPointId: model.data?.id, serialNumber: 0, isTrackThumbnail: true));

        if (model.data?.pinPoints?.pinPointArray != null) {
          for (int i = 0; i < (model.data?.pinPoints?.pinPointArray?.length ?? 0); i++) {
            if (model.data?.pinPoints?.pinPointArray?[i].image != null &&
                (model.data?.pinPoints?.pinPointArray?[i].image ?? '').isNotEmpty &&
                model.data?.pinPoints?.pinPointArray?[i].image != 'undefined') {
              if (model.data?.pinPoints?.pinPointArray?[i].image
                      ?.substring((model.data?.pinPoints?.pinPointArray?[i].image?.length ?? 0) - 4)
                      .toLowerCase() ==
                  ".mp4") {
                photosList.add(PhotoVideoModel(
                    url: model.data?.pinPoints?.pinPointArray?[i].image,
                    type: Constants.typeVideo,
                    pinPointId: model.data?.pinPoints?.pinPointArray?[i].id,
                    serialNumber: model.data?.pinPoints?.pinPointArray?[i].serialNumber ?? 0));
              } else {
                photosList.add(PhotoVideoModel(
                    url: model.data?.pinPoints?.pinPointArray?[i].image,
                    type: Constants.typePhoto,
                    pinPointId: model.data?.pinPoints?.pinPointArray?[i].id,
                    serialNumber: model.data?.pinPoints?.pinPointArray?[i].serialNumber ?? 0));
              }
            }
            if (model.data?.pinPoints?.pinPointArray?[i].video != null &&
                (model.data?.pinPoints?.pinPointArray?[i].video ?? '').isNotEmpty &&
                model.data?.pinPoints?.pinPointArray?[i].video != 'undefined') {
              photosList.add(PhotoVideoModel(
                  url: model.data?.pinPoints?.pinPointArray?[i].video,
                  type: Constants.typeVideo,
                  pinPointId: model.data?.pinPoints?.pinPointArray?[i].id ?? '',
                  serialNumber: model.data?.pinPoints?.pinPointArray?[i].serialNumber ?? 0));
            }
          }

          if ((model.data?.pinPoints?.pinPointArray?.length ?? 0) > 0) {
            Map<String, dynamic>? json = model.data?.pinPoints?.pinPointArray?[0].toJson();
            PinPointModel pinpointModel = PinPointModel.fromJson(json!);
            int index1 = photosList.indexWhere((item) => item.url == (pinpointModel.image ?? '') || item.url == (pinpointModel.video ?? ''));

            Navigator.of(Get.context!).push(
              PageRouteBuilder(
                opaque: false,
                pageBuilder: (BuildContext context, _, __) => PostsScreen(
                  pinpointId: pinpointModel.id,
                  index: 0,
                  photosList: photosList,
                  indexMostPopular: index,
                  trackId: id,
                  type: type,
                  channelController: channelController,
                ),
              ),
            );
          }
        }
      }
    } catch (e, st) {
      RemoveAppLoader();
      log("Error Message: $e : $st");
    } finally {}
  }
}
