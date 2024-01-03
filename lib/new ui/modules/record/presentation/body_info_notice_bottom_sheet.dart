import 'package:finutss/new%20ui/modules/connection/presentation/body_info_select_bottom_sheet.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/cancel_save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> BodyInfoNoticeBottomSheet(
  BuildContext context,
) {
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
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12),
          ),
        ),
        height: MediaQuery.of(context).size.height * 2,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: 15.w,
                top: 300.h,
              ),
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Image.asset(
                      IconAssets.close,
                      scale: 4,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.elliptical(
                      MediaQuery.of(context).size.width,
                      74.0,
                    ),
                  ),
                ),
                height: MediaQuery.of(context).size.height * 0.92,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 25.w,
                    right: 25.w,
                    top: 34.h,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'NOTICE'.tr.toUpperCase(),
                        style: TextStyle(
                          color: AppColor.blueTextColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Image.asset(
                        IconAssets.notice,
                        height: 94.h,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        "BODY_INFO_RECOMMENDATION".tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColor.blueTextColor,
                          fontSize: 14.sp,
                          height: 1.7,
                          letterSpacing: 0.4,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Spacer(),
                      CancelSaveButton(
                        saveTitle: "EDIT".tr,
                        cancelTitle: 'DO_LATER'.tr,
                        onTapSave: () {
                          Navigation.pop();
                          bodyInfoSelectBottomSheet(
                            isPopValue: false,
                            index: 0,
                            context: context,
                          );
                        },
                        onTapCancel: (){
                          Navigation.pop();
                        },
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                    ],
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
