import 'package:finutss/domain/controller/notice_controller.dart';
import 'package:finutss/data/data_service/lib_helper.dart';
import 'package:finutss/presentation/widgets/common_widgets/action_card.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:get/get.dart';

import 'notification_details_page.dart';

class NoticePage extends StatelessWidget {
  final ScrollController scrollController = new ScrollController();
  final _noticeController = Get.put(NoticeController());

  @override
  Widget build(BuildContext context) {
    _noticeController.callPaginateApi(isFirst: true);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (_noticeController.hasNextPage) {
          _noticeController.page = _noticeController.page + 1;
          _noticeController.callPaginateApi();
        }
      }
    });
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadiusDirectional.circular(20)),
        child: Stack(
          children: [
            Column(
              children: [
                size25,
                /* --------------------------------- heading -------------------------------- */
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customText(
                        text: 'NOTICE_BOARD'.tr,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ],
                ),
                size30,

                /* -------------------------------------------------------------------------- */
                /*                                Notice list                               */
                /* -------------------------------------------------------------------------- */
                Expanded(
                    child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: EdgeInsets.all(16.r),
                    child: GetBuilder<NoticeController>(builder: (controller) {
                      return Column(
                        children: [
                          for (var notice in controller.docs)
                            /* ---------------------------- language listCard ---------------------------- */
                            Padding(
                                padding: EdgeInsets.only(bottom: 14.0.h),
                                child: actionCard(
                                    onTapFunction: () {
                                      Get.to(NotificationDetailsPage(notice),
                                          preventDuplicates: false);
                                    },
                                    heading: '${notice['name']}',
                                    description: LocalDB.convertDateFormat(
                                        notice["createdAt"], "yyyy-MM-dd")))
                        ],
                      );
                    }),
                  ),
                )),
              ],
            ),
            /* -------------------------------------------------------------------------- */
            /*                                cancel button                               */
            /* -------------------------------------------------------------------------- */
            Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 14.h, right: 16.w),
                    child: CircleAvatar(
                      radius: 20.r,
                      backgroundColor: colorBackgroundSilver,
                      child: Icon(
                        CommunityMaterialIcons.window_close,
                        color: Colors.black,
                        size: 24.r,
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
