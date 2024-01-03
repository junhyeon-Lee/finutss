import 'package:finutss/constants.dart';
import 'package:finutss/domain/controller/qna_controller.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/common_widgets/expandable_text_field.dart';
import 'package:finutss/presentation/widgets/default_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:get/get.dart';

class ContactUsFormPage extends StatelessWidget {
  final title;
  ContactUsFormPage(this.title);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GetBuilder<QnAController>(builder: (qnAController) {
        return Container(
          height: Get.height,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadiusDirectional.circular(20.r)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  size25,
                  /* --------------------------------- heading -------------------------------- */
                  Stack(
                    children: [
                      Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: customText(text: 'CONTACT_US'.tr, fontSize: 24, fontWeight: FontWeight.bold),
                          )),
                      Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: CircleAvatar(
                              radius: 20.r,
                              backgroundColor: colorBackgroundSilver,
                              child: Icon(
                                CommunityMaterialIcons.window_close,
                                color: Colors.black,
                                size: 24.r,
                              ),
                            ),
                          ))
                    ],
                  ),
                  size30,
                  customText(text: "${title[0]}", fontSize: 16, fontWeight: FontWeight.w700),
                  size15,
                  expandableTextField(
                      hintText: 'PLEASE_FILL_OUT_THE_TITLE'.tr,
                      showBorder: true,
                      padding: 10,
                      controller: qnAController.titleTextController),
                  size15,
                  expandableTextField(
                      maxLine: 10,
                      hintText: 'PLEASE_FILL_OUT_THE_INQUIRY'.tr,
                      showBorder: true,
                      padding: 10,
                      controller: qnAController.contentTextController),
                  size15,
                  infoWidget('Email', 'useruser99@naver.com'),
                  if (title[1] == 'Payment') size15,
                  if (title[1] == 'Payment') infoWidget('Code', 'F463A476'),
                  size20,
                  Row(
                    children: [
                      Expanded(
                          child: customButton(
                              text: 'CONTACT_US'.tr,
                              textSize: 16,
                              fontWeight: FontWeight.bold,
                              height: 48,
                              radius: 15,
                              onTapFunction: () async {
                                await qnAController.writeQna(title[1]);
                                Get.dialog(DefalutDialog(
                                    title: 'REPORT_DONE'.tr,
                                    description: 'CONTACT_US_HISTORY'.tr,
                                    buttons: Row(
                                      children: [
                                        Expanded(
                                          child: customButton(
                                              onTapFunction: () {
                                                Get.back();
                                              },
                                              borderColor: colorDarkGrey,
                                              radius: 16,
                                              height: 48,
                                              text: 'OK'.tr,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              textColor: colorDarkGrey,
                                              textSize: 16),
                                        ),
                                      ],
                                    )));
                              }))
                    ],
                  )
                ],
              ),
            ),
          ),
          /* -------------------------------------------------------------------------- */
          /*                                cancel button                               */
          /* -------------------------------------------------------------------------- */
        );
      }),
    );
  }

  Widget infoWidget(title, value) {
    return Row(
      children: [
        customText(text: '$title :  ', fontSize: 14, fontWeight: FontWeight.w600, fontColor: Color(0xff7F8391)),
        customText(text: '$value', fontSize: 14, fontWeight: FontWeight.w600, fontColor: Colors.black),
      ],
    );
  }

  // ignore: unused_element
  Widget _date(date, {bool isLeftAlign = false}) {
    return Row(
      mainAxisAlignment: isLeftAlign ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        customText(
          fontColor: Color(0xff7F8391),
          text: date ?? '',
          fontSize: 14,
        ),
      ],
    );
  }
}
