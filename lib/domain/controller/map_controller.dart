import 'dart:async';
import 'package:finutss/domain/bloc/bloc.dart';
import 'package:finutss/data/graphql_operation/queries/TrackQueries.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/track.dart';
import '../../data/models/track_models.dart';

class MapController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  var duration = 0;
  var isStart = false;
  Timer? _timer;

  static var defaultTrackImg = "https://finutss.s3.ap-northeast-2.amazonaws.com/assets/Track_default_image.png";
  var token = 'pk.eyJ1IjoiZmludXRzcyIsImEiOiJja3BvdjJwdWYwcHQ3Mm9udXo4M3Nod3YzIn0.OMVZjImaogKth_ApsJTlNg';
  var fromLongitude = ' 73.14651890297009';
  var fromLatitude = '33.56149689804258';
  var toLongitude = '73.15773349173614';
  var toLatitude = '33.56924162015977';
  bool isChatMoodActive = true;
  bool isTipMoodActive = false;
  bool isTrackDialogOpen = false;
  bool iskmShort = false;
  bool iskmHalf = false;
  bool iskmFull = true;

  List<Map> allUserDistance = [
    {'color': Colors.blue, 'percent': 20.0},
    {'color': Colors.green, 'percent': 40.0},
    {'color': Colors.yellow, 'percent': 70.0},
    {'color': Colors.red, 'percent': 100.0},
  ];
  Track? jsonTrack;
  Track? jsonTrackOfTomorrow;
  GetTrackObject? getTrackobject;

  void onStyleLoadedCallback() {}
  /* --------- api for getting the direction from one point to another -------- */
  callApiDailyTrack() async {
    var now = new DateTime.now();
    print('-=callApiDailyTrack now : ${now.weekday - 1}');
    Map<String, dynamic> params = Map<String, dynamic>();
    params["findQuery"] = {'dayOfTheWeek': (now.weekday + 7) % 7 + 1};
    var response = await GlobalBloc().queryRepo(TrackQueries.TRACKS, params);
    if (response["data"] != null) {
      jsonTrack = await Track.fromMap(response["data"]["getTracks"][0]);
    } else {
      ///TODO
      /*
      Get.snackbar(
        "Error",
        "Somthing Went wrong please try again",
      );
       */
    }
    update();
  }

  callApiTomorrowTrack() async {
    var now = new DateTime.now();
    print('-=callApiTomorrowTrack now : ${(now.weekday + 7 + 1) % 7 + 1}');
    Map<String, dynamic> params = Map<String, dynamic>();
    params["findQuery"] = {'dayOfTheWeek': (now.weekday + 7 + 1) % 7 + 1};
    var response = await GlobalBloc().queryRepo(TrackQueries.TRACKS, params);
    if (response["data"] != null) {
      jsonTrackOfTomorrow = await Track.fromMap(response["data"]["getTracks"][0]);
    } else {
      ///TODO
      /*
      Get.snackbar(
        "Error",
        "fSomthing Went wrong please try again",
      );
       */
    }
    update();
  }

  startDuration() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      duration++;
      update();
    });
  }

  pauseDuration() {
    _timer?.cancel();
  }

  resetDuration() {
    duration = 0;
  }
}
