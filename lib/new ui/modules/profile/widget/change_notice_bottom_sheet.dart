import 'package:finutss/new%20ui/modules/profile/controller/edit_profile_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/custom_slider_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> ChangeNoticeBottomSheet(BuildContext context) {
  final EditProfileController controller = Get.find();
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
                    left: 10.w,
                    right: 10.w,
                    top: 34.h,
                  ),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'NOTICE'.tr.toUpperCase(),
                            style: TextStyle(
                              color: AppColor.blueTextColor,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "YOU_RECENTLY_CHANGED_YOUR_NICKNAME".tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColor.blueTextColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                              letterSpacing: 0.2,
                              height: 1.6,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                            ),
                            child: CustomSliderButton(
                              title: 'OK'.tr,
                              onTap: () {
                                Navigation.pop();
                              },
                              isCancelButton: false,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
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
