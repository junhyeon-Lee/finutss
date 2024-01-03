
import 'dart:developer';

import 'package:finutss/helper/network_helper.dart';
import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/new%20ui/modules/app_setting/model/success_model.dart';
import 'package:finutss/new%20ui/utils/api_constant.dart';

class WithdrawalService {
  static final NetworkAPICall _networkAPICall = NetworkAPICall();

  static Future<SuccessModel> withdrawal({required Map<String, dynamic> body}) async {
    try {
      final request = await _networkAPICall.post(ApiConstants.withdrawal,body, header: {
        "Authorization" :  await SharedPrefs.getToken(),
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
