import 'package:finutss/domain/controller/qna_controller.dart';
import 'package:finutss/domain/controller/setting_controller.dart';
import 'package:finutss/presentation/screens/setting_page/contact_pages/contact_us_form.dart';
import 'package:finutss/presentation/widgets/common_widgets/action_card.dart';
import 'package:finutss/presentation/widgets/common_widgets/appbars/simple_appbar.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'inquiry_history_page.dart';

class ContactUsPage extends StatelessWidget {
  final qnAController = Get.put(QnAController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackgroundSilver,
      appBar: simpleAppBar(text: 'CONTACT_US'.tr, actions: [
        Padding(
          padding: EdgeInsets.all(16.r),
          child: customButton(
              onTapFunction: () {
                Get.dialog(Padding(padding: EdgeInsets.all(16.r), child: InquiryHistoryPage()));
              },
              radius: 6,
              text: 'HISTORY'.tr,
              fontWeight: FontWeight.bold,
              textSize: 10),
        )
      ]) as PreferredSizeWidget?,
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.r),
            margin: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: GetBuilder<SettingController>(
                init: SettingController(),
                builder: (settingController) {
                  return Column(
                    children: [
                      for (var contactUsTitle in SettingController.contactUsList)
                        Padding(
                            padding: EdgeInsets.only(bottom: 14.0.h),
                            child: actionCard(
                                onTapFunction: () {
                                  Get.dialog(Padding(
                                      padding: EdgeInsets.all(16.r),
                                      child: Container(child: ContactUsFormPage(contactUsTitle))));
                                },
                                heading: contactUsTitle[0])),
                      /* -------------------------------------------------------------------------- */
                      /*                              bottom info text                              */
                      /* -------------------------------------------------------------------------- */

                      // size15,
                      for (var rules in settingController.contactUsRules)
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            text: rules,
                            style: TextStyle(
                              height: 1.5,
                              color: Color(0XFF7F8391),
                              fontSize: 14.sp,
                            ),
                          ),
                        )
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
