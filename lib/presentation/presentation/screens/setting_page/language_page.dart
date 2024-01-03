import 'package:community_material_icon/community_material_icon.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/domain/controller/localization_service.dart';
import 'package:finutss/domain/controller/setting_controller.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LanguagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List _selectedLang = LocalizationService.langs;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadiusDirectional.circular(20)),
        child: Stack(
          children: [
            Column(
              children: [
                size25,
                /* --------------------------------- heading -------------------------------- */
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customText(text: 'LANGUAGE'.tr, fontSize: 24, fontWeight: FontWeight.bold),
                  ],
                ),
                size25,
                Divider(
                  thickness: 1,
                ),
                /* -------------------------------------------------------------------------- */
                /*                                language list                               */
                /* -------------------------------------------------------------------------- */
                Expanded(
                    child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16.r),
                    child: GetBuilder<SettingController>(
                        init: SettingController(),
                        builder: (settingController) {
                          return Column(
                            children: _selectedLang
                                .map((e) => Padding(
                                      padding: EdgeInsets.only(bottom: 14.0.h),
                                      child: Container(
                                        height: 43.h,
                                        decoration: BoxDecoration(
                                            color: settingController.selectedValue == e
                                                ? colorBlue
                                                : colorBackgroundSilver,
                                            borderRadius: BorderRadius.circular(8)),
                                        child: InkWell(
                                          onTap: () {
                                            settingController.selectedValue = e;
                                            // settingController.unSelectAllLanguage();
                                            // // language['isSelected'] = true;
                                            settingController.update();
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                settingController.selectedValue == e
                                                    // language['isSelected']
                                                    ? Container(
                                                        height: 20.r,
                                                        width: 20.r,
                                                        decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                                image: AssetImage(
                                                          'assets/icons/un_check.png',
                                                        ))),
                                                      )
                                                    : size20,
                                                Text(
                                                  // " ${language['language']}",
                                                  e,
                                                  style: TextStyle(
                                                      fontSize: 16.sp,
                                                      color: settingController.selectedValue == e
                                                          // language['isSelected']
                                                          ? Colors.white
                                                          : Color(0xff7F8391),
                                                      fontWeight: FontWeight.w500),
                                                ),
                                                size20,
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ))
                                .cast<Widget>()
                                .toList(),

                            // [
                            //   for (var language in settingController.languageList)
                            //     /* ---------------------------- language listCard ---------------------------- */
                            // ],
                          );
                        }),
                  ),
                )),
                size10,
                /* -------------------------------------------------------------------------- */
                /*                           save and cancel button                           */
                /* -------------------------------------------------------------------------- */
                Padding(
                  padding: EdgeInsets.all(24.0.r),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r), border: Border.all(color: Colors.black)),
                          child: customButton(
                              radius: 15,
                              textSize: 16,
                              text: 'CANCEL'.tr,
                              fontWeight: FontWeight.bold,
                              textColor: Colors.black,
                              color: Colors.transparent,
                              onTapFunction: () {
                                Get.back();
                              },
                              height: 48),
                        ),
                      ),
                      size15,
                      GetBuilder<SettingController>(
                        builder: (SettingController controller) {
                          return Expanded(
                            child: customButton(
                                onTapFunction: () {
                                  LocalizationService().changeLocale(controller.selectedValue);
                                  Get.back();
                                },
                                textSize: 16,
                                radius: 15,
                                text: 'SAVE'.tr,
                                fontWeight: FontWeight.bold,
                                height: 48),
                          );
                        },
                        // child:
                      )
                    ],
                  ),
                )
              ],
            ),
            /* -------------------------------------------------------------------------- */
            /*                                cancel button                               */
            /* -------------------------------------------------------------------------- */
            Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 14.h, right: 16.w),
                    child: CircleAvatar(
                      radius: 20.r,
                      backgroundColor: colorBackgroundSilver,
                      child: Icon(
                        CommunityMaterialIcons.window_close,
                        color: Colors.black,
                        size: 24.r,
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
