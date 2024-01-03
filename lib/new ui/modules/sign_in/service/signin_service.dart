import 'dart:developer';

import 'package:finutss/helper/network_helper.dart';
import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/new%20ui/modules/app_setting/model/success_model.dart';
import 'package:finutss/new%20ui/modules/sign_in/model/login_model.dart';
import 'package:finutss/new%20ui/modules/sign_in/model/verification_model.dart';
import 'package:finutss/new%20ui/utils/api_constant.dart';
import 'package:finutss/new%20ui/utils/log_utils.dart';

class SignInService {
  static final NetworkAPICall _networkAPICall = NetworkAPICall();

  static Future<LoginModel> logIn({required Map<String, dynamic> body}) async {
    try {
      LogUtils.logMSG(
          'SignInService  logIn-------->body::$body,', StackTrace.empty);
  print(
          'SignInService  logIn-------->body::$body,');
      final request = await _networkAPICall.post(ApiConstants.logIn, body);

      if (request != null) {
        print(
            'SignInService  logIn-------->response::$request,');
        return LoginModel.fromJson(request);
      }
    } catch (e) {
      print(
          'SignInService  logIn-------->error::$e,');
      log("Discover log In Api Error $e");
      rethrow;
    } finally {
      //loader end
    }
    return LoginModel();
  }

  static Future<LoginModel> logout({required Map<String, dynamic> body}) async {
    try {
      final request =
          await _networkAPICall.post(ApiConstants.logOut, body, header: {
        "Authorization": await SharedPrefs.getToken(),
      });
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

  static Future<LoginModel> changePassword(
      {required Map<String, dynamic> body}) async {
    try {
      final request =
          await _networkAPICall.put(ApiConstants.changePassword, body, header: {
        "Authorization": await SharedPrefs.getToken(),
      });
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

  static Future<VerificationModel> verification(
      {required Map<String, dynamic> body}) async {
    try {
      final request =
          await _networkAPICall.post(ApiConstants.verification, body, header: {
        "Authorization": await SharedPrefs.getToken(),
      });
      if (request != null) {
        return VerificationModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {
      //loader end
    }
    return VerificationModel();
  }


  static Future<SuccessModel> resendOTP() async {
    try {
      Map<String, dynamic> body={};
      final request =
      await _networkAPICall.post(ApiConstants.resendOtp, body, header: {
        "Authorization": await SharedPrefs.getToken(),
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
