import 'dart:developer';

import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/new%20ui/modules/app_setting/controller/historyDisclosureController.dart';
import 'package:finutss/new%20ui/modules/app_setting/model/success_model.dart';
import 'package:finutss/new%20ui/modules/history/model/history_record_model.dart';
import 'package:finutss/new%20ui/modules/record/controller/bmi_slider_controller.dart';
import 'package:finutss/new%20ui/modules/record/model/workout_status_model.dart';
import 'package:finutss/new%20ui/modules/record/model/workout_status_model.dart' as Model;
import 'package:finutss/new%20ui/modules/record/service/today_record_service.dart';
import 'package:finutss/new%20ui/modules/record/service/weight_record_service.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/loader.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RecordController extends GetxController {
  RxString message = ''.obs;
  RxString successMessage = ''.obs;
  HistoryDisclosureController controller = Get.put(HistoryDisclosureController());
  Rx<WorkoutStatusModel> workoutModel = WorkoutStatusModel().obs;
  RxInt currentNumberOfDay = 0.obs;
  String? userId;

  RxList<RecordsArray> historyRecordList = RxList([]);
  RxList<String> stepList = RxList([]);
  List<String> dateList = [];
  Rx<DateTime> focusedDay = DateTime.now().obs;
  String? selectedDay;
  RxBool isLoading = false.obs;

  List<RecordsArray> todayRecordTempData = [];
  RxList<RecordsArray> todayRecordData = RxList([]);

  RxDouble totalKMRun = 0.0.obs;
  RxDouble totalMinRun = 0.0.obs;
  RxInt totalcalRun = 0.obs;
  RxDouble totalKMRide = 0.0.obs;
  RxDouble totalMinRide = 0.0.obs;
  RxInt totalcalRide = 0.obs;
  RxDouble totalKM = 0.0.obs;
  RxDouble totalMin = 0.0.obs;
  RxInt totalcal = 0.obs;

  RxString selectSensorMode = 'all'.obs;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  BmiSliderController bmiSliderController = Get.find();

  @override
  void onInit() {
    super.onInit();

    DateTime today = DateTime.now();
    currentNumberOfDay.value = today.weekday + 1;
    startDate = findFirstDateOfTheWeek(today);
    endDate = findLastDateOfTheWeek(today);
    calculateInterval(startDate, endDate);
  }

  calculateInterval(DateTime startDate, DateTime endDate) {
    dateList.clear();
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      DateTime dateTime = startDate.add(Duration(days: i));
      final DateFormat formatter = DateFormat('dd/MM/yyyy');
      final String formatted = formatter.format(dateTime);
      dateList.add(formatted);
    }
  }

  Future getUserID() async {
    userId = await SharedPrefs.getUserId();
  }

  DateTime findFirstDateOfTheWeek(DateTime dateTime) {
    return dateTime.subtract(Duration(days: dateTime.weekday));
  }

  DateTime findLastDateOfTheWeek(DateTime dateTime) {
    return dateTime.add(Duration(days: DateTime.daysPerWeek - dateTime.weekday - 1));
  }

  setRunRideRecord({required String selectType}) {
    todayRecordData.value = [];
    if (selectType == 'all') {
      todayRecordData.value = todayRecordTempData;
    } else {
      for (int a = 0; a < todayRecordTempData.length; a++) {
        if ((todayRecordTempData[a].type ?? '').toString().toLowerCase() == selectType) {
          todayRecordData.value.add(todayRecordTempData[a]);
        }
      }
    }
  }

  Future getTodayRecord() async {
    try {
      var now = new DateTime.now();
      var formatter = new DateFormat('yyyy-MM-dd');
      String todayDate = formatter.format(now);
      Map<String, dynamic> body = {
        "userId": userId,
        "startDate": todayDate + 'T00:00:00.000',
        "endDate": todayDate + 'T23:59:59.000',
      };
      HistoryRecordModel model = await TodayRecordService.GetRecordFromDate(body: body);
      totalcalRide.value = 0;
      totalKMRide.value = 0;
      totalMinRide.value = 0;
      totalcalRun.value = 0;
      totalKMRun.value = 0;
      totalMinRun.value = 0;
      totalcal.value = 0;
      totalKM.value = 0;
      totalMin.value = 0;

      if (model.statusCode == Constants.successCode200) {
        todayRecordTempData = model.data?.recordsArray ?? [];
        todayRecordData.value = todayRecordTempData;

        for (int i = 0; i < todayRecordTempData.length; i++) {
          if (todayRecordTempData[i].type.toString().toLowerCase() == 'ride') {
            totalcalRide.value = totalcalRide.value + int.parse(todayRecordTempData[i].burnedCal.toString());
            totalKMRide.value = totalKMRide.value + double.parse(todayRecordTempData[i].distanceInKm.toString());
            totalMinRide.value = totalMinRide.value + double.parse(todayRecordTempData[i].exerciseTimeInMin.toString());
          } else if (todayRecordTempData[i].type.toString().toLowerCase() == 'run') {
            totalcalRun.value = totalcalRun.value + int.parse(todayRecordTempData[i].burnedCal.toString());
            totalKMRun.value = totalKMRun.value + double.parse(todayRecordTempData[i].distanceInKm.toString());
            totalMinRun.value = totalMinRun.value + double.parse(todayRecordTempData[i].exerciseTimeInMin.toString());
          }

          totalcal.value = totalcal.value + int.parse(todayRecordTempData[i].burnedCal.toString());
          totalKM.value = totalKM.value + double.parse(todayRecordTempData[i].distanceInKm.toString());
          totalMin.value = totalMin.value + double.parse(todayRecordTempData[i].exerciseTimeInMin.toString());
        }
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {}
  }

  Future<WorkoutStatusModel> getWorkoutStatus() async {
    try {
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String formattedStartDate = formatter.format(startDate);
      final String formattedEndDate = formatter.format(endDate);
      Map<String, dynamic> body = {"startDate": formattedStartDate + 'T00:00:00.000', "endDate": formattedEndDate + 'T23:59:59.000'};

      WorkoutStatusModel model = await WeightRecordService.workoutStatus(body);

      if (model.statusCode == Constants.successCode200) {
        stepList.clear();
        stepList = RxList([]);
        workoutModel.value = model;

        List<Model.DailyStatus> dailyStatus = workoutModel.value.data?.dailyStatus ?? [];

        for (int i = 0; i < dateList.length; i++) {
          int selectIndex = dailyStatus.indexWhere((note) {
            return note.date == dateList[i].toString();
          });

          if (selectIndex == null || selectIndex == -1) {
            stepList.add("0");
          } else {
            stepList.add((dailyStatus[selectIndex].burntCaloriesCount ?? 0).toString());
          }
        }
      }
      return model;
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {}
    return WorkoutStatusModel();
  }

  Future<HistoryRecordModel> getRecordFromDate() async {
    try {
      Map<String, dynamic> body = {
        "userId": userId,
        "startDate": (selectedDay ?? '') + 'T00:00:00.000',
        "endDate": (selectedDay ?? '') + 'T23:59:59.000',
      };
      isLoading.value = true;
      HistoryRecordModel model = await TodayRecordService.GetRecordFromDate(body: body);

      if (model.statusCode == Constants.successCode200) {
        historyRecordList.value.clear();
        historyRecordList.value = model.data?.recordsArray ?? [];
      }
      return model;
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {
      isLoading.value = false;
    }
    return HistoryRecordModel();
  }

  Future<SuccessModel> deleteTrackRecord(String id, int index) async {
    try {
      AppLoader(Get.context!);
      Map<String, dynamic> body = {
        "status": 'deleted',
      };
      SuccessModel model = await TodayRecordService.updateRecord(recordId: id, body: body);

      if (model.statusCode == Constants.successCode200) {
        historyRecordList.value.removeAt(index);
        historyRecordList.refresh();
        Navigation.pop();

        getTodayRecord();
      }
      return model;
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {
      RemoveAppLoader();
    }
    return SuccessModel();
  }
}
