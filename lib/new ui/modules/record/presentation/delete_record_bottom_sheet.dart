import 'package:finutss/new%20ui/modules/record/controller/bmi_slider_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/cancel_save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> DeleteRecordBottomSheet(
  BuildContext context,
  index,
  String id,
) {
  final BmiSliderController bodyInfoController = Get.find();
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
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: 15.w,
                top: 400.h,
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
                        'DELETE'.tr,
                        style: TextStyle(
                          color: AppColor.blueTextColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        "RECORD_DELETE_WARNING_GUIDE".tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColor.subTitleColor,
                          fontSize: 13.sp,
                          height: 1.7,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Spacer(),
                      CancelSaveButton(
                        saveTitle: "DELETE".tr.toUpperCase(),
                        onTapCancel: () {
                          Navigation.pop();
                        },
                        onTapSave: () {
                          bodyInfoController.DeleteWeightRecord(
                              index: index, id: id);
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
