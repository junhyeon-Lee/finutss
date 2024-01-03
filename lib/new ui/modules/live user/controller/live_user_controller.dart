import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/new%20ui/modules/app_setting/model/success_model.dart';
import 'package:finutss/new%20ui/modules/live%20user/model/live_user_model.dart';
import 'package:finutss/new%20ui/modules/live%20user/service/live_user_service.dart';
import 'package:finutss/new%20ui/modules/record/controller/bmi_slider_controller.dart';
import 'package:finutss/new%20ui/modules/user_profile/controller/controller.dart';
import 'package:finutss/new%20ui/modules/user_profile/service/user_profile_service.dart';
import 'package:finutss/new%20ui/utils/api_constant.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/widget/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/io_client.dart';

class LiveUserController extends GetxController {
  RxList<RecordsArray> liveUserList = RxList([]);
  List<RecordsArray> liveUserTempList = [];
  TextEditingController searchController = TextEditingController();
  RxBool isSearchEnable = false.obs;
  String? userId;
  String? currentTrackId = '';

  @override
  void onInit() {
    super.onInit();
    getUserId();
  }

  Future<void> getUserId() async {
    userId = await SharedPrefs.getUserId();
  }

  Future getLiveUser(String trackId) async {
    try {
      Map<String, dynamic> body = {
        "status": 'processing',
      };
      LiveUserModel model = await LiveUserService.getLiveUser(trackId: trackId, body: body);
      print("getLiveUser ======= ${model.data} -------- ${model.statusCode} ");
      if (model.statusCode == Constants.successCode200) {
        liveUserList.value = [];
        liveUserTempList = [];
        List<RecordsArray> userList = model.data?.recordsArray ?? [];

        for (int i = 0; i < userList.length; i++) {
          if (i == 0) {
            int index1 = userList.indexWhere((note) {
              return (note.user?.id ?? '') == (userId ?? '');
            });
            if (index1 != -1) {
              liveUserTempList.add(userList[index1]);
            }
          }

          int index = liveUserTempList.indexWhere((note) {
            return (note.user?.id ?? '') == (userList[i].user?.id ?? '');
          });

          if (index == -1) {
            liveUserTempList.add(userList[i]);
          }
        }

        liveUserList.value = liveUserTempList;
      }
      return model;
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {}
  }

  searchUser(String name) {
    if (name.isEmpty) {
      liveUserList.value = liveUserTempList;
      isSearchEnable.value = false;
    } else {
      liveUserList.value =
          liveUserTempList.where((user) => (user.user?.username ?? '').toString().toLowerCase().contains(name.toString().toLowerCase())).toList();
      isSearchEnable.value = true;
    }
  }

  static IOClient get httpClient {
    HttpClient httpClient = HttpClient()..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = IOClient(httpClient);
    return ioClient;
  }

  Future follow({required String userId, required int index, required int type}) async {
    try {
      AppLoader(Get.context!);
      Map<String, dynamic> body = {"userId": userId};

      final response = await httpClient.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.follow),
        headers: {
          "Authorization": await SharedPrefs.getToken(),
        },
        body: body,
      );
      if (response.statusCode == 201) {
        SuccessModel model = SuccessModel.fromJson(jsonDecode(response.body));
        if (model.statusCode == Constants.successCode201) {
          if (type == Constants.isLiveUser) {
            liveUserList[index].user?.isFollowing = true;
            liveUserList.refresh();
          } else if (type == Constants.isFollowDialog) {
            userProfileController controller = Get.find();
            BmiSliderController bmiSliderController = Get.find();
            controller.userArray.value.isFollowing = true;
            controller.userArray.refresh();

            if (controller.userArray.value.historyDisclosure.toString().toLowerCase() == 'all' ||
                controller.userArray.value.historyDisclosure.toString().toLowerCase() == 'friends') {
              controller.isShowRecord.value = true;
            } else {
              controller.isShowRecord.value = false;
            }
            bmiSliderController.userModel.value.data?.followingCount = (bmiSliderController.userModel.value.data?.followingCount ?? 0) + 1;
            bmiSliderController.userModel.refresh();

            liveUserList[index].user?.isFollowing = true;
            liveUserList.refresh();
          }
        }
      } else {}
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {
      RemoveAppLoader();
    }
  }

  Future unFollow({required String userId, required int index, required int type}) async {
    try {
      AppLoader(Get.context!);
      Map<String, dynamic> body = {"userId": userId};
      SuccessModel model = await UserProfileService.unFollow(body);
      if (model.statusCode == Constants.successCode200) {
        if (type == Constants.isLiveUser) {
          liveUserList[index].user?.isFollowing = false;
          liveUserList.refresh();
        } else if (type == Constants.isFollowDialog) {
          userProfileController controller = Get.find();
          BmiSliderController bmiSliderController = Get.find();
          controller.userArray.value.isFollowing = false;
          controller.userArray.refresh();

          if (controller.userArray.value.historyDisclosure.toString().toLowerCase() == 'all') {
            controller.isShowRecord.value = true;
          } else {
            controller.isShowRecord.value = false;
          }
          bmiSliderController.userModel.value.data?.followingCount = (bmiSliderController.userModel.value.data?.followingCount ?? 0) - 1;
          bmiSliderController.userModel.refresh();

          liveUserList[index].user?.isFollowing = false;
          liveUserList.refresh();
        }
      }
    } catch (e, st) {
      log("UnFollow Error Message: $e : $st");
    } finally {
      RemoveAppLoader();
    }
  }
}
