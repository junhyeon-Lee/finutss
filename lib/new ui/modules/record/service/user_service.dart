import 'dart:developer';

import 'package:finutss/helper/network_helper.dart';
import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/new%20ui/modules/sign_in/model/get_time_zone_model.dart';
import 'package:finutss/new%20ui/modules/sign_in/model/login_model.dart';
import 'package:finutss/new%20ui/utils/api_constant.dart';

class UserService {
  static final NetworkAPICall _networkAPICall = NetworkAPICall();

  static Future<LoginModel> getUserInfo() async {
    try {
      String timezone = "Asia/Seoul";
      timezone = await SharedPrefs.getTimeZone();
      final request = await _networkAPICall.get(
        ApiConstants.getUserInfo + "?timezone=$timezone",
        header: {
          "Authorization": await SharedPrefs.getToken(),
        },
      );
      print("getUserInfo Url ---->${ApiConstants.getUserInfo + "?timezone=${timezone}"}");
      log("getUserInfo Discover log In Api ${request}");
      if (request != null) {
        return LoginModel.fromJson(request);
      }
    } catch (e, st) {
      log("getUserInfo Discover log In Api Error $e --- $st");
      rethrow;
    } finally {
      //loader end
    }
    return LoginModel();
  }

  static Future<GetTimeZoneModel> getTimeZone() async {
    try {
      final request = await _networkAPICall.getWithOutBaseURl(ApiConstants.getTimeZone, header: {});
      print("getTimeZone Api ${(request).toString()}");

      if (request != null) {
        print("getTimeZone Api ${GetTimeZoneModel.fromJson(request).toString()}");
        return GetTimeZoneModel.fromJson(request);
      }
    } catch (e, st) {
      print("getTimeZone Api Error $e --- $st");
      rethrow;
    } finally {
      //loader end
    }
    return GetTimeZoneModel();
  }
}
