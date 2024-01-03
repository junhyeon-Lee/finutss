import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/distance_time_calory_row.dart';
import 'package:finutss/presentation/widgets/live_user_widgets/live_user_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:get/get.dart';

Widget liveUserBottomSheet({String imagePath = ''}) {
  return Column(
    children: [
      Spacer(),
      CircleAvatar(
        backgroundColor: colorBackgroundSilver,
        radius: 20.r,
        child: IconButton(
            onPressed: () {
              Get.back();
            },
            padding: EdgeInsets.zero,
            icon: Icon(
              CommunityMaterialIcons.window_close,
              size: 24.r,
              color: colorDarkGrey,
            )),
      ),
      size10,
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: colorBackgroundSilver,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 25.h, right: 14.w, left: 14.w),
              child: liveUserCard(
                  isBottomSheet: true, imagePath: imagePath, backgroundColor: Color(0xff9DBCFE).withOpacity(0.2)),
            ),
            /* ---------------------------- follow following ---------------------------- */
            Padding(
              padding: EdgeInsets.fromLTRB(33.5.w, 8.h, 33.5.w, 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('assets/icons/star_blue.png'),
                  Column(
                    children: [
                      customText(text: '999+', fontColor: colorBlue, fontWeight: FontWeight.bold, fontSize: 24),
                      customText(
                          text: 'FOLLOWER'.tr, fontColor: colorDarkGrey, fontSize: 14, fontWeight: FontWeight.w500)
                    ],
                  ),
                  Image.asset('assets/icons/star_pink.png'),
                  Column(
                    children: [
                      customText(text: '1.4k', fontColor: colorPink, fontWeight: FontWeight.bold, fontSize: 24),
                      customText(text: 'FOLLOW'.tr, fontColor: colorDarkGrey, fontSize: 14, fontWeight: FontWeight.w500)
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 14.h, right: 12.w, left: 12.w),
              child: distanceTimeCaloryRow(),
            ),
            size10,
            /* ------------------------------ follow button ----------------------------- */
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: Row(
                children: [
                  Expanded(
                      child: customButton(text: 'FOLLOW'.tr, height: 48, fontWeight: FontWeight.bold, textSize: 16)),
                ],
              ),
            ),
            size20,
          ],
        ),
      )
    ],
  );
}
