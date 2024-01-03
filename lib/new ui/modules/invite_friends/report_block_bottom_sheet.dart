import 'package:finutss/new%20ui/modules/app_setting/controller/black_list_controller.dart';
import 'package:finutss/new%20ui/modules/connection/widget/close_button.dart';
import 'package:finutss/new%20ui/modules/home/widget/custom_button.dart';
import 'package:finutss/new%20ui/modules/report_screen/presentation/report_screen.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/widget/cancel_save_button.dart';
import 'package:finutss/new%20ui/widget/custom_slider_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

Future<void> reportBlockBottomSheet(BuildContext context, {String? userId,String? commentId,String? trackId,bool? isOnlyReport}) {
  final BlackListController controller = Get.find();

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
      Constants.isOpenScreen=true;
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 3.w),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12),
          ),
        ),
        height: MediaQuery.of(context).size.height * 2,
        width: MediaQuery.of(context).size.width,
        child: SizedBox(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Column(
                  children: [
                    Container(
                      child: CloseButtonCustom(
                        onTap: () {
                          Get.back();
                        },
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
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
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 22.w),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 26.h,
                                ),
                                SizedBox(
                                  height: 40.h,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top: 0,
                                          bottom: 0,
                                          left: 0,
                                          child: InkWell(
                                            onTap: () {
                                              Get.back();
                                            },
                                            child: SvgPicture.asset(
                                              IconAssets.backIcon,
                                              color: AppColor.backIconColor,
                                              width: 20.w,
                                            ),
                                          )),
                                      Positioned(
                                          left: 0,
                                          right: 0,
                                          top: 0,
                                          bottom: 0,
                                          child: Center(
                                            child: Text(
                                              (isOnlyReport ?? false) ? 'REPORT'.tr : "REPORT_BLOCK".tr,
                                              style: TextStyle(
                                                color: AppColor.subTitleColor,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 19.h,
                                ),
                                Text(
                                  'DECLARE_BLOCK_INFO'.tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color:
                                        AppColor.subTitleColor.withOpacity(0.7),
                                    fontSize: 13.sp,
                                    height: 1.7,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  height: 52.h,
                                ),
                                (isOnlyReport ?? false) ? Padding(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 82.w),
                                  child: CustomSliderButton(
                                    height: 40.h,
                                    title: "REPORT".tr.toUpperCase(),
                                    onTap: () {
                                      Navigation.pop();
                                      Get.to(ReportScreen(trackId: trackId,),transition: Routes.defaultTransition);
                                    }, isCancelButton: false,
                                  ),
                                ): Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: CancelSaveButton(
                                    cancelTitle: "BLOCK".tr.toUpperCase(),
                                    saveTitle: "REPORT".tr.toUpperCase(),
                                    onTapSave: () {
                                      Get.to(ReportScreen(userId: userId,commentId: commentId,trackId: trackId,),transition: Routes.defaultTransition);
                                    },
                                    onTapCancel: () {
                                      Map<String, dynamic> body = {
                                        "userId": userId ?? '',
                                      };
                                      controller.addUserBlacklist(body: body);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 35.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
