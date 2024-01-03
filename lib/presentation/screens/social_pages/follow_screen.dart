import 'package:community_material_icon/community_material_icon.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/domain/controller/dummy_data_controller.dart';
import 'package:finutss/domain/controller/follow_controller.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/live_user_widgets/live_user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FollowScreen extends StatelessWidget {
  final DummyDataController dummyDataController = Get.put(DummyDataController());
  final _followController = Get.put(FollowController());
  final authController = Get.put(AuthController());
  final ScrollController scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    print("FollowScreen");
    _followController.init();
    _followController.callFollowPaginate(authController.user?.userId);
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (_followController.hasNextPage) {
          _followController.page = _followController.page + 1;
          _followController.callFollowPaginate(authController.user?.userId);
        }
      }
    });
    return Scaffold(
      backgroundColor: colorLightGrey.withOpacity(0.9),
      body: GetBuilder<FollowController>(builder: (followController) {
        return Stack(
          children: [
            // size30,
            Positioned.fill(
              child: SingleChildScrollView(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  size70,
                  size20,
                  for (var data in followController.docs) userView(data, context),
                ]),
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
                            text: 'FOLLOW'.tr,
                            fontColor: colorBackgroundSilver,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CircleAvatar(
                          radius: 20.r,
                          backgroundColor: colorBackgroundSilver,
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

  Widget userView(data, BuildContext context) {
    // var user = data.firstWhere((e) => e?.userId != authController.user?.userId);
    // print(data);
    if (data != null) {
      return Padding(
        padding: EdgeInsets.only(left: 14.w, right: 14.w),
        child: liveUserCard(userInfo: data, isMapPage: false, isBottomSheet: false, context: context),
      );
    } else {
      return size0;
    }
  }
}
