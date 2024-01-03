import 'dart:developer';

import 'package:finutss/helper/network_helper.dart';
import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/new%20ui/modules/app_setting/model/success_model.dart';
import 'package:finutss/new%20ui/modules/track/model/add_comment_model.dart';
import 'package:finutss/new%20ui/modules/track/model/commentModel.dart';
import 'package:finutss/new%20ui/utils/api_constant.dart';

class CommentService {
  static final NetworkAPICall _networkAPICall = NetworkAPICall();

  static Future<AddCommentModel> addComment(
      {required Map<String, dynamic> body}) async {
    try {
      final request = await _networkAPICall.post(ApiConstants.addComment, body,header: {
        "Authorization" :  await SharedPrefs.getToken(),
        'accept' : '*/*',
        'Content-Type' : 'multipart/form-data',
      });
      if (request != null) {
        return AddCommentModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {}
    return AddCommentModel();
  }


  static Future<CommentModel> getComment(
      {required Map<String, dynamic> body}) async {
    try {
      final request = await _networkAPICall.get(ApiConstants.addComment+ApiConstants.getParamsFromBody(body),header: {
        "Authorization" :  await SharedPrefs.getToken(),
      });
      if (request != null) {
        return CommentModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {}
    return CommentModel();
  }


  static Future<SuccessModel> reaction(
      {required Map<String, dynamic> body}) async {
    try {
      final request = await _networkAPICall.post(ApiConstants.reaction, body);
      if (request != null) {
        return SuccessModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {}
    return SuccessModel();
  }
}
