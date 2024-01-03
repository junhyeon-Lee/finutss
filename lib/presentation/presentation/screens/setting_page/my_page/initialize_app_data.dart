import 'package:finutss/domain/controller/initialize_app_data_controller.dart';
import 'package:finutss/domain/controller/workout_record_controller.dart';
import 'package:finutss/presentation/widgets/common_widgets/appbars/simple_appbar.dart';
import 'package:finutss/presentation/widgets/common_widgets/confirmation_text_field.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/rounded_decoration.dart';
import 'package:finutss/presentation/widgets/dialogs/settings_dialogs/initialize_appdata_complete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class InitializeAppData extends StatelessWidget {
  // final _initializeAppDataController = Get.put(InitializeAppDataController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(text: 'INITIALIZE_APP_DATA'.tr) as PreferredSizeWidget?,
      body: GetBuilder<WorkoutRecordController>(builder: (workoutRecordController) {
        return GetBuilder<InitializeAppDataController>(
            init: InitializeAppDataController(),
            builder: (initializeAppDataController) {
              return Container(
                color: colorBackgroundSilver,
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        /* -------------------------------------------------------------------------- */
                        /*                       info text + user data info card                      */
                        /* -------------------------------------------------------------------------- */
                        Container(
                          decoration: roundedDecoration(),
                          child: Padding(
                            padding: EdgeInsets.all(16.0.r),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                customText(
                                    height: 1.4,
                                    fontSize: 14,
                                    fontColor: Color(0xff7F8391),
                                    text: 'INITIALIZE_APP_DATA_INFO'.tr),
                                Container(
                                  padding: EdgeInsets.all(16.r),
                                  decoration: roundedDecoration(color: colorBackgroundSilver),
                                  child: Column(
                                    children: [
                                      _informationRow(
                                          'CUMULATIVE_TIME'.tr,
                                          workoutRecordController.jsonWorkTotalObject != null
                                              ? "${((workoutRecordController.jsonWorkTotalObject?["all"]?["duration"] ?? 0) / 60 / 60).toStringAsFixed(2)}"
                                              : "0",
                                          'HOURS'.tr),
                                      size20,
                                      _informationRow(
                                          'CUMULATIVE_DISTANCE'.tr,
                                          workoutRecordController.jsonWorkTotalObject != null
                                              ? "${((workoutRecordController.jsonWorkTotalObject?["all"]?["distance"] ?? 0) / 1000).toStringAsFixed(1)}"
                                              : "0",
                                          'KM'.tr),
                                      size20,
                                      _informationRow(
                                          'BURN_CALORIES'.tr,
                                          workoutRecordController.jsonWorkTotalObject != null
                                              ? "${(workoutRecordController.jsonWorkTotalObject?["all"]?["kcal"] ?? 0).toStringAsFixed(1)}"
                                              : "0",
                                          'KCAL'.tr),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        size15,
                        Container(
                          decoration: roundedDecoration(),
                          child: Padding(
                            padding: EdgeInsets.all(16.r),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: customText(
                                          text: 'INITIALIZATION_CONFIRMATION_TEXT'.tr,
                                          fontColor: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                size10,
                                customText(
                                  text: 'INITIALIZATION_CONFIRMATION_TEXT_INFO'.tr,
                                  fontColor: Color(0xff7F8391),
                                  fontSize: 14,
                                ),
                                size10,
                                confirmationTextField(
                                    hint: 'INITIALIZE'.tr,
                                    buttonText: "ENTER".tr,
                                    controller: initializeAppDataController.initializeTextController,
                                    onPressFunction: initializeAppDataController.checkInitializeText)
                              ],
                            ),
                          ),
                        ),
                        size20,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(15.r)),
                                  child: customButton(
                                    color: Colors.white,
                                    textColor: Colors.black,
                                    radius: 15,
                                    fontWeight: FontWeight.bold,
                                    text: 'CANCEL'.tr,
                                    textSize: 16,
                                    onTapFunction: () {
                                      Get.back();
                                    },
                                    height: 48,
                                  ),
                                ),
                              ),
                              size5,
                              Expanded(
                                child: customButton(
                                  radius: 15,
                                  fontWeight: FontWeight.bold,
                                  text: 'INITIALIZE'.tr,
                                  textSize: 16,
                                  color: initializeAppDataController.isCheck ? colorBlue : colorLightSilver,
                                  onTapFunction: () {
                                    if (!initializeAppDataController.isCheck) return;

                                    initializeAppDataController.initializeAppData();
                                    Get.dialog(InitializeAppdataCompleteDialog());
                                  },
                                  height: 48,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
      }),
    );
  }

  Widget _informationRow(title, value, unit) {
    return Row(
      children: [
        Expanded(
          child: customText(text: '$title', fontColor: Color(0xff7F8391), fontSize: 14, fontWeight: FontWeight.w500),
        ),
        customText(text: '$value', fontColor: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
        size10,
        Container(
          width: 34,
          child: customText(text: '$unit', fontColor: colorBlue, fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  List infoText = [
    '1. The function ts to initialize data about personal exercise records.\n',
    '2. Initialize the following range of data, and personal information and related data based on service subscription are not initialized.\n',
    '3. Initialization data: Time, Distance, Burned\n',
    "4. Pre-initialization data already in progress cannot be recovered under any circumstances. If you don't want it, please hold the initialization of the data."
  ];
}
