import 'dart:developer';
import 'package:finutss/new%20ui/modules/app_setting/model/success_model.dart';
import 'package:finutss/new%20ui/modules/history/model/history_record_model.dart';
import 'package:finutss/new%20ui/modules/home/controller/home_screen_controller.dart';
import 'package:finutss/new%20ui/modules/record/controller/bmi_slider_controller.dart';
import 'package:finutss/new%20ui/modules/record/service/today_record_service.dart';
import 'package:finutss/new%20ui/modules/social/controller/following_followers_controller.dart';
import 'package:finutss/new%20ui/modules/social/controller/social_controller.dart';
import 'package:finutss/new%20ui/modules/social/model/friends_model.dart';
import 'package:finutss/new%20ui/modules/social/service/find_friends_service.dart';
import 'package:finutss/new%20ui/modules/track/model/track_detail_model.dart';
import 'package:finutss/new%20ui/modules/track/service/track_service.dart';
import 'package:finutss/new%20ui/modules/user_profile/service/user_profile_service.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/widget/loader.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class userProfileController extends GetxController {
  Rx<UserArray> userArray = UserArray().obs;
  BmiSliderController bmiSliderController = Get.find();
  final SocialController socialController = Get.find();
  RxList<RecordsArray> todayRecordTempData = RxList([]);

  RxString trackImage = ''.obs;
  String trackId = '';
  RxBool isLoadingRecentActivity = false.obs;
  RxBool isShowRecord = false.obs;

  Future FollowApi({required String userId, int? type, int? index, bool? isLiveUser,String? specificUserId}) async {
    try {
      AppLoader(Get.context!);
      Map<String, dynamic> body = {"userId": userId};

      SuccessModel model = await UserProfileService.follow(body);
      if (model.statusCode == Constants.successCode201) {
        if (type == Constants.recommendedUser) {
          final SocialController controller = Get.find();
          controller.recommendedUsers.removeAt(index ?? 0);
          controller.recommendedUsers.refresh();
          socialController.getRecommendedUser();
        } else if (type == Constants.hotPeople) {
          SocialController socialController = Get.find();
          socialController.hotUserList.removeAt(index ?? 0);
          socialController.hotUserList.refresh();
        } else if (type == Constants.workoutUser) {
          HomeScreenController homeController = Get.find();
          homeController.workoutUserList[index ?? 0].isFollowing = true;
          homeController.workoutUserList.refresh();
        } else if (type == Constants.isSearchUserScreen) {
          SocialController socialController = Get.find();
          socialController.userList[index ?? 0].isFollowing = true;
          socialController.userList.refresh();
        } else if (type == Constants.isFollowingScreen) {
          FollowingFollowersController followingController=Get.find<FollowingFollowersController>(tag:specificUserId ?? '');
          followingController.followingList[index ?? 0].isFollowing = true;
          followingController.followingList.refresh();
        }else if (type == Constants.isFollowerScreen) {
          FollowingFollowersController followingController=Get.find<FollowingFollowersController>(tag:specificUserId ?? '');
          followingController.followerList[index ?? 0].isFollowing = true;
          followingController.followerList.refresh();
        }

        userArray.value.isFollowing = true;
        userArray.refresh();

        print('------------>${userArray.value.historyDisclosure}');

        if (userArray.value.historyDisclosure.toString().toLowerCase() == 'all' ||
            userArray.value.historyDisclosure.toString().toLowerCase() == 'friends') {
          isShowRecord.value = true;
        } else {
          isShowRecord.value = false;
        }

        bmiSliderController.userModel.value.data?.followingCount =
            (bmiSliderController.userModel.value.data?.followingCount ?? 0) + 1;
        bmiSliderController.userModel.refresh();
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {
      RemoveAppLoader();
    }
  }

  Future unFollowApi({required String userId, int? index, int? type,String? specificUserId}) async {
    try {
      AppLoader(Get.context!);
      Map<String, dynamic> body = {"userId": userId};
      SuccessModel model = await UserProfileService.unFollow(body);
      if (model.statusCode == Constants.successCode200) {
        userArray.value.isFollowing = false;
        userArray.refresh();

        if (type == Constants.workoutUser) {
          HomeScreenController homeController = Get.find();
          homeController.workoutUserList[index ?? 0].isFollowing = false;
          homeController.workoutUserList.refresh();
        } else if (type == Constants.isSearchUserScreen) {
          SocialController socialController = Get.find();
          socialController.userList[index ?? 0].isFollowing = false;
          socialController.userList.refresh();
        }else if (type == Constants.isFollowingScreen) {
          FollowingFollowersController followingController=Get.find<FollowingFollowersController>(tag:specificUserId ?? '');
          followingController.followingList[index ?? 0].isFollowing = false;
          followingController.followingList.refresh();
        }else if (type == Constants.isFollowerScreen) {
          FollowingFollowersController followingController=Get.find<FollowingFollowersController>(tag:specificUserId ?? '');
          followingController.followerList[index ?? 0].isFollowing = false;
          followingController.followerList.refresh();
        }

        if (userArray.value.historyDisclosure.toString().toLowerCase() == 'all') {
          isShowRecord.value = true;
        } else {
          isShowRecord.value = false;
        }

        bmiSliderController.userModel.value.data?.followingCount =
            (bmiSliderController.userModel.value.data?.followingCount ?? 0) - 1;
        bmiSliderController.userModel.refresh();
      }
    } catch (e, st) {
      log("UnFollow Error Message: $e : $st");
    } finally {
      RemoveAppLoader();
    }
  }


  Future<FriendModel> getUserById({required Map<String, dynamic> body}) async {
    try {
      AppLoader(Get.context!);
      FriendModel model = await FindFriendsService.searchFriend(body: body);
      RemoveAppLoader();
      if (model.statusCode == Constants.successCode200) {
        if ((model.data?.userArray?.length ?? 0) > 0) {
          userArray.value = model.data?.userArray?[0] ?? UserArray();

          if (userArray.value.historyDisclosure.toString().toLowerCase() == 'all' ||
              (userArray.value.historyDisclosure.toString().toLowerCase() == 'friends' &&
                  (userArray.value.isFollowing ?? false))) {
            isShowRecord.value = true;
          } else {
            isShowRecord.value = false;
          }
          getTodayRecord(userId: userArray.value.id ?? '');
        }
      }
      return model;
    } catch (e, st) {
      RemoveAppLoader();
      log("Error Message: $e : $st");
    } finally {}
    return FriendModel();
  }

  Future getTodayRecord({required String userId}) async {
    try {
      isLoadingRecentActivity.value = true;
      var now = new DateTime.now().toUtc();
      var formatter = new DateFormat('yyyy-MM-dd');
      String todayDate = formatter.format(now);
      Map<String, dynamic> body = {
        "userId": userId,
        // "startDate": todayDate  + 'T00:00:00.000',
        // "endDate":  todayDate  + 'T23:59:59.000',
      };
      HistoryRecordModel model = await TodayRecordService.GetRecordFromDate(body: body);

      if (model.statusCode == Constants.successCode200) {
        List<RecordsArray> recordTempList = [];
        todayRecordTempData.value=[];
        recordTempList= model.data?.recordsArray ?? [];

        for(int i=0; i<recordTempList.length; i++){
          if((recordTempList[i].status ?? '').toLowerCase()==Constants.finished.toLowerCase()){
            todayRecordTempData.value.add(recordTempList[i]);
            trackId = recordTempList[i].trackId ?? '';
            getTrackDetail(id: trackId);
            break;
          }
        }
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {
      isLoadingRecentActivity.value = false;
    }
  }

  Future getTrackDetail({required String id}) async {
    try {
      TrackDetailModel model = await TrackService.getTrackDetail(trackId: id);
      if (model.statusCode == Constants.successCode200) {
        trackImage.value = model.data?.previewImage ?? '';

      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {}
  }
}
