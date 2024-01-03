import 'dart:async';
import 'dart:io';

import 'package:finutss/new%20ui/controller/login_controller.dart';
import 'package:finutss/new%20ui/modules/connection/controller/connection_controller.dart';
import 'package:finutss/new%20ui/modules/connection/widget/close_button.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/log_utils.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/presentation/presentation/animation/bouncing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:location/location.dart' as locationLib;
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

enum StrideTestStatus { Start, Measuring, Save }

class StrideTestScreen extends StatefulWidget {
  StrideTestScreen({Key? key}) : super(key: key);

  @override
  State<StrideTestScreen> createState() => _StrideTestScreenState();
}

class _StrideTestScreenState extends State<StrideTestScreen>
    with SingleTickerProviderStateMixin {
  double progressValue = 0;
  Timer? _timer;
  Timer? _speedTimer;
  final locationLib.Location location = locationLib.Location();

  int? isStart;
  static int totalSteps = 0;
  bool isCount = false;
  late Stream<StepCount> _stepCountStream;
  String _steps = '0';
  late Stream<PedestrianStatus> _pedestrianStatusStream;

  // StreamSubscription<Position>? _positionStream;
  int previousStep = 0;
  int currentStep = 0;
  ValueNotifier<double> stepsSpeed = ValueNotifier(0.0);

  @override
  void initState() {
    isStart = StrideTestStatus.Start.index;
    super.initState();
  }

  void onStepCount(StepCount event) {
    if (isCount == false) {
      setState(() {
        totalSteps = event.steps;
        isCount = true;
      });
    }
    if (int.parse(_steps) < 20) {
      setState(() {
        _steps = (event.steps - totalSteps).toString();
        currentStep = int.parse(_steps);
        if (int.parse(_steps) >= 20) {
          _steps = 20.toString();
        }
      });
    } else {
      isStart = StrideTestStatus.Save.index;
      _timer?.cancel();
      _speedTimer?.cancel();
      setState(() {});
    }
  }

  void onStepCountError(error) {
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void initPlatformState() async {
    _pedestrianStatusStream = await Pedometer.pedestrianStatusStream;
    _stepCountStream = await Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
    // _positionStream = await Geolocator.getPositionStream().listen((position) {
    //   print("heyy -----speedAccuracy->${position.speedAccuracy}   speed----->${position.speed}");
    //   _speed.value = (position.speed);
    //   //Converting position speed from m/s to km/hr
    // });

    LogUtils.logMSG(
        'stride initPlatformState mounted ${mounted} ', StackTrace.empty);

    if (mounted) return;
  }

  permissionPhysicalActivity() async {
    if (Platform.isAndroid) {
      bool status = await Permission.activityRecognition.request().isGranted;
      LogUtils.logMSG('stride permission status ${status} ', StackTrace.empty);

      if (status) {
        isStart = StrideTestStatus.Measuring.index;
        initPlatformState();
        LogUtils.logMSG(
            'stride permission mounted ${mounted} ', StackTrace.empty);

        if (mounted) {
          _timer = Timer.periodic(const Duration(seconds: 2), (Timer _timer) {
            int stepDiff = currentStep - previousStep;
            stepsSpeed.value = (stepDiff * 0.762) * 3.6;
            previousStep = currentStep;
          });
          _speedTimer =
              Timer.periodic(const Duration(seconds: 1), (Timer _timer) {
            setState(() {
              progressValue++;
            });
          });

          LogUtils.logMSG('stride timer ${mounted} ', StackTrace.empty);
        }
      }
      await Permission.activityRecognition.request().isGranted;
    } else if (Platform.isIOS) {
      bool status = await Permission.sensors.request().isGranted;
      if (status) {
        isStart = StrideTestStatus.Measuring.index;
        initPlatformState();
        if (mounted) {
          _timer = Timer.periodic(
            const Duration(seconds: 2),
            (Timer _timer) {
              setState(
                () {
                  int stepDiff = currentStep - previousStep;
                  stepsSpeed.value = (stepDiff * 0.762) * 3.6;
                  previousStep = currentStep;
                },
              );
            },
          );
          _speedTimer =
              Timer.periodic(const Duration(seconds: 1), (Timer _timer) {
            setState(() {
              progressValue++;
            });
          });
        }
      } else if (await Permission.activityRecognition.isDenied) {
        await Permission.activityRecognition.request().then(
          (value) {
            if (value == PermissionStatus.granted) {
            } else if (value == PermissionStatus.denied) {}
          },
        );
      }
    }
  }

  bool data = false;
  final ConnectionController connectionController = Get.find();
  LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    connectionController.isSelectedType.value = false;
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          CloseButtonCustom(
            onTap: () {
              Get.back();
            },
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.elliptical(
                    MediaQuery.of(context).size.width,
                    100.0,
                  ),
                ),
              ),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.h),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    HeaderWidget(
                      icon: IconAssets.mobileRun,
                      title: "EXERCISER_RUNNING".tr,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.whiteColor[100],
                        borderRadius: BorderRadius.circular(
                          12.h,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.w,
                          vertical: 15.h,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 19.w,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'STRIDE_TEST'.tr,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.blueTextColor[100],
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Image.asset(
                                      IconAssets.checkBoxSelect,
                                      scale: 3.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.w,
                              ),
                              child: Text(
                                "MEASURE_THE_AVERAGE_MOVEMENT_VALUE_BY_PLACING_THE_MOBILE_DEVICE"
                                    .tr,
                                style: TextStyle(
                                  color:
                                      AppColor.blueTextColor.withOpacity(0.7),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13.sp,
                                  height: 1.5.h,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            Container(
                              height: 110.h,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    SleekCircularSlider(
                                      initialValue: double.parse(_steps),
                                      innerWidget: null,
                                      appearance: CircularSliderAppearance(
                                        size: 70.h,
                                        customWidths: CustomSliderWidths(
                                          trackWidth: 3,
                                          progressBarWidth: 5,
                                        ),
                                        infoProperties: info03,
                                        customColors: CustomSliderColors(
                                          progressBarColor:
                                              AppColor.orangeColor,
                                          trackColor: AppColor.inActiveBg,
                                          shadowColor: AppColor.gray,
                                        ),
                                        animationEnabled: false,
                                      ),
                                      min: 0,
                                      max: 20,
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      left: 0,
                                      child: Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.transparent,
                                          ),
                                          width: 30.w,
                                          height: 25.h,
                                          child: IgnorePointer(
                                            child: SvgPicture.asset(
                                              IconAssets.stepRoundIcon,
                                              color: AppColor.orangeColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.whiteColor,
                                borderRadius: BorderRadius.circular(
                                  8,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            ValueListenableBuilder(
                              valueListenable: stepsSpeed,
                              builder: (BuildContext context, double val,
                                  Widget? child) {
                                return Row(
                                  children: [
                                    Expanded(
                                      child: kmCard(
                                        title: val.toStringAsFixed(2),
                                        subTitle: 'KMH',
                                      ),
                                    ),
                                    SizedBox(
                                      width: 16.w,
                                    ),
                                    Expanded(
                                      child: kmCard(
                                        title: progressValue.toStringAsFixed(0),
                                        subTitle: 'SEC',
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: cancelButton(
                            onTap: () {
                              _timer?.cancel();
                              _speedTimer?.cancel();
                              Get.back();
                            },
                            title: "CANCEL".tr,
                          ),
                        ),
                        SizedBox(
                          width: 22.w,
                        ),
                        Expanded(
                          child: isStart == StrideTestStatus.Start.index
                              ? startButton(
                                  title: 'START_NOW',
                                  onTap: () async {
                                    loginController.user?.data?.workoutType
                                        ?.value = Constants.mobileSensor;
                                    LogUtils.logMSG(
                                        'stride test Start now screen isStart ${isStart}----StrideTestStatus.Start.index  ${StrideTestStatus.Start.index}',
                                        StackTrace.empty);
                                    if (isStart ==
                                        StrideTestStatus.Start.index) {
                                      LogUtils.logMSG(
                                          'stride test Start now permissionPhysicalActivity',
                                          StackTrace.empty);

                                      await permissionPhysicalActivity();
                                    } else if (isStart ==
                                        StrideTestStatus.Save.index) {
                                      LogUtils.logMSG(
                                          'stride test Start now else if',
                                          StackTrace.empty);

                                      Get.back(
                                        result: {'result': true},
                                      );
                                    } else {
                                      LogUtils.logMSG(
                                          'stride test Start now else==',
                                          StackTrace.empty);
                                    }
                                  },
                                )
                              : isStart == StrideTestStatus.Measuring.index
                                  ? Center(
                                      child: Text(
                                        'MEASURING'.tr + '...',
                                        style: TextStyle(
                                          color: AppColor.lightBlueTextColor,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 0.04,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    )
                                  : startButton(
                                      title: 'SAVE',
                                      onTap: () async {
                                        Navigation.pop();
                                        Constants.positionModelList[2]
                                            .isSelected.value = true;
                                      },
                                    ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget kmCard({String? title, String? subTitle}) {
  return Container(
    height: 38.h,
    decoration: BoxDecoration(
      color: AppColor.whiteColor,
      borderRadius: BorderRadius.circular(
        8,
      ),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 6.w,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                title ?? "",
                style: TextStyle(
                  color: AppColor.stepGreenColor,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                  height: 1.5.h,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              subTitle?.tr ?? "",
              style: TextStyle(
                color: AppColor.blueTextColor.withOpacity(0.4),
                letterSpacing: 0,
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                height: 1.5.h,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget cancelButton({String? title, required VoidCallback onTap}) {
  return Bouncing(
    duration: Duration(milliseconds: 100),
    onPressed: onTap,
    child: Container(
      height: 36.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          12,
        ),
        border: Border.all(
          width: 1.5,
          color: AppColor.cancelButtonBg,
        ),
      ),
      child: Center(
        child: Text(
          title ?? 'CANCEL'.tr,
          style: TextStyle(
            color: AppColor.cancelButtonColor,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.04,
            fontSize: 14.sp,
          ),
        ),
      ),
    ),
  );
}

Widget startButton({String? title, required VoidCallback onTap}) {
  return Bouncing(
    duration: Duration(milliseconds: 100),
    onPressed: onTap,
    child: Container(
      height: 36.h,
      width: 136.w,
      decoration: BoxDecoration(
        color: AppColor.orangeColor,
        borderRadius: BorderRadius.circular(
          12,
        ),
      ),
      child: Center(
        child: Text(
          title?.tr ?? 'START_NOW'.tr,
          style: TextStyle(
            color: AppColor.whiteColor,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.04,
            fontSize: 16.sp,
          ),
        ),
      ),
    ),
  );
}

final info03 = InfoProperties(
  bottomLabelStyle: TextStyle(
    color: AppColor.orangeColor,
    fontSize: 11.sp,
    fontStyle: FontStyle.italic,
    fontFamily: 'MontserratItalic',
    fontWeight: FontWeight.w600,
  ),
  bottomLabelText: 'STEPS'.tr,
  mainLabelStyle: TextStyle(
    color: AppColor.black,
    fontSize: 19.sp,
    fontWeight: FontWeight.w700,
  ),
  modifier: (double value) {
    final kcal = value.toInt();
    return '$kcal';
  },
);

class HeaderWidget extends StatelessWidget {
  final String? icon;
  final String? title;

  HeaderWidget({this.icon, this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.0.h, bottom: 20.h),
      child: Column(
        children: [
          Text(
            "CONNECTION".tr,
            style: TextStyle(
              color: AppColor.blueTextColor,
              fontSize: 19.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 36.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "TUTORIAL_1_6_SUBTITLE_MOBILE_DEVICE".tr,
                style: TextStyle(
                  color: AppColor.blueTextColor[100],
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 17.w,
                  vertical: 5.h,
                ),
                decoration: BoxDecoration(
                  color: AppColor.lightPink,
                  borderRadius: BorderRadius.circular(
                    15,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      icon ?? '',
                      scale: 3,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      title?.toLowerCase() ?? '',
                      style: TextStyle(
                          color: AppColor.darkPink,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
