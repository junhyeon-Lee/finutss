import 'dart:io';
import 'dart:typed_data';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/domain/controller/map_controller.dart';
import 'package:finutss/domain/controller/tutorial_controller.dart';
import 'package:finutss/domain/controller/workout_record_controller.dart';
import 'package:finutss/presentation/screens/user_record_screens/track_record_calendar_screen.dart';
import 'package:finutss/presentation/screens/workout_result_screens/passed_by_screen.dart';
import 'package:finutss/presentation/screens/workout_screens/map_page.dart';
import 'package:finutss/presentation/widgets/common_widgets/appbars/simple_appbar.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/divider.dart';
import 'package:finutss/presentation/widgets/from_to_heading_widget.dart';
import 'package:finutss/presentation/widgets/social_page_widgets/info_card.dart';
import 'package:finutss/presentation/widgets/track_distance_widgets/user_avatar_with_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class WorkoutResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final WorkoutRecordController workoutRecordController = Get.put(WorkoutRecordController());
    final TutorialController tutorialController = Get.put(TutorialController());
    final AuthController authController = Get.put(AuthController());
    ScreenshotController screenshotController = ScreenshotController();
    // var value = Get.arguments;
    // print(value);
    // workoutRecordController.callMyWorkoutById(value);
    workoutRecordController.callApiRecordDailyTotal(authController.user?.userId);
    return Scaffold(
        /* --------------------------------- appbar --------------------------------- */

        backgroundColor: colorBackgroundSilver,
        appBar: simpleAppBar(automaticallyImplyLeading: true, text: 'RESULT'.tr, actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: IconButton(
                onPressed: () {
                  Get.to(() => TrackRecordCalendarScreen());
                },
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.calendar_today_outlined,
                  color: colorBlue,
                  size: 25.r,
                )),
          ),
        ]) as PreferredSizeWidget?,
        /* ---------------------------------- body ---------------------------------- */
        body: GestureDetector(
          onTap: () {
            tutorialController.showTotorial(tutorialController.BodyInfoIndex);
          },
          child: GetBuilder<WorkoutRecordController>(
            builder: (controller) {
              print(controller.jsonWorkOutRecord);
              String distance = "0", duration = "0", kcal = "0";
              if (controller.jsonWorkOutRecord != null) {
                distance = (controller.jsonWorkOutRecord["distance"] / 1000).toStringAsFixed(1);
                duration = (controller.jsonWorkOutRecord["duration"] / 60).floor().toString();
                kcal = controller.jsonWorkOutRecord["kcal"].toStringAsFixed(1);
              }
              return Column(
                children: [
                  Column(children: [
                    Screenshot(
                      controller: screenshotController,
                      child: Padding(
                        padding: EdgeInsets.only(left: 16, right: 16, top: 14),
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: Colors.white),
                          // height: 40,
                          child: Column(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15.r), topLeft: Radius.circular(15.r))),
                                color: colorLightGrey,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(14.w, 10.h, 0, 10.h),
                                      child: Text(
                                        'DAILY_TRACK'.tr,
                                        style: TextStyle(
                                            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.sp),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 16.w),
                                      child: customButton(
                                          onTapFunction: () {
                                            Get.to(() => TrackRecordCalendarScreen());
                                          },
                                          text: (controller.jsonWorkOutRecord?["workoutType"] ?? "Riding") == "Riding"
                                              ? 'WORKOUT_TYPE_RIDE'.tr
                                              : 'WORKOUT_TYPE_RUN'.tr,
                                          height: 20,
                                          width: 60,
                                          textSize: 10,
                                          color: (controller.jsonWorkOutRecord?["workoutType"] ?? "Riding") == "Riding"
                                              ? colorPictonBlue
                                              : colorPink,
                                          textColor: colorWhite,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              size10,
                              fromToHeading(
                                  from: controller.jsonWorkOutRecord != null
                                      ? controller.jsonWorkOutRecord['track']["sName"]
                                      : "",
                                  to: controller.jsonWorkOutRecord != null
                                      ? controller.jsonWorkOutRecord['track']["eName"]
                                      : "",
                                  backgroundColor: Color(0xffF5F7FA)),
                              size10,
                              /* ------------------------------ built in map ------------------------------ */
                              Padding(
                                padding: EdgeInsets.only(left: 14.w, right: 14.w),
                                child: Container(
                                  height: 120.h,
                                  width: Get.width - 15,
                                  child: Positioned.fill(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(controller.jsonWorkOutRecord != null
                                          ? controller.jsonWorkOutRecord['track']["image"]["url"]
                                          : MapController.defaultTrackImg),
                                    ),
                                  ),
                                ),
                              ),
                              size15,
                              Padding(
                                padding: EdgeInsets.only(left: 16.w, right: 16.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    size5,
                                    infoCard(
                                      header: 'DISTANCE'.tr,
                                      footer: "$distance km",
                                      image: "destination.png",
                                    ),
                                    divider(),
                                    infoCard(
                                      header: 'TIME'.tr,
                                      footer: "$duration min",
                                      image: "time.png",
                                    ),
                                    divider(),
                                    infoCard(
                                      header: "BURNED".tr,
                                      footer: "$kcal kcal",
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
                      ),
                    ),
                    size10,
                    Padding(
                      padding: EdgeInsets.only(left: 16.w, right: 16.w),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.only(topRight: Radius.circular(15.r), topLeft: Radius.circular(15.r)),
                            color: Colors.white),
                        height: 130.h,
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(14.w, 10.h, 0, 10.h),
                                child: customText(
                                    text: 'PASSED_BY'.tr,
                                    fontColor: colorDarkGrey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                          size15,
                          Container(
                            width: Get.width - 20.w,
                            height: 70.h,
                            child: Stack(
                              children: [
                                for (var i = 1; i <= 8; i++)
                                  if (i != 14)
                                    Positioned(
                                      left: ((Get.width / 1.5) - 50) - i * (((Get.width / 1.5) - 55) / 8),
                                      child: userAvatarWithStack(
                                        height: 50,
                                        width: 50,
                                      ),
                                    ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 10, bottom: 15),
                                      child: customText(
                                        text: '+999',
                                        fontColor: colorBlue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    // Padding(
                                    //   padding:
                                    //       EdgeInsets.only(right: 15.5),
                                    //   child: customText(
                                    //       text: '+999',
                                    //       fontColor: blueColor,
                                    // fontWeight: FontWeight.bold),
                                    // ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 16.h),
                                      child: InkWell(
                                        onTap: () {
                                          showModalBottomSheet(
                                              backgroundColor: Colors.transparent,
                                              isScrollControlled: true,
                                              context: context,
                                              builder: (context) {
                                                return SafeArea(
                                                    child: Padding(
                                                  padding: EdgeInsets.only(top: 40.0.h),
                                                  child: PassedByScreen(),
                                                ));
                                              });
                                          // Get.bottomSheet(LiveUserScreen());
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 7.5.w),
                                          child: CircleAvatar(
                                              minRadius: 22.r,
                                              backgroundColor: colorBlue,
                                              child: Icon(
                                                Icons.search,
                                                color: Colors.white,
                                                size: 30.r,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ]),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              iconSize: 45,
                              onPressed: () async {
                                await screenshotController
                                    .capture(delay: const Duration(milliseconds: 10))
                                    .then((Uint8List? image) async {
                                  if (image != null) {
                                    final directory = await getApplicationDocumentsDirectory();
                                    final imagePath = await File('${directory.path}/image.png').create();
                                    await imagePath.writeAsBytes(image);
                                    await Share.shareFiles([imagePath.path]);
                                  }
                                });
                              },
                              icon: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.share,
                                    color: colorBlue,
                                    size: 30.r,
                                  ))),
                          size10,
                          IconButton(
                              iconSize: 45,
                              onPressed: () => Get.off(() => MapPage()),
                              icon: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    CommunityMaterialIcons.refresh,
                                    color: colorBlue,
                                    size: 30.r,
                                  )))
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ));
  }
}
