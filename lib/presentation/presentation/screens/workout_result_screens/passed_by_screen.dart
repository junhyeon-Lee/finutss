import 'package:finutss/domain/controller/dummy_data_controller.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/live_user_widgets/live_user_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:get/get.dart';

class PassedByScreen extends StatelessWidget {
  final DummyDataController dummyDataController = Get.put(DummyDataController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorLightGrey.withOpacity(0.9),
      body: Stack(
        children: [
          Positioned.fill(
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    size70,
                    customText(
                      text: 'FOLLOW_USER'.tr,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontColor: colorBackgroundSilver,
                    ),
                    size10,
                    for (var data in dummyDataController.smallUserList) liveUserCard(imagePath: data['imagePath']),
                    size15,
                    customText(
                      text: 'PASSED_BY'.tr,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontColor: colorBackgroundSilver,
                    ),
                    size5,
                    for (var data in dummyDataController.userList) liveUserCard(imagePath: data['imagePath']),
                  ]),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 0.1.h),
              child: Container(
                color: colorLightGrey.withOpacity(1),
                width: double.infinity,
                height: 65.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customText(
                        text: 'Passed by',
                        fontColor: colorBackgroundSilver,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(top: 0.1.h),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: CircleAvatar(
                    radius: 20.r,
                    backgroundColor: colorBackgroundSilver,
                    child: Icon(
                      CommunityMaterialIcons.window_close,
                      size: 24.r,
                      color: colorDarkGrey,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
