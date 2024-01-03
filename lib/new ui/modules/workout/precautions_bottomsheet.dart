import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/new%20ui/modules/map_view/presentation/map_screen.dart';
import 'package:finutss/new%20ui/modules/track/controller/track_detail_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> precautionsBottomSheet(BuildContext context,
    {String? title, String? icon, required String trackId, required TrackDetailController trackDetailController}) {
  return showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(12),
      ),
    ),
    enableDrag: false,
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: Colors.black.withOpacity(0.2),
    builder: (context) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 3.w),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12),
          ),
        ),
        height: MediaQuery.of(context).size.height * 2,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Spacer(),
                Container(
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
                    padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0.h),
                          child: Text(
                            "PRECAUTIONS".tr,
                            style: TextStyle(
                              color: AppColor.blueTextColor,
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            primary: true,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColor.calibrationCardColor,
                                // border: Border.all(color: AppColor.iconColorBg, width: 1.2),
                                borderRadius: BorderRadius.circular(
                                  12,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.h),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 20.0.h,
                                        ),
                                        child: Text(
                                          "WORKOUT".tr.toUpperCase(),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: AppColor.darkPink,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        bottom: 12.0.h,
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'PRECAUTIONS_DETAIL_GUIDE'.tr,
                                              maxLines: null,
                                              style: TextStyle(
                                                color: AppColor.blueTextColor.withOpacity(0.7),
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 20.0.h,
                                        ),
                                        child: Text(
                                          "COMMUNITY".tr.toUpperCase(),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: AppColor.darkPink,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        bottom: 12.0.h,
                                      ),
                                      child: Text(
                                        "COMMUNITY_DETAILS_GUIDE".tr,
                                        style: TextStyle(
                                          color: AppColor.blueTextColor.withOpacity(0.7),
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.h),
                                      child: CustomButton(
                                        onTap: () async {
                                          String token = await SharedPrefs.getToken();
                                          Navigation.pop();
                                          Navigation.pop();
                                          print("onTap StartNow  trackId::$trackId");
                                          Get.to(MapScreen(
                                            trackId: trackId,
                                            token: token,
                                            trackDetailController: trackDetailController,
                                          ));
                                        },
                                        title: "START_NOW".tr,
                                        isShowBorder: true,
                                        backGroundColor: AppColor.orangeColor,
                                        fontColor: AppColor.whiteColor,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                        height: 40.h,
                                        padding: EdgeInsets.zero,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 55.h,
              right: 15.w,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  child: Image.asset(
                    IconAssets.close,
                    scale: 4,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
