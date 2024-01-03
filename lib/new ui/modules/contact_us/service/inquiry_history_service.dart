import 'dart:developer';

import 'package:finutss/helper/network_helper.dart';
import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/new%20ui/modules/app_setting/model/success_model.dart';
import 'package:finutss/new%20ui/modules/contact_us/model/inquiry_history_model.dart';
import 'package:finutss/new%20ui/modules/contact_us/model/inquiry_model.dart';
import 'package:finutss/new%20ui/utils/api_constant.dart';

class InquiryService {
  static final NetworkAPICall _networkAPICall = NetworkAPICall();

  static Future<InquiryHistoryModel> getInquiryHistory() async {
    try {
      final request =
          await _networkAPICall.get(ApiConstants.getInquiryHistory, header: {
        "Authorization": await SharedPrefs.getToken(),
      });
      if (request != null) {
        return InquiryHistoryModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {
      //loader end
    }
    return InquiryHistoryModel();
  }


  static Future<SuccessModel> updateInquiryHistory(
      {required Map<String, dynamic> body, required String id}) async {
    try {
      final request = await _networkAPICall
          .put(ApiConstants.putInquiryHistory + id, body, header: {
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

  static Future<InquiryModel> postInquiry({required Map<String, dynamic> body}) async {
    try {
      final request = await _networkAPICall
          .post(ApiConstants.postInquiryHistory, body, header: {
        "Authorization": await SharedPrefs.getToken(),
      });
      if (request != null) {
        return InquiryModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {
      //loader end
    }
    return InquiryModel();
  }
}
