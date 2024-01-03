import 'dart:async';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/domain/controller/map_controller.dart';
import 'package:finutss/domain/controller/workout_in_controller.dart';
import 'package:finutss/presentation/screens/track_screens/live_user_screen.dart';
import 'package:finutss/presentation/screens/workout_screens/precaution_page.dart';
import 'package:finutss/presentation/widgets/common_widgets/appbars/app_bar.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/divider.dart';
import 'package:finutss/presentation/widgets/common_widgets/notification_drawer.dart';
import 'package:finutss/presentation/widgets/dialogs/track_distance_dialogs/track_dialog.dart';
import 'package:finutss/presentation/widgets/from_to_heading_widget.dart';
import 'package:finutss/presentation/widgets/map_page_widgets/user_circle_avatar.dart';
import 'package:finutss/presentation/widgets/social_page_widgets/info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class TrackDistanceScreen extends StatelessWidget {
  final MapController mapController = Get.put(MapController());
  final scaffoldKey = GlobalKey<ScaffoldState>();

  WebViewPlusController? _controller;

  @override
  Widget build(BuildContext context) {
    ///TODO
    //int? trackId = mapController.jsonTrack?.trackId;

    var trackId = '61e4e2aacdb92937db97ba0b';

    return Scaffold(
        key: scaffoldKey,
        endDrawer: ClipRRect(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), topLeft: Radius.circular(15)),
          child: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors.transparent,
            ),
            child: SafeArea(
              child: Drawer(
                elevation: 0,
                child: NotificationDrawer(),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: GetBuilder<MapController>(builder: (mapController) {
            return Container(
              child: Stack(
                children: [
                  /* -------------------------------------------------------------------------- */
                  /*                                     map                                    */
                  /* -------------------------------------------------------------------------- */
                  Positioned.fill(
                    top: 60.h,
                    bottom: 363.h,
                    child: WebViewPlus(
                      initialUrl: 'assets/webview/                                                                                                                                               .html',
                      javascriptMode: JavascriptMode.unrestricted,
                      javascriptChannels: <JavascriptChannel>{},
                      onWebViewCreated: (WebViewPlusController webViewController) async {
                        _controller = webViewController;
                      },
                      onPageFinished: (finish) {
                        Timer(Duration(seconds: 1),
                            () => _controller!.webViewController.evaluateJavascript('setPath("$trackId")'));
                      },
                    ),
                  ),
                  Align(alignment: Alignment.bottomCenter, child: _bottomContainer(context, trackId)),
                  /* -------------------------------------------------------------------------- */
                  /*                        top alight app bar and speed                        */
                  /* -------------------------------------------------------------------------- */
                  Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 60.h,
                            padding: EdgeInsets.zero,
                            child: Center(
                              child: appbar(
                                key: scaffoldKey,
                                automaticallyImplyLeading: true,
                                centerTitle: false,
                                isTrackDistanceScreen: true,
                                titleWidget: customText(
                                    text: 'DAILY_TRACK'.tr,
                                    fontColor: colorDarkGrey,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          size5,

                          ///TODO
                          // fromToHeading(from: mapController.jsonTrack["sName"], to: mapController.jsonTrack["eName"]),
                          fromToHeading(),
                          if (mapController.isTrackDialogOpen)
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.only(top: 13.h, right: 13.w),
                                child: trackDialog(),
                              ),
                            ),
                          if (mapController.isTrackDialogOpen == false)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 23.h, right: 23.w),
                                  child: CircleAvatar(
                                    radius: 20.r,
                                    backgroundColor: colorBackgroundSilver,
                                    child: IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          mapController.isTrackDialogOpen = true;
                                          mapController.update();
                                          // Get.dialog(TrackDialog(),
                                          //     barrierDismissible: false);
                                        },
                                        icon: Icon(
                                          CommunityMaterialIcons.information_variant,
                                          color: colorBlue,
                                          size: 25.r,
                                        )),
                                  ),
                                )
                              ],
                            )
                        ],
                      )),
                  /* ---------------------------- bottom container ---------------------------- */
                ],
              ),
            );
          }),
        ));
  }

  /* -------------------------------------------------------------------------- */
  /*                       bottom container                                     */
  /* -------------------------------------------------------------------------- */

  _bottomContainer(context, trackId) {
    ///TODO
    var distance = mapController.jsonTrack?.distance ?? 0;
    var duration = mapController.jsonTrack?.duration ?? 0;
    var kcal = mapController.jsonTrack?.workOut.kcal ?? 0;

    print('-------------');
    print(mapController.jsonTrack?.distance.toString());

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
          color: Colors.white),
      height: 363.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topRight: Radius.circular(15.r), topLeft: Radius.circular(15.r))),
            color: colorLightGrey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(14.w, 10.h, 0.w, 10.h),
                  child: customText(
                      text: 'ACTIVE_USER'.tr, fontColor: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
          size10,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20),
                width: Get.width - 40,
                height: 60.h,
                child: GetBuilder<WorkoutInController>(builder: (controller) {
                  var activeUserSize = controller.docs.length;
                  return Stack(
                    children: [
                      // for (int i = 0; i < controller.inWorkout.length; i++)
                      for (int i = activeUserSize > 5 ? 5 : activeUserSize - 1; i >= 0; i--)
                        Positioned(
                          right: (((Get.width - 40) / 1) - 50) - i * (((Get.width / 1.4) - 55) / 7),
                          // right: 0,
                          // top: 0,
                          // bottom: 0,
                          child:
                              userAvatar(width: 50, height: 50, isOnline: true, userInfo: controller.docs[i]['writer']),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.h, right: 10.w),
                            child: customText(
                                text: activeUserSize > 5 ? (activeUserSize - 5).toString() : '',
                                fontColor: colorBlue,
                                fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return SafeArea(
                                        child: Padding(
                                      padding: EdgeInsets.only(top: 40.h),
                                      child: LiveUserScreen(
                                        isMapPage: false,
                                      ),
                                    ));
                                  });
                              // Get.bottomSheet(LiveUserScreen());
                            },
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 10.h, right: 16.w),
                              child: CircleAvatar(
                                  backgroundColor: colorBlue,
                                  minRadius: 22.r,
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                    size: 30.r,
                                  )),
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                }),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 32.w),
            child: customText(text: 'ENTRANCE'.tr, fontColor: colorDarkGrey, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          size5,
          /* ------------------------------- km card row ------------------------------ */
          Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _kmCard(
                  // backgroundColor: blueColor,
                  context: context,
                  title: 'SHORT'.tr,
                  text: (distance * 0.25).toStringAsFixed(1),
                  unitText: 'KM'.tr,
                  isSelected: mapController.iskmShort,
                  onTap: () {
                    _controller!.webViewController.evaluateJavascript('setPath("$trackId", "short")');
                    mapController.iskmShort = true;
                    mapController.iskmHalf = false;
                    mapController.iskmFull = false;
                    mapController.update();
                  },
                ),
                _kmCard(
                  // backgroundColor: blueColor,
                  context: context,
                  title: 'HALF'.tr,
                  text: (distance * 0.5).toStringAsFixed(1),
                  unitText: 'KM'.tr,
                  isSelected: mapController.iskmHalf,
                  onTap: () {
                    _controller!.webViewController.evaluateJavascript('setPath("$trackId", "half")');
                    mapController.iskmShort = false;
                    mapController.iskmHalf = true;
                    mapController.iskmFull = false;
                    mapController.update();
                  },
                ),
                _kmCard(
                  // backgroundColor: blueColor,
                  context: context,
                  title: 'FULL'.tr,
                  text: (distance).toStringAsFixed(1),
                  unitText: 'KM'.tr,
                  isSelected: mapController.iskmFull,
                  onTap: () {
                    _controller!.webViewController.evaluateJavascript('setPath("$trackId")');
                    mapController.iskmShort = false;
                    mapController.iskmHalf = false;
                    mapController.iskmFull = true;
                    mapController.update();
                  },
                ),
              ],
            ),
          ),
          size5,
          /* ------------------------ information changing row ------------------------ */
          if (mapController.iskmShort)
            _changingRow(
                timeText: '${(duration / 3).ceil()}',
                kmText: '${(distance * 0.25).toStringAsFixed(1)}',
                caloryText: '${(kcal / 3).ceil()}'),
          if (mapController.iskmHalf)
            _changingRow(
                timeText: '${((duration) / 2).ceil()}',
                kmText: '${(distance * 0.5).toStringAsFixed(1)}',
                caloryText: '${(kcal).ceil() / 2}'),
          if (mapController.iskmFull)
            _changingRow(
                timeText: '${((duration)).ceil()}',
                kmText: '${(distance * 1).toStringAsFixed(1)}',
                caloryText: '${(kcal).ceil()}'),
          size10,
          /* --------------------------------- buttom --------------------------------- */
          Padding(
            padding: EdgeInsets.only(left: 32.w, right: 32.w),
            child: Row(
              children: [
                Expanded(
                  child: customButton(
                      onTapFunction: () {
                        // Get.dialog(PrecautionsDialog(),
                        //     barrierDismissible: false);
                        Get.to(() => PrecautionsPage());
                      },
                      height: 48,
                      radius: 15,
                      fontWeight: FontWeight.w700,
                      text: "START_NOW".tr,
                      textSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

/* ------------------------------ km selection ------------------------------ */
  Widget _kmCard({title = '', context, text = '', unitText = 'km', onTap, isSelected = false}) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        child: Container(
          height: 48.h,
          width: 95.w,
          decoration:
              BoxDecoration(color: isSelected ? colorBlue : colorLightSilver, borderRadius: BorderRadius.circular(7.r)),
          child: Padding(
            padding: EdgeInsets.only(left: 10.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // size10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    customText(
                      text: title,
                      fontColor: colorDarkGrey,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    /* -------------------------------------------------------------------------- */
                    /*                                  unit text                                 */
                    /* -------------------------------------------------------------------------- */
                    customText(
                      text: unitText,
                      fontColor: Color(0xffF5F7FA),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: customText(
                      text: text,
                      fontColor: Color(0xffF5F7FA),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

/* ----------------------------- information row ---------------------------- */
  _changingRow({
    String kmText = "0.0",
    String timeText = "0.0",
    String caloryText = "0.0",
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 0, right: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          size5,
          infoCard(
            unitText: 'KM'.tr,
            header: "",
            footer: kmText,
            image: "destination.png",
          ),
          divider(),
          infoCard(
            unitText: 'MIN'.tr,
            header: "",
            footer: timeText,
            image: "time.png",
          ),
          divider(),
          infoCard(
            unitText: 'KCAL'.tr,
            header: "",
            footer: caloryText,
            image: "calories.png",
          ),
          size5,
        ],
      ),
    );
  }
}
