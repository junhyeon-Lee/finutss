import 'package:finutss/constants.dart';
import 'package:finutss/data/models/users_model.dart';
import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/domain/controller/map_controller.dart';
import 'package:finutss/domain/controller/other_user_profile_controller.dart';
import 'package:finutss/domain/controller/social_controller.dart';
import 'package:finutss/presentation/widgets/common_widgets/appbars/simple_appbar.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/divider.dart';
import 'package:finutss/presentation/widgets/from_to_heading_widget.dart';
import 'package:finutss/presentation/widgets/social_page_widgets/info_card.dart';
import 'package:finutss/presentation/widgets/social_page_widgets/other_user_information_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OtherUserProfilePage extends StatelessWidget {
  final otherUserProfileController = Get.put(OtherUserProfileController());
  final authController = Get.put(AuthController());
  final socialController = Get.put(SocialController());
  User? userInfo;
  OtherUserProfilePage() {
    userInfo = Get.arguments;
    otherUserProfileController.setUserInfo(userInfo);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: simpleAppBar(text: 'USER_PROFILE'.tr, automaticallyImplyLeading: true) as PreferredSizeWidget?,
      body: GetBuilder<SocialController>(
          init: SocialController(),
          builder: (_socialController) {
            return GetBuilder<OtherUserProfileController>(builder: (otherUserProfileController) {
              var url = MapController.defaultTrackImg, sName = "", eName = "", pastTimeString = "";
              if (otherUserProfileController.lastWorkout != null) {
                ///TODO
                //url = otherUserProfileController.lastWorkout["track"]["image"]["url"];
                url = MapController.defaultTrackImg;
                sName = otherUserProfileController.lastWorkout?.sName as String;
                eName = otherUserProfileController.lastWorkout?.eName as String;
                // pastTimeString = LocalDB.getPastTime(DateTime.parse(otherUserProfileController.lastWorkout?.createdAt as String));
                DateFormat formatter = DateFormat('yyyy-MM-dd');
                pastTimeString = formatter.format(DateTime.now()).toString();
              }

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      /* -------------------------------------------------------------------------- */
                      /*                           other user profile card                          */
                      /* -------------------------------------------------------------------------- */
                      otherUserProfileInformationCard(userInfo, otherUserProfileController),

                      ///TODO
                      //otherUserProfileController.infoDisclosure == "All" || (otherUserProfileController.infoDisclosure == "Friends" && _socialController.isFollowed == true)
                      otherUserProfileController.infoDisclosure == "All" ||
                              (otherUserProfileController.infoDisclosure == "Friends" ||
                                  _socialController.isFollowed == true)
                          ? Column(
                              /* -------------------------------------------------------------------------- */
                              /*                              recent activities                             */
                              /* -------------------------------------------------------------------------- */
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16.w),
                                  child: Row(
                                    children: [
                                      customText(
                                        text: 'RECENT_ACTIVITIES'.tr,
                                        fontColor: Color(0xFF303443),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: Get.width,
                                  // height: 340.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    color: Color(0xFFFFFFFF),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFF41465C),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12.r),
                                            topRight: Radius.circular(12.r),
                                          ),
                                        ),
                                        height: 45.62.h,
                                        width: Get.width,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 16.w,
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              customText(
                                                text: "RESULT".tr,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                fontColor: Color(0xFFFFFFFF),
                                              ),
                                              Row(
                                                children: [
                                                  customText(
                                                    text: pastTimeString,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                    fontColor: Color(0xFF3BCCE1),
                                                  ),
                                                  if (otherUserProfileController.lastWorkout != null)
                                                    Padding(
                                                      padding: EdgeInsets.only(left: 12.w),
                                                      child: customButton(
                                                          //TODO
                                                          text: 'WORKOUT_TYPE_RUN'.tr,
                                                          /*
                                                          text: otherUserProfileController.lastWorkout["workoutType"] ==
                                                                  "Riding"
                                                              ? 'WORKOUT_TYPE_RIDE'.tr
                                                              : 'WORKOUT_TYPE_RUN'.tr,

                                                         */
                                                          height: 20,
                                                          width: 60,
                                                          textSize: 10,

                                                          ///TODO
                                                          color: colorPink,
                                                          /*
                                                          color:
                                                              otherUserProfileController.lastWorkout["workoutType"] ==
                                                                      "Riding"
                                                                  ? colorPictonBlue
                                                                  : colorPink,

                                                           */
                                                          textColor: colorWhite,
                                                          fontWeight: FontWeight.bold),
                                                    )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      size5,
                                      fromToHeading(backgroundColor: Color(0xFFF5F7FA), from: sName, to: eName),
                                      size10,
                                      /* -------------------------------------------------------------------------- */
                                      /*                                   map box                                  */
                                      /* -------------------------------------------------------------------------- */
                                      GetBuilder<MapController>(
                                          init: MapController(),
                                          builder: (mapController) {
                                            return Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                                              child: Container(
                                                height: 120.h,
                                                width: Get.width,
                                                child: Positioned.fill(
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                    child: Image.network(url),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            size5,
                                            infoCard(
                                              unitText: 'KM'.tr,
                                              header: 'DISTANCE'.tr,
                                              footer:
                                                  "${otherUserProfileController.lastWorkout?.distance != null ? (otherUserProfileController.lastWorkout?.distance)?.toStringAsFixed(1) : "0.0"}",
                                              image: "destination.png",
                                            ),
                                            divider(),
                                            infoCard(
                                              unitText: 'MIN'.tr,
                                              header: 'TIME'.tr,
                                              footer:
                                                  "${otherUserProfileController.lastWorkout?.duration != null ? (otherUserProfileController.lastWorkout?.duration)?.toStringAsFixed(0) : "0.0"}",
                                              image: "time.png",
                                            ),
                                            divider(),
                                            infoCard(
                                              unitText: 'KCAL'.tr,
                                              header: 'BURNED'.tr,
                                              footer:
                                                  "${otherUserProfileController.lastWorkout?.workOut.kcal != null ? (otherUserProfileController.lastWorkout?.workOut.kcal)?.toStringAsFixed(1) : "0.0"}",
                                              image: "calories.png",
                                            ),
                                            size5,
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                      size20
                    ],
                  ),
                ),
              );
            });
          }),
    );
  }
}
