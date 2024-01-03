import 'dart:developer';

import 'package:finutss/helper/network_helper.dart';
import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/new%20ui/modules/social/model/follow_users_model.dart';
import 'package:finutss/new%20ui/utils/api_constant.dart';

class FollowUsersService {
  static final NetworkAPICall _networkAPICall = NetworkAPICall();

  static Future<FollowUsersModel> FollowUsersDetails(
      {Map<String, dynamic>? body}) async {
    try {
      final request = await _networkAPICall.get(
        ApiConstants.followDetails + ApiConstants.getParamsFromBody(body),
        header: {
          "Authorization": await SharedPrefs.getToken(),
        },
      );
      if (request != null) {
        return FollowUsersModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {}
    return FollowUsersModel();
  }
}
