import 'package:finutss/new%20ui/modules/connection/controller/connection_controller.dart';
import 'package:finutss/new%20ui/modules/connection/presentation/body_info_select_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/connection/presentation/stride_test_screen.dart';
import 'package:finutss/new%20ui/modules/connection/widget/close_button.dart';
import 'package:finutss/new%20ui/modules/connection/widget/mobile_device_widget.dart';
import 'package:finutss/new%20ui/modules/record/controller/bmi_slider_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/presentation/presentation/animation/bouncing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> mobileDeviceConnectionBottomSheet(BuildContext context,
    {String? title, String? icon}) {
  final ConnectionController connectionController = Get.find();
  connectionController.isSelectedType.value = false;
  BmiSliderController bmiSliderController = Get.find();

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
      Constants.isSelectWearPosition.value = false;
      return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12),
          ),
        ),
        height: MediaQuery.of(context).size.height,
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
                padding: EdgeInsets.symmetric(horizontal: 5.w),
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
                child: Padding(
                  padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      HeaderWidget(
                        icon: icon,
                        title: "EXERCISER_RUNNING".tr,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    if (bmiSliderController.selectWeight !=
                                        '0') {
                                      Constants.positionModelList[1].isSelected
                                          .value = true;
                                    }
                                    return Obx(
                                      () => MobileDeviceWidget(
                                        onTap: () {
                                          if (index == 0) {
                                            Constants.positionModelList[index]
                                                .icChoose.value = true;
                                          } else if (index == 1) {
                                            bodyInfoSelectBottomSheet(
                                                index: 0,
                                                context: context,
                                                itemIndex: index);
                                          } else if (index == 2) {
                                            Navigator.of(context).push(
                                              PageRouteBuilder(
                                                opaque: false,
                                                pageBuilder:
                                                    (BuildContext context, _,
                                                            __) =>
                                                        StrideTestScreen(),
                                              ),
                                            );
                                          }
                                        },
                                        isSelected: Constants
                                            .positionModelList[index]
                                            .isSelected
                                            .value,
                                        checkIcon: Constants
                                                .positionModelList[index]
                                                .isSelected
                                                .value
                                            ? IconAssets.checkBoxSelect
                                            : IconAssets.checkBoxUnSelect,
                                        buttonTitle: Constants
                                            .positionModelList[index]
                                            .buttonName,
                                        position: Constants
                                            .positionModelList[index].position,
                                        positionDescription: Constants
                                            .positionModelList[index]
                                            .positionDescription,
                                        completeDes: Constants
                                            .positionModelList[index]
                                            .completeDes  ,
                                        completeButtonTitle: Constants
                                            .positionModelList[index]
                                            .completeButtonTitle,
                                        index: index,
                                        isChoose: Constants
                                            .positionModelList[index]
                                            .icChoose
                                            .value,
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, i) {
                                    return SizedBox(
                                      height: 14.h,
                                    );
                                  },
                                  itemCount:
                                      Constants.positionModelList.length),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

class HeaderWidget extends StatelessWidget {
  final String? icon;
  final String? title;

  HeaderWidget({this.icon, this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.0.h, bottom: 12.h),
      child: Column(
        children: [
          Text(
            "CONNECTION".tr,
            style: TextStyle(
              color: AppColor.blueTextColor,
              fontSize: 19.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 36.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  "CONNECTION_STATUS".tr,
                  style: TextStyle(
                    color: AppColor.blueTextColor[100],
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Bouncing(
                duration: Duration(milliseconds: 100),
                onPressed: () {
                  Navigation.pop();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 17.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.lightPink,
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        icon ?? '',
                        scale: 3,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        title?.toLowerCase() ?? '',
                        style: TextStyle(
                          color: AppColor.darkPink,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
