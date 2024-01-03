import 'package:finutss/domain/controller/dummy_data_controller.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/domain/controller/recommand_controller.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/live_user_widgets/live_user_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:get/get.dart';

class RecommendedScreen extends StatelessWidget {
  final DummyDataController dummyDataController = Get.put(DummyDataController());
  final _recommandController = Get.put(RecommandController());
  final ScrollController scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        print("_recommandController.addListener");
        if (_recommandController.hasNextPage) {
          _recommandController.page = _recommandController.page + 1;
          _recommandController.callPaginateApi();
        }
      }
    });
    return GetBuilder<RecommandController>(builder: (recommandController) {
      return Scaffold(
        backgroundColor: colorLightGrey.withOpacity(0.9),
        body: RefreshIndicator(
          onRefresh: () async {
            print("onRefresh");
          },
          child: Stack(
            children: [
              Positioned.fill(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    size70,
                    size20,
                    if (recommandController.docs.length > 0)
                      for (var data in recommandController.docs)
                        Padding(
                            padding: EdgeInsets.only(left: 14.w, right: 14.w),
                            child: liveUserCard(
                              // isBottomSheet: false,
                              isMapPage: false,
                              userInfo: data,
                            ))
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
                              text: 'RECOMMEND'.tr,
                              fontColor: colorBackgroundSilver,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: CircleAvatar(
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
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
