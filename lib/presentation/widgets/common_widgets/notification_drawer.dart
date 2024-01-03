import 'package:community_material_icon/community_material_icon.dart';
import 'package:finutss/domain/controller/notification_controller.dart';
import 'package:finutss/presentation/widgets/common_widgets/notification_discrption.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import 'custom_button.dart';
import 'custom_text.dart';

class NotificationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
        init: NotificationController(),
        builder: (notificationController) {
          return Column(
            children: [
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          topLeft: Radius.circular(15)),
                      color: Color(0xff41465C),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        size20,
                        customText(
                            text: 'NOTIFICATION'.tr,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            fontColor: Colors.white),
                        size15,
                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.only(left: 16.w),
                              child: Column(
                                children: [
                                  for (var data in notificationController
                                      .notificationList)
                                    InkWell(
                                      child: _notificationCard(
                                        title: data['title'].toString().tr,
                                        text: data['text'].toString().tr,
                                        time: data['time'],
                                        icon: data['icon'],
                                        isFriendRequest:
                                            data['isFriendRequest'],
                                        accept: data['accept'],
                                        decline: data['decline'],
                                      ),
                                      onTap: () {
                                        if (data['isFriendRequest'] == false)
                                          Get.to(
                                            () => NotificationDescription(
                                              text: data['text'],
                                              title: data['title'],
                                            ),
                                          );
                                      },
                                    )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h),
                child: CircleAvatar(
                  radius: 20.r,
                  backgroundColor: colorPink,
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      CommunityMaterialIcons.close,
                      color: Colors.white,
                      size: 24.r,
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }
}

_notificationCard({
  String title = 'Beat the operatior!',
  String text = "Challenge now and get galaxy. Buds pro! Events...",
  icon = Icons.note,
  String time = '7:21',
  bool isFriendRequest = false,
  accept,
  decline,
}) {
  return Column(
    children: [
      Container(
        // height: 114,
        decoration: BoxDecoration(
          color: colorBackgroundSilver,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.r),
              bottomLeft: Radius.circular(15.r)),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(14.w, 16.h, 16.w, 16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 45.r,
                    color: colorBlue,
                  ),
                  size15,
                  customText(
                    text: time,
                    fontColor: colorBlue,
                  ),
                ],
              ),
              size15,
              Expanded(
                child: Container(
                  // height: 84,
                  decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(9.0.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        size5,
                        Text(
                          text,
                          style: TextStyle(
                              color: Color(0xff7F8391), fontSize: 12.sp),
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                        size15,
                        isFriendRequest
                            ? Row(
                                children: [
                                  Expanded(
                                    child: customButton(
                                      text: 'DECLINE'.tr,
                                      color: Color(0xffF7EBEE),
                                      fontWeight: FontWeight.bold,
                                      textSize: 10,
                                      textColor: Color(0xffF73A6B),
                                      onTapFunction: decline,
                                    ),
                                  ),
                                  size10,
                                  Expanded(
                                    child: customButton(
                                        text: 'ACCEPT'.tr,
                                        color: Color(0xff3BCCE1),
                                        fontWeight: FontWeight.bold,
                                        textSize: 10,
                                        textColor: Color(0xffffffff),
                                        onTapFunction: accept),
                                  ),
                                ],
                              )
                            : Container()
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      size5
    ],
  );
}
