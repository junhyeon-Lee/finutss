import 'package:finutss/new%20ui/modules/connection/widget/close_button.dart';
import 'package:finutss/new%20ui/modules/contact_us/controller/contact_us_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/app_string.dart';
import 'package:finutss/new%20ui/widget/custom_slider_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> paymentBottomSheet(BuildContext context, String paymentDialog, String title) {
  TextEditingController titleController = TextEditingController();
  TextEditingController disController = TextEditingController();
  ContactUsController contactUsController = Get.find();
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
      return Padding(
        padding:
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(12),
            ),
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: 50.h,
              ),
            CloseButtonCustom(
              onTap: () {
                Get.back();
              },
            ),
              Expanded(
                child: Container(
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
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 36.h,
                      ),
                      Text(
                        paymentDialog.tr,
                        style: TextStyle(
                            color: AppColor.subTitleColor,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.2,
                            fontSize: 20.sp),
                      ),
                      SizedBox(
                        height: 36.h,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 12.h,
                                ),
                                DialogTextField(
                                  controller: titleController,
                                  title: "TITLE".tr,
                                  hintText: "PLEASE_FILL_OUT_THE_TITLE".tr,
                                  maxline: 1,
                                ),
                                SizedBox(
                                  height: 19.h,
                                ),
                                DialogTextField(
                                  controller: disController,
                                  title: "MESSAGE".tr,
                                  hintText: "PLEASE_FILL_OUT_THE_INQUIRY".tr,
                                  maxline: 8,
                                ),
                                SizedBox(
                                  height: 25.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "EMAIL".tr,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13.sp,
                                          color: AppColor.subTitleColor
                                              .withOpacity(0.9)),
                                    ),
                                    Text(
                                      " : ${contactUsController.userModel.value.data?.email}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                        color: AppColor.greenSliderBg,
                                        letterSpacing: 0.2,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                paymentDialog=='BUG_REPORTING'
                                    ? SizedBox(
                                  height: 15.h,
                                )
                                    : Row(
                                  children: [
                                    Text(
                                      "CODE".tr,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13.sp,
                                          color: AppColor.subTitleColor
                                              .withOpacity(0.9)),
                                    ),
                                    Text(
                                      " : ${contactUsController.userModel.value.data?.uniqueId}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                        color: AppColor.greenSliderBg,
                                        letterSpacing: 0.2,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 63.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 23.w),
                                  child: CustomSliderButton(
                                    height: 42.3.h,
                                    title: "CONTACT_US".tr.toUpperCase(),
                                    onTap: () {
                                      Map<String, dynamic> body = {
                                        "title": titleController.text,
                                        "description": disController.text,
                                        "type": title,
                                      };
                                      if (titleController.text != '' && disController.text != '') {
                                        contactUsController.postInquiry(
                                            body: body);
                                      }

                                    },
                                    isCancelButton: false,
                                  ),
                                ),
                                SizedBox(
                                  height: 54.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class DialogTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String? hintText;
  final int maxline;

  DialogTextField(
      {required this.controller,
      required this.title,
      this.hintText,
      required this.maxline});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColor.subTitleColor,
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
          ),
        ),
        SizedBox(
          height: 9.h,
        ),
        SizedBox(
          child: TextFormField(
            textAlign: TextAlign.start,
            controller: controller,
            maxLines: maxline,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13.sp,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                  color: AppColor.subTitleColor.withOpacity(0.6),
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp),
              isDense: true,
              contentPadding: EdgeInsets.fromLTRB(
                16,
                12.7,
                10,
                12.7,
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide.none,
              ),
              suffixIconConstraints: BoxConstraints(
                maxHeight: 35.h,
              ),
              fillColor: AppColor.textFieldColor,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    8,
                  ),
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    8,
                  ),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    8,
                  ),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    8,
                  ),
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    8,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
