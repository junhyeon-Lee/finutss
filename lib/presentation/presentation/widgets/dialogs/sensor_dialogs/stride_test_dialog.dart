import 'dart:async';
import 'dart:io';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/domain/controller/sensor_controller.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/heading_widget.dart';
import 'package:finutss/presentation/widgets/dialogs/sensor_dialogs/exerciser_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:location/location.dart' as locationLib;
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

enum StrideTestStatus { Start, Measuring, Save }

class StrideTestDialog extends StatefulWidget {
  @override
  _StrideTestDialogState createState() => _StrideTestDialogState();
}

class _StrideTestDialogState extends State<StrideTestDialog>
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
    if (int.parse(_steps) < 200) {
      setState(() {
        _steps = (event.steps - totalSteps).toString();
        currentStep = int.parse(_steps);
        if (int.parse(_steps) >= 200) {
          _steps = 200.toString();
        }
      });
    } else {
      isStart = StrideTestStatus.Save.index;
      _timer?.cancel();
      _speedTimer?.cancel();
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
    if (!mounted) return;
  }

  permissionPhysicalActivity() async {
    if (Platform.isAndroid) {
      bool status = await Permission.activityRecognition.request().isGranted;
      if (status) {
        isStart = StrideTestStatus.Measuring.index;
        initPlatformState();
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
        }
      }
      await Permission.activityRecognition.request().isGranted;
    } else if (Platform.isIOS) {
      bool status = await Permission.sensors.request().isGranted;
      if (status) {
        isStart = StrideTestStatus.Measuring.index;
        initPlatformState();
        if (mounted) {
          _timer = Timer.periodic(const Duration(seconds: 2), (Timer _timer) {
            setState(() {
              int stepDiff = currentStep - previousStep;
              stepsSpeed.value = (stepDiff * 0.762) * 3.6;
              previousStep = currentStep;
            });
          });
          _speedTimer =
              Timer.periodic(const Duration(seconds: 1), (Timer _timer) {
            setState(() {
              progressValue++;
            });
          });
        }
      } else if (await Permission.activityRecognition.isDenied) {
        await Permission.activityRecognition.request().then((value) {
          if (value == PermissionStatus.granted) {
          } else if (value == PermissionStatus.denied) {}
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SensorController>(
      builder: (controller) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
          contentPadding: EdgeInsets.zero,
          insetPadding:
              EdgeInsets.only(right: 16.w, left: 16.w, top: 60.h, bottom: 60.h),
          backgroundColor: Colors.white,
          content: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /* --------------------------------- heading -------------------------------- */
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(child: headingWidget(title: 'CONNECTION'.tr)),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CircleAvatar(
                        backgroundColor: colorBackgroundSilver,
                        radius: 20.r,
                        child: IconButton(
                            onPressed: () {
                              // _accelSubscription?.cancel();
                              // _positionStream?.cancel();
                              _timer?.cancel();
                              _speedTimer?.cancel();
                              Get.back();
                            },
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              CommunityMaterialIcons.window_close,
                              size: 24.r,
                              color: colorDarkGrey,
                            )),
                      ),
                    ),
                  ],
                ),
                size5,
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              subHeadingWidget(title: "Mobile Device"),
                              // Spacer(),
                              customButton(
                                onTapFunction: () {
                                  Get.back();
                                  Get.dialog(ExerciserDialog(),
                                      barrierDismissible: false);
                                },
                                text: 'EXERCISER_CHANGE'.tr,
                                width: 100,
                                height: 35,
                                textSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                borderColor: Colors.black,
                                textColor: Colors.black,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          commonDevice()
                        ]),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget commonDevice() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          border: Border.all(
            color: colorLightSilver,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'STRIDE_TEST'.tr,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: colorBackgroundSilver,
                    radius: 16.r,
                    child: IconButton(
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          CommunityMaterialIcons.check,
                          size: 20.r,
                          color: colorWhitish,
                        )),
                  ),
                ],
              ),
              Text(
                'Measure the average movement value by placing the mobile device in the wearing position and walking 200 steps in place or on the move.\nSelect [Start] to start the measurement.',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: colorLightGrey),
              ),
              /* IntrinsicHeight(
                child: Container(
                  height: 220.h,
                  child: RotationTransition(
                    turns: new AlwaysStoppedAnimation(65 / 360),
                    child: SfRadialGauge(axes: <RadialAxis>[
                      RadialAxis(
                          showLabels: false,
                          showTicks: false,
                          startAngle: 45,
                          endAngle: 360,
                          radiusFactor: 0.7,
                          minimum: 1,
                          maximum: 200,
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                                positionFactor: 0.1,
                                angle: 0,
                                widget: RotationTransition(
                                  turns: new AlwaysStoppedAnimation(-65 / 360),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        _steps.toString(),
                                        style: TextStyle(
                                            fontSize: 50.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Steps",
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ))
                          ],
                          pointers: <GaugePointer>[
                            RangePointer(
                              color: Colors.orange.withOpacity(0.6),
                              value: double.parse(_steps.toString()),
                              width: 0.128,
                              sizeUnit: GaugeSizeUnit.factor,
                              cornerStyle: CornerStyle.bothCurve,
                            )
                          ]),
                    ]),
                  ),
                ),
              ),*/
              Row(
                children: [
                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: stepsSpeed,
                      builder:
                          (BuildContext context, double val, Widget? child) {
                        return kmSecondButton(
                          val.toStringAsFixed(2),
                          'km/hr',
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child:
                        kmSecondButton(progressValue.toStringAsFixed(0), 'sec'),
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                children: [
                  customButton(
                    text: "Cancel",
                    color: colorWhite,
                    fontWeight: FontWeight.bold,
                    height: 48,
                    width: 141,
                    radius: 15,
                    textSize: 16,
                    borderColor: colorDarkGrey,
                    textColor: colorDarkGrey,
                    onTapFunction: () {
                      // _accelSubscription?.cancel();
                      // _positionStream?.cancel();
                      _timer?.cancel();
                      _speedTimer?.cancel();
                      Get.back();
                    },
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  customButton(
                    text: isStart == StrideTestStatus.Start.index
                        ? "Start"
                        : isStart == StrideTestStatus.Measuring.index
                            ? 'Measuring'
                            : 'Save',
                    color: colorBlue,
                    fontWeight: FontWeight.bold,
                    height: 48,
                    width: 141,
                    radius: 15,
                    textSize: 16,
                    onTapFunction: () async {
                      if (isStart == StrideTestStatus.Start.index) {
                        await permissionPhysicalActivity();
                      } else if (isStart == StrideTestStatus.Save.index) {
                        // _positionStream?.cancel();
                        Get.back(result: {'result': true});
                      } else {}
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget kmSecondButton(String count, String measurement) {
    return Container(
      height: 60.h,
      decoration: BoxDecoration(
        color: colorBackgroundSilver,
        borderRadius: BorderRadius.all(Radius.circular(14)),
        border: Border.all(
          color: colorLightSilver,
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              count,
              style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0.h),
              child: Text(
                measurement,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
