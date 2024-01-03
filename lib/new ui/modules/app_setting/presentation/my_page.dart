import 'package:finutss/new%20ui/modules/app_setting/controller/historyDisclosureController.dart';
import 'package:finutss/new%20ui/modules/app_setting/widget/custom_setting_row.dart';
import 'package:finutss/new%20ui/modules/app_setting/widget/history_disclosure_bottom_sheet.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyPageScreen extends StatelessWidget {
  MyPageScreen({Key? key}) : super(key: key);
  final HistoryDisclosureController controller = Get.put(HistoryDisclosureController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getUserInfo();
    });

    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomSettingRow(
              title: 'MY_PAGE'.tr,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.w,
                ),
                child: Column(
                  children: [

                    SizedBox(
                      height: 10.h,
                    ),
                    card(
                      () {
                        Navigation.pushNamed(
                          Routes.myScreenChangePasswordScreen,
                        );
                      },
                      'CHANGE_PASSWORD'.tr,
                      "",
                    ),
                    Obx(
                      () => card(
                        () {
                          historyDisclosureBottomSheet(context);
                        },
                        'HISTORY_DISCLOSURE'.tr,
                        controller.selectHistoryDisclosure.value.toString().toUpperCase().tr,
                      ),
                    ),
                    // card(
                    //   () {
                    //     Navigation.pushNamed(Routes.initializeAppDataScreen);
                    //   },
                    //   'INITIALIZE_APP_DATA'.tr,
                    //   "",
                    // ),
                    card(
                      () {
                        Navigation.pushNamed(Routes.withdrawalScreen);
                      },
                      'WITHDRAWAL'.tr,
                      "",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget card(VoidCallback? onTap, String? title, String? subTitle) {
    return InkWell(
      onTap: onTap!,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 6.h,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(
              6,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 15.h,
              horizontal: 12.w,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  title ?? " ",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.1,
                    color: AppColor.blueTextColor,
                  ),
                ),
                Spacer(),
                Text(
                  subTitle ?? "",
                  style: TextStyle(
                    color: AppColor.blueTextColor.withOpacity(0.6),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.2,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColor.iconColorBg,
                  size: 16,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
