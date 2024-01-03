import 'dart:developer';

import 'package:finutss/new%20ui/modules/app_setting/model/success_model.dart';
import 'package:finutss/new%20ui/modules/record/controller/bmi_slider_controller.dart';
import 'package:finutss/new%20ui/modules/social/model/follow_users_model.dart';
import 'package:finutss/new%20ui/modules/social/service/follow_users_service.dart';
import 'package:finutss/new%20ui/modules/user_profile/service/user_profile_service.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/widget/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowingFollowersController extends GetxController{
  RxBool isLoadingUser=false.obs;
  RxBool isFirstLoadingFollowers=true.obs;
  RxBool isFirstLoadingFollowing=true.obs;
  RxList<FollowingArray> followingList = RxList([]);
  RxList<FollowersArray> followerList = RxList([]);

  ScrollController scrollControllerFollowers = ScrollController();
  RxInt limitFollowers = 10.obs;
  RxInt offsetFollowers = 0.obs;
  String userId='';

  ScrollController scrollControllerFollowing = ScrollController();
  RxInt limitFollowing = 10.obs;
  RxInt offsetFollowing = 0.obs;

  FollowUsersModel? followModel;

  BmiSliderController bmiSliderController=Get.find();

  int offsetAll=10;


  @override
  void onInit() {
    super.onInit();
    scrollControllerFollowers.addListener(paginationFollowers);
    scrollControllerFollowing.addListener(paginationFollowing);
  }


  clear(){
    followingList.value=[];
    followerList.value=[];
    offsetFollowers.value=0;
    offsetFollowing.value=0;
    isFirstLoadingFollowing.value=true;
    isFirstLoadingFollowers.value=true;
  }

  void paginationFollowers() {
    if (scrollControllerFollowers.position.pixels == scrollControllerFollowers.position.maxScrollExtent && followerList.length < (followModel?.data?.followersCount ?? 0)) {
      limitFollowers.value = limitFollowers.value;
      offsetFollowers.value = offsetFollowers.value + offsetAll;
      getFollowers(userId);
    }
  }

  void paginationFollowing() {
    if (scrollControllerFollowing.position.pixels == scrollControllerFollowing.position.maxScrollExtent && followingList.length < (followModel?.data?.followingCount ?? 0)) {
      limitFollowing.value = 10;
      offsetFollowing.value = offsetFollowing.value + offsetAll;
      getFollowing(userId);
    }
  }


  Future getFollowers(String? id) async {
    try {
      Map<String, dynamic> body = {
        "userId": id,
        "limit": limitFollowers.value,
        "offset": offsetFollowers.value
      };
      isLoadingUser.value=true;
      followModel = await FollowUsersService.FollowUsersDetails(body: body);

      if (followModel?.statusCode == Constants.successCode200) {
        followerList.addAll(followModel?.data?.followersArray ?? []);
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {
      isFirstLoadingFollowers.value=false;
      isLoadingUser.value=false;
    }
  }


  Future getFollowing(String? id) async {
    try {
      Map<String, dynamic> body = {
        "userId": id,
        "limit": limitFollowing.value,
        "offset": offsetFollowing.value
      };
      isLoadingUser.value=true;
      followModel = await FollowUsersService.FollowUsersDetails(body: body);

      if (followModel?.statusCode == Constants.successCode200) {
        followingList.addAll(followModel?.data?.followingArray ?? []);
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {
      isFirstLoadingFollowing.value=false;
      isLoadingUser.value=false;
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
        }else if(screenCode==Constants.isCurrentUser){
          followingList.removeAt(index);
          followingList.refresh();
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