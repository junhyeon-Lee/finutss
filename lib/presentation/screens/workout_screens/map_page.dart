import 'dart:async';
import 'dart:convert';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/data/graphql_operation/queries/WorkOutQueries.dart';
import 'package:finutss/domain/bloc/bloc.dart';
import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/domain/controller/chat_controller.dart';
import 'package:finutss/domain/controller/map_controller.dart';
import 'package:finutss/domain/controller/sensor_controller.dart';
import 'package:finutss/domain/controller/workout_in_controller.dart';
import 'package:finutss/presentation/screens/track_screens/live_user_screen.dart';
import 'package:finutss/presentation/screens/workout_result_screens/workout_result_screen.dart';
import 'package:finutss/presentation/screens/workout_screens/chat_page.dart';
import 'package:finutss/presentation/screens/workout_screens/declare_category_screen.dart';
import 'package:finutss/presentation/screens/workout_screens/invite_friends_screen.dart';
import 'package:finutss/presentation/widgets/common_widgets/appbars/app_bar.dart';
import 'package:finutss/presentation/widgets/common_widgets/notification_drawer.dart';
import 'package:finutss/presentation/widgets/dialogs/sensor_dialogs/connection_dialog_combined.dart';
import 'package:finutss/presentation/widgets/dialogs/track_distance_dialogs/exit_workout_dialog.dart';
import 'package:finutss/presentation/widgets/map_page_widgets/all_user_run_distance.dart';
import 'package:finutss/presentation/widgets/map_page_widgets/card_button.dart';
import 'package:finutss/presentation/widgets/map_page_widgets/center_icon.dart';
import 'package:finutss/presentation/widgets/map_page_widgets/circle_icons.dart';
import 'package:finutss/presentation/widgets/map_page_widgets/message_widget.dart';
import 'package:finutss/presentation/widgets/map_page_widgets/timer_widget.dart';
import 'package:finutss/presentation/widgets/map_page_widgets/tips_card.dart';
import 'package:finutss/presentation/widgets/map_page_widgets/user_distance_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wakelock/wakelock.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with TickerProviderStateMixin {
  final MapController mapController = Get.put(MapController());
  final SensorController _sensorController = Get.put(SensorController());
  final AuthController authController = Get.put(AuthController());
  final ChatController chatController = Get.put(ChatController());
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
  bool isClicked = false;
  bool centerButtonClicked = false;
  final Duration duration = Duration(milliseconds: 2000);
  double height = 0;
  Widget? _animatedWidget;

  @override
  void initState() {
    print('-= initSate');
    Wakelock.enable();

    _animatedWidget = _chatWidget();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _translationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _translationController2 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    toBottomAnimation =
        Tween<double>(begin: 50, end: 0).animate(_translationController2);
    toTopAnimation =
        Tween<double>(begin: 30, end: 0).animate(_translationController);
    toRightAnimation =
        Tween<double>(begin: 50, end: 0).animate(_translationController);
    centerButtonAnimation = CurvedAnimation(
        parent: _animationController, curve: Curves.fastLinearToSlowEaseIn);

    _translationController.forward();
    _translationController2.forward();
    _animationController.forward();
    super.initState();
  }

  Widget _closeWidget() {
    return Container(
      key: LabeledGlobalKey("one"),
      height: 41.h,
      width: 41.h,
      child: RawMaterialButton(
        elevation: 2,
        onPressed: null,
        child: Icon(
          Icons.close,
          color: Colors.white,
        ),
        fillColor: Color(0xfff7386b),
        shape: CircleBorder(),
      ),
    );
  }

  Widget _chatWidget() {
    return Container(
      key: LabeledGlobalKey("two"),
      height: 41.h,
      width: 41.h,
      // duration: duration,
      child: centerIcon(onPressedFunction: null),
    );
  }

  @override
  void dispose() {
    GlobalBloc().subscriptionStream?.cancel();
    GlobalBloc().subscriptionStream = null;

    GlobalBloc().subscriptionStreamForChat?.cancel();
    GlobalBloc().subscriptionStreamForChat = null;

    mapController.pauseDuration();
    mapController.resetDuration();

    _sensorController.cancleNotification();
    _sensorController.clearValue();

    _controller?.webViewController.clearCache();
    Wakelock.disable();
    //채팅 종료

    _translationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('-= map_page build');
    FlutterBlue.instance.setLogLevel(LogLevel.emergency);

    ///TODO
    // var trackId = mapController.jsonTrack?.trackId;
    var trackId = '61e4e2aacdb92937db97ba0b';
    var isDownSpeed = true;

    double? distance = mapController.jsonTrack?.distance;

    if (mapController.iskmHalf) distance = distance! * 0.5;
    if (mapController.iskmShort) distance = distance! * 0.25;

    ///TODO
    //createWorkOut(trackId);

    return WillPopScope(
      onWillPop: () {
        Get.dialog(ExitWorkoutDialog());
        return Future(() => false);
      },
      child: Scaffold(
        key: scaffoldKey,
        endDrawer: ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15.r),
              topLeft: Radius.circular(15.r)),
          child: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors.transparent,
            ),
            child: SafeArea(
              child: Drawer(
                child: NotificationDrawer(),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: GetBuilder<MapController>(
            builder: (mapController) {
              return GetBuilder<SensorController>(
                builder: (sensorController) {
                  double speed = 0;

                  if ((authController.user?.workoutType ?? "Riding") ==
                      "Riding") {
                    speed = sensorController.mWheel.length > 0
                        ? (sensorController.mWheel['speed'] ?? 0)
                        : (sensorController.mCrank['crankCadence'] ?? 0) *
                            sensorController
                                .sensitivityList[sensorController.sensitivity];
                  } else {
                    if (sensorController.mRSC.length > 0) {
                      speed = (sensorController.mRSC['speed']?.toDouble() ?? 0);
                    }
                    if (sensorController.mPad.length > 0) {
                      speed = sensorController.mPad['speed']?.toDouble() ?? 0;
                    }
                  }
                  if (sensorController.mWheel.length > 0 ||
                      sensorController.mCrank.length > 0) {}

                  return Container(
                    child: Stack(
                      children: [
                        /* -------------------------------------------------------------------------- */
                        /*                                     map                                    */
                        /* -------------------------------------------------------------------------- */
                        Positioned.fill(
                          child: WebViewPlus(
                              initialUrl: 'assets/webview/index.html',
                              javascriptMode: JavascriptMode.unrestricted,
                              onWebViewCreated:
                                  (WebViewPlusController controller) {
                                print("init web view");
                                _controller = controller;
                                // _setUserImg(controller, context);
                              },
                              onPageFinished: (url) {
                                String type = "normal";
                                if (mapController.iskmShort) type = "short";
                                if (mapController.iskmHalf) type = "half";

                                Timer(
                                    Duration(milliseconds: 500),
                                    () => _controller!.webViewController
                                        .evaluateJavascript(
                                            'setPath("$trackId", "$type")'));
                                _setMyMarker(_controller!);

                                sensorController.setListener((speed) {
                                  _onChangeSpeed(_controller!, context, speed);
                                  isDownSpeed = false;
                                });

                                // _onChangeSpeed(_controller!, context, 25);
                                mapController.startDuration();
                                print("init Subscription");
                                Timer(
                                    Duration(milliseconds: 1000),
                                    () => GlobalBloc().setSubscription(
                                            WorkOutQueries.NEW_WORKOUT,
                                            {'track': "track"},
                                            callback: (result) {
                                          result.data!['newWorkOut']
                                              .removeWhere((item) =>
                                                  item['writer']['id'] ==
                                                  authController.user?.userId);
                                          var sendMsg = jsonEncode(
                                              result.data!['newWorkOut']);
                                          _controller!.webViewController
                                              .evaluateJavascript(
                                                  'setUser($sendMsg)');
                                        }));
                              },
                              javascriptChannels: <JavascriptChannel>[
                                JavascriptChannel(
                                    name: 'update',
                                    onMessageReceived:
                                        (JavascriptMessage msg) async {
                                      if (authController.user == null) return;
                                      var data = jsonDecode(msg.message);
                                      sensorController
                                          .setPhaseToWorkout(data['phase']);
                                      GlobalBloc().queryMutate(
                                          WorkOutQueries.UPDATE_WORKOUT, {
                                        'data': {
                                          'id': sensorController.workout['id'],
                                          'phase': data['phase'],
                                          'duration': data['duration'],
                                          'distance': data['distance'],
                                          'kcal': data['kcal'],
                                          'workoutType': authController
                                                  .user?.workoutType ??
                                              "Riding"
                                        },
                                      });
                                      isSend = true;
                                    }),
                                JavascriptChannel(
                                    name: 'finish',
                                    onMessageReceived:
                                        (JavascriptMessage msg) async {
                                      if (authController.user == null) return;
                                      print("finish");
                                      var data = jsonDecode(msg.message);
                                      sensorController.setPhaseToWorkout(1);
                                      await GlobalBloc().queryMutate(
                                          WorkOutQueries.UPDATE_WORKOUT, {
                                        'data': {
                                          'id': sensorController.workout['id'],
                                          'phase': data['phase'],
                                          'duration': data['duration'],
                                          'distance': data['distance'],
                                          'kcal': data['kcal'],
                                          'finish': true,
                                          'workoutType': authController
                                                  .user?.workoutType ??
                                              "Riding"
                                        },
                                      });
                                      isSend = true;
                                      Timer(
                                          Duration(seconds: 2),
                                          () => Get.off(
                                              () => WorkoutResultScreen(),
                                              arguments: sensorController
                                                  .workout['id']));
                                    })
                              ].toSet()),
                        ),
                        /* -------------------------------------------------------------------------- */
                        /*                        top alight app bar and speed                        */
                        /* -------------------------------------------------------------------------- */
                        Align(
                            alignment: Alignment.topCenter,
                            // child: appbar(title: 'abc'),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 60.h,
                                  child: appbar(
                                      isTrackDistanceScreen: true,
                                      key: scaffoldKey,
                                      automaticallyImplyLeading: true,
                                      isGoingBack: false,
                                      titleWidget: InkWell(
                                        child: timerWidget(
                                            duration: mapController.duration),
                                        onTap: () {
                                          _onChangeSpeed(
                                              _controller!, context, 500);
                                        },
                                      )),
                                ),
                                size10,
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: 15.0.w, left: 15.w),
                                  child: allUserRunDistance(
                                      mapController.allUserDistance,
                                      speed.toInt()),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 10.0.h, left: 20.w),
                                  child: _speedText(speed),
                                )
                              ],
                            )),

                        /* -------------------------------------------------------------------------- */
                        /*                       chat message and bottom buttons                      */
                        /* -------------------------------------------------------------------------- */
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Stack(
                                alignment: AlignmentDirectional.bottomCenter,
                                children: [
                                  if (!isClicked) buildMassage(),
                                  if (isClicked)
                                    Column(
                                      children: [
                                        Transform.translate(
                                          offset:
                                              Offset(toRightAnimation.value, 0),
                                          child: FadeTransition(
                                            opacity: _translationController
                                                .drive(CurveTween(
                                                    curve: Curves.easeOut)),
                                            child: Padding(
                                              padding: EdgeInsets.all(8.r),
                                              child: tipsCard('TIP_INFO'.tr),
                                            ),
                                          ),
                                        ),
                                        Transform.translate(
                                          offset:
                                              Offset(0, toTopAnimation.value),
                                          child: FadeTransition(
                                            opacity: _translationController
                                                .drive(CurveTween(
                                                    curve: Curves.easeOut)),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    circleIcons(
                                                        icon: Icons
                                                            .online_prediction,
                                                        iconColor:
                                                            Color(0xff3BCCE1),
                                                        onPressedFunction: () {
                                                          Get.dialog(
                                                              ConnectionDialogCombined(),
                                                              barrierDismissible:
                                                                  false);
                                                        }),
                                                    size10,
                                                    circleIcons(
                                                        onPressedFunction: () {
                                                          Get.to(() =>
                                                              InviteFriendsScreen());
                                                        },
                                                        icon:
                                                            Icons.mail_outline,
                                                        iconColor:
                                                            Color(0xff3BCCE1)),
                                                    size10,
                                                    circleIcons(
                                                        onPressedFunction: () {
                                                          Get.to(() =>
                                                              DeclareCategoryScreen());
                                                        },
                                                        icon:
                                                            CommunityMaterialIcons
                                                                .chat_outline,
                                                        iconColor:
                                                            Color(0xff3BCCE1)),
                                                  ],
                                                ),
                                                size20,
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Transform.translate(
                                    offset: Offset(0, toBottomAnimation.value),
                                    child: FadeTransition(
                                      opacity: _translationController2.drive(
                                          CurveTween(curve: Curves.easeOut)),
                                      child: cardButton(
                                          icon: CommunityMaterialIcons.chat,
                                          text: 'CHAT'.tr,
                                          onPressedFunction: () async {
                                            // _bottomSheetController.forward();
                                            showModalBottomSheet(
                                                backgroundColor:
                                                    Colors.transparent,
                                                isScrollControlled: true,
                                                context: context,
                                                builder: (context) {
                                                  return SafeArea(
                                                      child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 40.h),
                                                    child: ChatPage(),
                                                  ));
                                                });
                                          }),
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
                                        await Future.delayed(
                                            Duration(milliseconds: 300));

                                        setState(() {
                                          _animatedWidget = _closeWidget();
                                        });
                                        await Future.delayed(
                                            Duration(milliseconds: 300));

                                        _animationController.forward();
                                      } else {
                                        _translationController.reset();
                                        _translationController.forward();
                                        //for chat and people button
                                        _translationController2.forward();

                                        //for center button
                                        _animationController.reverse();
                                        await Future.delayed(
                                            Duration(milliseconds: 300));

                                        setState(() {
                                          _animatedWidget = _chatWidget();
                                        });
                                        await Future.delayed(
                                            Duration(milliseconds: 300));

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
                                      reverseDuration:
                                          Duration(milliseconds: 300),
                                      child: _animatedWidget,
                                    ),
                                    // child: _animatedWidget,
                                  ),
                                  Transform.translate(
                                    offset: Offset(0, toBottomAnimation.value),
                                    child: FadeTransition(
                                      opacity: _translationController2.drive(
                                          CurveTween(curve: Curves.easeOut)),
                                      child: GetBuilder<WorkoutInController>(
                                        builder: (controller) {
                                          return cardButton(
                                            icon: Icons.group,
                                            text:
                                                '${controller.docs.length}/100',
                                            onPressedFunction: () {
                                              showModalBottomSheet(
                                                backgroundColor:
                                                    Colors.transparent,
                                                isScrollControlled: true,
                                                context: context,
                                                builder: (context) {
                                                  return SafeArea(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 40.0.h),
                                                      child: LiveUserScreen(
                                                        isMapPage: false,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                              // Get.to(() => LiveUserScreen());
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              size20,
                            ],
                          ),
                        ),
                        /* -------------------------------------------------------------------------- */
                        /*                             walk distance meter                            */
                        /* -------------------------------------------------------------------------- */
                        Positioned(
                          top: 147.h,
                          right: 12.w,
                          child: Padding(
                            padding: EdgeInsets.only(right: 15.0.w),
                            child: runDistance(
                              goal: distance != null ? distance : 15,
                              ratio: sensorController.workout == null
                                  ? 0.0
                                  : sensorController.workout["phase"]
                                      .toDouble(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _onChangeSpeed(WebViewPlusController controller, BuildContext context,
      double speed) async {
    print('_onChangeSpeed');
    await controller.webViewController
        .evaluateJavascript("changeSpeed('$speed')");
  }

  void _setMyMarker(WebViewPlusController controller) async {
    print('_setMyMarker');

    var data =
        '{"image": "${authController.user?.image?.url ?? "https://finutss.s3.ap-northeast-2.amazonaws.com/assets/finutss_default_profile.png"}", "type": "${authController.user?.workoutType ?? "Riding"}"}';
    controller.webViewController.evaluateJavascript('setMyMarker($data)');
  }

  Future<void> createWorkOut(trackId) async {
    if (authController.user == null) return;
    print('-= ADD_WORKOUT');
    var workout = await GlobalBloc().queryMutate(
      WorkOutQueries.ADD_WORKOUT,
      {
        'data': {'track': trackId, 'phase': 0}
      },
    ).then(
      (workout) {
        _sensorController.workout = workout['data']['addWorkOut'];
      },
    );
  }

  Widget _speedText(speed, {unit = 'km/h'}) {
    speed = speed.toStringAsFixed(1) ?? 0;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "$speed",
          style: TextStyle(
            color: Color(0xfff73a6b),
            fontSize: 30.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 3.w),
        Text(
          "$unit",
          style: TextStyle(
            color: Color(0xfff73a6b),
            fontSize: 16.sp,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  buildMassage() {
    return GetBuilder<ChatController>(
      builder: (controller) {
        var size = controller.listMessage.length;
        var printMsg;
        if (size > 4)
          printMsg = controller.listMessage.skip(size - 4).take(4);
        else
          printMsg = controller.listMessage;
        return Column(
          children: [
            for (var item in printMsg)
              messageWidget(
                  message: item["description"], userInfo: item["writer"])
          ],
        );
      },
    );
  }
}
