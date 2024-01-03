import 'dart:developer';

import 'package:finutss/helper/network_helper.dart';
import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/new%20ui/modules/app_setting/model/success_model.dart';
import 'package:finutss/new%20ui/modules/history/model/history_record_model.dart';
import 'package:finutss/new%20ui/modules/record/model/today_record_model.dart';
import 'package:finutss/new%20ui/modules/record/model/workout_record_model.dart';
import 'package:finutss/new%20ui/utils/api_constant.dart';

class TodayRecordService {
  static final NetworkAPICall _networkAPICall = NetworkAPICall();

  static Future<TodayRecordModel> TodayRecordData(
      {Map<String, dynamic>? body}) async {

    try {
      final request = await _networkAPICall.get(
        ApiConstants.todayRecord + ApiConstants.getParamsFromBody(body),
        header: {
          "Authorization": await SharedPrefs.getToken(),
        },
      );
      if (request != null) {
        return TodayRecordModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {}
    return TodayRecordModel();
  }

  static Future<SuccessModel> updateRecord(
      {Map<String, dynamic>? body,required String recordId}) async {
    print("updateRecord----URL::${ApiConstants.updateRecord + recordId} token::${await SharedPrefs.getToken()}  body::$body"  );
    try {
      final request = await _networkAPICall.patch(
        ApiConstants.updateRecord + recordId,
        body: body,
        header: {
          "Authorization": await SharedPrefs.getToken(),
        },
      );
      print('JavascriptChannel Response-------->-updateRecord request-----> request:: ${request}');
      if (request != null) {
        return SuccessModel.fromJson(request);
      }
    } catch (e) {
      log("updateRecord Discover log In Api Error $e");
      rethrow;
    } finally {}
    return SuccessModel();
  }



  static Future<WorkoutRecordModel> createRecord(
      {Map<String, dynamic>? body}) async {

    try {
      final request = await _networkAPICall.post(
        ApiConstants.createRecord,
        body,
        header: {
          "Authorization": await SharedPrefs.getToken(),
        },
      );

      if (request != null) {
        return WorkoutRecordModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {}
    return WorkoutRecordModel();
  }



  static Future<HistoryRecordModel> GetRecordFromDate(
      {Map<String, dynamic>? body}) async {

    try {
      final request = await _networkAPICall.get(
        ApiConstants.getRecord + ApiConstants.getParamsFromBody(body),
        header: {
          "Authorization": await SharedPrefs.getToken(),
        },
      );
      if (request != null) {
        return HistoryRecordModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {}
    return HistoryRecordModel();
  }





}
