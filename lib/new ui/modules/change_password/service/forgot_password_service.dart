import 'dart:developer';

import 'package:finutss/helper/network_helper.dart';
import 'package:finutss/new%20ui/modules/app_setting/model/success_model.dart';
import 'package:finutss/new%20ui/modules/sign_in/model/login_model.dart';
import 'package:finutss/new%20ui/utils/api_constant.dart';

class ForgotPasswordService {
  static final NetworkAPICall _networkAPICall = NetworkAPICall();

  static Future<LoginModel> forgotPassword({required Map<String, dynamic> body}) async {
    try {
      final request = await _networkAPICall.post(ApiConstants.forgotPassword, body);
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


  static Future<SuccessModel> createPassword({required Map<String, dynamic> body}) async {
    try {
      final request = await _networkAPICall.put(ApiConstants.createPassword, body);
      if (request != null) {
        return SuccessModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {
      //loader end
    }
    return SuccessModel();
  }



  static Future<SuccessModel> forgotPasswordWithOTP({required Map<String, dynamic> body}) async {
    try {
      final request = await _networkAPICall.post(ApiConstants.forgotPasswordWithOTP, body);

      if (request != null) {
        return SuccessModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {
      //loader end
    }
    return SuccessModel();
  }


  static Future<SuccessModel> verifyOTP({required Map<String, dynamic> body}) async {
    try {
      final request = await _networkAPICall.patch(ApiConstants.verifyOTP, body: body,header: {
        'accept' : '*/*'
      });

      if (request != null) {
        return SuccessModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {
      //loader end
    }
    return SuccessModel();
  }
}
