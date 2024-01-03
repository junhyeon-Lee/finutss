
import 'dart:developer';

import 'package:finutss/helper/network_helper.dart';
import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/new%20ui/modules/app_setting/model/blackList_model.dart';
import 'package:finutss/new%20ui/modules/app_setting/model/success_model.dart';
import 'package:finutss/new%20ui/utils/api_constant.dart';

class BlackListService {
  static final NetworkAPICall _networkAPICall = NetworkAPICall();

  static Future<SuccessModel> addUserBlackList({required Map<String, dynamic> body}) async {
    try {
      print('--------call api blacklist--token---->${await SharedPrefs.getToken()}');
      final request = await _networkAPICall.post(ApiConstants.addUserBlackList,body, header: {
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


  static Future<BlackListModel> getBlackList({required Map<String, dynamic> body}) async {
    try {
      final request = await _networkAPICall.get(ApiConstants.addUserBlackList+ApiConstants.getParamsFromBody(body), header: {
        "Authorization" :  await SharedPrefs.getToken(),
      });

      if (request != null) {
        return BlackListModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {
      //loader end
    }
    return BlackListModel();
  }




  static Future<SuccessModel> removeUserBlackList({required String userId}) async {
    try {
      final request = await _networkAPICall.delete(ApiConstants.removeUserBlackList+userId,header: {
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
