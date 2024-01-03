
import 'dart:developer';

import 'package:finutss/helper/network_helper.dart';
import 'package:finutss/new%20ui/modules/sign_in/model/login_model.dart';
import 'package:finutss/new%20ui/utils/api_constant.dart';

class SignUpService {
  static final NetworkAPICall _networkAPICall = NetworkAPICall();

  static Future<LoginModel> signUp({required Map<String, dynamic> body}) async {
    try {
      final request = await _networkAPICall.post(ApiConstants.register, body);
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
