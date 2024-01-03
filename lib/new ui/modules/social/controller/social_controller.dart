import 'dart:developer';

import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/new%20ui/modules/app_setting/model/success_model.dart';
import 'package:finutss/new%20ui/modules/record/controller/bmi_slider_controller.dart';
import 'package:finutss/new%20ui/modules/social/model/follow_users_model.dart';
import 'package:finutss/new%20ui/modules/social/model/friends_model.dart';
import 'package:finutss/new%20ui/modules/social/model/recommended_Model.dart';
import 'package:finutss/new%20ui/modules/social/service/find_friends_service.dart';
import 'package:finutss/new%20ui/modules/social/service/follow_users_service.dart';
import 'package:finutss/new%20ui/modules/social/service/recommended_service.dart';
import 'package:finutss/new%20ui/modules/user_profile/service/user_profile_service.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/widget/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SocialController extends GetxController {
  final TextEditingController findController = TextEditingController();
  List<String> tagList = [
    "#matual friend",
    "#${"PASSED_BY".tr}",
    "#nearme",
    "#similartime"
  ];
  RxList<HotUsersArray> hotUserList = RxList([]);
  RxList<FollowersArray> followerList = RxList([]);
  RxList<FollowersArray> currentUserFollowerList = RxList([]);
  RxList<FollowingArray> followingList = RxList([]);
  RxList<FollowingArray> currentUserFollowingList = RxList([]);
  RxBool isLoadingHotPeople = true.obs;
  RxList<RecommendedUsersArray> recommendedUsers = RxList([]);
  RxInt selectTagIndex = 0.obs;
  ScrollController scrollController = ScrollController();
  RxList<UserArray> userList = RxList([]);
  RxInt totalLength = 0.obs;
  RxInt limit = 20.obs;
  RxInt offset = 0.obs;
  RxBool isLoadRunning = false.obs;
  RxBool isSearchEnable = false.obs;
  RxBool isFirstTimeSearch = true.obs;
  String searchText = '';
  BmiSliderController bmiSliderController = Get.find();
  FocusNode searchFocus = new FocusNode();
  String userId='';

  int totalOffset=20;


  RxBool isLoadingFollowerUser = false.obs;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(pagination);
    getUserId();
  }



  Future<void> getUserId() async {
    userId = await SharedPrefs.getUserId();
  }

  keyboardIsVisible(BuildContext context) {
    /* bool isVisible= !(MediaQuery.of(context).viewInsets.bottom == 0.0);
    if(!isVisible){
      searchFocus.context.unfocus();
    }*/
  }

  void searchFriend(String text) {
    searchText = text;
    limit.value=totalOffset;
    offset.value=0;

    if (searchText.isEmpty) {
      isSearchEnable.value = false;
    } else {
      isSearchEnable.value = true;
      isFirstTimeSearch.value = true;
      userList.value=[];
      Map<String, dynamic> body = {
        "limit": limit.value,
        "offset": offset.value,
        "keyword": searchText,
      };
      searchFriendApiCall(body: body);
    }
  }

  void pagination() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        userList.length < totalLength.value) {
      limit.value =  totalOffset;
      offset.value=offset.value+totalOffset;
      Map<String, dynamic> body = {
        "limit": limit.value,
        "offset": offset.value,
        "keyword": searchText,
      };
      searchFriendApiCall(body: body);
    }
  }

  Future<RecommendedModel> getRecommendedUser() async {
    try {
      isLoadingHotPeople.value = true;
      await getFollowersDetailsForCurrentUser();
      RecommendedModel model = await RecommendedService.RecommendedUser();

      if (model.statusCode == Constants.successCode200) {
        hotUserList.value = model.data?.hotUsersArray ?? [];
        recommendedUsers.value = model.data?.recommendedUsersArray ?? [];


        for(int i=0; i<recommendedUsers.length; i++){
          int index = currentUserFollowerList.value.indexWhere((note) {
            return (note.follower?.id ?? '') == recommendedUsers[i].id;
          });

          if(index!=-1){
            recommendedUsers[i].isShowFollowYou=true;
          }
        }
      }
      return model;
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {
      isLoadingHotPeople.value = false;
    }
    return RecommendedModel();
  }

  Future<FollowUsersModel> getFollowersDetails(String? id) async {
    try {
     // await getFollowersDetailsForCurrentUser();


      Map<String, dynamic> body = {
        "userId": id,
      };
      isLoadingFollowerUser.value=true;
      FollowUsersModel model = await FollowUsersService.FollowUsersDetails(body: body);

      if (model.statusCode == Constants.successCode200) {
        followingList.value=model.data?.followingArray ?? [];
        followerList.value=model.data?.followersArray ?? [];
      }
      return model;
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {
      isLoadingFollowerUser.value=false;
    }
    return FollowUsersModel();
  }




  Future getFollowersDetailsForCurrentUser() async {
    followerList.value = [];
    followingList.value = [];

    try {
      Map<String, dynamic> body = {
        "userId": userId,
      };
      isLoadingFollowerUser.value=true;
      FollowUsersModel model = await FollowUsersService.FollowUsersDetails(body: body);
      if (model.statusCode == Constants.successCode200) {
        currentUserFollowingList.value = model.data?.followingArray ?? [];
        currentUserFollowerList.value = model.data?.followersArray ?? [];
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {
    }
  }



  Future<FriendModel> searchFriendApiCall(
      {required Map<String, dynamic> body}) async {
    try {
      isLoadRunning.value = true;
      FriendModel model = await FindFriendsService.searchFriend(body: body);
      if (model.statusCode == Constants.successCode200) {
        userList.addAll(model.data?.userArray ?? []);
        totalLength.value = model.data?.count ?? 0;

        print('=============->${totalLength.value}');
      }
      return model;
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {
      isLoadRunning.value = false;
      isFirstTimeSearch.value = false;
    }
    return FriendModel();
  }

  Future FollowApi(int index, String userID) async {
    try {
      Map<String, dynamic> body = {
        "userId": userID,
      };
      SuccessModel model = await UserProfileService.follow(body);
      if (model.statusCode == Constants.successCode201) {
        recommendedUsers.removeAt(index);
        recommendedUsers.refresh();
        bmiSliderController.getUserInfo();
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    }
  }

  Future hotFollowApi(int index, String userID) async {
    try {
      Map<String, dynamic> body = {
        "userId": userID,
      };
      SuccessModel model = await UserProfileService.follow(body);
      if (model.statusCode == Constants.successCode201) {
        hotUserList.removeAt(index);
        hotUserList.refresh();
        bmiSliderController.getUserInfo();
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    }
  }



  Future follow({required String userId, required int index,int? screenCode}) async {
    try {
      AppLoader(Get.context!);
      Map<String, dynamic> body = {"userId": userId};

      SuccessModel model = await UserProfileService.follow(body);
      if (model.statusCode == Constants.successCode201) {
        if(screenCode==Constants.isFollowerScreen){
          followerList[index].isFollowing=true;
          followerList.refresh();
        }else if(screenCode==Constants.isFollowingScreen){
          followingList[index].isFollowing=true;
          followingList.refresh();
        }else if(screenCode==Constants.isSearchUserScreen){
          userList[index].isFollowing = true;
          userList.refresh();
        }
        bmiSliderController.userModel.value.data?.followingCount=(bmiSliderController.userModel.value.data?.followingCount ?? 0)+1;
        bmiSliderController.userModel.refresh();
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {
      RemoveAppLoader();
    }
  }

  Future unFollow({required String userId, required int index,int? screenCode}) async {
    try {
      AppLoader(Get.context!);
      Map<String, dynamic> body = {"userId": userId};
      SuccessModel model = await UserProfileService.unFollow(body);
      if (model.statusCode == Constants.successCode200) {
        if(screenCode==Constants.isFollowerScreen){
          followerList[index].isFollowing=false;
          followerList.refresh();
        }else if(screenCode==Constants.isFollowingScreen){
          followingList[index].isFollowing=false;
          followingList.refresh();
        }else if(screenCode==Constants.isSearchUserScreen){
          userList[index].isFollowing = false;
          userList.refresh();
        }
        bmiSliderController.userModel.value.data?.followingCount=(bmiSliderController.userModel.value.data?.followingCount ?? 0)-1;
        bmiSliderController.userModel.refresh();
      }
    } catch (e, st) {
      log("UnFollow Error Message: $e : $st");
    } finally {
      RemoveAppLoader();
    }
  }
}
