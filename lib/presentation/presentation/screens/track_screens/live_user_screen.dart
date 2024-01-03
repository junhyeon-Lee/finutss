import 'package:finutss/constants.dart';
import 'package:finutss/domain/controller/workout_in_controller.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/live_user_widgets/live_user_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class LiveUserScreen extends StatelessWidget {
  final workoutInController = Get.put(WorkoutInController());
  bool isMapPage;
  LiveUserScreen({required this.isMapPage});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorLightGrey.withOpacity(0.9),
      body: GetBuilder<WorkoutInController>(builder: (controller) {
        return Stack(
          children: [
            // size30,
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: SingleChildScrollView(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    size70,
                    size20,
                    for (var data in controller.docs)
                      Padding(
                        padding: EdgeInsets.only(left: 14.w, right: 14.w),
                        child: liveUserCard(
                            isMapPage: isMapPage, isDeclareBlock: true, context: context, userInfo: data["writer"]),
                      ),
                  ]),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                color: colorLightGrey.withOpacity(0.9),
                width: double.infinity,
                height: 80.h,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 26.h, 16.w, 16.h),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Center(
                          child: customText(
                            text: '${'LIVE_USER'.tr} (${controller.docs.length}/100)',
                            fontColor: colorBackgroundSilver,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: CircleAvatar(
                            radius: 20.r,
                            backgroundColor: colorBackgroundSilver,
                            child: Icon(
                              CommunityMaterialIcons.window_close,
                              size: 18.r,
                              color: colorDarkGrey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
