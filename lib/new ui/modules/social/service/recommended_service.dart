import 'dart:developer';

import 'package:finutss/helper/network_helper.dart';
import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/new%20ui/modules/social/model/recommended_Model.dart';
import 'package:finutss/new%20ui/utils/api_constant.dart';

class RecommendedService {
  static final NetworkAPICall _networkAPICall = NetworkAPICall();

  static Future<RecommendedModel> RecommendedUser(
      {Map<String, dynamic>? body}) async {
    try {
      final request = await _networkAPICall.get(
        ApiConstants.recommendedUser,
        header: {
          "Authorization": await SharedPrefs.getToken(),
        },
      );
      if (request != null) {
        return RecommendedModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {}
    return RecommendedModel();
  }
}
