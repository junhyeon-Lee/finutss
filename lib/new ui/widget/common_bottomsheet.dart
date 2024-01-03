import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/widget/bottomsheet_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> customBottomSheet(BuildContext context, {String? title, String? icon, required Widget child}) {
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
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 15.h),
                        child: HeaderWidget(icon: icon, title: title ?? ''),
                      ),
                      child
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 50.h,
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
