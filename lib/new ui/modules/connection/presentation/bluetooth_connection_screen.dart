import 'package:finutss/new%20ui/controller/new_sensor_controller.dart';
import 'package:finutss/new%20ui/modules/connection/controller/connection_controller.dart';
import 'package:finutss/new%20ui/modules/connection/presentation/calibration_guide_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/connection/presentation/wheel_size_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/connection/widget/close_button.dart';
import 'package:finutss/new%20ui/modules/connection/widget/device_tile.dart';
import 'package:finutss/new%20ui/modules/home/widget/custom_card_widget.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/log_utils.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/bluetooth_connection_tile.dart';
import 'package:finutss/new%20ui/widget/custom_button.dart';
import 'package:finutss/presentation/presentation/animation/bouncing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothConnectionScreen extends StatefulWidget {
  BluetoothConnectionScreen({Key? key, this.icon, this.title,required this.searchDes,required this.isShowWheelSize,required this.isRiding})
      : super(key: key);
  final String? icon;
  final String? title;
  bool isShowWheelSize;
  bool isRiding;
  String searchDes;

  @override
  State<BluetoothConnectionScreen> createState() =>
      _BluetoothConnectionScreenState();
}

class _BluetoothConnectionScreenState extends State<BluetoothConnectionScreen>
    with SingleTickerProviderStateMixin {
  final ConnectionController connectionController = Get.find();
  final NewSensorController sensorController = Get.find();
  late AnimationController _controller;

  @override
  void initState() {
    LogUtils.logMSG('initState bluetooth connect screen', StackTrace.empty);
    sensorController.startScan(widget.isRiding);
    sensorController.setScanListener();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 5000),
    )..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            _controller.repeat();
          }
        },
      );

    _controller.reset();
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    print("Dialog Disposed");
    _controller.dispose();
    sensorController.cancelScanListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FlutterBlue.instance.setLogLevel(LogLevel.emergency);
    return GetBuilder<NewSensorController>(
      builder: (sensorController) {
        return Material(
          color: AppColor.black.withOpacity(0.5),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: Column(
              children: [
                CloseButtonCustom(
                  onTap: (){
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
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 15.w,
                        right: 15.w,
                        top: 26.h,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "CONNECTION".tr.toUpperCase(),
                            style: TextStyle(
                              color: AppColor.blueTextColor,
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "CONNECTION_STATUS".tr,
                                        style: TextStyle(
                                          color: AppColor.blueTextColor[100],
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Bouncing(
                                        duration: Duration(milliseconds: 100),
                                        onPressed: (){
                                          Navigation.pop();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.w, vertical: 7.h),
                                          decoration: BoxDecoration(
                                              color: AppColor.lightPink,
                                              borderRadius:
                                                  BorderRadius.circular(14)),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                widget.icon ?? '',
                                                scale: 3.8,
                                              ),
                                              SizedBox(
                                                width: 8.w,
                                              ),
                                              Text(
                                                widget.title?.tr
                                                        .toLowerCase() ??
                                                    '',
                                                style: TextStyle(
                                                    color: AppColor.darkPink,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12.sp),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  sensorController.isStatusDialog
                                      ? Column(
                                          children: [
                                            if (sensorController.connectedDevices != null)
                                              for (var device in sensorController.connectedDevices)
                                               /* BluetoothConnectionTile(
                                                  bluetoothName: device.name,
                                                  bluetoothNumber:
                                                      device.id.toString(),
                                                  isConnect: true,
                                                  networkIcon:
                                                      IconAssets.greenNetwork,
                                                  topPrefixIcon:
                                                      IconAssets.clock,
                                                  isBluetooth: true,
                                                  onTap: () {
                                                    LogUtils.logMSG('-----tapped on connectedDevices bluetooth desConnect----', StackTrace.empty);

                                                    device.disconnect();
                                                    sensorController.update();
                                                  },
                                                ),*/


                                                if (sensorController.deviceSpeed != null && widget.isRiding)
                                                  BluetoothConnectionTile(
                                                    bluetoothName:
                                                    sensorController
                                                        .deviceSpeed ==
                                                        null
                                                        ? ""
                                                        : sensorController
                                                        .deviceSpeed?.name ?? '',
                                                    bluetoothNumber:
                                                    sensorController
                                                        .deviceSpeed ==
                                                        null
                                                        ? ""
                                                        : (sensorController
                                                        .deviceSpeed?.id ?? '')
                                                        .toString(),
                                                    isConnect: true,
                                                    networkIcon:
                                                    IconAssets.greenNetwork,
                                                    topPrefixIcon:
                                                    IconAssets.clock,
                                                    isBluetooth: true,
                                                    onTap: () {
                                                      LogUtils.logMSG('-----tapped on deviceSpeed bluetooth desConnect----',
                                                          StackTrace.empty);

                                                      sensorController
                                                          .deviceSpeed?.disconnect();
                                                      sensorController
                                                          .deviceSpeed = null;
                                                      sensorController.update();
                                                    },
                                                  ),
                                                if (sensorController.deviceCadence != null && widget.isRiding)
                                                  BluetoothConnectionTile(
                                                    bluetoothName:
                                                    (sensorController
                                                        .deviceCadence?.name ?? '').toString(),
                                                    bluetoothNumber:
                                                    (sensorController
                                                        .deviceCadence?.id ?? '')
                                                        .toString(),
                                                    isConnect: true,
                                                    networkIcon:
                                                    IconAssets.greenNetwork,
                                                    topPrefixIcon:
                                                    IconAssets.clock,
                                                    isBluetooth: true,
                                                    onTap: () {
                                                      LogUtils.logMSG('-----tapped on deviceCadence bluetooth desConnect----',
                                                          StackTrace.empty);

                                                      sensorController
                                                          .deviceCadence?.disconnect();
                                                      sensorController
                                                          .deviceCadence = null;
                                                      sensorController.update();
                                                    },
                                                  ),

                                            if (sensorController.deviceRSC != null && !widget.isRiding)
                                              BluetoothConnectionTile(
                                                bluetoothName:
                                                    (sensorController
                                                        .deviceRSC?.name ?? '').toString(),
                                                bluetoothNumber:
                                                    (sensorController
                                                        .deviceRSC?.id ?? '')
                                                        .toString(),
                                                isConnect: true,
                                                networkIcon:
                                                    IconAssets.greenNetwork,
                                                topPrefixIcon:
                                                    IconAssets.clock,
                                                isBluetooth: true,
                                                onTap: () {
                                                  LogUtils.logMSG('-----tapped on deviceRSC bluetooth desConnect----', StackTrace.empty);

                                                  sensorController.deviceRSC?.disconnect();
                                                  sensorController.deviceRSC =
                                                      null;
                                                  sensorController.update();
                                                },
                                              ),
                                            if (sensorController.devicePad != null && !widget.isRiding)
                                              BluetoothConnectionTile(
                                                bluetoothName:
                                                    (sensorController
                                                        .devicePad?.name ?? '').toString(),
                                                bluetoothNumber:
                                                    (sensorController
                                                        .devicePad?.id ?? '')
                                                        .toString(),
                                                isConnect: true,
                                                networkIcon:
                                                    IconAssets.greenNetwork,
                                                topPrefixIcon:
                                                    IconAssets.clock,
                                                isBluetooth: true,
                                                onTap: () {
                                                  //LogUtils.logMSG('-----tapped on devicePad bluetooth desConnect----', StackTrace.empty);

                                                  sensorController.devicePad?.disconnect();
                                                  sensorController.devicePad = null;
                                                  sensorController.update();
                                                },
                                              ),
                                          ],
                                        )
                                      : Container(
                                          height: 48.h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.r),
                                            color: Color(0xfff5f7fa),
                                          ),
                                          width: MediaQuery.of(context)
                                              .size
                                              .width,
                                          child: Center(
                                            child: Text(
                                              'NO_SENSORS_ARE_CONNECTED'.tr,
                                              style: TextStyle(
                                                color: AppColor.black,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                  /* ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      Constants.connectionModelList.length -
                                          1,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return BluetoothConnectionTile(
                                      bluetoothName: Constants
                                          .connectionModelList[index]
                                          .bluetoothName,
                                      bluetoothNumber: Constants
                                          .connectionModelList[index]
                                          .bluetoothNumber,
                                      isConnect: Constants
                                          .connectionModelList[index]
                                          .isConnect
                                          .value,
                                      networkIcon: Constants
                                          .connectionModelList[index]
                                          .networkIcon,
                                      topPrefixIcon: Constants
                                          .connectionModelList[index]
                                          .topPrefixIcon,
                                      isBluetooth: true,
                                      onTap: () {
                                        Navigation.pop();
                                      },
                                    );
                                  },
                                ),*/
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Obx(
                                    () => Container(
                                      decoration: BoxDecoration(
                                        color: AppColor.whiteColor[100],
                                        borderRadius:
                                            BorderRadius.circular(15),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 15.h,
                                        horizontal: 22.w,
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              Text(
                                                "SEARCH".tr,
                                                style: TextStyle(
                                                  color:
                                                      AppColor.blueTextColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                              Image.asset(
                                                IconAssets.information,
                                                height: 21.h,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          connectionController.isRescan.value
                                              ? SizedBox()
                                              : Text(
                                                  widget.searchDes.tr,
                                                  style: TextStyle(
                                                      color: AppColor
                                                          .blueTextColor[100],
                                                      height: 1.8,
                                                      fontSize: 14.sp),
                                                ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          searchBox(
                                            isStatus: sensorController
                                                .isStatusDialog,
                                            context: context,
                                            buttonColor: sensorController
                                                    .isStatusDialog
                                                ? AppColor.orangeColor
                                                : Colors.transparent,
                                            buttonTextColor: sensorController
                                                    .isStatusDialog
                                                ? AppColor.orangeColor
                                                : Colors.transparent,
                                            streamBuilder: Column(
                                              children: [
                                                if (sensorController
                                                        .scanResults !=
                                                    null)
                                                  for (var scanResult
                                                      in sensorController
                                                          .scanResults)
                                                    DeviceTileWidget(
                                                      netWorkIcon: IconAssets
                                                          .greenNetwork,
                                                      bluetoothNumber:
                                                          !scanResult
                                                                  .device.name
                                                                  .toString()
                                                                  .isEmpty
                                                              ? scanResult
                                                                  .device.name
                                                              : scanResult
                                                                  .device.id
                                                                  .toString(),
                                                      onTap: () async {
                                                        try {
                                                          if (sensorController
                                                                  .isLoading ==
                                                              false.obs) {
                                                            LogUtils.logMSG('tapped on connect button for specific bluetooth connect', StackTrace.empty);

                                                            await sensorController
                                                                .connect(
                                                                    scanResult
                                                                        .device);
                                                            sensorController
                                                                    .navigateToConnect =
                                                                false;
                                                            sensorController
                                                                .startScan(widget.isRiding);
                                                            sensorController
                                                                    .isStatusDialog =
                                                                true;
                                                            sensorController
                                                                .update();
                                                          }

                                                          LogUtils.logMSG('tapped on connect button in specific bluetooth---------> ', StackTrace.empty);

                                                        } catch (e) {
                                                          LogUtils.logMSG('-----tapped on connect button for specific bluetooth connect exception---->${e.toString()}', StackTrace.empty);
                                                         // snackBar('connectButton :$e');
                                                          print(
                                                              "connectButton====>>> $e");
                                                        }
                                                      },
                                                      index: 0,
                                                    ),
                                                /*  _connectToTile(
                                                    text: scanResult
                                                        .device.name,
                                                    textColor:
                                                    Color(0xff303443),
                                                    scale: 1,
                                                    networkImage:
                                                    'assets/images/network_green.png',
                                                    buttonOnTap:
                                                        () async {
                                                      try {
                                                        if (sensorController
                                                            .isLoading ==
                                                            false.obs) {
                                                          await sensorController
                                                              .connect(
                                                              scanResult
                                                                  .device);
                                                          sensorController
                                                              .navigateToConnect =
                                                          false;

                                                          sensorController
                                                              .startScan();
                                                          sensorController
                                                              .isStatusDialog =
                                                          true;
                                                          sensorController
                                                              .update();
                                                        }
                                                      } catch (e) {
                                                        snackBar(
                                                            'connectButton :$e');
                                                        print(
                                                            "connectButton====>>> $e");
                                                      }
                                                    },
                                                  )*/
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 22.h,
                                  ),

                                  widget.isShowWheelSize ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      Text(
                                        'PRESS_THE_CONNECT_BUTTON_TO_CONNECT_THE_SENSOR'
                                            .tr,
                                        style: TextStyle(
                                          color: AppColor.blueTextColor[100],
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15.sp,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 18.h,
                                      ),


                                      Obx(
                                            () => Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomCardWidget(
                                              onTap: () {
                                                wheelSizeBottomSheet(context);
                                              },
                                              title: "WHEEL_SIZE".tr,
                                              size: sensorController
                                                  .wheelSizesList
                                                  .firstWhere((element) =>
                                              element[1] ==
                                                  sensorController
                                                      .circumference
                                                      .value)[0],
                                            ),
                                            SizedBox(
                                              width: 20.w,
                                            ),
                                            CustomCardWidget(
                                              onTap: () {
                                                calibrationGuideBottomSheet(
                                                  context,
                                                );
                                              },
                                              title: "CALIBRATE_SPEED".tr,
                                              size: "(+" +
                                                  sensorController
                                                      .sensitivity.value
                                                      .toString() +
                                                  ")",
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ) : SizedBox(),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget searchBox(
      {required context,
      buttonColor = Colors.white,
      buttonTextColor = Colors.green,
      isStatus = false,
      Widget? streamBuilder}) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Color(0xfff5f7fa),
      ),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 14.w),
      duration: Duration(milliseconds: 300),
      child: Column(
        children: [
          StreamBuilder<bool>(
            stream: FlutterBlue.instance.isScanning,
            initialData: false,
            builder: (context, snapshot) {
              if (snapshot.data ?? false) {
                return _rescanProgressButton();
              } else {
                return CustomButton(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  onTap: () async {
                    await Permission.bluetoothScan.request().isGranted;
                    try {
                      LogUtils.logMSG('tapped on rescan button', StackTrace.empty);

                      _controller.reset();
                      _controller.forward();
                      sensorController.startScan(widget.isRiding);
                      sensorController.isStatusDialog = true;
                      sensorController.update();
                    } catch (e) {
                      LogUtils.logMSG('tapped on rescan button exception----->${e.toString()}', StackTrace.empty);

                      print(e);
                    }
                  },
                  backGroundColor: AppColor.orangeColor,
                  icon: IconAssets.whiteRescan,
                  showIcon: true,
                  isShowBorder: true,
                  title: "RESCAN".tr,
                  fontColor: AppColor.whiteColor,
                );
              }
            },
          ),
          SizedBox(
            height: 12.h,
          ),
          isStatus
              ? SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: streamBuilder,
                )
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
        ],
      ),
    );
  }

  _rescanProgressButton() {
    return InkWell(
      onTap: null,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            width: 1,
            color: AppColor.lightBlueTextColor,
          ),
          borderRadius: BorderRadius.circular(
            15.w,
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RotationTransition(
              turns: Tween(begin: 4.0, end: 0.0).animate(_controller),
              child: Image.asset(
                IconAssets.rescan,
                scale: 4,
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              "RESCAN".tr,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColor.lightBlueTextColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
