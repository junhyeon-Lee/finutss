import 'package:finutss/new%20ui/modules/app_setting/controller/app_setting_controller.dart';
import 'package:finutss/new%20ui/modules/app_setting/widget/custom_setting_row.dart';
import 'package:finutss/new%20ui/modules/app_setting/widget/expanded_selection.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/widget/custom_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';

class FaqScreen extends StatelessWidget {
  FaqScreen({Key? key}) : super(key: key);

  final AppSettingController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.faqTempList = [];
      controller.faqList.value = [];
      controller.selectedMenuFaq.value = 0;
      Map<String, dynamic> body = {"language": controller.selectedLanguageCode.value.toString(),};
      controller.getFaqs(body: body);
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backGroundColor,
        body: Column(
          children: [
            CustomSettingRow(
              title: "FAQ".tr,
              horizontalPadding: 22.w,
              fontsize: 18.sp,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 14.h,
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 3 / 1.04,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      itemCount: controller.faqMenuList.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return Obx(() {
                          bool isSelected =
                              controller.selectedMenuFaq.value == index
                                  ? true
                                  : false;
                          return GestureDetector(
                            onTap: () {
                              controller.selectedMenuFaq.value = index;
                              controller.getParticularFaq(controller
                                  .faqMenuList[index].category
                                  .toString());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9.w),
                                color: isSelected
                                    ? AppColor.orangeColor
                                    : Colors.transparent,
                                border: Border.all(
                                  width: 1.2,
                                  color: isSelected
                                      ? AppColor.orangeColor
                                      : AppColor.cancelButtonBg,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  controller.faqMenuList[index].title
                                      .toString()
                                      .tr,
                                  style: TextStyle(
                                      color: isSelected
                                          ? AppColor.whiteColor
                                          : AppColor.cancelButtonColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.4),
                                ),
                              ),
                            ),
                          );
                        });
                      },
                    ),
                    Expanded(
                      child: Obx(() => controller.faqList.length == 0
                          ? CustomVIew.errorMessageShow("THERE_IS_NO_FAQ_FOUND")
                          : ListView.separated(
                              padding: EdgeInsets.symmetric(vertical: 15.h),
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, i) {
                                return Obx(() => GestureDetector(
                                      onTap: () {
                                        controller.selectedFaq.value = i;
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppColor.whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(9.w),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColor.cardGradiant1
                                                  .withOpacity(0.01),
                                              spreadRadius: 1,
                                              blurRadius: 8,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15.w, vertical: 14.h),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Text(controller.faqList[i].title ?? '',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14.sp,
                                                          letterSpacing: 0.1,
                                                          color: AppColor
                                                              .subTitleColor,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 4.4.h,
                                                      ),

                                                      ///이쪽에서 한국어만 번역
                                                      controller.faqList[i].category=="General"?
                                                      Text("GENERAL".tr,
                                                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 11.sp, color: controller.selectedFaq.value == i ? AppColor.blue : AppColor.orangeColor),):
                                                      controller.faqList[i].category=="Sensor"?
                                                      Text("SENSOR".tr,
                                                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 11.sp, color: controller.selectedFaq.value == i ? AppColor.blue : AppColor.orangeColor),):
                                                      controller.faqList[i].category=="Service"?
                                                      Text("SERVICE".tr,
                                                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 11.sp, color: controller.selectedFaq.value == i ? AppColor.blue : AppColor.orangeColor),):
                                                      controller.faqList[i].category=="Payment"?
                                                      Text("PAYMENT".tr,
                                                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 11.sp, color: controller.selectedFaq.value == i ? AppColor.blue : AppColor.orangeColor),):
                                                      Text("EXERCISER_ETC".tr,
                                                           style: TextStyle(fontWeight: FontWeight.w500, fontSize: 11.sp, color: controller.selectedFaq.value == i ? AppColor.blue : AppColor.orangeColor),)
                                                      ,
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 16.w,
                                                ),
                                                SvgPicture.asset(
                                                  IconAssets.downArrowLineIcon,
                                                  color: AppColor.iconColorBg,
                                                  height: 7.h,
                                                ),
                                              ],
                                            ),
                                            controller.selectedFaq.value == i
                                                ? ExpandedSection(
                                                    expand: true,
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          top: 10.h),
                                                      decoration: BoxDecoration(
                                                        color: AppColor
                                                            .historyCardBlue,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.w),
                                                      ),
                                                      padding:
                                                          EdgeInsets.all(10.w),
                                                      child: Html(data:
                                                        controller.faqList[i].content
                                                            ??
                                                            '',
                                                        // style: TextStyle(
                                                        //   fontWeight:
                                                        //       FontWeight.w400,
                                                        //   fontSize: 12.sp,
                                                        //   color: AppColor
                                                        //       .subTitleColor
                                                        //       .withOpacity(0.8),
                                                        //   height: 1.6,
                                                        // ),
                                                      ),
                                                    ),
                                                  )
                                                : SizedBox(),
                                          ],
                                        ),
                                      ),
                                    ));
                              },
                              separatorBuilder: (context, i) {
                                return SizedBox(
                                  height: 11.h,
                                );
                              },
                              itemCount: controller.faqList.value.length)),
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
}
