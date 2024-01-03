import 'package:finutss/new%20ui/modules/connection/widget/close_button.dart';
import 'package:finutss/new%20ui/modules/home/controller/notification_controller.dart';
import 'package:finutss/new%20ui/modules/track/presentation/track_detail_screen.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/widget/custom_circle_imageview.dart';
import 'package:finutss/new%20ui/widget/custom_view.dart';
import 'package:finutss/presentation/animation/bouncing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final HomeNotificationController notificationController = Get.put(HomeNotificationController());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      notificationController.getNotification();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12),
          ),
          color: AppColor.black.withOpacity(0.4)),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: CloseButtonCustom(onTap: () {
              Get.back();
            }),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.elliptical(
                    MediaQuery.of(context).size.width,
                    100.0,
                  ),
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.92,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 5.h,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      "NOTIFICATION".tr.toUpperCase(),
                      style: TextStyle(
                        color: AppColor.blueTextColor,
                        fontSize: 21.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 23.h,
                    ),
                    Expanded(
                        child: Obx(() => notificationController.isLoading.value
                            ? CustomVIew.listViewShimmer()
                            : notificationController.notificationList.length == 0
                                ? CustomVIew.errorMessageShow('NO_NOTIFICATION_FOUND')
                                : ListView.builder(
                                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                                    itemBuilder: (context, i) {
                                      return _notificationCard(
                                          icon: notificationController.notificationList[i].notificationData?.profilePhoto ?? '',
                                          title: notificationController.notificationList[i].notificationData?.trackId != null
                                              ? 'WANT_TO_WORKOUT_TOGHTHER'.tr
                                              : notificationController.notificationList[i].title ?? '',
                                          text: notificationController.notificationList[i].content ?? '',
                                          isFriendRequest:
                                              notificationController.notificationList[i].notificationData?.trackId != null
                                                  ? true
                                                  : false,
                                          trackID: notificationController.notificationList[i].notificationData?.trackId);
                                    },
                                    shrinkWrap: true,
                                    itemCount: notificationController.notificationList.length,
                                  ))),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

_notificationCard(
    {String title = '',
    String text = "",
    String name = "",
    required String icon,
    bool isFriendRequest = false,
    String? trackID}) {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(bottom: 9.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColor.backGroundColor,
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 4.w,
            ),
            Column(
              children: [
                CustomCircleImageview(
                  width: 48.w,
                  imagePath: icon,
                ),
                /* SizedBox(
                  width: 48.w,
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: AppColor.transparent,
                      child: Image.asset(
                              icon,
                              height: 30.h,
                            ),
                      radius: 21.w,
                    ),
                  ),
                ),*/
              ],
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Container(
                // height: 84,
                child: Padding(
                  padding: EdgeInsets.all(9.0.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                          color: AppColor.blueTextColor,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        text,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 11.sp,
                          color: AppColor.blueTextColor.withOpacity(0.8),
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      isFriendRequest
                          ? Padding(
                              padding: const EdgeInsets.only(top: 14),
                              child: Row(
                                children: [
                                  AcceptButton(AppColor.declineBg, "DECLINE".tr, AppColor.declineBg, () {}),
                                  SizedBox(
                                    width: 16.w,
                                  ),
                                  AcceptButton(AppColor.orangeColor, "ACCEPT".tr, AppColor.orangeGradiant1, () {
                                    Get.to(TrackDetailScreen(trackId: trackID ?? ''), transition: Routes.defaultTransition);
                                  }),
                                ],
                              ),
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
    ],
  );
}

Widget AcceptButton(Color? borderColor, String? title, Color titleColor, VoidCallback onTap) {
  return Bouncing(
    duration: Duration(milliseconds: 100),
    onPressed: onTap,
    child: Container(
      height: 24.h,
      padding: EdgeInsets.symmetric(horizontal: 17.w),
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor ?? Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          title ?? "ACCEPT".tr,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: titleColor,
            fontSize: 12.sp,
          ),
        ),
      ),
    ),
  );
}
