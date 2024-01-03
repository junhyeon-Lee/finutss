import 'dart:developer';

import 'package:finutss/helper/network_helper.dart';
import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/new%20ui/modules/live%20user/model/live_user_model.dart';
import 'package:finutss/new%20ui/utils/api_constant.dart';

class LiveUserService{
  static final NetworkAPICall _networkAPICall = NetworkAPICall();

  static Future<LiveUserModel> getLiveUser(
      {Map<String, dynamic>? body,required String trackId}) async {

    try {
      print("getLiveUser----URL::${ ApiConstants.updateRecord+trackId + ApiConstants.getParamsFromBody(body)}");
      final request = await _networkAPICall.get(
        ApiConstants.updateRecord+trackId + ApiConstants.getParamsFromBody(body),
        header: {
          "Authorization": await SharedPrefs.getToken(),
        },
      );
      if (request != null) {
        return LiveUserModel.fromJson(request);
      }
    } catch (e) {
      print("getLiveUser Discover log In Api Error $e");
      rethrow;
    } finally {}
    return LiveUserModel();
  }
}