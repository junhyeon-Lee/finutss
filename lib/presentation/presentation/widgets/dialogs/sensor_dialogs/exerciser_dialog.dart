import 'package:community_material_icon/community_material_icon.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/domain/controller/sensor_controller.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/heading_widget.dart';
import 'package:finutss/presentation/widgets/dialogs/sensor_dialogs/connection_dialog_combined.dart';
import 'package:finutss/presentation/widgets/dialogs/sensor_dialogs/mobile_device_connection_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ExerciserDialog extends StatefulWidget {
  @override
  _ExerciserDialogState createState() => _ExerciserDialogState();
}

class _ExerciserDialogState extends State<ExerciserDialog> with SingleTickerProviderStateMixin {
  final sensorController = Get.put(SensorController());
  late AnimationController _controller;
  bool isLoading = false;

  // Animation<double> _animation;

  List sensorList = [];

  scanSensors() async {
    // sensorController.isStatusDialog = true;
    // sensorController.update();
    setState(() {
      isLoading = true;
    });
    setState(() {
      sensorList = [];
    });
    await Future.forEach(sensorController.dummySensorList, (dynamic element) async {
      int index = sensorController.dummySensorList.indexOf(element);
      await Future.delayed(Duration(milliseconds: 1000));
      print(index);
      setState(() {
        sensorList.add(element);
      });
    });
    // sensorController.isStatusDialog = false;
    // sensorController.update();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    print("Dialog Created");
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 5000),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.repeat();
        }
      });
    // _animation = CurvedAnimation(
    //   parent: _controller,
    //   curve: Curves.elasticOut,
    // );
    super.initState();
  }

  @override
  void dispose() {
    print("Dialog Disposed");
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SensorController>(builder: (controller) {
      return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
          contentPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.only(right: 16.w, left: 16.w, top: 60.h, bottom: 60.h),
          backgroundColor: Colors.white,
          content: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              /* --------------------------------- heading -------------------------------- */
              Stack(
                alignment: Alignment.center,
                children: [
                  Center(child: headingWidget(title: 'EXERCISER'.tr)),
                  Align(
                    alignment: Alignment.centerRight,
                    child: CircleAvatar(
                      backgroundColor: colorBackgroundSilver,
                      radius: 20.r,
                      child: IconButton(
                          onPressed: () {
                            Get.back();
                            Get.dialog(ConnectionDialogCombined(), barrierDismissible: false);
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
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          _exerciserRidingWidget(),
                          SizedBox(
                            width: 10.w,
                          ),
                          _exerciserRunningWidget(),
                        ],
                      ),
                      Row(
                        children: [
                          _mobileDeviceWidget(),
                          SizedBox(
                            width: 10.w,
                          ),
                          _etcWidget(),
                        ],
                      )
                    ]),
              ),
            ]),
          ));
    });
  }

  _exerciserRidingWidget() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.h),
      width: 148.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Color(0xffF5F7FA),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 148.w,
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: customText(
                fontSize: 16,
                text: 'EXERCISER_RIDING'.tr,
                textAlign: TextAlign.center,
                fontColor: Colors.white,
                fontWeight: FontWeight.bold),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12.r), topRight: Radius.circular(12.r)),
                color: Color(0xff41465C)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 25.28.w,
                height: 67.18.h,
                child: Image(
                  image: AssetImage('assets/images/exerciser_riding.png'),
                ),
              ),
              Container(
                width: 99.w,
                child: customText(fontSize: 11, height: 1.8.h, text: 'EXERCISER_RIDING_DESCRIPTION'.tr),
              ),
            ],
          ),
          customButton(
            onTapFunction: () {
              sensorController.setWorkoutType("Riding");
              Get.back();
              Get.dialog(ConnectionDialogCombined(), barrierDismissible: false);
            },
            text: 'SELECT'.tr,
            width: 141,
            height: 47,
            textSize: 16,
            fontWeight: FontWeight.bold,
          )
        ],
      ),
    );
  }

  _exerciserRunningWidget() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.h),
      width: 148.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Color(0xffF5F7FA),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 148.w,
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: customText(
                fontSize: 16,
                text: 'EXERCISER_RUNNING'.tr,
                textAlign: TextAlign.center,
                fontColor: Colors.white,
                fontWeight: FontWeight.bold),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  topRight: Radius.circular(
                    12.r,
                  ),
                ),
                color: Color(0xff41465C)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 35.28.w,
                height: 67.18.h,
                child: Image(
                  image: AssetImage('assets/images/exerciser_running.png'),
                ),
              ),
              Container(
                width: 99.w,
                child: customText(fontSize: 11, height: 1.8.h, text: 'EXERCISER_RUNNING_DESCRIPTION'.tr),
              ),
            ],
          ),
          customButton(
            onTapFunction: () {
              sensorController.setWorkoutType("Running");
              Get.back();
              Get.dialog(ConnectionDialogCombined(), barrierDismissible: false);
            },
            text: 'SELECT'.tr,
            width: 141,
            height: 47,
            textSize: 16,
            fontWeight: FontWeight.bold,
          )
        ],
      ),
    );
  }

  _mobileDeviceWidget() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.h),
      width: 148.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Color(0xffF5F7FA),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 148.w,
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: customText(
                fontSize: 16,
                text: 'Mobile Device',
                textAlign: TextAlign.center,
                fontColor: Colors.white,
                fontWeight: FontWeight.bold),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12.r), topRight: Radius.circular(12.r)),
                color: Color(0xff41465C)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 35.28.w,
                height: 67.18.h,
                child: Image(
                  image: AssetImage('assets/images/exerciser_running.png'),
                ),
              ),
              Container(
                width: 99.w,
                child: customText(
                    fontSize: 11,
                    height: 1.8.h,
                    text: 'Workout without exercise equipment,using the sensor of a mobile device'),
              ),
            ],
          ),
          customButton(
            onTapFunction: () {
              Get.back();
              Get.dialog(MobileDeviceDialog(), barrierDismissible: false);
            },
            text: 'SELECT'.tr,
            width: 141,
            height: 47,
            textSize: 16,
            fontWeight: FontWeight.bold,
          )
        ],
      ),
    );
  }

  _etcWidget() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.h),
      width: 148.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Color(0xffF5F7FA),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 148.w,
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: customText(
                fontSize: 16,
                text: 'Etc',
                textAlign: TextAlign.center,
                fontColor: Colors.white,
                fontWeight: FontWeight.bold),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12.r), topRight: Radius.circular(12.r)),
                color: Color(0xff41465C)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 35.28.w,
                height: 67.18.h,
                child: Image(
                  image: AssetImage('assets/images/exerciser_running.png'),
                ),
              ),
              Container(
                width: 99.w,
                child: customText(
                    fontSize: 11,
                    height: 1.8.h,
                    text: 'Workout with other devices such as smart watches and wearable devices'),
              ),
            ],
          ),
          customButton(
            onTapFunction: () {},
            text: 'SELECT'.tr,
            width: 141,
            height: 47,
            textSize: 16,
            fontWeight: FontWeight.bold,
          )
        ],
      ),
    );
  }
}
