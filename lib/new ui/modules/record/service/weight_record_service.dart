import 'dart:developer';

import 'package:finutss/helper/network_helper.dart';
import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/new%20ui/modules/record/model/bmi_model.dart';
import 'package:finutss/new%20ui/modules/record/model/body_record_model.dart';
import 'package:finutss/new%20ui/modules/record/model/workout_status_model.dart';
import 'package:finutss/new%20ui/utils/api_constant.dart';

class WeightRecordService {
  static final NetworkAPICall _networkAPICall = NetworkAPICall();

  static Future<WeightRecordModel> weightRecordData(
      {Map<String, dynamic>? body}) async {
    try {
      final request = await _networkAPICall.get(
        ApiConstants.GetBodyRecord,
        header: {
          "Authorization": await SharedPrefs.getToken(),
        },
      );
      if (request != null) {
        return WeightRecordModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {}
    return WeightRecordModel();
  }


  static Future<BMIModel> getBMI() async {
    try {
      final request = await _networkAPICall.get(
        ApiConstants.getBmi,
        header: {
          "Authorization": await SharedPrefs.getToken(),
        },
      );
      if (request != null) {
        return BMIModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {}
    return BMIModel();
  }


  static Future<WeightRecordModel> deleteWeightRecordData(String id) async {
    try {
      final request =
          await _networkAPICall.delete(ApiConstants.DeleteBodyRecord+id, header: {
        "Authorization": await SharedPrefs.getToken(),
      });
      if (request != null) {
        return WeightRecordModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {}
    return WeightRecordModel();
  }



  static Future<WorkoutStatusModel> workoutStatus(Map<String, dynamic> body) async {
    try {
      final request = await _networkAPICall.get(
        ApiConstants.workoutStatus+ApiConstants.getParamsFromBody(body),
        header: {
          "Authorization": await SharedPrefs.getToken(),
        },
      );
      if (request != null) {
        return WorkoutStatusModel.fromJson(request);
      }
    } catch (e) {
      log("Discover log In Api Error $e");
      rethrow;
    } finally {}
    return WorkoutStatusModel();
  }
}
