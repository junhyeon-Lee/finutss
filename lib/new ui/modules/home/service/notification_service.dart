import 'dart:developer';

import 'package:finutss/helper/network_helper.dart';
import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/new%20ui/modules/home/model/notification_model.dart';
import 'package:finutss/new%20ui/utils/api_constant.dart';

class NotificationService {
  static final NetworkAPICall _networkAPICall = NetworkAPICall();

  static Future<NotificationModel> getNotification() async {
    try {
      final request = await _networkAPICall.get(
        ApiConstants.notification,
        header: {
          "Authorization": await SharedPrefs.getToken(),
        },
      );
      if (request != null) {
        return NotificationModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {}
    return NotificationModel();
  }
}
