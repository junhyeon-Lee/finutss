import 'package:finutss/new%20ui/modules/app_setting/controller/black_list_controller.dart';
import 'package:finutss/new%20ui/modules/app_setting/widget/custom_setting_row.dart';
import 'package:finutss/new%20ui/modules/app_setting/widget/unblock_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/user_profile/presentation/user_profile_screen.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/widget/custom_circle_imageview.dart';
import 'package:finutss/new%20ui/widget/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BlackListScreen extends StatefulWidget {
  BlackListScreen({Key? key}) : super(key: key);

  @override
  State<BlackListScreen> createState() => _BlackListScreenState();
}

class _BlackListScreenState extends State<BlackListScreen> {
  final BlackListController controller = Get.find();

  final DateFormat dateFormat = DateFormat("yyyy.MM.dd");

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.isFirstTimeLoading.value=true;
      controller.previousDate='';
      controller.limit.value=10;
      controller.offset.value=0;
      controller.blackList.value=[];
      controller.tempBlackList=[];
      controller.getBlackList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomSettingRow(
              title: 'BLACKLIST'.tr.toUpperCase(),
              fontsize: 18.sp,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.h),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.circular(
                      8.w,
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(child: Obx(
                            () {
                          return controller.isFirstTimeLoading.value ? CustomVIew.listViewShimmer() : controller.blackListTotalLength.value == 0
                              ? noRecordLayout()
                              : Obx(() => ListView.builder(
                            shrinkWrap: true,
                            controller: controller.scrollController,
                            itemCount: controller.blackList.length,
                            itemBuilder: (context, index) {
                              if(index==0){
                                controller.previousDate='';
                              }
                              bool isShow = false;
                              String currentDate = dateFormat.format(DateTime.parse(controller.blackList[index].updatedAt.toString()).toUtc());
                              if (controller.previousDate != currentDate) {
                                controller.previousDate = currentDate;
                                isShow = true;
                              }
                              return Obx(() => Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 5.h),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    controller.blackList[index].showDate!=null
                                        ? Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 8.h,
                                        horizontal: 5.w,
                                      ),
                                      child: Text(
                                        controller.blackList[index].showDate ?? '',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: AppColor.blueTextColor
                                              .withOpacity(0.5),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                                        : Container(),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Container(
                                      padding:  EdgeInsets.symmetric(vertical: 11.h),
                                      decoration: BoxDecoration(
                                          color: AppColor.couponTextFieldBg,
                                          borderRadius:
                                          BorderRadius.circular(8.w)),
                                      child: InkWell(
                                        onTap: () {
                                          Get.to(
                                            UserProfileScreen(
                                              userId: controller.blackList[index].blocked?.id ?? '',
                                            ),
                                            transition: Routes.defaultTransition
                                          );
                                        },
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 14.w,
                                            ),
                                            CustomCircleImageview(
                                              width: 55.w,
                                              imagePath: controller
                                                  .blackList
                                                  .value[index]
                                                  .blocked
                                                  ?.profilePhoto ??
                                                  '',
                                            ),
                                            SizedBox(
                                              width: 14.w,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    controller
                                                        .blackList[index]
                                                        .blocked
                                                        ?.username ??
                                                        '',
                                                    style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      fontSize: 12.sp,
                                                      color: AppColor
                                                          .blueTextColor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 8.h,
                                                  ),
                                                  Text(
                                                    controller
                                                        .blackList[index]
                                                        .blocked
                                                        ?.username ??
                                                        '',
                                                    style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: 11.sp,
                                                      color: AppColor
                                                          .blueTextColor
                                                          .withOpacity(0.8),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                UnBlockBottomSheet(
                                                  context: context,
                                                  imagePath: controller
                                                      .blackList[index]
                                                      .blocked
                                                      ?.profilePhoto ??
                                                      '',
                                                  Name: controller
                                                      .blackList[index]
                                                      .blocked
                                                      ?.username ??
                                                      '',
                                                  Bio: controller
                                                      .blackList[index]
                                                      .blocked
                                                      ?.username ??
                                                      '',
                                                  userId: controller.blackList[index].blocked?.id,
                                                  index: index,
                                                );
                                              },
                                              child: Container(
                                                width : 80.w,
                                                height: 55.w,
                                                padding :  EdgeInsets.only(right: 17.w),
                                                child: Align(
                                                  alignment :  Alignment.centerRight,
                                                  child: SvgPicture.asset(
                                                    IconAssets.blackListIcon,
                                                    width: 17.w,
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
                              ));
                            },
                          ));
                        },
                      )),

                      Obx(() => controller.isLoadRunning.value && !controller.isFirstTimeLoading.value
                          ? Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 10.h),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                          : SizedBox())
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

  Widget noRecordLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          IconAssets.noRecordIcon,
          height: 72.h,
        ),
        SizedBox(
          height: 16.h,
        ),
        Text(
          "THERE_IS_NO_BLACKLIST_USER".tr,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
            color: AppColor.subTitleColor.withOpacity(
              0.8,
            ),
          ),
        )
      ],
    );
  }
}
