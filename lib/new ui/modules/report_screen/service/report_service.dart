import 'dart:developer';
import 'package:finutss/helper/network_helper.dart';
import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/new%20ui/modules/report_screen/model/report_model.dart';
import 'package:finutss/new%20ui/utils/api_constant.dart';

class ReportService {
  static final NetworkAPICall _networkAPICall = NetworkAPICall();

  static Future<ReportModel> reportUser(
      {required Map<String, dynamic> body}) async {
    try {
      final request = await _networkAPICall.post(
        ApiConstants.report,
        body,
        header: {
          "Authorization": await SharedPrefs.getToken(),
        },
      );
      if (request != null) {
        return ReportModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {}
    return ReportModel();
  }
}
