import 'dart:developer';
import 'package:finutss/helper/network_helper.dart';
import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/new%20ui/modules/sign_in/model/login_model.dart';
import 'package:finutss/new%20ui/utils/api_constant.dart';

class HistoryDisclosureService {
  static final NetworkAPICall _networkAPICall = NetworkAPICall();

  static Future<LoginModel> updateHistoryDisclosure(
      {required Map<String, dynamic> body}) async {
    try {
      final request =
          await _networkAPICall.put(ApiConstants.editProfile, body, header: {
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

}
