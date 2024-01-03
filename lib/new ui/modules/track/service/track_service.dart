import 'dart:convert';
import 'dart:developer';

import 'package:finutss/helper/network_helper.dart';
import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/new%20ui/modules/app_setting/model/success_model.dart';
import 'package:finutss/new%20ui/modules/channel_track/model/channel_model.dart';
import 'package:finutss/new%20ui/modules/home/model/home_model.dart';
import 'package:finutss/new%20ui/modules/home/model/slider_model.dart';
import 'package:finutss/new%20ui/modules/track/model/trackAnalysisModel.dart';
import 'package:finutss/new%20ui/modules/track/model/track_detail_model.dart';
import 'package:finutss/new%20ui/utils/api_constant.dart';
import 'package:http/http.dart' as http;

class TrackService {
  static final NetworkAPICall _networkAPICall = NetworkAPICall();

  static Future<SliderModel> getBanner() async {
    try {
      final request =
          await http.get(Uri.parse(ApiConstants.dashboardImage));
      if (request != null) {
        return SliderModel.fromJson(jsonDecode(request.body));
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {}
    return SliderModel();
  }

  static Future<HomeModel> getDailyTrack() async {
    try {
      print("getDailyTrack---------->token::${await SharedPrefs.getToken()}");
      final request = await _networkAPICall.get(
        ApiConstants.dashboard,
        header: {
          "Authorization": await SharedPrefs.getToken(),
        },
      );
      print("getDailyTrack---------->request::$request");
      if (request != null) {
        return HomeModel.fromJson(request);
      }
    } catch (e,st) {
      print("Discover log In Api Error getDailyTrack $e---------->$st");
      rethrow;
    } finally {}
    return HomeModel();
  }

  static Future<TrackDetailModel> getTrackDetail(
      {required String trackId}) async {
    try {
      final request = await _networkAPICall.get(
        ApiConstants.track + trackId + "/info",
        header: {
          "Authorization": await SharedPrefs.getToken(),
        },
      );
      if (request != null) {
        return TrackDetailModel.fromJson(request);
      }
    } catch (e,st) {
      log("Discover log In Api Error $e $st");
      rethrow;
    } finally {}
    return TrackDetailModel();
  }

  static Future<TrackAnalysisModel> getPopularLatestTrack(
      {required Map<String, dynamic> body}) async {
    try {
      final request = await _networkAPICall.get(
        ApiConstants.trackListing + ApiConstants.getParamsFromBody(body),
        header: {
          "Authorization": await SharedPrefs.getToken(),
        },
      );
      if (request != null) {
        return TrackAnalysisModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {}
    return TrackAnalysisModel();
  }

  static Future<TrackAnalysisModel> getRecommendedTrack() async {
    try {
      final request = await _networkAPICall.get(
        ApiConstants.recommendedTrack,
        header: {
          "Authorization": await SharedPrefs.getToken(),
        },
      );
      if (request != null) {
        return TrackAnalysisModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {}
    return TrackAnalysisModel();
  }

  static Future<SuccessModel> setLikeUnlike(
      {required Map<String, dynamic> body}) async {
    try {
      final request = await _networkAPICall.post(
        ApiConstants.reaction,
        body,
        header: {
          "Authorization": await SharedPrefs.getToken(),
        },
      );
      if (request != null) {
        return SuccessModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {}
    return SuccessModel();
  }


  static Future<ChannelModel> getChannelInfo(
      {required String channelId}) async {
    try {
      final request = await _networkAPICall.get(
        ApiConstants.channelInfo + channelId,
        header: {
          "Authorization": await SharedPrefs.getToken(),
        },
      );
      if (request != null) {
        return ChannelModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {}
    return ChannelModel();
  }
}
