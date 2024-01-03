import 'package:community_material_icon/community_material_icon.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/domain/controller/dummy_data_controller.dart';
import 'package:finutss/domain/controller/follower_controller.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/live_user_widgets/live_user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FollowerScreen extends StatefulWidget {
  @override
  State<FollowerScreen> createState() => _FollowerScreenState();
}

class _FollowerScreenState extends State<FollowerScreen> {
  final DummyDataController dummyDataController = Get.put(DummyDataController());

  final _followerController = Get.put(FollowerController());

  final authController = Get.put(AuthController());

  final ScrollController scrollController = new ScrollController();
  @override
  void initState() {
    _followerController.init();
    _followerController.callFollowerPaginate(authController.user?.userId);

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (_followerController.hasNextPage) {
          _followerController.page = _followerController.page + 1;
          _followerController.callFollowerPaginate(authController.user?.userId);
        }
      }
    });
    // _followerController.callFollowerPaginate(authController.user?.userId);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorLightGrey.withOpacity(0.9),
      body: GetBuilder<FollowerController>(builder: (followerController) {
        return Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  size70,
                  size20,
                  for (var data in followerController.docs) userView(data, context),
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
                            text: 'FOLLOWER'.tr,
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

  Padding userView(data, BuildContext context) {
    // var user = data.firstWhere((e) => e.userId != authController.user?.userId);
    print(data);
    return Padding(
      padding: EdgeInsets.only(left: 14.w, right: 14.w),
      child: liveUserCard(userInfo: data, isMapPage: false, isBottomSheet: false, context: context),
    );
  }
}
