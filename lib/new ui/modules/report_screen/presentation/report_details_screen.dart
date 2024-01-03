import 'package:finutss/new%20ui/modules/app_setting/widget/custom_setting_row.dart';
import 'package:finutss/new%20ui/modules/report_screen/controller/report_screen_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/cancel_save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ReportDetailsScreen extends StatelessWidget {
  ReportDetailsScreen({Key? key}) : super(key: key);
  final ReportScreenController reportScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    Constants.screenCloseCount=3;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backGroundColor,
        body: Column(
          children: [
            CustomSettingRow(
              title: "REPORT".tr.toUpperCase(),
              horizontalPadding: 22.w,
              fontsize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(13),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(
                                3.0,
                                4.0,
                              ),
                              blurRadius: 10.0,
                              spreadRadius: 1.0,
                            ), //BoxShadow
                          ],
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 20.h, horizontal: 12.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "DETAILED_REPORTING_CONTENT_QUESTIONS".tr,
                              style: TextStyle(
                                color: AppColor.subTitleColor,
                                fontSize: 13.sp,
                                height: 1.8,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.1,
                              ),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColor.calibrationCardColor,
                                borderRadius: BorderRadius.circular(10.w),
                              ),
                              padding: EdgeInsets.only(
                                  top: 14.h,
                                  bottom: 10.h,
                                  left: 18.w,
                                  right: 10.w),
                              child: TextField(
                                controller: reportScreenController.desController,
                                style: TextStyle(
                                  color: AppColor.alreadyTextColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp,
                                  height: 1.7,
                                ),
                                maxLength: 60,
                                maxLines: 6,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  hintText: "DETAILED_REPORTING_CONTENT_HINT".tr,
                                  hintStyle: TextStyle(
                                    color: AppColor.alreadyTextColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11.sp,
                                    height: 1.7,
                                  ),
                                  counterStyle: TextStyle(
                                    color: AppColor.subTitleColor.withOpacity(0.7),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11.sp,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 38.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6.w),
                              child: CancelSaveButton(
                                onTapCancel: () {
                                  Constants.screenCloseCount=2;
                                  Navigation.pop();
                                },
                                onTapSave: () {
                                  Map<String, dynamic> body = {
                                    "reportCategory": reportScreenController
                                        .unsubscribeModelList[
                                            reportScreenController
                                                .selectedUnsubscribeIndex.value]
                                        .value,
                                  };
                                  if(reportScreenController.userID!=null){
                                    body['reportedId'] = reportScreenController.userID;
                                  }
                                  if(reportScreenController.commentId!=null){
                                    body['commentId'] = reportScreenController.commentId.toString().trim();
                                  }

                                  if(reportScreenController.trackId!=null){
                                    body['trackId'] = reportScreenController.trackId.toString().trim();
                                  }
                                  if (reportScreenController.desController.text.isNotEmpty) {
                                    body['reportDetail'] = reportScreenController.desController.text.toString().trim();
                                  }

                                  FocusScope.of(context).requestFocus(new FocusNode());
                                  reportScreenController.report(body: body);
                                },
                                saveTitle: "SEND".tr,
                              ),
                            ),
                            SizedBox(
                              height: 9.h,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
