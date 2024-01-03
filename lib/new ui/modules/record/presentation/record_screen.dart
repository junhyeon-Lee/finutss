import 'package:finutss/new%20ui/modules/connection/presentation/body_info_select_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/dash_board_bottom_navi/controller/dashboard_screen_controller.dart';
import 'package:finutss/new%20ui/modules/record/controller/bmi_slider_controller.dart';
import 'package:finutss/new%20ui/modules/record/controller/record_controller.dart';
import 'package:finutss/new%20ui/modules/record/controller/stepper_controller.dart';
import 'package:finutss/new%20ui/modules/sign_in/model/login_model.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/widget/bmi_slider.dart';
import 'package:finutss/new%20ui/widget/custom_login_button.dart';
import 'package:finutss/new%20ui/widget/notice_dialog.dart';
import 'package:finutss/new%20ui/widget/number_stepper.dart';
import 'package:finutss/new%20ui/widget/user_profile_card.dart';
import 'package:finutss/presentation/presentation/animation/bouncing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RecordScreen extends StatefulWidget {
  RecordScreen({Key? key, required this.scrollController}) : super(key: key);
  final ScrollController scrollController;

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  final StepperController stepperController = Get.put(StepperController());
  BmiSliderController bmiSliderController = Get.find();
  DashboardController DashBoardController = Get.find();
  RecordController recordController = Get.put(RecordController());

  @override
  void initState() {
    super.initState();

    if (!Constants.isGuest) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          recordController.getUserID().then((value) {
            bmiSliderController
                .getUserInfo()
                .then((value) {})
                .then((value) => recordController.getTodayRecord())
                .then((value) => recordController.getWorkoutStatus())
                .then(
                  (value) => bmiSliderController.getWeightRecordApiCall(),
                );
          });
        },
      );
      recordController.selectSensorMode.value = 'all';
    } else {
      bmiSliderController.userModel.value = LoginModel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SingleChildScrollView(
        controller: widget.scrollController,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
            ),
            child: Column(
              children: [
                Obx(
                  () => UserProfileCard(
                    profileOnTap: () {
                      if (!Constants.isGuest) {
                        Navigation.pushNamed(Routes.profileScreen);
                      }
                    },
                    BottomRow: true,
                    button: false,
                    showExerciseMenu: true,
                    isSocialScreen: true,
                    isCurrentUser: true,
                    isSelectType: recordController.selectSensorMode.value,
                    userModel: bmiSliderController.userModel.value,
                    valueChangedHandler: (value) {
                      recordController.selectSensorMode.value = value ?? 'all';
                      recordController.setRunRideRecord(selectType: value ?? 'all');
                    },
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      new BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.07),
                        blurRadius: 20.0,
                      ),
                    ],
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 16.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 4.h,
                        ),
                        secondCardRow(),
                        SizedBox(
                          height: 9.h,
                        ),
                        Obx(
                          () {
                            return NumberStepper(
                              onTap: () {},
                              totalSteps: stepperController.stepLength,
                              width: MediaQuery.of(context).size.width,
                              curStep: recordController.currentNumberOfDay.value,
                              stepCompleteColor: AppColor.purple,
                              currentStepColor: AppColor.purple,
                              inactiveColor: AppColor.inActiveColor,
                              lineWidth: 3,
                              stepList: recordController.stepList.value,
                            );
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Obx(() => Row(
                              children: [
                                calRow(
                                  "THIS_WEEK".tr,
                                  (recordController.workoutModel.value.data?.totalBurntCaloriesCount ?? 0).toString() +
                                      " " +
                                      "KCAL".tr,
                                  AppColor.purple,
                                ),
                                SizedBox(
                                  width: 15.w,
                                ),
                                calRow(
                                  "GOAL".tr,
                                  (recordController.workoutModel.value.data?.weeklyBurntCaloriesGoal ?? 0).toString() +
                                      " " +
                                      "KCAL".tr,
                                  AppColor.inActiveColor,
                                )
                              ],
                            )),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 14.w, horizontal: 14.w),
                          decoration: BoxDecoration(color: AppColor.backGroundColor, borderRadius: BorderRadius.circular(6.w)),
                          child: Row(
                            children: [
                              SizedBox(
                                child: Text(
                                  "YOU_HAVENT_DONE_TODAYS_WORKOUT_YETNSHALL_WE_START_NOW".tr.replaceFirst(
                                        "%d",
                                        bmiSliderController.differenceInDays.toString(),
                                      ),
                                  maxLines: 3,
                                  style: TextStyle(
                                    color: AppColor.subTitleColor.withOpacity(0.7),
                                    height: 1.5,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11.5.sp,
                                  ),
                                ),
                                width: 140.w,
                              ),
                              Spacer(),
                              CustomLoginButton(
                                height: 32.h,
                                width: 110.w,
                                fontsize: 16.sp,
                                fontWeight: FontWeight.w700,
                                title: "LETS_GO".tr,
                                onTap: () async {
                                  Constants.isGuest == true ? GuestNotice(context) : DashBoardController.currentIndex(2);
                                },
                                isCancelButton: false,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.circular(
                      14,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.cardGradiant1.withOpacity(0.06),
                        spreadRadius: 1.4,
                        blurRadius: 10,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 20.h,
                      horizontal: 20.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            BmiText(),
                            Spacer(),
                            bodyInfoButton(
                              onTap: () async {
                                Constants.isGuest == true
                                    ? GuestNotice(context)
                                    : Navigation.pushNamed(
                                        Routes.trackBodyInfoScreen,
                                      );
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        Obx(
                          () => bmiSlider(
                            bmiSliderController: bmiSliderController,
                            bmi: bmiSliderController.userModel.value.data?.bmi ?? 0,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Obx(() => Text(
                                bmiSliderController.daysTitle.value,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColor.blueTextColor.withOpacity(0.7),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.w),
                          child: Row(
                            children: [
                              // LaterButton(),
                              // SizedBox(
                              //   width: 15.w,
                              // ),
                              changeWeightButton(
                                onTap: () {
                                  if (!Constants.isGuest) {
                                    bmiSliderController.setBodyData();
                                    bodyInfoSelectBottomSheet(
                                      index: 3,
                                      context: context,
                                    );
                                  } else {
                                    GuestNotice(context);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Constants.isGuest ? SizedBox() : todayRecordView(),
                SizedBox(
                  height: 80.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget todayRecordView() {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(
          14,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.cardGradiant1.withOpacity(0.06),
            spreadRadius: 1.4,
            blurRadius: 10,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20.h,
          horizontal: 20.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "TODAYS_RECORD".tr,
                    style: TextStyle(
                      color: AppColor.blueTextColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),

                /*  if(recordController.selectSensorMode.value == 'all') ...[
                  if(recordController
                      .todayRecordData.value.type !=null) ...[
                  RunRideButton(
                    isRunMode: recordController
                        .todayRecordData.value.type
                        .toString()
                        .toLowerCase() ==
                        'run'
                        ? true
                        : false,
                  ),
                  ]
                ] else if(recordController.selectSensorMode.value == recordController.todayRecordData.value.type.toString().toLowerCase()) ...[
                  RunRideButton(
                    isRunMode: recordController
                        .todayRecordData.value.type
                        .toString()
                        .toLowerCase() ==
                        'run'
                        ? true
                        : false,
                  ),
                ],*/

                SizedBox(
                  width: 12.w,
                ),
                Bouncing(
                  duration: Duration(milliseconds: 100),
                  onPressed: () {
                    Navigation.pushNamed(
                      Routes.historyScreen,
                    );
                  },
                  ///운동 이력
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        7,
                      ),
                      border: Border.all(
                        width: 1.5,
                        color: AppColor.darkPink,
                      ),
                    ),
                    child: Text(
                      // recordController.successMessage.value,
                      "HISTORY_WORKOUT".tr,
                      style: TextStyle(
                        color: AppColor.darkPink,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.04,
                        fontSize: 13 .sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            /*  Obx(() => ListView.separated(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(bottom: 14.h),
                  itemBuilder: (context, i) {
                    return FinishedDropCard(
                      recordData: recordController.todayRecordData[i],
                      color: AppColor.greenSliderBg,
                      isShowDelete: false,
                      onTapDelete: () {},
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 12.h,
                    );
                  },
                  itemCount: recordController.todayRecordData.length,
                ))*/
            Obx(() => Column(
                  children: [
                    if (recordController.todayRecordData.value == null) ...[
                      SizedBox(),
                    ] else if (recordController.selectSensorMode.value == 'all') ...[
                      todayKmMin(
                          km: recordController.totalKM.value,
                          min: recordController.totalMin.value,
                          cal: recordController.totalcal.value),
                    ] else if (recordController.selectSensorMode.value.toLowerCase() == 'run') ...[
                      todayKmMin(
                          km: recordController.totalKMRun.value,
                          min: recordController.totalMinRun.value,
                          cal: recordController.totalcalRun.value),
                    ] else ...[
                      todayKmMin(
                          km: recordController.totalKMRide.value,
                          min: recordController.totalMinRide.value,
                          cal: recordController.totalcalRide.value),
                    ]
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget todayKmMin({required double km, required double min, required int cal}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        kmRow(
          IconAssets.location,
          (km).toStringAsFixed(2),
          "KM".tr,
        ),
        divider(),
        kmRow(
          IconAssets.time,
          min.toStringAsFixed(2),
          "MIN".tr,
        ),
        divider(),
        kmRow(
          IconAssets.kcal,
          cal.toStringAsFixed(2),
          "KCAL".tr,
        ),
      ],
    );
  }

  Widget divider() {
    return Container(
      height: 40.h,
      width: 1.w,
      color: Color(0xFFE4EDFF),
    );
  }

  Widget changeWeightButton({required VoidCallback onTap}) {
    return Expanded(
      child: Bouncing(
        duration: Duration(milliseconds: 100),
        onPressed: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 0.w,
            vertical: 10.h,
          ),
          decoration: BoxDecoration(
            color: AppColor.orangeColor,
            borderRadius: BorderRadius.circular(
              10.w,
            ),
          ),
          child: Center(
            child: Text(
              "CHANGING_WEIGHT".tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.whiteColor,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
                fontSize: 16.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget LaterButton() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10.w,
        ),
        border: Border.all(
          width: 1.5.w,
          color: AppColor.cancelButtonBg,
        ),
      ),
      child: Text(
        "LATER".tr,
        style: TextStyle(
          color: AppColor.cancelButtonBg,
          fontWeight: FontWeight.w600,
          fontSize: 13.sp,
        ),
      ),
    );
  }

  Widget BmiText() {
    return Text(
      "BMI".tr,
      style: TextStyle(
        color: AppColor.greenSliderBg,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget bodyInfoButton({required VoidCallback onTap}) {
    return Bouncing(
      duration: Duration(milliseconds: 100),
      onPressed: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 5.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            7,
          ),
          border: Border.all(
            width: 1.5,
            color: AppColor.darkPink,
          ),
        ),
        child: Text(
          "BODY_INFO".tr,
          style: TextStyle(
            color: AppColor.darkPink,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.04,
            fontSize: 13.sp,
          ),
        ),
      ),
    );
  }

  Widget kmRow(String? ImagePath, String? km, String? kmString) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
          ),
          child: Image.asset(
            ImagePath ?? " ",
            height: 20.h,
          ),
        ),
        SizedBox(
          height: 7.h,
        ),
        Row(
          children: [
            Text(
              km ?? "",
              style: TextStyle(
                color: AppColor.blueTextColor,
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            Text(
              kmString ?? "",
              style: TextStyle(
                color: AppColor.blueTextColor.withOpacity(0.6),
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget trackTitle(String title, int index) {
    return Text(
      title,
      style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w400, color: AppColor.black),
    );
  }

  Widget calRow(String? title, String value, Color color) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 9.w,
            height: 9.w,
            decoration: new BoxDecoration(
              color: color,
              borderRadius: new BorderRadius.all(
                new Radius.circular(
                  25.0,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 5.w,
          ),
          Text(
            title ?? " ",
            style: TextStyle(
              color: AppColor.blueTextColor.withOpacity(
                0.7,
              ),
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
          ),
          Flexible(
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColor.blueTextColor,
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget appRow() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
      ),
      child: Row(
        children: [
          Image.asset(
            IconAssets.ridingSensor,
            height: 22.h,
          ),
          Spacer(),
          Text(
            "RECORD".tr,
            style: TextStyle(
              color: AppColor.blueTextColor,
              fontWeight: FontWeight.w700,
              fontSize: 22.sp,
            ),
          ),
          Spacer(),
          Image.asset(
            IconAssets.notification,
            height: 22.h,
          ),
        ],
      ),
    );
  }

  Widget secondCardRow() {
    return Row(
      children: [
        Text(
          'WEEKLY_STATUS'.tr,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14.sp,
            color: AppColor.blueTextColor,
            letterSpacing: 0.4,
          ),
        ),
        Spacer(),
        Text(
          "WORKOUT_DAY_SINCE".tr.replaceAll('%d', recordController.currentNumberOfDay.value.toString()),
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 12.sp,
            color: AppColor.darkPink,
            letterSpacing: 0.6,
          ),
        ),
      ],
    );
  }
}
