import 'package:finutss/new%20ui/modules/app_setting/widget/custom_setting_row.dart';
import 'package:finutss/new%20ui/modules/connection/presentation/body_imformation_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/connection/presentation/body_info_select_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/record/controller/bmi_slider_controller.dart';
import 'package:finutss/new%20ui/modules/record/presentation/body_info_notice_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/record/presentation/delete_record_bottom_sheet.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/widget/bmi_slider.dart';
import 'package:finutss/new%20ui/widget/custom_view.dart';
import 'package:finutss/presentation/presentation/animation/bouncing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TrackBodyInfo extends StatefulWidget {
  TrackBodyInfo({Key? key}) : super(key: key);

  @override
  State<TrackBodyInfo> createState() => _TrackBodyInfoState();
}

class _TrackBodyInfoState extends State<TrackBodyInfo> {
  final BmiSliderController bmiSliderController = Get.find();

  @override
  Widget build(BuildContext context) {
    bmiSliderController.getWeightRecordApiCall();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backGroundColor,
        body: Column(
          children: [
            CustomSettingRow(
              title: "BODY_INFO".tr.toUpperCase(),
              horizontalPadding: 22.w,
              fontsize: 18.sp,
              fontWeight: FontWeight.w700,
              lastImagePath: IconAssets.editSquareIcon,
              child: InkWell(
                onTap: () {
                  bmiSliderController.setBodyData();
                  BodyInfoNoticeBottomSheet(context);
                },
                child: SvgPicture.asset(
                  IconAssets.editSquareIcon,
                  width: 22.w,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 16.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.cardGradiant1.withOpacity(0.06),
                              spreadRadius: 1.4,
                              blurRadius: 10,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 18.h,
                            horizontal: 20.w,
                          ),
                          child: Obx(() => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "BASIC_BODY_INFO".tr,
                                    style: TextStyle(
                                      color: AppColor.subTitleColor,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 19.h,
                                  ),
                                  BasicInformationRow(
                                    "GENDER".tr,
                                    bmiSliderController
                                            .userModel.value.data?.gender ??
                                        '',
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  BasicInformationRow(
                                    "YEAR_OF_BIRTH".tr,
                                    bmiSliderController
                                            .userModel.value.data?.yearOfBirth
                                            ?.toString() ??
                                        '',
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  BasicInformationRow(
                                    "HEIGHT".tr,
                                    (bmiSliderController.userModel.value.data
                                                    ?.heightInCm ??
                                                0)
                                            .toString() +
                                        " ${"CM".tr}",
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  BasicInformationRow(
                                    "WEIGHT".tr,
                                    (bmiSliderController.userModel.value.data
                                                    ?.weightInKg ??
                                                0)
                                            .toString() +
                                        " ${"KG".tr}",
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                ],
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 13.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.cardGradiant1.withOpacity(0.06),
                              spreadRadius: 1.4,
                              blurRadius: 10,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 18.h,
                            horizontal: 20.w,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "BMI".tr.toUpperCase(),
                                    style: TextStyle(
                                      color: AppColor.subTitleColor,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.4,
                                    ),
                                  ),
                                  Spacer(),
                                  Obx(() => Text(
                                        bmiSliderController
                                                .userModel.value.data?.bmi
                                                ?.toString() ??
                                            '',
                                        style: TextStyle(
                                          color: AppColor.sliderIndicatorColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 0.2,
                                        ),
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Obx(() => bmiSlider(
                                    bmiSliderController: bmiSliderController,
                                    bmi: bmiSliderController
                                            .userModel.value.data?.bmi ??
                                        0,
                                    showLabel: false,
                                  )),
                              SizedBox(
                                height: 10.h,
                              ),
                              Bouncing(
                                duration: Duration(milliseconds: 100),
                                onPressed: () {
                                  bmiSliderController.setBodyData();
                                  bodyInfoSelectBottomSheet(
                                      isPopValue: false,
                                      index: 3,
                                      context: context,
                                      isBack: true);
                                },
                                child: Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.w),
                                      border: Border.all(
                                          width: 0.8.w,
                                          color: AppColor.orangeColor),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.w, vertical: 8.h),
                                    child: Text(
                                      "WEIGHT_EDIT".tr,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700,
                                        color: AppColor.orangeColor,
                                        letterSpacing: 0.4,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 13.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.cardGradiant1.withOpacity(0.06),
                              spreadRadius: 1.4,
                              blurRadius: 10,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 12.h,
                            horizontal: 8.w,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10.w, top: 5.h),
                                child: Text(
                                  "WEIGHT_RECORD".tr.toUpperCase(),
                                  style: TextStyle(
                                    color: AppColor.subTitleColor,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Container(
                                height: 16.h,
                              ),

                              Obx(
                                () => bmiSliderController
                                            .bodyInfoDataList.length ==
                                        0
                                    ? CustomVIew.noRecordLayout(
                                        title: "THERE_IS_NO_RECORD_OF_WORKOUT",
                                        isShadow: false)
                                    : ListView.separated(
                                        separatorBuilder: (context, index) {
                                          return Container(
                                            height: 0.8.h,
                                            color: AppColor.bodyLineColor,
                                          );
                                        },
                                        itemCount: bmiSliderController
                                            .bodyInfoDataList.length,
                                        shrinkWrap: true,
                                        reverse: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return SizedBox(
                                            height: 45.h,
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 6.w,
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Center(
                                                    child: Text(
                                                      bmiSliderController
                                                          .dateFormat
                                                          .format(
                                                        DateTime.parse(
                                                          bmiSliderController
                                                              .bodyInfoDataList[
                                                                  index]
                                                              .createdAt
                                                              .toString(),
                                                        ).toLocal(),
                                                      ),
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 15.sp,
                                                        color: AppColor
                                                            .subTitleColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 4,
                                                  child: Center(
                                                    child: Text(
                                                      bmiSliderController
                                                          .bodyInfoDataList[
                                                              index]
                                                          .weightInKg
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16.sp,
                                                        color: AppColor.blue,
                                                        letterSpacing: 0.3,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SvgPicture.asset(
                                                        bmiSliderController
                                                                .bodyInfoDataList[
                                                                    index]
                                                                .variationInWeight
                                                                .toString()
                                                                .contains('-')
                                                            ? IconAssets
                                                                .downArrowLineIcon
                                                            : IconAssets
                                                                .upArrowLineIcon,
                                                      ),
                                                      SizedBox(
                                                        width: 7.w,
                                                      ),
                                                      Text(
                                                        bmiSliderController
                                                            .bodyInfoDataList[
                                                                index]
                                                            .variationInWeight
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16.sp,
                                                          letterSpacing: 0.2,
                                                          color: bmiSliderController
                                                                  .bodyInfoDataList[
                                                                      index]
                                                                  .variationInWeight
                                                                  .toString()
                                                                  .contains('-')
                                                              ? AppColor.green
                                                              : AppColor
                                                                  .sliderIndicatorColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    DeleteRecordBottomSheet(
                                                        context,
                                                        index,
                                                        bmiSliderController
                                                                .bodyInfoDataList[
                                                                    index]
                                                                .id ??
                                                            '');
                                                  },
                                                  child: SizedBox(
                                                    height: 20.h,
                                                    width: 20.w,
                                                    child: Center(
                                                      child: Image.asset(
                                                        IconAssets.more,
                                                        height: 10.h,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                              ),
                              // FutureBuilder(
                              //   future: bodyInfoController.WeightApiCall(),
                              //   builder: (BuildContext context,
                              //       AsyncSnapshot<weightRecordModel> snapshot) {
                              //     print(
                              //         "snapshot.data?.data?.first==>>${snapshot.data?.data?.first.weight}");
                              //     return ListView.separated(
                              //       separatorBuilder: (context, i) {
                              //         return Container(
                              //           height: 0.8.h,
                              //           color: AppColor.bodyLineColor,
                              //         );
                              //       },
                              //       itemCount: snapshot.data?.data?.length ?? 0,
                              //       shrinkWrap: true,
                              //       physics: NeverScrollableScrollPhysics(),
                              //       itemBuilder: (context, index) {
                              //         return SizedBox(
                              //           height: 45.h,
                              //           child: Row(
                              //             children: [
                              //               SizedBox(
                              //                 width: 6.w,
                              //               ),
                              //               Expanded(
                              //                 flex: 2,
                              //                 child: Center(
                              //                   child: Text(
                              //                     "13",
                              //                     style: TextStyle(
                              //                       fontWeight: FontWeight.w500,
                              //                       fontSize: 13.sp,
                              //                       color: AppColor
                              //                           .subTitleColor,
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ),
                              //               Expanded(
                              //                 flex: 4,
                              //                 child: Center(
                              //                   child: Text(
                              //                     snapshot.data?.data?[index]
                              //                             .weight
                              //                             .toString() ??
                              //                         "",
                              //                     style: TextStyle(
                              //                       fontWeight: FontWeight.w600,
                              //                       fontSize: 14.sp,
                              //                       color: AppColor.blue,
                              //                       letterSpacing: 0.3,
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ),
                              //               Expanded(
                              //                 flex: 3,
                              //                 child: Row(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment.center,
                              //                   crossAxisAlignment:
                              //                       CrossAxisAlignment.center,
                              //                   children: [
                              //                     SvgPicture.asset(
                              //                       IconAssets.upArrowLineIcon,
                              //                     ),
                              //                     SizedBox(
                              //                       width: 7.w,
                              //                     ),
                              //                     Text(
                              //                       "10",
                              //                       style: TextStyle(
                              //                         fontWeight:
                              //                             FontWeight.w500,
                              //                         fontSize: 14.sp,
                              //                         letterSpacing: 0.2,
                              //                         color: AppColor
                              //                             .sliderIndicatorColor,
                              //                       ),
                              //                     ),
                              //                   ],
                              //                 ),
                              //               ),
                              //               InkWell(
                              //                 onTap: () {
                              //                   setState(() {
                              //                     snapshot.data?.data
                              //                         ?.removeAt(index);
                              //                   });
                              //
                              //                   // DeleteRecordBottomSheet(
                              //                   //   context,
                              //                   //   index,
                              //                   // );
                              //                 },
                              //                 child: SizedBox(
                              //                   height: 20.h,
                              //                   width: 20.w,
                              //                   child: Center(
                              //                     child: Image.asset(
                              //                       IconAssets.more,
                              //                       height: 10.h,
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //         );
                              //       },
                              //     );
                              //   },
                              // )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
