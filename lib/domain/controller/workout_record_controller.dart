// import 'dart:html';

import 'package:finutss/data/graphql_operation/queries/TrackQueries.dart';
import 'package:finutss/data/models/track.dart';
import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/domain/bloc/bloc.dart';
import 'package:finutss/data/graphql_operation/queries/WorkOutQueries.dart';
import 'package:finutss/data/data_service/lib_helper.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';



class WorkoutRecordController extends GetxController {
  final authController = Get.put(AuthController());
  var isLoading = false.obs;

  /* -------------------------------- variables ------------------------------- */
  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime focusedDay = DateTime.now().subtract(Duration(days: 5));
  DateTime firstDay = DateTime.utc(1980, 1, 1);
  DateTime lastDay = DateTime.now().add(Duration(days: 365));
  DateTime? selectedDay;

  var jsonWorkOutRecord;
  var jsonWorkTotalObject;
  var jsonWorkDailyTotalObject;
  var jsonWorkWeekTotalObject;

  var workOutsOfMonth;

  var workOutsOfDay;

  String workoutType = "all";
  /* -------------------------------- functions ------------------------------- */

  void initState() {
    selectedDay = focusedDay;
  }

  void onDaySelected() {
    if (!isSameDay(selectedDay, selectedDay)) {
      {
        selectedDay = selectedDay;
        focusedDay = focusedDay;
      }
    }
    update();
  }

  Future<void> callMyWorkoutById(id) async {
    print("callApiDailyTrack");
    Map<String, dynamic> params = Map<String, dynamic>();
    params["id"] = id;
    jsonWorkOutRecord = await callWorkoutById(id);
    update();
  }

  static Future<Map> callWorkoutById(id) async {
    print("callApiDailyTrack");
    Map<String, dynamic> params = Map<String, dynamic>();
    params["id"] = id;
    var response = await GlobalBloc().queryRepo(WorkOutQueries.WORKOUT, params);
    if (response["data"] != null) {
      return response["data"]["workOut"];
    } else {
      ///TODO
      /*
      Get.snackbar(
        "Error",
        "Somthing Went wrong please try again",
      );
       */
      return {};
    }
  }

  callApiMyRecordTotal(userId) async {
    jsonWorkTotalObject = await callApiRecordTotal(userId);
    print('callApiMyRecordTotal');
    print(jsonWorkTotalObject);
    update();
  }

  static Future<Map?> callApiRecordTotal(userId) async {
    print("--callApiRecordTotal");
    Map<String, dynamic> params = Map<String, dynamic>();
    params["writer"] = userId;

    var response = await GlobalBloc().queryRepo(WorkOutQueries.WORKOUT_TOTAL_OF_ALL, params);
    if (response["data"] != null) {
      if (response["data"]["workOutTotalOfAll"] == null) {
        return null;
      }
      return response["data"]["workOutTotalOfAll"];
    } else {
      ///TODO
      /*
      Get.snackbar(
        "Error",
        "Somthing Went wrong please try again",
      );
       */
      return {};
    }
  }

  callApiRecordDailyTotal(userId) async {
    print("--callApiRecordDailyTotal");
    isLoading(true);
    var date = DateTime.now();
    date = LocalDB.getDate(date);
    Map<String, dynamic> params = Map<String, dynamic>();
    params["writer"] = userId;
    params["createdAt"] = {'\$gte': date.toUtc().toString(), '\$lte': DateTime.now().toUtc().toString()};
    var response = await GlobalBloc().queryRepo(WorkOutQueries.WORKOUT_TOTAL_OF_DAY, params);
    isLoading(false);
    print(params);
    if (response["data"] != null) {
      jsonWorkDailyTotalObject = response["data"]["workOutTotalOfDay"];
      update();
    } else {
      ///TODO
      /*
      Get.snackbar(
        "Error",
        "Somthing Went wrong please try again",
      );
       */
    }
  }

  callApiMyRecordWeekTotal(userId) async {
    print("--callApiRecordWeekTotal");
    isLoading(true);
    jsonWorkWeekTotalObject = await callApiRecordWeekTotal(userId);
    isLoading(false);
    update();
  }

  static callApiRecordWeekTotal(userId) async {
    print("--callApiRecordWeekTotal");
    var date = DateTime.now();
    date = LocalDB.getDate(date);
    Map<String, dynamic> params = Map<String, dynamic>();
    params["writer"] = userId;

    var response = await GlobalBloc().queryRepo(WorkOutQueries.WORKOUT_BY_DAY_OF_WEEK, params);
    if (response["data"] != null) {
      return response["data"]["workOutByDayOfWeek"];
    } else {
      ///TODO
      /*
      Get.snackbar(
        "Error",
        "Somthing Went wrong please try again",
      );
       */
      return [];
    }
  }

  static Future<Track> callPaginateApi({values}) async {
    ///TODO
    var now = new DateTime.now();
    print("-workout callPaginateApi");
    Map<String, dynamic> params = Map<String, dynamic>();
    params["findQuery"] = {'dayOfTheWeek': (now.weekday + 7 + 1) % 7 + 1};
    var response = await GlobalBloc().queryRepo(TrackQueries.TRACKS, params);
    if (values == null) values = {"limit": 1};
    if (response ["data"] != null) {
      var res = await Track.fromMap(response ["data"]["getTracks"][0]);
      return res;
    } else {
      return LocalDB.snackbar("Error", response ["message"]);
    }
  }


  /*
 static Future<Map> callPaginateApi({values}) async {
    print("-workout callPaginateApi");
    if (values == null) values = {"limit": 1};
    var res = await GlobalBloc().queryRepo(WorkOutQueries.WORKOUT_PAGINATE, values);
    if (!res["success"]) {
      return LocalDB.snackbar("Error", res["message"]);
    }
    return res["data"]["workOutPaginate"];
  }
   */

  callApiRecodList({values}) async {
    print("-workout callApiRecodList");
    var res = await GlobalBloc().queryRepo(WorkOutQueries.WORKOUTS, values);
    if (!res["success"]) {
      return LocalDB.snackbar("Error", res["message"]);
    }
    return res["data"]["workOuts"];
  }

  Future<void> callApiRecordByMonth() async {
    DateTime start = new DateTime(focusedDay.year, focusedDay.month, 1);
    DateTime end = new DateTime(focusedDay.year, focusedDay.month + 1, 1);
    var value = {
      'findQuery': {
        'writer': authController.user?.userId,
        'createdAt': {'\$gt': start.toString(), '\$lt': end.toString()}
      }
    };
    var result = await callApiRecodList(values: value);
    workOutsOfMonth = result;
    update();
  }

  void setWorkListOfDay(DateTime selectedDay) {
    if (workOutsOfMonth != null && workOutsOfMonth.length > 0) {
      var items = workOutsOfMonth.where((item) {
        var itemDay = DateTime.parse(item['createdAt']);
        return (itemDay.day == selectedDay.day && itemDay.month == selectedDay.month);
      });
      workOutsOfDay = items;
      update();
    } else {
      workOutsOfDay = null;
    }
  }
}
