import 'dart:async';
import 'dart:developer';

import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/new%20ui/controller/login_controller.dart';
import 'package:finutss/new%20ui/controller/new_sensor_controller.dart';
import 'package:finutss/new%20ui/modules/app_setting/model/success_model.dart';
import 'package:finutss/new%20ui/modules/map_view/controller/chat_controller.dart';
import 'package:finutss/new%20ui/modules/map_view/model/pinpoint_model.dart';
import 'package:finutss/new%20ui/modules/record/model/workout_record_model.dart';
import 'package:finutss/new%20ui/modules/record/service/today_record_service.dart';
import 'package:finutss/new%20ui/modules/sign_in/model/user_model.dart';
import 'package:finutss/new%20ui/modules/track/service/track_service.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/log_utils.dart';
import 'package:finutss/presentation/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/presentation/widgets/default_dialog.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pod_player/pod_player.dart';

// import 'package:pod_player_new/pod_player_new.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MapViewController extends GetxController {
  List<Map> allUserDistance = [
    {'color': Colors.blue, 'percent': 20.0},
    {'color': Colors.green, 'percent': 40.0},
    {'color': Colors.yellow, 'percent': 70.0},
    {'color': Colors.red, 'percent': 100.0},
  ];

/*
  Track? jsonTrack;
  Track? jsonTrackOfTomorrow;
  GetTrackObject? getTrackobject;*/

  final scaffoldKey = GlobalKey<ScaffoldState>();

  var duration = 0;
  var isStart = false;
  Timer? _timer;

  static var defaultTrackImg = "https://finutss.s3.ap-northeast-2.amazonaws.com/assets/Track_default_image.png";
  var token = 'pk.eyJ1IjoiZmludXRzcyIsImEiOiJja3BvdjJwdWYwcHQ3Mm9udXo4M3Nod3YzIn0.OMVZjImaogKth_ApsJTlNg';
  var fromLongitude = '73.14651890297009';
  var fromLatitude = '33.56149689804258';
  var toLongitude = '73.15773349173614';
  var toLatitude = '33.56924162015977';
  bool isChatMoodActive = true;
  bool isTipMoodActive = false;
  bool isTrackDialogOpen = false;
  bool iskmShort = false;
  bool iskmHalf = false;
  bool iskmFull = true;
  Map<String, dynamic> previousRecordBody = {};
  bool isCallAPI = true;
  bool isOpenScreen = false;
  VideoPlayerController? videoController;
  RxBool isVideoPlaying = false.obs;
  RxBool isVideoLoading = false.obs;

  RxBool isFinishedVideo = false.obs;
  RxBool isOpenPostScreen = false.obs;
  bool isExist = false;

  FlickManager? flickManager;
  PodPlayerController? podController;
  YoutubePlayerController? youtubePlayerController;
  LogInUser? logInUser;
  String recordId = '';
  late String userToken;
  ChatController chatController = Get.put(ChatController());

  Rx<PreviewComment> previewComments = PreviewComment().obs;

  void onInit() async {
    super.onInit();

    userToken = await SharedPrefs.getToken();
    userToken = userToken.replaceAll("Bearer ", "");
  }

  getCurrentUser() async {
    logInUser = (await SharedPrefs.getUser())!;
  }

  startDuration() {
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        duration++;
        update();
      },
    );
  }

  pauseDuration() {
    _timer?.cancel();
  }

  resetDuration() {
    duration = 0;
  }

  createRecord({required String trackId, required NewSensorController sensorController, required LoginController loginController}) async {
    // loginController.user?.data?.workoutType?.value=Constants.riding;

    LogUtils.logMSG('---Map Screen---- createRecord', StackTrace.empty);
    print('---Map Screen---- createRecord ${StackTrace.empty}');
    if (loginController.user == null) return;
    String type = (loginController.user?.data?.workoutType?.value ?? '');
    LogUtils.logMSG('---Map Screen---- createRecord body type.isNotEmpty-----> ${type.isNotEmpty}----', StackTrace.empty);
    if (type.isNotEmpty) {
      try {
        Map<String, dynamic> body = {
          "trackId": trackId,
          "type": loginController.user?.data?.workoutType?.value == Constants.riding ? Constants.ride : Constants.run,
        };

        WorkoutRecordModel model = await TodayRecordService.createRecord(body: body);
        LogUtils.logMSG(
            '---Map Screen---- createRecord body-----> ${body.toString()}-----statusCode------${model.statusCode}-----responce------${model.message} ${model.data}',
            StackTrace.empty);
        print("---Map Screen---- createRecord body-----> ${body.toString()}-----statusCode------${model.statusCode} ${model.message}");
        if (model.statusCode == Constants.successCode200) {
          if (model.data != null) {
            Map<String, dynamic> map = {
              "recordId": (model.data?.id ?? '').toString(),
              "burnedCal": (model.data?.burnedCal ?? 0).toString(),
              "exerciseTimeInMin": (model.data?.exerciseTimeInMin ?? 0).toString(),
              "distanceInKm": (model.data?.distanceInKm ?? 0).toString(),
              "status": (model.data?.status ?? Constants.processing).toString(),
              "phase": 0,
            };
            LogUtils.logMSG('---Map Screen----createRecord body-----> ${map.toString()}', StackTrace.empty);
            sensorController.workout = map;
            print("---Map Screen----createRecord body-----> ${map.toString()}");
            LogUtils.logMSG('---Map Screen----JavascriptCsensorController.workout-----> ${sensorController.workout}', StackTrace.empty);
            print('---Map Screen---- Javascript sensorController.workout-----> ${sensorController.workout} ${StackTrace.empty}');
          }
          recordId = (model.data?.id ?? '').toString();
          chatController.recordId = recordId;
          chatController.chatInitialize(userToken);
        } else if (model.statusCode.isNull) {
          TrackCreateRecordIssue();
        }
      } catch (e, st) {
        log("Error Message: $e : $st");
        LogUtils.logMSG('---Map Screen----createRecord Error Message: $e : $st', StackTrace.empty);
      } finally {}
    }
  }

  void TrackCreateRecordIssue() async {
    Get.dialog(
      DefalutDialog(
        title: "Error",
        description: """Something wants wrong.""",
        buttons: Row(
          children: [
            Expanded(
              child: customButton(
                  onTapFunction: () {
                    Get.back();
                    Get.back();
                  },
                  borderColor: AppColor.orangeColor,
                  radius: 16,
                  height: 48,
                  text: 'CLOSE'.tr,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  textColor: AppColor.orangeColor,
                  textSize: 16),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  void WebSocketNotConnect() async {
    Get.dialog(
      DefalutDialog(
        title: "Error",
        description: """Something wants wrong.""",
        buttons: Row(
          children: [
            Expanded(
              child: customButton(
                  onTapFunction: () {
                    Get.back();
                    Get.back();
                  },
                  borderColor: AppColor.orangeColor,
                  radius: 16,
                  height: 48,
                  text: 'CLOSE'.tr,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  textColor: AppColor.orangeColor,
                  textSize: 16),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  Future updateRecord({required Map<String, dynamic> body, required String recordId}) async {
    try {
      print('JavascriptChannel Response-------->-updateRecord body-----> ${body.toString()}');
      LogUtils.logMSG('---Map Screen----updateRecord body-----> ${body.toString()}', StackTrace.empty);
      if (!isExist && isCallAPI) {
        SuccessModel model = await TodayRecordService.updateRecord(recordId: recordId, body: body);
        print('JavascriptChannel Response-------->-updateRecord response-----> statusCode:: ${model.statusCode}');
        LogUtils.logMSG(
            '---Map Screen----updateRecord Response-----> statusCode:: ${model.statusCode} ::Body ${model.data.toString()}', StackTrace.empty);
        if (model.statusCode == Constants.successCode200) {}
      }
    } catch (e, st) {
      print("JavascriptChannel Response-------->-updateRecord  Error Message: $e : $st");
      LogUtils.logMSG('---Map Screen----updateRecord Response-----> Error Message: $e : $st', StackTrace.empty);
    } finally {}
  }

  Future pausedRecord(bool oneKm, {required String status}) async {
    try {
      NewSensorController sensorController = Get.find();

      if (sensorController.workout != null) {
        String recordId = sensorController.workout['recordId'];

        if (isExist) {
          previousRecordBody['status'] = status /*?? oneKm ? Constants.dropped : Constants.deleted*/;
          SuccessModel model = await TodayRecordService.updateRecord(recordId: recordId, body: previousRecordBody);
          print("pausedRecord ======> ${model.toString()} ------- ${previousRecordBody}");
          if (model.statusCode == Constants.successCode200) {
            isExist = false;
          }
        }
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {}
  }

  String secondToMinute({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "$min" : "$min";
    String second = sec.toString().length <= 1 ? "$sec" : "$sec";
    // return "$minute : $second";
    return "$minute";
  }

  leaveSocket() {
/*    chatController.chatLeave();
    chatController.socketIo?.destroy();
    chatController.socketIo?.close();
    chatController.socketIo?.disconnect();*/
    chatController.socketIo?.destroy();
    chatController.socketIo?.close();
    chatController.socketIo?.disconnect();
    chatController.chatMsgList.value = [];
  }

  Future likeUnlike({required String status, required String commentId}) async {
    try {
      Map<String, dynamic> body = {
        "commentId": commentId,
        "type": status,
      };
      SuccessModel model = await TrackService.setLikeUnlike(body: body);
      if (model.statusCode == Constants.successCode200) {
        if (model.data != null) {
          if (previewComments.value.isReacted ?? false) {
            if (previewComments.value.reactionsCount != 0) {
              previewComments.value.reactionsCount = (previewComments.value.reactionsCount ?? 0) - 1;
            }
          } else {
            previewComments.value.reactionsCount = (previewComments.value.reactionsCount ?? 0) + 1;
          }

          previewComments.value.isReacted = !(previewComments.value.isReacted ?? false);
          previewComments.refresh();
        }
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {}
  }
}
