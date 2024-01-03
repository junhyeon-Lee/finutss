import 'package:finutss/helper/network_helper.dart';
import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/new%20ui/modules/app_setting/model/success_model.dart';
import 'package:finutss/new%20ui/utils/api_constant.dart';

class UserProfileService {
  static final NetworkAPICall _networkAPICall = NetworkAPICall();

  static Future<SuccessModel> follow(Map<String, dynamic> body) async {
    try {

      final request = await _networkAPICall.post(
        ApiConstants.follow,
        body,
        header: {
          "Authorization": await SharedPrefs.getToken(),
        },
      );

      if (request != null) {
        return SuccessModel.fromJson(request);
      }
    } catch (e) {
      rethrow;
    }
    return SuccessModel();
  }

  static Future<SuccessModel> unFollow(Map<String, dynamic> body) async {
    try {
      final request = await _networkAPICall.delete(
        ApiConstants.follow,
        body: body,
        header: {
          "Authorization": await SharedPrefs.getToken(),
        },
      );
      if (request != null) {
        return SuccessModel.fromJson(request);
      }
    } catch (e) {
      rethrow;
    }
    return SuccessModel();
  }
}
