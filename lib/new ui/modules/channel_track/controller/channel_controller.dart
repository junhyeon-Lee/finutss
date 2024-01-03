import 'dart:developer';

import 'package:finutss/new%20ui/modules/app_setting/model/success_model.dart';
import 'package:finutss/new%20ui/modules/channel_track/model/channel_model.dart';
import 'package:finutss/new%20ui/modules/track/model/trackAnalysisModel.dart';
import 'package:finutss/new%20ui/modules/track/service/track_service.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChannelController extends GetxController {
  String currentChannelId = '';
  Rx<ChannelModel> channelModel = ChannelModel().obs;

  // Popular track
  ScrollController scrollControllerPopular = ScrollController();
  RxList<TracksArray> popularTrackList = RxList([]);
  int limitPopularTrack = 10;
  int offsetPopular = 0;
  int totalCountPopular = 0;

  // Latest Track
  ScrollController scrollControllerLatest = ScrollController();
  RxList<TracksArray> latestTrackList = RxList([]);
  int limitLatestTrack = 10;
  int offsetLatest = 0;
  int totalCountLatest = 0;

  @override
  void onInit() {
    scrollControllerLatest.addListener(paginationLatestTrack);
    scrollControllerPopular.addListener(paginationPopularTrack);
  }

  clearList() {
    popularTrackList.value = [];
    latestTrackList.value = [];
  }

  Future getChannelInfo() async {
    try {
      ChannelModel model = await TrackService.getChannelInfo(channelId: currentChannelId);

      if (model.statusCode == Constants.successCode200) {
        channelModel.value = model;
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {}
  }

  void paginationPopularTrack() {
    if (scrollControllerPopular.position.pixels == scrollControllerPopular.position.maxScrollExtent &&
        popularTrackList.value.length < totalCountPopular - 1) {
      limitPopularTrack = limitPopularTrack + 10;
      offsetPopular++;

      getPopularTrack();
    }
  }

  Future getPopularTrack() async {
    try {
      Map<String, dynamic> body = {
        /*  "limit": limitPopularTrack,
        "offset": offsetPopular,*/
        'channelId': currentChannelId,
        'sort': 'popular'
      };
      TrackAnalysisModel model = await TrackService.getPopularLatestTrack(body: body);

      if (model.statusCode == Constants.successCode200) {
        popularTrackList.value = model.data?.tracksArray ?? [];
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {}
  }

  void paginationLatestTrack() {
    if (scrollControllerLatest.position.pixels == scrollControllerLatest.position.maxScrollExtent &&
        latestTrackList.value.length < totalCountLatest - 1) {
      limitLatestTrack = limitLatestTrack + 10;
      offsetLatest++;

      getLatestTrack();
    }
  }

  Future getLatestTrack() async {
    try {
      Map<String, dynamic> body = {
        //  "limit": limitLatestTrack,
        //  "offset": offsetLatest,
        'channelId': currentChannelId,
        'sort': 'latest'
      };
      TrackAnalysisModel model = await TrackService.getPopularLatestTrack(body: body);

      if (model.statusCode == Constants.successCode200) {
        latestTrackList.value = model.data?.tracksArray ?? [];
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {}
  }

  Future likeUnlike({required String status, required String trackID, required int screenCode, int? index}) async {
    try {
      Map<String, dynamic> body = {
        "trackId": trackID,
        "type": status,
      };
      SuccessModel model = await TrackService.setLikeUnlike(body: body);
      if (model.statusCode == Constants.successCode200) {
        if (screenCode == Constants.channelPopularTrack) {
          if (popularTrackList[index!].isTrackLiked ?? false) {
            if (popularTrackList[index].totalReactionCount != 0) {
              popularTrackList[index].totalReactionCount = (popularTrackList[index].totalReactionCount ?? 0) - 1;
            }
          } else {
            popularTrackList[index].totalReactionCount = (popularTrackList[index].totalReactionCount ?? 0) + 1;
          }
          popularTrackList[index].isTrackLiked = !(popularTrackList[index].isTrackLiked ?? false);
          popularTrackList.refresh();
        } else if (screenCode == Constants.channelLatestTrack) {
          if (latestTrackList[index!].isTrackLiked ?? false) {
            if (latestTrackList[index].totalReactionCount != 0) {
              latestTrackList[index].totalReactionCount = (latestTrackList[index].totalReactionCount ?? 0) - 1;
            }
          } else {
            latestTrackList[index].totalReactionCount = (latestTrackList[index].totalReactionCount ?? 0) + 1;
          }
          latestTrackList[index].isTrackLiked = !(latestTrackList[index].isTrackLiked ?? false);
          latestTrackList.refresh();
        }
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {}
  }
}
