import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/new%20ui/modules/connection/widget/close_button.dart';
import 'package:finutss/new%20ui/modules/contact_us/controller/contact_us_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/custom_slider_button.dart';
import 'package:finutss/new%20ui/widget/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

Future<void> inquiryHistoryBottomSheet(BuildContext context,
    {required String id,required int index, required String userId, required String Name}) {
  ContactUsController contactUsController = Get.find();

  final DateFormat timeFormat = DateFormat('dd.MM.yyyy');


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
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 35.h,
                      ),
                      Text(
                        "INQUIRY_HISTORY".tr.toUpperCase(),
                        style: TextStyle(
                            color: AppColor.subTitleColor,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.2,
                            fontSize: 22.sp),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),

                      Expanded(
                        child: Obx(()=> contactUsController.repliesList.length==0 ? CustomVIew.errorMessageShow('no replie message found') : ListView.separated(
                          controller: contactUsController.scrollController,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, i){
                              String date=contactUsController.repliesList[i].createdAt!=null ? timeFormat.format(DateTime.parse(contactUsController.repliesList[i].createdAt ?? DateTime.now().toString()).toLocal()) : '';


                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.w),
                                  color: (contactUsController.repliesList[i].messageByUserId.toString() == userId) ? AppColor.historyCardBlue : AppColor.historyCardPink,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 18.w, vertical: 12.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(

                                          (contactUsController.repliesList[i].messageByUserId.toString() == userId) ?Name:"SUPPORT".tr,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12.sp,
                                              letterSpacing: 0.1,
                                              color: AppColor.purple),
                                        ),
                                        Text(
                                          date,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 11.sp,
                                              color: AppColor.subTitleColor
                                                  .withOpacity(0.6)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(

                                      contactUsController.repliesList[i].message ?? '',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.sp,
                                          height: 1.8,
                                          color: AppColor.subTitleColor
                                              .withOpacity(0.8)),
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    )
                                  ],
                                ),
                              );
                            }, separatorBuilder: (context,i){
                          return  SizedBox(
                            height: 12.h,
                          );
                        }, itemCount: contactUsController.repliesList.length)),
                      ),

                      SizedBox(
                        height: 13.h,
                      ),
                      Container(
                        height: 54.h,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9.w),
                          color: AppColor.textFieldColor,
                        ),
                        child: TextField(
                          controller: contactUsController.replayController,
                          textAlign: TextAlign.start,
                          maxLines: 10,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13.sp,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'WRITE_YOUR_REPLY'.tr,
                            hintStyle: TextStyle(
                                color: AppColor.subTitleColor
                                    .withOpacity(0.6),
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 36.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: CustomSliderButton(
                          isCancelButton: false,
                          title: "SEND".tr,
                          onTap: () {
                            Map<String, dynamic> body = {
                              "reply": contactUsController.replayController.text
                            };
                            if (contactUsController.replayController.text != '') {
                              contactUsController.updateInquiryHistory(
                                  body: body, id: id,index: index);
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 52.h,
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
