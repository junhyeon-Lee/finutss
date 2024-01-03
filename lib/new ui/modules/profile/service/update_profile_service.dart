
import 'dart:developer';

import 'package:finutss/helper/network_helper.dart';
import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/new%20ui/modules/sign_in/model/login_model.dart';
import 'package:finutss/new%20ui/utils/api_constant.dart';

class UpdateProfileService {
  static final NetworkAPICall _networkAPICall = NetworkAPICall();

  static Future<LoginModel> updateProfile({required Map<String, dynamic> body,bool? isDecode}) async {
    try {
      final request = await _networkAPICall.put(ApiConstants.editProfile, body,header: {
      "Authorization" :  await SharedPrefs.getToken(),
      },isDecode: isDecode);
      if (request != null) {
        return LoginModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {
      //loader end
    }
    return LoginModel();
  }
}