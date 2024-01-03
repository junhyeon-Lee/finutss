import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:finutss/new%20ui/controller/login_controller.dart';
import 'package:finutss/new%20ui/controller/new_sensor_controller.dart';
import 'package:finutss/new%20ui/modules/app_setting/controller/app_setting_controller.dart';
import 'package:finutss/new%20ui/modules/invite_friends/invite_friend_controller/invite_friend_controller.dart';
import 'package:finutss/new%20ui/modules/live%20user/controller/live_user_controller.dart';
import 'package:finutss/new%20ui/modules/live%20user/presentation/live_user_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/map_view/controller/chat_controller.dart';
import 'package:finutss/new%20ui/modules/map_view/controller/map_view_controller.dart';
import 'package:finutss/new%20ui/modules/map_view/model/pinpoint_model.dart';
import 'package:finutss/new%20ui/modules/map_view/presentation/chat_screen.dart';
import 'package:finutss/new%20ui/modules/map_view/widget/all_user_run_distance_track.dart';
import 'package:finutss/new%20ui/modules/map_view/widget/button_view.dart';
import 'package:finutss/new%20ui/modules/map_view/widget/pin_point_screen.dart';
import 'package:finutss/new%20ui/modules/map_view/widget/user_distance_slider.dart';
import 'package:finutss/new%20ui/modules/record/controller/bmi_slider_controller.dart';
import 'package:finutss/new%20ui/modules/track/controller/track_detail_controller.dart';
import 'package:finutss/new%20ui/modules/track/presentation/posts_screen.dart';
import 'package:finutss/new%20ui/modules/workout/presentation/sound_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/workout/presentation/workout_exit_bottomSheet.dart';
import 'package:finutss/new%20ui/modules/workout/presentation/workout_result_screen.dart';
import 'package:finutss/new%20ui/modules/workout/presentation/workout_trial_notice.dart';
import 'package:finutss/new%20ui/utils/api_constant.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/log_utils.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/audio_player/voice_message_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key? key, required this.trackId, required this.token, required this.trackDetailController}) : super(key: key);
  String trackId;
  String token;
  TrackDetailController trackDetailController;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin, WidgetsBindingObserver {
  final AppSettingController controller = Get.find<AppSettingController>();
  final BmiSliderController bmiSliderController = Get.find();
  final MapViewController mapController = Get.put(MapViewController());
  final NewSensorController _sensorController = Get.put(NewSensorController());
  final LiveUserController liveUserController = Get.put(LiveUserController());
  final InviteFriendController inviteController = Get.put(InviteFriendController());

  LoginController loginController = Get.find();
  late TrackDetailController trackDetailController;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  WebViewPlusController? _controller;
  bool isSend = false;

  late AnimationController _animationController;
  late AnimationController _translationController;
  late AnimationController _translationController2;
  late Animation<double> toBottomAnimation;
  late Animation<double> toTopAnimation;
  late Animation<double> toRightAnimation;
  late Animation<double> centerButtonAnimation;
  double progressWidth = 126.w;

  bool isClicked = false;
  bool centerButtonClicked = false;
  final Duration duration = Duration(milliseconds: 2000);
  double height = 0;
  Widget? _animatedWidget;

  late Stream<PedestrianStatus> _pedestrianStatusStream;
  int previousStep = 0;
  int currentStep = 0;
  int? isStart;
  static int totalSteps = 0;
  late Stream<StepCount> _stepCountStream;
  String _steps = '0';
  bool isCount = false;
  String kcal = '';
  String lastduration = '';
  Timer? _timer;
  ValueNotifier<double> stepsSpeed = ValueNotifier(0.0);

  bool isLoadSuccessFully = false;
  NewSensorController sensorControllerupdate = NewSensorController();
  dynamic updateData;
  double distance1 = 0.0;

  void initState() {
    super.initState();
    Wakelock.enable();
    WidgetsBinding.instance.addObserver(this);
    Constants.isOpenScreen = false;
    trackDetailController = widget.trackDetailController;
    mapController.isExist = false;
    mapController.getCurrentUser();

    LogUtils.logMSG('---Map Screen---- initState', StackTrace.empty);
    print('---Map Screen---- initState ${StackTrace.empty}');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      mapController.recordId = '';
      mapController.createRecord(trackId: widget.trackId, sensorController: _sensorController, loginController: loginController).then((value) {
        liveUserController.getLiveUser(widget.trackId).then((value) {
          print("call getLiveUser");
          inviteController.clear();
          inviteController.getFollowing(inviteController.userId);
        });
      });
    });

    _animatedWidget = Container(
      key: LabeledGlobalKey("two"),
      height: 46.h,
      width: 46.h,
      // duration: duration,
      child: InkWell(
        onTap: null,
        child: Container(
          height: 52.h,
          width: 45.w,
          child: SvgPicture.asset(IconAssets.appLogoTra, fit: BoxFit.contain),
        ),
      ),
    );
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _translationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _translationController2 = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    toBottomAnimation = Tween<double>(begin: 50, end: 0).animate(_translationController2);
    toTopAnimation = Tween<double>(begin: 30, end: 0).animate(_translationController);
    toRightAnimation = Tween<double>(begin: 50, end: 0).animate(_translationController);
    centerButtonAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastLinearToSlowEaseIn,
    );
    _translationController.forward();

    _translationController.addListener(() {
      // setState(() {});
    });
    _translationController2.forward();
    _translationController2.addListener(() {
      // setState(() {});
    });
    _animationController.forward();

    if ((loginController.user?.data?.workoutType ?? '') == Constants.mobileSensor) {
      permissionPhysicalActivity();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    print("dispose");
    _timer?.cancel();
    _translationController2.dispose();
    _animationController.dispose();

    mapController.leaveSocket();
    mapController.pauseDuration();
    mapController.resetDuration();

    _sensorController.cancleNotification();
    _sensorController.clearValue();
    print("dispose Work");
    Wakelock.disable();
    _controller?.webViewController.clearCache();
    _translationController.dispose();
    WebViewPlus.platform.clearCookies();
    CookieManager().clearCookies();
    super.dispose();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        print("resumed App");
        break;
      case AppLifecycleState.paused:
        print("paused App");
        mapController.isExist = true;
        if (distance1 < 1) {
          mapController.pausedRecord(false, status: Constants.paused);
        } else {
          print("distance < 1 --- ");
          mapController.pausedRecord(true, status: Constants.dropped);
        }
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    FlutterBlue.instance.setLogLevel(LogLevel.emergency);
    // var trackId = '3c1461b0-15bb-492f-afd5-32d4c1d627bf';
    var isDownSpeed = true;
    // double? distance = mapController.jsonTrack?.distance;
    double? distance = Constants.trackDistance;

    if (mapController.iskmHalf) distance = distance * 0.5;
    if (mapController.iskmShort) distance = distance * 0.25;

    NewSensorController sensorController = Get.find();
    return WillPopScope(
      onWillPop: () {
        double phase = 0.0;
        if (sensorController.workout != null) {
          if (sensorController.workout.containsKey("phase")) {
            phase = (sensorController.workout["phase"] ?? 0).toDouble();
          }
        }
        phase = double.parse(updateData['distance'].toString()) / 1000;
        print("phase --- $phase");
        trackDetailController.isTrackCompleted = trackDetailController.isTrackCompletedTemp;
        workoutExitBottomSheet(
            context: context,
            distance: distance1,
            ontap: () async {
              mapController.isExist = true;
              print("distance < 1 --- ${distance1 < 1} ---- ${distance}");
              if (distance1 < 1) {
                mapController.pausedRecord(false, status: Constants.deleted);
                Navigation.pop();
                Navigation.pop();
              } else {
                print("distance < 1 --- ${mapController.recordId}");
                print("distance < 1 --- ${widget.trackId}");
                mapController.pausedRecord(true, status: Constants.dropped);
                Navigation.pop();
                Get.off(
                    () => WorkoutResultScreen(
                          recordId: mapController.recordId,
                          trackId: widget.trackId,
                        ),
                    arguments: sensorController.workout['id']);
              }
            });
        return Future(() => false);
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: AppColor.transparent,
          systemNavigationBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          body: GetBuilder<MapViewController>(builder: (mapController) {
            return GetBuilder<NewSensorController>(builder: (sensorController) {
              return ValueListenableBuilder(
                  valueListenable: stepsSpeed,
                  builder: (BuildContext context, double val, Widget? child) {
                    double speed = 0;

                    String sensorType =
                        (loginController.user?.data?.workoutType?.value.toString().toLowerCase() ?? Constants.riding.toString().toLowerCase());
                    if (sensorType == Constants.riding.toString().toLowerCase()) {
                      speed = sensorController.mWheel.length > 0
                          ? (sensorController.mWheel['speed'] ?? 0)
                          : (sensorController.mCrank['crankCadence'] ?? 0) * sensorController.sensitivityList[sensorController.sensitivity.value];
                    } else if (sensorType == Constants.running.toString().toLowerCase()) {
                      if (sensorController.mRSC.length > 0) {
                        speed = (sensorController.mRSC['speed']?.toDouble() ?? 0);
                      }
                      if (sensorController.mPad.length > 0) {
                        speed = sensorController.mPad['speed']?.toDouble() ?? 0;
                      }
                    } else if (sensorType == Constants.mobileSensor.toLowerCase()) {
                      speed = stepsSpeed.value;
                    }

                    LogUtils.logMSG('---Map Screen----GetBuilder MapViewController speed------>: ${speed}', StackTrace.empty);

                    print('----------=======speed==>${speed}');

                    if (sensorController.workout != null) {
                      print('----------=======JavascriptCsensorController==> ${sensorController.workout["recordId"]}');
                      LogUtils.logMSG('---Map Screen----JavascriptCsensorController.workout-----> ${sensorController.workout}', StackTrace.empty);
                      LogUtils.logMSG(
                          'GetBuilder MapViewController sensorController.workout["phase"].toDouble()  ${sensorController.workout["phase"].toDouble()}',
                          StackTrace.empty);
                    }

                    return Container(
                      child: Stack(
                        children: [
                          /* -------------------------------------------------------------------------- */
                          /*                                     map                                    */
                          /* -------------------------------------------------------------------------- */
                          Positioned.fill(
                            child: WebViewPlus(
                              initialUrl: 'new_assets/webview/index.html',
                              javascriptMode: JavascriptMode.unrestricted,
                              onWebViewCreated: (WebViewPlusController controller) {
                                print("init web view");
                                _controller = controller;
                                //_setUserImg(controller, context);
                              },
                              onWebResourceError: (onWebResourceError) {
                                print("---- onWebResourceError --- ${onWebResourceError}");
                              },
                              onPageFinished: (url) {
                                String type = "normal";
                                if (mapController.iskmShort) type = "short";
                                if (mapController.iskmHalf) type = "half";
                                Timer(Duration(milliseconds: 500), () {
                                  _controller?.webViewController.runJavascriptReturningResult(
                                      'setPath("${ApiConstants.baseUrl + ApiConstants.track + widget.trackId}", "$type","${widget.token}")');
                                });
                                _setMyMarker(_controller!);

                                sensorController.setListener((speed) {
                                  LogUtils.logMSG('---Map Screen----sensorController.setListener((speed) ${speed.toString()}', StackTrace.empty);

                                  if (isLoadSuccessFully && mapController.isOpenScreen == false) {
                                    _onChangeSpeed(_controller!, context, speed);
                                  }
                                  isDownSpeed = false;
                                });
                                print("onPageFinished ");
                                mapController.startDuration();
                              },
                              javascriptChannels: <JavascriptChannel>[
                                JavascriptChannel(
                                  name: 'update',
                                  onMessageReceived: (JavascriptMessage msg) async {
                                    LogUtils.logMSG('JavascriptChannel Response--------> ${jsonDecode(msg.message)}', StackTrace.empty);

                                    if (loginController.user == null) return;
                                    sensorControllerupdate = sensorController;
                                    updateData = jsonDecode(msg.message);
                                    sensorController.setPhaseToWorkout(updateData['phase']);

                                    String recordId = '';
                                    if (sensorController.workout != null) {
                                      double distanceInKiloMeters = double.parse(updateData['distance'].toString()) / 1000;
                                      recordId = sensorController.workout['recordId'];
                                      distance1 = distanceInKiloMeters;
                                      recordId = sensorController.workout['recordId'];
                                      kcal = updateData['kcal'].toString();
                                      lastduration = Constants.secondToMinuteConvert(timeInSecond: updateData['duration']);
                                      Map<String, dynamic> body = {
                                        "type": (loginController.user?.data?.workoutType?.value ?? Constants.running).toString().toLowerCase() ==
                                                Constants.running.toLowerCase()
                                            ? Constants.run
                                            : Constants.ride,
                                        "status": Constants.processing.toLowerCase(),
                                        "burnedCal": updateData['kcal'].toString(),
                                        "distanceInKm": distanceInKiloMeters.toStringAsFixed(2),
                                        "exerciseTimeInMin": Constants.secondToMinuteConvert(timeInSecond: updateData['duration']),
                                      };
                                      print('JavascriptChannel Response-------->update body::${body}, recordId: $recordId}');
                                      mapController.updateRecord(body: body, recordId: recordId);
                                    } else {
                                      LogUtils.logMSG('JavascriptChannel Response--------> null update body::', StackTrace.empty);
                                    }

                                    isSend = true;
                                  },
                                ),
                                // JavascriptChannel(name: "", onMessageReceived: (JavascriptMessage msg){
                                //
                                // }),
                                JavascriptChannel(
                                    name: 'finish',
                                    onMessageReceived: (JavascriptMessage msg) async {
                                      LogUtils.logMSG(
                                          '---Map Screen----JavascriptChannel Finish Response--------> ${jsonDecode(msg.message)}', StackTrace.empty);

                                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
                                        if (loginController.user == null) return;
                                        var data = jsonDecode(msg.message);
                                        sensorController.setPhaseToWorkout(1);
                                        String recordId = '';
                                        if (sensorController.workout != null) {
                                          recordId = sensorController.workout['recordId'];
                                          kcal = data['kcal'].toString();
                                          lastduration = Constants.secondToMinuteConvert(timeInSecond: data['duration']);
                                          double distanceInKiloMeters = double.parse(data['distance'].toString()) / 1000;

                                          Map<String, dynamic> body = {
                                            "type": (loginController.user?.data?.workoutType?.value ?? Constants.running).toString().toLowerCase() ==
                                                    Constants.running.toLowerCase()
                                                ? Constants.run
                                                : Constants.ride,
                                            "status": Constants.finished.toLowerCase(),
                                            "burnedCal": data['kcal'].toString(),
                                            "distanceInKm": distanceInKiloMeters.toStringAsFixed(2),
                                            "exerciseTimeInMin": Constants.secondToMinuteConvert(timeInSecond: data['duration']),
                                          };
                                          LogUtils.logMSG(
                                              'JavascriptChannel Response-------->finish body::${body}, recordId: $recordId}', StackTrace.empty);
                                          await mapController.updateRecord(body: body, recordId: recordId);
                                        }
                                        isSend = true;

                                        if (mapController.isFinishedVideo.value) {
                                          if (mapController.flickManager != null) {
                                            mapController.flickManager?.dispose();
                                          }
                                          mapController.videoController?.dispose();
                                          Navigator.of(context, rootNavigator: true).pop();
                                          mapController.isFinishedVideo.value = false;
                                        }

                                        Timer(
                                            Duration(seconds: 2),
                                            () => Get.off(
                                                () => WorkoutResultScreen(
                                                      recordId: recordId,
                                                      trackId: widget.trackId,
                                                    ),
                                                arguments: sensorController.workout['id']));
                                      });
                                    }),
                                JavascriptChannel(
                                  name: 'loadSuccessFully',
                                  onMessageReceived: (JavascriptMessage msg) async {
                                    Timer(Duration(seconds: 4), () {
                                      isLoadSuccessFully = true;
                                    });
                                  },
                                ),
                                JavascriptChannel(
                                    name: 'markerOnClick',
                                    onMessageReceived: (JavascriptMessage msg) async {
                                      mapController.isVideoPlaying.value = false;
                                      mapController.isVideoLoading.value = false;
                                      var data = jsonDecode(msg.message);

                                      PinPointModel pinpointModel = PinPointModel.fromJson(data);
                                      LogUtils.logMSG(
                                          '---Map Screen----markerOnClick  id ${pinpointModel.id}-----------text------>${pinpointModel.text}',
                                          StackTrace.empty);

                                      mapController.isFinishedVideo.value = true;

                                      if (!mapController.isOpenScreen) {
                                        LogUtils.logMSG('---Map Screen----markerOnClick  showGeneralDialog------>', StackTrace.empty);

                                        showGeneralDialog(
                                          context: context,
                                          barrierColor: Colors.transparent,
                                          barrierLabel: 'Label',
                                          barrierDismissible: true,
                                          pageBuilder: (_, __, ___) => Center(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    WidgetsBinding.instance.addPostFrameCallback((_) {
                                                      mapController.isOpenScreen = true;
                                                      int index = trackDetailController.photosList.indexWhere((item) =>
                                                          item.url == (pinpointModel.image ?? '') || item.url == (pinpointModel.video ?? ''));
                                                      mapController.flickManager?.flickVideoManager?.videoPlayerController?.pause();
                                                      mapController.podController?.pause();

                                                      trackDetailController.isTrackCompleted.value = true;
                                                      Navigator.of(context)
                                                          .push(
                                                        PageRouteBuilder(
                                                          opaque: false,
                                                          pageBuilder: (BuildContext context, _, __) => PostsScreen(
                                                            pinpointId: pinpointModel.id,
                                                            index: index == -1 ? null : index,
                                                            type: Constants.trackDetailScreen,
                                                            trackDetailController: trackDetailController,
                                                            trackId: widget.trackId,
                                                            photosList: trackDetailController.photosList,
                                                            isOpenThroughMapScreen: true,
                                                          ),
                                                        ),
                                                      )
                                                          .then((value) {
                                                        mapController.isOpenScreen = false;
                                                      });
                                                    });
                                                  },
                                                  // child: soundLayout(pinpointModel),
                                                  child: PinPointScreen(pinPointModel: pinpointModel),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ).then((value) {
                                          if (mapController.videoController != null) {
                                            mapController.videoController?.dispose();
                                          }
                                          mapController.isFinishedVideo.value = false;
                                        });
                                      }
                                    }),
                                JavascriptChannel(
                                  name: 'closeDialog',
                                  onMessageReceived: (JavascriptMessage msg) async {
                                    print("closeDialog msg ---> ${msg.message}");
                                    mapController.isVideoPlaying.value = false;
                                    mapController.isVideoLoading.value = false;

                                    if (mapController.videoController != null) {
                                      mapController.videoController?.dispose();
                                    }

                                    if (mapController.isFinishedVideo.value) {
                                      if (mapController.flickManager != null) {
                                        mapController.flickManager?.dispose();
                                      }
                                      mapController.videoController?.dispose();
                                      Navigator.of(context, rootNavigator: true).pop();
                                      mapController.isFinishedVideo.value = false;
                                    }

                                    /*  if(mapController.isOpenScreen){
                        Navigator.pop(context);
                      }*/
                                  },
                                ),
                              ].toSet(),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  // child: appbar(title: 'abc'),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 40.h),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  double phase = 0.0;
                                                  if (sensorController.workout != null) {
                                                    if (sensorController.workout.containsKey("phase")) {
                                                      phase = (sensorController.workout["phase"] ?? 0).toDouble();
                                                    }
                                                  }
                                                  workoutExitBottomSheet(
                                                      context: context,
                                                      distance: phase,
                                                      ontap: () {
                                                        mapController.isExist = true;
                                                        print("distance < 1 --- ${distance1 < 1} ---- ${distance}");
                                                        if (distance1 < 1) {
                                                          mapController.pausedRecord(false, status: Constants.deleted);
                                                          Navigation.pop();
                                                          Navigation.pop();
                                                        } else {
                                                          print("distance < 1 --- ");
                                                          mapController.pausedRecord(true, status: Constants.dropped);
                                                          Navigation.pop();
                                                          Get.off(
                                                              () => WorkoutResultScreen(
                                                                    recordId: mapController.recordId,
                                                                    trackId: widget.trackId,
                                                                  ),
                                                              arguments: sensorController.workout['id']);
                                                        }
                                                      });
                                                },
                                                child: CircleAvatar(
                                                  backgroundColor: AppColor.whiteColor,
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.arrow_back,
                                                      color: AppColor.backIconColor,
                                                    ),
                                                  ),
                                                  radius: 15,
                                                ),
                                              ),
                                              Text(
                                                Duration(seconds: mapController.duration).toString().substring(0, 7),
                                                style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColor.black,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  // _onChangeSpeed(_controller!, context, 5);
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(right: 5.w),
                                                  child: SvgPicture.asset(
                                                    loginController.getCurrentType(),
                                                    width: 32.w,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 18.h),
                                          color: AppColor.whiteColor.withOpacity(0.5),
                                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                                          child: AllUserRunDistanceTrack(
                                            userList: mapController.allUserDistance,
                                            speed: speed.toInt(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 11.h,
                                ),
                                InkWell(
                                  onTap: () {
                                    // _onChangeSpeed(_controller!, context, 20);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 18.w,
                                    ),
                                    child: _speedText(speed),
                                  ),
                                ),

                                /* InkWell(
                                  onTap: () {
                                     _onChangeSpeed(_controller!, context, 75);
                                  },
                                  child: Container(
                                    color: Colors.red,
                                    padding: EdgeInsets.only(
                                      left: 18.w,
                                      top:20
                                    ),
                                    child:Text("change Speed"),
                                  ),
                                ),*/

                                /* Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    child: Center(
                      child: leftTodayLayout(distance: distance ?? 0,workout: sensorController.workout == null ? 0.0 : 0),
                     // child: leftTodayLayout(distance: 50,workout: 1),
                    ),
                  )*/
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                buildMassage(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Transform.translate(
                                      offset: Offset(0, toBottomAnimation.value),
                                      child: FadeTransition(
                                        opacity: _translationController2.drive(
                                          CurveTween(
                                            curve: Curves.easeOut,
                                          ),
                                        ),
                                        child: ButtonView(
                                          icon: IconAssets.chatFill,
                                          color: AppColor.whiteColor,
                                          text: 'CHAT'.tr,
                                          onPressedFunction: () async {
                                            if (!mapController.recordId.isEmpty) {
                                              Constants.isOpenScreen = true;
                                              mapController.isOpenScreen = true;
                                              final ChatController controller = Get.find();
                                              controller.scrollDown();
                                              Navigator.of(context)
                                                  .push(
                                                PageRouteBuilder(
                                                  opaque: false,
                                                  pageBuilder: (BuildContext context, _, __) => ChatScreen(
                                                    recordId: mapController.recordId,
                                                    token: mapController.userToken,
                                                  ),
                                                ),
                                              )
                                                  .then((value) {
                                                print(" mapController.isOpenScreen ${mapController.isOpenScreen}");
                                                mapController.isOpenScreen = false;
                                                Constants.isOpenScreen = false;
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        setState(() {
                                          isClicked = !isClicked;
                                        });
                                        print(isClicked);

                                        if (isClicked) {
                                          _translationController.reset();
                                          _translationController.forward();
                                          //for chat and people button
                                          _translationController2.reverse();
                                          //for center button
                                          _animationController.reverse();
                                          await Future.delayed(Duration(milliseconds: 300));

                                          setState(() {
                                            mapController.isCallAPI = false;
                                            mapController.isOpenScreen = true;
                                            workoutMenuBottomSheet(context, trackId: widget.trackId).then((value) {
                                              Constants.isOpenScreen = false;
                                            }).then((value) {
                                              mapController.isCallAPI = true;
                                              mapController.isOpenScreen = false;
                                            });
                                          });
                                          await Future.delayed(Duration(milliseconds: 300));

                                          _animationController.forward();
                                        } else {
                                          _translationController.reset();
                                          _translationController.forward();
                                          //for chat and people button
                                          _translationController2.forward();

                                          //for center button
                                          _animationController.reverse();
                                          await Future.delayed(Duration(milliseconds: 300));

                                          setState(() {
                                            //_animatedWidget = _chatWidget();
                                          });
                                          await Future.delayed(Duration(milliseconds: 300));

                                          _animationController.forward();
                                        }
                                      },
                                      child: AnimatedSwitcher(
                                        duration: Duration(milliseconds: 300),
                                        transitionBuilder: (child, animation) {
                                          return ScaleTransition(
                                            child: child,
                                            scale: centerButtonAnimation,
                                          );
                                        },
                                        reverseDuration: Duration(milliseconds: 300),
                                        child: _animatedWidget,
                                      ),
                                      // child: _animatedWidget,
                                    ),
                                    Transform.translate(
                                      offset: Offset(0, toBottomAnimation.value),
                                      child: FadeTransition(
                                        opacity: _translationController2.drive(CurveTween(curve: Curves.easeOut)),
                                        child: Obx(() => ButtonView(
                                              color: AppColor.whiteColor,
                                              icon: IconAssets.groupMultiple,
                                              text: liveUserController.liveUserList.length.toString().toString(),
                                              onPressedFunction: () async {
                                                print("getLiveUser legth======= ${liveUserController.liveUserList.length.toString().toString()} ");
                                                Constants.isOpenScreen = true;
                                                mapController.isOpenScreen = true;
                                                await liveUserController.getLiveUser(widget.trackId);
                                                print("getLiveUser legth======= ${liveUserController.liveUserList.length.toString().toString()} ");
                                                liveUserBottomSheet(context, title: 'LIVE_USER').then((value) {
                                                  Constants.isOpenScreen = false;
                                                  mapController.isOpenScreen = false;
                                                });
                                              },
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 147.h,
                            right: 16.w,
                            child: runDistance(
                              goal: (distance ?? 0),
                              ratio: sensorController.workout == null ? 0.0 : sensorController.workout["phase"].toDouble(),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            });
          }),
        ),
      ),
    );
  }

  Widget leftTodayLayout({required double workout, required double distance}) {
    double current = (distance / 1000) * workout;
    double currrentPercent = (current * progressWidth) / (distance / 1000);
    double currentPositionPointer = progressWidth * (((currrentPercent / progressWidth) * 100) / 100);

    String totalKm = (distance / 1000).toStringAsFixed(2);

    if (currentPositionPointer.isNaN) {
      currentPositionPointer = 0;
    }

    return GestureDetector(
      onTap: () {
        workoutTrialNoticeBottomSheet(context);
      },
      child: Container(
        width: 140.w,
        decoration: BoxDecoration(
          color: AppColor.whiteColor.withOpacity(0.75),
          borderRadius: BorderRadius.circular(7.w),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 7.w,
          vertical: 7.h,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  current.toStringAsFixed(2) + "/" + totalKm,
                  style: TextStyle(
                    height: 1.2.h,
                    color: AppColor.blueTextColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                  ),
                ),
                Flexible(
                  child: Text(
                    " km left today",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      height: 1.2.h,
                      color: AppColor.blueTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 6.h,
            ),
            _customSlider(currentPositionPointer: currentPositionPointer)
          ],
        ),
      ),
    );
  }

  Widget _customSlider({double currentPositionPointer = 100}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 4.h,
          width: progressWidth,
          decoration: BoxDecoration(color: Color(0xFFDBDFEA), borderRadius: BorderRadius.circular(16)),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            height: 4.h,
            width: currentPositionPointer,
            decoration:
                BoxDecoration(color: AppColor.blue, borderRadius: BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16))),
          ),
        ),
        Positioned(
          left: currentPositionPointer - 5,
          top: -3,
          child: Container(
            height: 10,
            width: 10,
            decoration:
                BoxDecoration(color: AppColor.blue, border: Border.all(color: Colors.white, width: 1.5), borderRadius: BorderRadius.circular(50)),
          ),
        ),
      ],
    );
  }

  buildMassage() {
    return Column(
      children: [
        // MessageView(),
        //  MessageView(isOnline: true),
      ],
    );
  }

  Widget soundLayout(PinPointModel pinpointModel, {VoidCallback? onTap}) {
    VideoPlayerController? videoController;
    if (pinpointModel.image != null &&
        (pinpointModel.image ?? '') != "" &&
        pinpointModel.image?.substring((pinpointModel.image?.length ?? 0) - 4).toLowerCase() == ".mp4") {
      videoController = VideoPlayerController.network(pinpointModel.image ?? '')..initialize().then((_) {});
    }
    return Padding(
      padding: EdgeInsets.only(top: 180.h, right: 80.w, left: 16.w),
      child: Column(
        children: [
          if (pinpointModel.sound != null && (pinpointModel.sound ?? '') != "") ...[
            VoiceMessageCustom(
              meBgColor: AppColor.whiteColor.withOpacity(0.75),
              meFgColor: AppColor.blueTextColor.withOpacity(0.36),
              mePlayIconColor: AppColor.whiteColor.withOpacity(0.9),
              audioSrc: pinpointModel.sound ?? '',
              played: true,
              me: true,
              onPlay: () {},
            ),
          ],
          SizedBox(
            height: 5.h,
          ),
          if (pinpointModel.image != null && (pinpointModel.image ?? '') != "") ...[
            if (pinpointModel.image?.substring((pinpointModel.image?.length ?? 0) - 4).toLowerCase() == ".mp4") ...[
              Obx(() => GestureDetector(
                    onTap: () {
                      mapController.isVideoPlaying.value = !mapController.isVideoPlaying.value;
                      if (mapController.isVideoPlaying.value) {
                        videoController?.play();
                      } else {
                        videoController?.pause();
                      }
                    },
                    child: Container(
                      height: 140.h,
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 5.h),
                      decoration: BoxDecoration(
                        color: AppColor.whiteColor.withOpacity(0.75),
                        borderRadius: BorderRadius.circular(6.w),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 8.h,
                                horizontal: 10.w,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: AspectRatio(
                                  aspectRatio: videoController!.value.aspectRatio,
                                  child: VideoPlayer(videoController),
                                ),
                              ),
                            ),
                          ),
                          if (!mapController.isVideoPlaying.value) ...[
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: Center(
                                child: Image.asset(
                                  IconAssets.play,
                                  width: 24.w,
                                ),
                              ),
                            )
                          ],
                          Positioned(
                            top: 18.w,
                            right: 18.w,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.white.withOpacity(0.5),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 3.h,
                                  horizontal: 4.w,
                                ),
                                child: Icon(
                                  Icons.edit,
                                  size: 14.w,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
            ] else ...[
              Container(
                height: 140.h,
                margin: EdgeInsets.only(bottom: 5.h),
                decoration: BoxDecoration(
                  color: AppColor.whiteColor.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(6.w),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.h,
                        horizontal: 10.w,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: pinpointModel.image ?? '',
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 18.w,
                      right: 18.w,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 3.h,
                            horizontal: 4.w,
                          ),
                          child: Icon(
                            Icons.edit,
                            size: 14.w,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ]
          ],
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColor.whiteColor.withOpacity(0.75),
              borderRadius: BorderRadius.circular(6.w),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 9.h,
            ),
            child: Text(
              pinpointModel.text ?? '',
              style: TextStyle(
                height: 1.2.h,
                color: AppColor.blueTextColor,
                fontWeight: FontWeight.w400,
                fontSize: 10.sp,
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          /* InkWell(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.whiteColor.withOpacity(0.75),
                borderRadius: BorderRadius.circular(6.w),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 15.w,
                vertical: 9.h,
              ),
              child: Column(
                children: [
                  Text(
                    "1/15 km left today",
                    style: TextStyle(
                      height: 1.2.h,
                      color: AppColor.blueTextColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 10.sp,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: AppColor.lightBlueTextColor,
                      inactiveTrackColor: AppColor.inActiveSliderBg,
                      thumbColor: AppColor.lightBlueTextColor,
                      overlayShape: RoundSliderOverlayShape(overlayRadius: 0),
                      trackHeight: 3.2,
                      trackShape: CustomTrackShape(),
                      thumbShape: SeekBarThumbShape(
                        thumbRadius: 7,
                        roundness: 5,
                        thickness: 2,
                        color: AppColor.lightBlueTextColor,
                      ),
                    ),
                    child: Slider(
                      min: 0,
                      max: 100,
                      value: controller.speedValue.value,
                      onChanged: (newValue) {
                        controller.speedValue.value = newValue;
                      },
                    ),
                  ),
                ],
              ),
            ),
          )*/
        ],
      ),
    );
  }

  Widget _speedText(speed) {
    LogUtils.logMSG('---Map Screen----Map screen _speedText------>: ${speed}', StackTrace.empty);

    speed = speed.toStringAsFixed(1) ?? 0;

    LogUtils.logMSG('Map Screen speed.toStringAsFixed------>: ${speed}', StackTrace.empty);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "$speed",
          style: TextStyle(
            color: Color(0xfff73a6b),
            fontSize: 28.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: 3.w),
        Text(
          "KMH".tr,
          style: TextStyle(
            color: Color(0xfff73a6b),
            fontSize: 15.sp,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  void _onChangeSpeed(WebViewPlusController controller, BuildContext context, double speed) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      await controller.webViewController.evaluateJavascript("changeSpeed('$speed')");
    } else {
      await controller.webViewController.evaluateJavascript("changeSpeed('0')");
    }
  }

  void _setMyMarker(WebViewPlusController controller) async {
    String profilePhoto =
        (mapController.logInUser?.profilePicture ?? "https://finutss.s3.ap-northeast-2.amazonaws.com/assets/finutss_default_profile.png");
    profilePhoto = profilePhoto.isEmpty ? 'https://finutss.s3.ap-northeast-2.amazonaws.com/assets/finutss_default_profile.png' : profilePhoto;
    String type = (loginController.user?.data?.workoutType?.value ?? "Riding");
    type = type.isEmpty ? 'Riding' : type;
    var data = '{"image": "${profilePhoto}", "type":  "${type}"}';

    controller.webViewController.evaluateJavascript('setMyMarker($data)');
  }

  permissionPhysicalActivity() async {
    if (Platform.isAndroid) {
      bool status = await Permission.activityRecognition.request().isGranted;
      LogUtils.logMSG('stride permission status ${status} ', StackTrace.empty);

      if (status) {
        initPlatformState();

        _timer = Timer.periodic(const Duration(seconds: 2), (Timer _timer) {
          int stepDiff = currentStep - previousStep;
          // stepsSpeed.value =  (stepDiff*76)/100000;
          stepsSpeed.value = (stepDiff * 0.762) * 3.6;

          previousStep = currentStep;
          if (mapController.isOpenScreen == false) {
            _onChangeSpeed(_controller!, context, stepsSpeed.value);
            // _onChangeSpeed(_controller!, context, 2);
          }
        });
      }
      await Permission.activityRecognition.request().isGranted;
    } else if (Platform.isIOS) {
      bool status = await Permission.sensors.request().isGranted;
      if (status) {
        _timer = Timer.periodic(const Duration(seconds: 2), (Timer _timer) {
          setState(() {
            int stepDiff = currentStep - previousStep;
            // stepsSpeed.value = (stepDiff * 0.762) * 3.6;
            stepsSpeed.value = (stepDiff * 76) / 100000;
            previousStep = currentStep;
          });
        });
      } else if (await Permission.activityRecognition.isDenied) {
        await Permission.activityRecognition.request().then((value) {
          if (value == PermissionStatus.granted) {
          } else if (value == PermissionStatus.denied) {}
        });
      }
    }
  }

  void initPlatformState() async {
    _pedestrianStatusStream = await Pedometer.pedestrianStatusStream;
    _stepCountStream = await Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
  }

  void onStepCount(StepCount event) {
    if (isCount == false) {
      totalSteps = event.steps;
      isCount = true;
    }
    _steps = (event.steps - totalSteps).toString();
    currentStep = int.parse(_steps);
  }

  void onStepCountError(error) {
    _steps = 'Step Count not available';
  }
}

Widget circleIcons(
    {VoidCallback? onPressedFunction,
    icon = Icons.light_mode_outlined,
    double height = 45,
    double width = 45,
    backgroundColor = Colors.white,
    iconColor = Colors.white,
    double iconSize = 30,
    String? isImagePath = ''}) {
  return InkWell(
    onTap: onPressedFunction,
    child: Container(
      height: height.r,
      width: width.r,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: isImagePath != ''
          ? Center(
              child: SvgPicture.asset(
                isImagePath ?? '',
                width: 32.w,
              ),
            )
          : Center(
              child: Icon(
                icon,
                size: iconSize.r,
                color: iconColor,
              ),
            ),
    ),
  );
}

Widget tipsCard(String tip) {
  return Card(
    color: AppColor.whiteColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
    child: Padding(
      padding: EdgeInsets.all(8.r),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            CommunityMaterialIcons.lightbulb_on_outline,
            size: 35.r,
            color: AppColor.lightBlueTextColor.withOpacity(0.6),
          ),
          SizedBox(
            width: 10.w,
          ),
          Flexible(
            child: Text(
              "$tip",
              style: TextStyle(
                color: AppColor.subTitleColor,
                fontSize: 14.sp,
                height: 1.5,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
