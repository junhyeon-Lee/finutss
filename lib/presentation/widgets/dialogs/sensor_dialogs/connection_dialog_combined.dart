import 'package:community_material_icon/community_material_icon.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/domain/controller/sensor_controller.dart';
import 'package:finutss/domain/controller/tutorial_controller.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/heading_widget.dart';
import 'package:finutss/presentation/widgets/dialogs/sensor_dialogs/exerciser_dialog.dart';
import 'package:finutss/presentation/widgets/sensor_widgets/add_sensor_row.dart';
import 'package:finutss/presentation/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ConnectionDialogCombined extends StatefulWidget {
  @override
  _ConnectionDialogCombinedState createState() =>
      _ConnectionDialogCombinedState();
}

class _ConnectionDialogCombinedState extends State<ConnectionDialogCombined>
    with SingleTickerProviderStateMixin {
  final _sensorController = Get.put(SensorController());
  final tutorialController = Get.put(TutorialController());
  late AnimationController _controller;

  // Animation<double> _animation;

  @override
  void initState() {
    _sensorController.startScan();
    _sensorController.setScanListener();
    print("Dialog Created");
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 5000),
    )
      // ..addListener(() {
      //   setState(() {});
      // })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.repeat();
        }
      });
    // _animation = CurvedAnimation(
    //   parent: _controller,
    //   curve: Curves.elasticOut,
    // );
    _controller.reset();
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    print("Dialog Disposed");
    _controller.dispose();
    _sensorController.cancelScanListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FlutterBlue.instance.setLogLevel(LogLevel.emergency);
    return GetBuilder<SensorController>(
      builder: (sensorController) {
        return GetBuilder<AuthController>(
          builder: (authController) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r)),
              contentPadding: EdgeInsets.zero,
              insetPadding:
                  EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              backgroundColor: Colors.white,
              content: Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /* --------------------------------- heading -------------------------------- */
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Center(child: headingWidget(title: 'CONNECTION'.tr)),
                        Align(
                          alignment: Alignment.centerRight,
                          child: CircleAvatar(
                            backgroundColor: colorBackgroundSilver,
                            radius: 20.r,
                            child: IconButton(
                                onPressed: () {
                                  Get.back();
                                  tutorialController.showTotorial(
                                      tutorialController.WorkoutIndex);
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
                    /* ------------------------------- subheading ------------------------------- */
                    size30,
                    // connection status and exerciser dialog
                    Row(
                      children: [
                        subHeadingWidget(title: "CONNECTION_STATUS".tr),
                        Spacer(),
                        customButton(
                            onTapFunction: () {
                              Get.back();
                              Get.dialog(ExerciserDialog(),
                                  barrierDismissible: false);
                            },
                            icon: (authController.user?.workoutType ??
                                        "Riding") ==
                                    "Riding"
                                ? "assets/images/icon_exerciser_ride.png"
                                : "assets/images/icon_exerciser_run.png",
                            text: 'EXERCISER_CHANGE'.tr,
                            width: 100,
                            height: 35,
                            textSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            borderColor: Colors.black,
                            textColor: Colors.black),
                      ],
                    ),
                    // add row and put exerciser button
                    size15,
                    /* ---------------------------- 1st row condition --------------------------- */
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // _sensorController.isStatusDialog
                            //     ? Column(
                            //         children: [
                            //           if (sensorController.connectedDevices !=
                            //               null)
                            //             for (var device in sensorController
                            //                 .connectedDevices)
                            //               _connectionTypeCard(
                            //                   context: context,
                            //                   title: device.name,
                            //                   device: device,
                            //                   onTap: () {
                            //                     device.disconnect();
                            //                     sensorController.update();
                            //                   }),
                            //           if (sensorController.deviceSpeed != null)
                            //             _connectionTypeCard(
                            //               text: "SPEED".tr,
                            //               context: context,
                            //               title: sensorController
                            //                   .deviceSpeed!.name,
                            //               device: sensorController.deviceSpeed!,
                            //               onTap: () {
                            //                 sensorController.deviceSpeed!
                            //                     .disconnect();
                            //                 sensorController.deviceSpeed = null;
                            //                 sensorController.update();
                            //               },
                            //             ),
                            //           if (sensorController.deviceCadence !=
                            //               null)
                            //             _connectionTypeCard(
                            //                 text: "CADENCE".tr,
                            //                 context: context,
                            //                 title: sensorController
                            //                     .deviceCadence!.name,
                            //                 device:
                            //                     sensorController.deviceCadence!,
                            //                 onTap: () {
                            //                   sensorController.deviceCadence!
                            //                       .disconnect();
                            //                   sensorController.deviceCadence =
                            //                       null;
                            //                   sensorController.update();
                            //                 }),
                            //           if (sensorController.deviceRSC != null)
                            //             _connectionTypeCard(
                            //                 text: "RSC".tr,
                            //                 context: context,
                            //                 title: sensorController
                            //                     .deviceRSC!.name,
                            //                 device: sensorController.deviceRSC!,
                            //                 onTap: () {
                            //                   sensorController.deviceRSC!
                            //                       .disconnect();
                            //                   sensorController.deviceRSC = null;
                            //                   sensorController.update();
                            //                 }),
                            //           if (sensorController.devicePad != null)
                            //             _connectionTypeCard(
                            //                 text: "PAD".tr,
                            //                 context: context,
                            //                 title: sensorController
                            //                     .devicePad!.name,
                            //                 device: sensorController.devicePad!,
                            //                 onTap: () {
                            //                   sensorController.devicePad!
                            //                       .disconnect();
                            //                   sensorController.devicePad = null;
                            //                   sensorController.update();
                            //                 })
                            //         ],
                            //       )
                            //     : Container(
                            //         height: 48.h,
                            //         decoration: BoxDecoration(
                            //           borderRadius: BorderRadius.circular(12.r),
                            //           color: Color(0xfff5f7fa),
                            //         ),
                            //         width: MediaQuery.of(context).size.width,
                            //         child: Center(
                            //           child: customText(
                            //             text: 'NO_SENSORS_ARE_CONNECTED'.tr,
                            //             fontColor: colorWhitish,
                            //             fontSize: 14,
                            //           ),
                            //         ),
                            //       ),
                            size15,
                            _searchBox(
                              isStatus: _sensorController.isStatusDialog,
                              context: context,
                              buttonColor: _sensorController.isStatusDialog
                                  ? colorDarkGrey
                                  : Colors.white,
                              buttonTextColor: _sensorController.isStatusDialog
                                  ? Colors.white
                                  : colorLightSilver,
                              streamBuilder: Column(
                                children: [
                                  if (sensorController.scanResults != null)
                                    for (var scanResult
                                        in sensorController.scanResults)
                                      _connectToTile(
                                        text: scanResult.device.name,
                                        textColor: Color(0xff303443),
                                        scale: 1,
                                        networkImage:
                                            'assets/images/network_green.png',
                                        buttonOnTap: () async {
                                          try {
                                            if (_sensorController.isLoading == false.obs) {
                                              await _sensorController.connect(scanResult.device);
                                              _sensorController.navigateToConnect = false;

                                              _sensorController.startScan();
                                              _sensorController.isStatusDialog =
                                                  true;
                                              _sensorController.update();
                                            }
                                          } catch (e) {
                                            snackBar('connectButton :$e');
                                            print("connectButton====>>> $e");
                                          }
                                        },
                                      )
                                ],
                              ),
                              // buttonColor: sensorController.isStatusDialog ? Colors.white : darkGreyColor,
                              // buttonTextColor:
                              //     sensorController.isStatusDialog ? lightSilverColor : Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    addSensorRow(),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _searchBox(
      {required context,
      buttonColor = Colors.white,
      buttonTextColor = colorLightSilver,
      isStatus = false,
      Widget? streamBuilder}) {
    var isPressed = false;
    return GetBuilder<AuthController>(builder: (authController) {
      return AnimatedContainer(
        height: !isStatus ? 211.h : 461.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Color(0xfff5f7fa),
        ),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 14.w),
        duration: Duration(milliseconds: 300),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                subHeadingWidget(title: 'SEARCH_SENSOR'.tr),
                GestureDetector(
                  onTap: () {
                    tutorialController
                        .showSensorTutorial(tutorialController.SensorIndex);
                  },
                  child: Image.asset(
                    'assets/images/exclamation.png',
                    height: 24.r,
                  ),
                ),
              ],
            ),
            size10,
            RichText(
              text: TextSpan(
                text: (authController.user?.workoutType ?? "Riding") == "Riding"
                    ? 'ATTEMPT_TO_CONNECT_TO_THE_SENSOR_RIDE'.tr
                    : 'ATTEMPT_TO_CONNECT_TO_THE_SENSOR_RUN'.tr,
                style: TextStyle(
                  color: Color(0xff7f8391),
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            size5,
            isStatus
                ? streamBuilder!
                // ? Column(children: [
                //     for (var data in sensorController.dummySensorList)
                //       _connectToTile(
                //           text: data['network'],
                //           textColor: Color(0xff303443),
                //           scale: 1,
                //           networkImage: data['networkPath'],
                //           buttonOnTap: () {
                //             Get.back();
                //             // controller.navigateToConnect = false;
                //             // controller.update();
                //           })
                //   ])
                : RichText(
                    text: TextSpan(
                      text: 'ATTEMPT TO CONNECT TO THE SENSOR'.tr,
                      style: TextStyle(
                        color: Color(0xff7f8391),
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
            size15,
            StreamBuilder<bool>(
              stream: FlutterBlue.instance.isScanning,
              initialData: false,
              builder: (c, snapshot) {
                if (snapshot.data!) {
                  return _rescanProgressButton(
                      buttonColor: buttonColor,
                      buttonTextColor: buttonTextColor);
                } else {
                  return _rescanButton(
                    onTap: () async {
                      await Permission.bluetoothScan.request().isGranted;
                      snackBar('rescan button press');
                      try {
                        print('-----start----');
                        _controller.reset();
                        _controller.forward();
                        _sensorController.startScan();
                        _sensorController.isStatusDialog = true;
                        _sensorController.update();
                      } catch (e) {
                        print('----stop-----');
                        snackBar('reScan :$e');
                        print(e);
                      }
                    },
                    buttonTextColor: buttonTextColor,
                    buttonColor: buttonColor,
                  );
                }
              },
            ),
            size15,
          ],
        ),
      );
    });
  }

  _rescanButton({buttonColor, buttonTextColor, required Function onTap}) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: colorDarkGrey,
        ),
        padding: EdgeInsets.symmetric(vertical: 15.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.sync,
              size: 24.r,
              color: Colors.white,
            ),
            size10,
            Text(
              'RESCAN'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _rescanProgressButton({buttonColor, buttonTextColor}) {
    return InkWell(
      onTap: null,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(vertical: 15.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RotationTransition(
              turns: Tween(begin: 4.0, end: 0.0).animate(_controller),
              // turns: _animation,
              child: Icon(
                Icons.sync,
                size: 24.r,
                color: colorLightSilver,
              ),
            ),
            size10,
            Text(
              'RESCAN'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colorLightSilver,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _connectionTypeCard({
    required context,
    onTap,
    text = 'None',
    image = 'assets/images/clock.png',
    wifiImage = 'assets/images/network_green.png',
    String title = "",
    required BluetoothDevice device,
  }) {
    // if (SensorController.devicesMap.containsKey(device.id)) {
    //   var type = SensorController.devicesMap[device.id]["type"];
    //   if (type == DeviceType.CADENCE) text = "Speed";
    //   if (type == DeviceType.SPEED) text = "Cadence";
    // }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Color(0xfff5f7fa),
      ),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 14.w),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            image,
            height: 46.r,
          ),
          size10,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    text,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  size10,
                  Image.asset(
                    wifiImage,
                    width: 24.r,
                    height: 24.r,
                  ),
                ],
              ),
              size5,
              Text(
                title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          Spacer(),
          InkWell(
            onTap: onTap,
            child: Container(
              // width: 64,
              // height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 13.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/bluetooth_off.png',
                      width: 24.r,
                      height: 24.r,
                      //scale: 1,
                    ),
                    Text(
                      "OFF".tr,
                      style: TextStyle(
                        color: Color(0xff41465c),
                        fontSize: 12.sp,
                        /*fontFamily: "Montserrat",*/ fontWeight:
                            FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _connectToTile({
    String text = 'XOSS-6946317',
    Color textColor = const Color(0xff7f8391),
    String networkImage = 'assets/images/network_green.png',
    double scale = 1.5,
    Function? buttonOnTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xffcdd5e9),
          width: 0.50,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 9.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 14.sp,
                // fontFamily: "Montserrat",
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Row(
            children: [
              Image.asset(
                networkImage,
                height: 24.r,
              ),
              SizedBox(
                width: 10.w,
              ),
              customButton(
                text: 'CONNECT'.tr,
                width: 80.w,
                height: 34.h,
                onTapFunction: buttonOnTap,
              )
            ],
          )
        ],
      ),
    );
  }
}
