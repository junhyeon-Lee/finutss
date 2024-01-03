import 'package:finutss/domain/controller/map_controller.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:get/get.dart';

Widget trackDialog() {
  final MapController mapController = Get.put(MapController());

  double? distance = mapController.jsonTrack?.distance;

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.r),
      color: colorDarkGrey.withOpacity(0.8),
    ),
    height: 278.h,
    width: 343.w,
    child: Padding(
      padding: EdgeInsets.all(17.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              Positioned.fill(
                child: customText(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    overflow: TextOverflow.ellipsis,
                    fontColor: colorBackgroundSilver,
                    // height: 2,
                    // text: 'COEX> Samsung Station'
                    text: '${mapController.jsonTrack?.sName} > ${mapController.jsonTrack?.eName}'),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: CircleAvatar(
                  radius: 16.r,
                  backgroundColor: colorBackgroundSilver,
                  child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        mapController.isTrackDialogOpen = false;
                        mapController.update();
                      },
                      icon: Icon(
                        CommunityMaterialIcons.window_close,
                        size: 19.r,
                        color: colorDarkGrey,
                      )),
                ),
              ),
            ],
          ),
          size20,
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    customText(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        overflow: TextOverflow.ellipsis,
                        fontColor: colorBackgroundSilver,
                        // height: 2,
                        text: '${'DISTANCE'.tr}: '),
                    customText(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis,
                        fontColor: colorBackgroundSilver,
                        // height: 2,
                        text: '${(distance! / 1000).toStringAsFixed(1)} ${"KM".tr}'),
                  ],
                ),
              ),
            ],
          ),
          size5,
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    customText(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        overflow: TextOverflow.ellipsis,
                        fontColor: colorBackgroundSilver,
                        // height: 2,
                        text: '${"TIME".tr}: '),
                    customText(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis,
                        fontColor: colorBackgroundSilver,
                        // height: 2,
                        text: '${(mapController.jsonTrack?.duration)} ${"MIN".tr}'),
                  ],
                ),
              ),
            ],
          ),
          size15,
          Expanded(
            // height: 70,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  customText(
                      fontSize: 14,
                      // fontWeight: FontWeight.w400,
                      overflow: TextOverflow.visible,
                      fontColor: colorBackgroundSilver,
                      height: 1.5,
                      text: '${(mapController.jsonTrack?.description)}'),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
