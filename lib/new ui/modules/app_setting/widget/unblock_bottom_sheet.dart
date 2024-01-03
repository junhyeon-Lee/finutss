import 'package:finutss/new%20ui/modules/app_setting/controller/black_list_controller.dart';
import 'package:finutss/new%20ui/modules/connection/widget/close_button.dart';
import 'package:finutss/new%20ui/modules/user_profile/presentation/user_profile_screen.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/widget/cancel_save_button.dart';
import 'package:finutss/new%20ui/widget/custom_circle_imageview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

///UnBlockBottomSheet

Future<void> UnBlockBottomSheet({
  BuildContext? context,
  String? imagePath,
  String? Name,
  String? Bio,
  String? userId,
  int? index,
}) {
  final BlackListController controller = Get.find();

  return showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(12),
      ),
    ),
    enableDrag: false,
    context: context!,
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
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Spacer(),


            CloseButtonCustom(onTap: (){
              Get.back();
            }),

            Container(
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
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 10.w,
                  right: 10.w,
                  top: 34.h,
                ),
                child: Column(
                  children: [
                    Text(
                      "UNBLOCK".tr,
                      style: TextStyle(
                        color: AppColor.blueTextColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 11.h, horizontal: 10.w),
                      decoration: BoxDecoration(
                          color: AppColor.couponTextFieldBg,
                          borderRadius: BorderRadius.circular(8.w)),
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 4.w,
                            ),
                            CustomCircleImageview(
                              width: 55.w,
                              borderSize: 1.3,
                              imagePath: imagePath ?? '',
                            ),
                            SizedBox(
                              width: 14.w,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    Name ?? '',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.sp,
                                      color: AppColor.blueTextColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Text(
                                    Bio ?? '',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11.sp,
                                      color: AppColor.blueTextColor
                                          .withOpacity(0.8),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Image.asset(
                              IconAssets.more,
                              height: 9.h,
                              width: 3.w,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      "ARE_YOU_SURE_YOU_WANT_TO_UNBLOCK_THIS_USER".tr,
                      style: TextStyle(
                        color: AppColor.blueTextColor.withOpacity(0.7),
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(
                      height: 68.h,
                    ),
                    CancelSaveButton(
                      cancelTitle: "PROFILE".tr.toUpperCase(),
                      saveTitle: "UNBLOCK".tr.toUpperCase(),
                      onTapCancel: () {
                        Navigation.pop();
                        Get.to(UserProfileScreen(
                            userId: userId ?? ''),  transition: Routes.defaultTransition);
                      },
                      onTapSave: () {
                        controller.removeUserBlacklist(
                            userId: userId ?? '', index: index!);
                      },
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget startButton() {
  return InkWell(
    onTap: () {},
    child: Container(
      decoration: BoxDecoration(
        color: AppColor.orangeColor,
        borderRadius: BorderRadius.circular(
          12,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 12.h),
        child: Center(
          child: Text(
            "UNBLOCK".tr,
            style: TextStyle(
              color: AppColor.whiteColor,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.04,
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget CancelButton() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        12,
      ),
      border: Border.all(
        width: 1.5,
        color: AppColor.cancelButtonBg,
      ),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
      child: Center(
        child: Text(
          "PROFILE".tr,
          style: TextStyle(
            color: AppColor.cancelButtonColor,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.04,
            fontSize: 14.sp,
          ),
        ),
      ),
    ),
  );
}
