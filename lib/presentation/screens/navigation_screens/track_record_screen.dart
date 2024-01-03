import 'package:finutss/constants.dart';
import 'package:finutss/data/data_service/lib_helper.dart';
import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/domain/controller/edit_body_info_controller.dart';
import 'package:finutss/domain/controller/home_controller.dart';
import 'package:finutss/domain/controller/workout_record_controller.dart';
import 'package:finutss/presentation/screens/edit_body_info_screens/body_info_navigation.dart';
import 'package:finutss/presentation/screens/social_pages/follow_screen.dart';
import 'package:finutss/presentation/screens/social_pages/follower_screen.dart';
import 'package:finutss/presentation/screens/user_record_screens/body_info_screen.dart';
import 'package:finutss/presentation/screens/user_record_screens/track_record_calendar_screen.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/divider.dart';
import 'package:finutss/presentation/widgets/live_user_widgets/live_user_card.dart';
import 'package:finutss/presentation/widgets/social_page_widgets/info_card.dart';
import 'package:finutss/presentation/widgets/social_page_widgets/other_user_information_card.dart';
import 'package:finutss/presentation/widgets/user_bmi_slider.dart';
import 'package:finutss/presentation/widgets/user_notic_dialog.dart';
import 'package:finutss/presentation/widgets/workout_record_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TrackRecordScreen extends StatelessWidget {
  final EditBodyInfoController editBodyInfoController = Get.put(EditBodyInfoController());
  final HomeController homeController = Get.put(HomeController());
  final AuthController authController = Get.put(AuthController());
  final WorkoutRecordController workoutRecordController = Get.put(WorkoutRecordController());

  final ScrollController scrollController;
  TrackRecordScreen({required this.scrollController});

  @override
  Widget build(BuildContext context) {
    double? goalKcal = 0.0;
    if (authController.user != null) {
      workoutRecordController.callApiMyRecordTotal(authController.user?.userId);
      workoutRecordController.callApiMyRecordWeekTotal(authController.user?.userId);
      workoutRecordController.callApiRecordDailyTotal(authController.user?.userId);

      print("bmr ${authController.user?.usersDetails?.bmr}");
      goalKcal =
          authController.user?.usersDetails?.bmr != null ? authController.user!.usersDetails?.bmr.toDouble() : 0.0;
    }

    return Column(
      children: [
        _profileCard(context: context),
        size15,
        _workoutStatusCard(goalKcal),
        size15,
        _bmiCard(),
        size15,
        _todayRecordCard(),
        size30,
      ],
    );
  }
  /* -------------------------------------------------------------------------- */
  /*                              profile container                             */
  /* -------------------------------------------------------------------------- */

  _profileCard({context}) {
    return GetBuilder<WorkoutRecordController>(builder: (workoutRecordController) {
      return GetBuilder<AuthController>(builder: (controller) {
        var nickName = "", text = "", imagePath = AuthController.userProfileDefaultPath, follow = 0, follower = 0;
        if (controller.user != null) {
          nickName = controller.user!.username;
          text = (controller.user?.biography != null ? controller.user?.biography : "")!;
          imagePath = authController.user?.image?.url ?? AuthController.userProfileDefaultPath;

          ///TODO authController.user["follow"]
          // follow = authController.user["follow"];
          ///TODO authController.user["follower"]
          // follower = authController.user["follower"];
        }
        return Padding(
          padding: EdgeInsets.only(left: 17.w, right: 17.w, top: 14.h),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 14.h),
                  child: workoutRecordController.jsonWorkTotalObject != null
                      ? customText(
                          text:
                              'At Last ${DateFormat('MMMM d, hh:mm a').format(DateTime.parse(workoutRecordController.jsonWorkTotalObject?["all"]?["last"] ?? DateTime.now().toIso8601String()))}',
                          fontSize: 14,
                          fontColor: colorWhitish,
                          fontWeight: FontWeight.w600,
                        )
                      : Text("${DateFormat('MMMM d, hh:mm a').format(DateTime.now())}"),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: 14,
                    left: 14,
                    top: 14,
                  ),
                  child: liveUserCard(
                      context: context,
                      isRecordScreen: true,
                      isBottomSheet: true,
                      userInfo: authController.user ?? null,
                      userName: nickName,
                      text: text,
                      imagePath: imagePath,
                      backgroundColor: colorBackgroundSilver),
                ),
                /* ---------------------------- follow following ---------------------------- */
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return SafeArea(
                                    child: Padding(
                                  padding: EdgeInsets.only(top: 40.0.h),
                                  child: FollowerScreen(),
                                ));
                              });
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 48.r,
                              width: 48.r,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/followers.png'),
                                ),
                              ),
                            ),
                            textInfoBox(authController.user?.followersCount, 'FOLLOWER'.tr, Color(0xFF3BCCE1)),
                          ],
                        ),
                      ),
                      size20,
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return SafeArea(
                                    child: Padding(
                                  padding: EdgeInsets.only(top: 40.0.h),
                                  child: FollowScreen(),
                                ));
                              });
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 48.r,
                              width: 48.r,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/icons/star_pink.png'),
                                ),
                              ),
                            ),
                            textInfoBox(authController.user?.followingCount, 'FOLLOW'.tr, Color(0xFFF73A6B))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 32.h, right: 16.w, left: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customButton(
                          height: 26,
                          width: 90,
                          radius: 4,
                          fontWeight: FontWeight.bold,
                          color: workoutRecordController.workoutType == "all" ? colorDarkGrey : colorLightSilver,
                          textColor: workoutRecordController.workoutType == "all" ? colorLightSilver : colorDarkGrey,
                          text: "WORKOUT_TYPE_ALL".tr,
                          onTapFunction: () {
                            workoutRecordController.workoutType = "all";
                            workoutRecordController.update();
                          },
                          textSize: 10),
                      customButton(
                          height: 26,
                          width: 90,
                          radius: 4,
                          fontWeight: FontWeight.bold,
                          color: workoutRecordController.workoutType == "riding" ? colorDarkGrey : colorLightSilver,
                          textColor: workoutRecordController.workoutType == "riding" ? colorLightSilver : colorDarkGrey,
                          text: "WORKOUT_TYPE_RIDE".tr,
                          onTapFunction: () {
                            workoutRecordController.workoutType = "riding";
                            workoutRecordController.update();
                          },
                          textSize: 10),
                      customButton(
                          height: 26,
                          width: 90,
                          radius: 4,
                          fontWeight: FontWeight.bold,
                          color: workoutRecordController.workoutType == "running" ? colorDarkGrey : colorLightSilver,
                          textColor:
                              workoutRecordController.workoutType == "running" ? colorLightSilver : colorDarkGrey,
                          text: "WORKOUT_TYPE_RUN".tr,
                          onTapFunction: () {
                            workoutRecordController.workoutType = "running";
                            workoutRecordController.update();
                          },
                          textSize: 10),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 14.h, right: 16.w, left: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      infoCard(
                        unitText: 'KM'.tr,
                        header: "",
                        footer:
                            "${((workoutRecordController.jsonWorkTotalObject?[workoutRecordController.workoutType]?["distance"] ?? 0) / 1000).toStringAsFixed(1)} ",
                        image: "destination.png",
                      ),
                      divider(),
                      infoCard(
                        unitText: 'MIN'.tr,
                        header: "",
                        footer:
                            "${((workoutRecordController.jsonWorkTotalObject?[workoutRecordController.workoutType]?["duration"] ?? 0) / 60).toStringAsFixed(0)}",
                        image: "time.png",
                      ),
                      divider(),
                      infoCard(
                        unitText: 'KCAL'.tr,
                        header: "",
                        footer:
                            "${(workoutRecordController.jsonWorkTotalObject?[workoutRecordController.workoutType]?["kcal"] ?? 0).toStringAsFixed(1)}",
                        image: "calories.png",
                      ),
                    ],
                  ),
                ),
                size30,
              ],
            ),
          ),
        );
      });
    });
  }
  /* -------------------------------------------------------------------------- */
  /*                             workout status card                            */
  /* -------------------------------------------------------------------------- */

  _workoutStatusCard(goalKcal) {
    return GetBuilder<WorkoutRecordController>(
      builder: (controller) {
        var nowDay = DateTime.now().weekday + 1;
        return Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: Colors.white),
            // height: 40,
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(15.r), topLeft: Radius.circular(15.r))),
                  color: colorLightGrey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(14.w, 10.h, 0, 10.h),
                        child: Text(
                          'WEEKLY_STATUS'.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.r,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20.w),
                        child: customText(
                          text: 'DAY $nowDay',
                          fontColor: colorBlue,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                size30,
                /* --------------------------------- slider --------------------------------- */
                workoutRecordSlider(),
                size15,
                /* ------------------------------- calory text ------------------------------ */
                Padding(
                  padding: EdgeInsets.only(left: 18.w, right: 18.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.stop,
                                size: 20.r,
                                color: colorBlue,
                              ),
                              thisWeek(workoutRecordController)
                            ],
                          ),
                          size15,
                          Row(
                            children: [
                              Icon(
                                Icons.stop,
                                color: colorLightSilver,
                                size: 20.r,
                              ),
                              customText(
                                text: ' ${'GOAL'.tr} ${goalKcal.toStringAsFixed(2)} ${'KCAL'.tr}',
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              )
                            ],
                          ),
                        ],
                      ),
                      customText(
                        text:
                            '${workoutRecordController.jsonWorkDailyTotalObject == null ? 0 : workoutRecordController.jsonWorkDailyTotalObject["kcal"].toStringAsFixed(2)} ${'KCAL'.tr}',
                        fontSize: 24,
                        fontColor: workoutRecordController.jsonWorkDailyTotalObject == null
                            ? colorLightSilver
                            : workoutRecordController.jsonWorkDailyTotalObject["kcal"] == 0
                                ? colorLightSilver
                                : colorPink,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
                /* ---------------------------------- text ---------------------------------- */
                Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 15.h),
                  child: customText(
                    text: 'WORKOUT_RECOMMENDATION'.tr,
                    fontSize: 14,
                    fontColor: colorWhitish,
                    textAlign: TextAlign.center,
                  ),
                ),
                /* --------------------------------- button --------------------------------- */
                Padding(
                  padding: EdgeInsets.only(top: 14.h),
                  child: customButton(
                      text: "LETS_GO".tr,
                      color: colorPink,
                      fontWeight: FontWeight.bold,
                      height: 48,
                      width: 141,
                      radius: 15,
                      textSize: 16,
                      onTapFunction: () {
                        homeController.navBarIndex = 4;
                        homeController.update();
                      }),
                ),
                size20,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget thisWeek(WorkoutRecordController workoutRecordController) {
    double totalKcal = 0;
    if (workoutRecordController.jsonWorkWeekTotalObject != null)
      for (int i = 0; i < workoutRecordController.jsonWorkWeekTotalObject.length; i++) {
        var item = workoutRecordController.jsonWorkWeekTotalObject[i];
        totalKcal += item["kcal"];
      }
    return customText(
      text: ' ${'THIS_WEEK'.tr} ${totalKcal.toStringAsFixed(2)} ${'KCAL'.tr}',
      fontSize: 12,
      fontWeight: FontWeight.w600,
    );
  }
  /* -------------------------------------------------------------------------- */
  /*                                  BMI Card                                  */
  /* -------------------------------------------------------------------------- */

  _bmiCard() {
    return GetBuilder<AuthController>(
      builder: (controller) {
        print("bmi card - AuthController");
        return Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: Colors.white),
            // height: 40,
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(15.r), topLeft: Radius.circular(15.r))),
                  color: colorLightGrey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(14.w, 10.h, 0, 10.h),
                        child: Text(
                          'BMI'.tr,
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.sp),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 5.5.w),
                        child: customButton(
                            onTapFunction: () async {
                              var guest = await LocalDB.getInt("userAsGuest");
                              guest == null ? Get.dialog(UserNoticeDialog()) : Get.to(() => BodyInfoScreen());
                            },
                            text: 'BODY_INFO'.tr,
                            height: 20,
                            width: 80,
                            textSize: 10,
                            color: colorBackgroundSilver,
                            textColor: colorDarkGrey,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                size15,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: bmiSlider(editBodyInfoController: editBodyInfoController, bmi: controller.userBMI),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 15.h),
                  child: customText(
                    text: 'WEIGHT_CHANGE_RECOMMENDATION'.tr,
                    fontSize: 14,
                    fontColor: colorWhitish,
                    textAlign: TextAlign.center,
                  ),
                ),
                /* --------------------------------- button --------------------------------- */
                Padding(
                  padding: EdgeInsets.only(top: 14, right: 14, left: 14),
                  child: Row(
                    children: [
                      customButton(
                        text: 'LATER'.tr,
                        height: 48,
                        width: 94,
                        color: Colors.white,
                        borderColor: colorDarkGrey,
                        fontWeight: FontWeight.bold,
                        textColor: colorDarkGrey,
                        radius: 15,
                        textSize: 16,
                      ),
                      size10,
                      Expanded(
                        child: customButton(
                            text: 'CHANGING_WEIGHT'.tr,
                            fontWeight: FontWeight.bold,
                            height: 48,
                            radius: 15,
                            textSize: 16,
                            onTapFunction: () {
                              editBodyInfoController.isNavigatedFromEditBodyInfo = false;
                              editBodyInfoController.screenIndex = 3;
                              editBodyInfoController.update();
                              Get.to(() => BodyInfoNavigation());
                            }),
                      ),
                    ],
                  ),
                ),
                size20,
              ],
            ),
          ),
        );
      },
    );
  }

  /* -------------------------------------------------------------------------- */
  /*                             today's record card                            */
  /* -------------------------------------------------------------------------- */

  _todayRecordCard() {
    return GetBuilder<WorkoutRecordController>(builder: (workoutRecordController) {
      return Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: Colors.white),
          // height: 40,
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(15.r), topLeft: Radius.circular(15.r))),
                color: colorLightGrey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(14.w, 10.h, 0, 10.h),
                      child: Text(
                        "TODAYS_RECORD".tr,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.sp),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 5.5.w),
                          child: customButton(
                              onTapFunction: () {
                                Get.to(() => TrackRecordCalendarScreen());
                              },
                              text: 'MORE'.tr,
                              height: 20,
                              width: 60,
                              textSize: 10,
                              color: colorBackgroundSilver,
                              textColor: colorDarkGrey,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              size15,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    size5,
                    infoCard(
                      unitText: 'KM'.tr,
                      header: 'DISTANCE'.tr,
                      footer: workoutRecordController.jsonWorkDailyTotalObject != null
                          ? "${(workoutRecordController.jsonWorkDailyTotalObject["distance"] / 1000).toStringAsFixed(1)}"
                          : "0.0",
                      image: "destination.png",
                    ),
                    divider(),
                    infoCard(
                      unitText: 'MIN'.tr,
                      header: 'TIME'.tr,
                      footer: workoutRecordController.jsonWorkDailyTotalObject != null
                          ? "${(workoutRecordController.jsonWorkDailyTotalObject["duration"] / 60).toStringAsFixed(0)} ${'MIN'.tr}"
                          : "0.0",
                      image: "time.png",
                    ),
                    divider(),
                    infoCard(
                      unitText: 'KCAL'.tr,
                      header: 'BURNED'.tr,
                      footer: workoutRecordController.jsonWorkDailyTotalObject != null
                          ? "${workoutRecordController.jsonWorkDailyTotalObject["kcal"].toStringAsFixed(1)} ${'KCAL'.tr}"
                          : "0.0",
                      image: "calories.png",
                    ),
                    size5,
                  ],
                ),
              ),
              size15,
            ],
          ),
        ),
      );
    });
  }
}
