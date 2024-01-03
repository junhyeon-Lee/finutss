import 'package:finutss/data/data_service/lib_helper.dart';
import 'package:finutss/data/graphql_operation/queries/WorkOutQueries.dart';
import 'package:finutss/domain/bloc/bloc.dart';
import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/domain/controller/workout_record_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InitializeAppDataController extends GetxController {
  final authController = Get.put(AuthController());
  final workoutRecordController = Get.put(WorkoutRecordController());

  TextEditingController initializeTextController = new TextEditingController();
  bool isCheck = false;

  checkInitializeText() {
    if (initializeTextController.text == "INITIALIZE".tr) {
      isCheck = true;
    } else {
      isCheck = false;
    }
    update();
  }

  initializeAppData() {
    callApiRemoveAllWorkout();
    workoutRecordController.callApiMyRecordTotal(authController.user?.userId);
    workoutRecordController
        .callApiMyRecordWeekTotal(authController.user?.userId);
    workoutRecordController
        .callApiRecordDailyTotal(authController.user?.userId);
    workoutRecordController.callApiRecordByMonth();
  }

  callApiRemoveAllWorkout() {
    Map<String, dynamic> values = {};
    if (authController.user != null) {
      values["id"] = authController.user?.userId;
    }

    GlobalBloc()
        .queryMutate(WorkOutQueries.REMOVE_ALL_WORKOUT, values)
        .then((res) {
      print("result : REMOVE_ALL_WORKOUT");
      if (!res["success"]) {
        return LocalDB.snackbar("Error", res["message"]);
      }
      update();
    });
  }
}
