import 'dart:developer';
import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/new%20ui/modules/app_setting/model/success_model.dart';
import 'package:finutss/new%20ui/modules/invite_friends/service/invite_friend_service.dart';
import 'package:finutss/new%20ui/modules/social/model/follow_users_model.dart';
import 'package:finutss/new%20ui/modules/social/service/follow_users_service.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/widget/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InviteFriendController extends GetxController {
  ScrollController scrollControllerFollowing = ScrollController();
  RxInt limitFollowing = 10.obs;
  RxInt offsetFollowing = 0.obs;

  RxBool isLoadingUser=false.obs;
  FollowUsersModel? followModel;
  RxBool isFirstLoadingFollowing=true.obs;
  List<FollowingArray> followingList = [];
  List<FollowersArray> followerList = [];
  RxList<FollowersArray> inviteFriendList = RxList([]);

  int offsetAll=10;
  String userId='';


  @override
  void onInit() {
    super.onInit();
    getUserId();
    scrollControllerFollowing.addListener(paginationFollowing);
  }

  clear(){
    followingList=[];
    followerList=[];
    inviteFriendList.value=[];
    offsetFollowing.value=0;
    isFirstLoadingFollowing.value=true;
  }

  Future<void> getUserId() async {
    userId = await SharedPrefs.getUserId();
  }

  void paginationFollowing() {
   /* if (scrollControllerFollowing.position.pixels == scrollControllerFollowing.position.maxScrollExtent && followingList.length < (followModel?.data?.followingCount ?? 0)) {
      limitFollowing.value = 10;
      offsetFollowing.value = 0;
      offsetFollowing.value = offsetFollowing.value + offsetAll;
      getFollowing(userId);
    }*/
  }




  Future getFollowing(String? id) async {
    try {
      Map<String, dynamic> body = {
        "userId": id,
       /* "limit": limitFollowing.value,
        "offset": offsetFollowing.value*/
      };
      isLoadingUser.value=true;
      followModel = await FollowUsersService.FollowUsersDetails(body: body);

      if (followModel?.statusCode == Constants.successCode200) {
        followingList.addAll(followModel?.data?.followingArray ?? []);
        followerList.addAll(followModel?.data?.followersArray ?? []);


        for(int i=0; i<followerList.length; i++){

          int myItem = followingList
              .indexWhere((element) => element.followed?.id == followerList[i].follower?.id);

          print('------item--->${myItem}');
          if(myItem!=-1){
            inviteFriendList.add(followerList[i]);
          }
        }

        print('------item- length-->${inviteFriendList.length}');
        inviteFriendList.refresh();
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {
      isFirstLoadingFollowing.value=false;
      isLoadingUser.value=false;
    }
  }




  Future sentInvite({required String userId,required int index,required String trackId}) async {
    try {
      AppLoader(Get.context!);
      Map<String, dynamic> body = {
        "trackId": trackId,
        "userId": userId,
      };

      print('------call ----4--->${body.toString()}');
      SuccessModel model = await InviteFriendService.sentInvitation(body: body);

      print('------call ----3--->${model.statusCode}');
      if (model.statusCode == Constants.successCode200) {
        inviteFriendList[index].isInvite=true;
        inviteFriendList.refresh();
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {
      RemoveAppLoader();
    }
  }


}
