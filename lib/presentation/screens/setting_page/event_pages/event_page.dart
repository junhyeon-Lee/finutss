import 'package:finutss/domain/controller/event_controller.dart';
import 'package:finutss/presentation/screens/setting_page/event_pages/event_details_page.dart';
import 'package:finutss/presentation/widgets/common_widgets/action_card.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:get/get.dart';

import '../../../../data/data_service/lib_helper.dart';

class EventPage extends StatelessWidget {
  final ScrollController scrollController = new ScrollController();
  final _eventController = Get.put(EventController());
  @override
  Widget build(BuildContext context) {
    _eventController.callPaginateApi(isFirst: true);
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (_eventController.hasNextPage) {
          _eventController.page = _eventController.page + 1;
          _eventController.callPaginateApi();
        }
      }
    });
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadiusDirectional.circular(20)),
        child: Stack(
          children: [
            Column(
              children: [
                size25,
                /* --------------------------------- heading -------------------------------- */
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customText(text: 'Event', fontSize: 24, fontWeight: FontWeight.bold),
                  ],
                ),
                size30,

                /* -------------------------------------------------------------------------- */
                /*                                Event list                               */
                /* -------------------------------------------------------------------------- */
                Expanded(
                    child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16.r),
                    child: GetBuilder<EventController>(builder: (controller) {
                      return Column(
                        children: [
                          for (var event in controller.docs)
                            /* ---------------------------- language listCard ---------------------------- */
                            Padding(
                                padding: EdgeInsets.only(bottom: 14.0.h),
                                child: actionCard(
                                    onTapFunction: () {
                                      Get.to(() => EventDetailsPage(event), preventDuplicates: false);
                                    },
                                    heading: '${event['name']}',
                                    description: LocalDB.convertDateFormat(event["createdAt"], "yyyy-MM-dd")))
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
