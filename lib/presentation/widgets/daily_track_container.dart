import 'package:cached_network_image/cached_network_image.dart';
import 'package:finutss/data/models/track.dart';
import 'package:finutss/domain/controller/map_controller.dart';
import 'package:finutss/domain/controller/workout_in_controller.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/from_to_heading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import 'common_widgets/custom_button.dart';
import 'km_selection_row.dart';

Widget dailyTrackContainer(
    {String title = 'Daily Track',
    onInfoCardPressed,
    context,
    onMapPressed,
    onViewButtonPressed,
    isTomorrowMap = false,
    isViewButton = true,
    isNumberOfPeople = false,
    backgroundColor = colorBlue,
    Track? track}) {
  return Padding(
    padding: EdgeInsets.only(left: 16.w, right: 16.w),
    child: GetBuilder<MapController>(builder: (mapController) {
      ///TODOA
      //String url = track != null ? track["image"]["url"] : MapController.defaultTrackImg;
      String url = MapController.defaultTrackImg;
      var remainingTime = 0;
      if (isTomorrowMap) {
        remainingTime = 24 - DateTime.now().hour;
      }
      return Container(
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
                      title,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.sp),
                    ),
                  ),
                  isViewButton
                      ? Padding(
                          padding: EdgeInsets.only(right: 5.5.w),
                          child: customButton(
                              onTapFunction: onViewButtonPressed,
                              text: 'VIEW'.tr,
                              height: 20,
                              width: 60,
                              textSize: 10,
                              color: colorBackgroundSilver,
                              textColor: colorDarkGrey,
                              fontWeight: FontWeight.bold),
                        )
                      : Container()
                ],
              ),
            ),
            size10,
            InkWell(
                onTap: onMapPressed,
                child: fromToHeading(
                  backgroundColor: Color(0xffF5F7FA),
                  from: track?.sName != null ? track?.sName as String : "",
                  to: track?.eName != null ? track?.eName as String : "",
                )),
            size10,
            /* ------------------------------ built in map ------------------------------ */
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: Container(
                height: 120.h,
                width: Get.width - 20.w,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CachedNetworkImage(
                          imageUrl: url,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    isNumberOfPeople
                        ? Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.all(8.r),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: colorDarkGrey,
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                      child: Row(
                                        children: [
                                          Icon(Icons.people, size: 24.r, color: Colors.white),
                                          size5,
                                          GetBuilder<WorkoutInController>(builder: (controller) {
                                            return customText(
                                              text: '${controller.docs.length}/100',
                                              fontColor: colorBackgroundSilver,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            );
                                          })
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(),
                    isTomorrowMap
                        ? Positioned.fill(
                            child: Container(
                            color: Colors.black.withOpacity(0.4),
                            child: Center(
                                child: Text(
                              ('AFTER_HOURS'.tr).replaceAll("%d", remainingTime.toString()),
                              style: TextStyle(fontSize: 18.sp, color: Colors.white, fontWeight: FontWeight.bold),
                            )),
                          ))
                        : Container()
                  ],
                ),
              ),
            ),
            size10,
            InkWell(
              onTap: onInfoCardPressed,
              child: kmSelectionRow(context: context, backgroundColor: backgroundColor, track: track),
            ),
            size10,
          ],
        ),
      );
    }),
  );
}
