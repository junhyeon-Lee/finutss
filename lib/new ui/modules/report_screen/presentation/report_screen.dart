import 'package:finutss/helper/toast_helper.dart';
import 'package:finutss/new%20ui/modules/app_setting/widget/custom_setting_row.dart';
import 'package:finutss/new%20ui/modules/report_screen/controller/report_screen_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/widget/custom_slider_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class ReportScreen extends StatefulWidget {
  ReportScreen({Key? key,this.userId, this.trackId, this.commentId}) : super(key: key);

  final String? userId;
  final String? trackId;
  final String? commentId;

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final ReportScreenController reportScreenController = Get.put(ReportScreenController());

  @override
  void initState() {
    super.initState();

    reportScreenController.selectedUnsubscribeIndex.value=-1;
    Constants.isOpenScreen=true;
    reportScreenController.userID=widget.userId;
    reportScreenController.trackId=widget.trackId;
    reportScreenController.commentId=widget.commentId;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColor.backGroundColor,
        systemNavigationBarColor: AppColor.backGroundColor,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.backGroundColor,
          body: Column(
            children: [
              CustomSettingRow(
                title: "REPORT".tr,
                horizontalPadding: 22.w,
                fontsize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 26.h, horizontal: 18.w),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.whiteColor,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.cardGradiant1.withOpacity(0.06),
                                spreadRadius: 1.6,
                                blurRadius: 16,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 23.h, horizontal: 22.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "WHY_DID_YOU_REPORT_IT".tr,
                                style: TextStyle(
                                    color: AppColor.subTitleColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp),
                              ),
                              SizedBox(
                                height: 28.h,
                              ),
                              ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: reportScreenController.unsubscribeModelList.length,
                                itemBuilder: (context, index) {
                                  return Obx(() => InkWell(
                                    onTap: () {
                                      reportScreenController.selectedUnsubscribeIndex.value = index;
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          reportScreenController
                                              .selectedUnsubscribeIndex
                                              .value ==
                                              index
                                              ? IconAssets.checkBoxSelect
                                              : IconAssets.checkBoxUnSelect,
                                          scale: 3.2,
                                        ),
                                        SizedBox(
                                          width: 16.w,
                                        ),
                                        Expanded(
                                          child: Text(
                                            reportScreenController
                                                .unsubscribeModelList[index]
                                                .tittle,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.sp,
                                                color: AppColor.alreadyTextColor),
                                          ),
                                        )
                                      ],
                                    ),
                                  ));
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(
                                    height: 28.h,
                                  );
                                },
                              ),
                              SizedBox(
                                height: 6.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 56.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 46.w),
                        child: CustomSliderButton(
                            title: 'NEXT'.tr,
                            onTap: () {
                              reportScreenController.desController.text='';
                              if(reportScreenController.selectedUnsubscribeIndex.value==-1){
                                AppToast.showSnackBar(title: '', message: 'PLEASE_SELECT_A_REASON_FOR_REPORTING'.tr);
                              }else{
                                Navigation.pushNamed(Routes.reportDetailScreen);
                              }
                            },
                            isCancelButton: false),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
