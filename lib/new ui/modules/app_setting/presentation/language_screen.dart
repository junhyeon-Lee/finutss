import 'package:finutss/new%20ui/modules/app_setting/controller/app_setting_controller.dart';
import 'package:finutss/new%20ui/modules/app_setting/service/localization_service_new.dart';
import 'package:finutss/new%20ui/modules/app_setting/widget/custom_setting_row.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/cancel_save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageScreen extends StatelessWidget {
  final AppSettingController controller = Get.find();

  LanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomSettingRow(
              horizontalPadding: 24.w,
            ),
            SizedBox(
              height: 5.h,
            ),

            Expanded(child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.w,
                vertical: 5.h,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.CountryList.length,
                      itemBuilder: (context, index) {
                        return Obx(
                              () {
                            return InkWell(
                              onTap: () {
                                controller.selectedLanguageCode.value =
                                    controller.CountryList[index].languageCode;

                                controller.indexLan.value = index;
                                controller.getCurrentLanguageName();
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 3.h,
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
                                      vertical: 13.h,
                                      horizontal: 10.w,
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          controller.CountryList[index]
                                              .languageCode.toLowerCase() ==
                                              controller
                                                  .selectedLanguageCode.value.toLowerCase()
                                              ? IconAssets.checkBoxSelect
                                              : IconAssets.checkBoxUnSelect,
                                          //IconAssets.checkBoxUnSelect,
                                          width: 21.w,
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Text(
                                          controller.CountryList[index].nationalLanguageName,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.blueTextColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CancelSaveButton(
                    onTapSave: () async {
                      var prefs = await SharedPreferences.getInstance();
                      controller.selectedLanguage.value = controller
                          .CountryList[controller.indexLan.value]
                          .nationalLanguageName;

                      controller.setLanguage(languageCode: controller.selectedLanguageCode.value,languageName: controller
                          .CountryList[controller.indexLan.value]
                          .nationalLanguageName);
                      prefs.setBool('PhoneLanguage',false);
                      Navigation.pop();
                    },
                    onTapCancel: () {
                      Navigation.pop();
                    },
                  ),
                  SizedBox(
                    height: 39.h,
                  ),
                ],
              ),
            ),)

          ],
        ),
      ),
    );
  }

  Widget startButton() {
    return Container(
      height: 36.h,
      width: 136.w,
      decoration: BoxDecoration(
        color: AppColor.orangeColor,
        borderRadius: BorderRadius.circular(
          12,
        ),
      ),
      child: Center(
        child: Text(
          'START_NOW'.tr,
          style: TextStyle(
            color: AppColor.whiteColor,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.04,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }

  Widget CancelButton() {
    return Container(
      height: 36.h,
      width: 136.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          12,
        ),
        border: Border.all(
          width: 1.5,
          color: AppColor.cancelButtonBg,
        ),
      ),
      child: Center(
        child: Text(
          'CANCEL'.tr,
          style: TextStyle(
            color: AppColor.cancelButtonColor,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.04,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }
}
