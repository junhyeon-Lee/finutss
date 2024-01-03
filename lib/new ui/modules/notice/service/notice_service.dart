import 'dart:developer';

import 'package:finutss/helper/network_helper.dart';
import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/new%20ui/modules/notice/model/notice_model.dart';
import 'package:finutss/new%20ui/utils/api_constant.dart';

class NoticeService{
  static final NetworkAPICall _networkAPICall = NetworkAPICall();

  static Future<NoticeModel> getNotice({required Map<String, dynamic> body}) async {
    try {
      final request = await _networkAPICall.get(ApiConstants.getNotice+ApiConstants.getParamsFromBody(body), header: {
        "Authorization" :  await SharedPrefs.getToken(),
      });
      if (request != null) {
        return NoticeModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {
      //loader end
    }
    return NoticeModel();
  }
}