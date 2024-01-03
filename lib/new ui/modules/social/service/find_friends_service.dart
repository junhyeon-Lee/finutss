import 'dart:developer';

import 'package:finutss/helper/network_helper.dart';
import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/new%20ui/modules/social/model/friends_model.dart';
import 'package:finutss/new%20ui/utils/api_constant.dart';

class FindFriendsService {
  static final NetworkAPICall _networkAPICall = NetworkAPICall();

  static Future<FriendModel> searchFriend(
      {required Map<String, dynamic> body}) async {
    try {
      final request = await _networkAPICall.get(
        ApiConstants.searchFriend + ApiConstants.getParamsFromBody(body),
        header: {
          "Authorization": await SharedPrefs.getToken(),
        },
      );
      if (request != null) {
        return FriendModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {
      //loader end
    }
    return FriendModel();
  }



  static Future<FriendModel> getUserById(
      {required Map<String, dynamic> body}) async {
    try {
      final request = await _networkAPICall.get(
        ApiConstants.getUserById + ApiConstants.getParamsFromBody(body),
        header: {
          "Authorization": await SharedPrefs.getToken(),
        },
      );
      if (request != null) {
        return FriendModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {
      //loader end
    }
    return FriendModel();
  }
}
