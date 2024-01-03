import 'package:finutss/new%20ui/modules/user_guide/controller/user_guide_controller.dart';
import 'package:finutss/new%20ui/modules/user_guide/model/sensor_model.dart';
import 'package:finutss/new%20ui/modules/user_guide/widget/guide_sensor_appbar.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/widget/custom_slider_button.dart';
import 'package:finutss/new%20ui/widget/slider_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class BodyInfoGuideScreen extends StatelessWidget {
  BodyInfoGuideScreen({Key? key}) : super(key: key);
  final UserGuideController sliderController = Get.find();
  final PageController _pageController = PageController();
  final PageController _pageControllerText = PageController();
  static const _kDuration = Duration(milliseconds: 350);
  static const _kCurve = Curves.ease;

  @override
  Widget build(BuildContext context) {
    sliderController.selectedIndexBodyInfo.value = 0;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColor.bodyInfoStatusBar,
      ),
      child: Scaffold(
        body: Container(
          color: AppColor.darkPink.withOpacity(0.06),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: Obx(
                    () {
                      sliderController.selectedIndexBodyInfo.value;
                      return SafeArea(
                        child: Column(
                          children: [
                            GuideSensorAppBar(iconColor: AppColor.darkPink, title: 'TUTORIAL_3_TITLE_BODY_INFO',),
                            imagePageView(),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 31.w),
                  decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.elliptical(
                        MediaQuery.of(context).size.width,
                        100.0,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 38.h,
                      ),
                      SliderIndicator(
                        listLength: sliderController.bodyInfoGuideList.length,
                        selectedIndex: sliderController.selectedIndexBodyInfo,
                        iconSize: 7.5.w,
                        height: 19.w,
                      ),
                      SizedBox(
                        height: 60.h,
                      ),
                      textPageView(),
                      SizedBox(
                        height: 5.h,
                      ),
                      Obx(
                        () {
                          return sliderController.selectedIndexBodyInfo.value ==
                                  0
                              ? CustomSliderButton(
                                  width: 144.w,
                                  height: 49.w,
                                  title: 'NEXT'.tr,
                                  onTap: () {
                                    openPage(sliderController
                                            .selectedIndexBodyInfo.value +
                                        1);
                                  },
                                  isCancelButton: false,
                                )
                              : Row(
                                  children: [
                                    CustomSliderButton(
                                      height: 49.w,
                                      title: 'NEXT'.tr,
                                      onTap: () {
                                        openPage(sliderController
                                                .selectedIndexBodyInfo.value -
                                            1);
                                      },
                                      isCancelButton: true,
                                      width: 54.w,
                                    ),
                                    SizedBox(
                                      width: 26.w,
                                    ),
                                    Expanded(
                                      child: Obx(() {
                                        int listLength = sliderController
                                                .bodyInfoGuideList.length -
                                            1;
                                        return CustomSliderButton(
                                          height: 49.w,
                                          title: listLength ==
                                                  sliderController
                                                      .selectedIndexBodyInfo
                                                      .value
                                              ? "LETS_GO".tr.toUpperCase()
                                              : 'NEXT'.tr,
                                          onTap: () {
                                            if (listLength !=
                                                sliderController
                                                    .selectedIndexBodyInfo
                                                    .value) {
                                              openPage(sliderController
                                                      .selectedIndexBodyInfo
                                                      .value +
                                                  1);
                                            } else {
                                              Navigation.replaceAll(
                                                  Routes.dashboardScreen);
                                            }
                                          },
                                          isCancelButton: false,
                                        );
                                      }),
                                    ),
                                  ],
                                );
                        },
                      ),
                      SizedBox(
                        height: 38.h,
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


  Widget imagePageView() {
    return Expanded(
      child: PageView.builder(
        //physics: NeverScrollableScrollPhysics(),
        itemCount: sliderController.bodyInfoGuideList.length,
        controller: _pageController,
        onPageChanged: (int page) {
          sliderController.selectedIndexBodyInfo.value = page;
          openPage(page);
        },
        itemBuilder: (context, i) {
          SensorSliderModel model = sliderController.bodyInfoGuideList[i];

          double leftSize = 0;
          double bottomSize = 0;
          double topSize = 0;
          double right = 0;
          if (i == 0) {
            leftSize = 0;
            right = 20.w;
            bottomSize = 0;
            topSize = 20.h;
          } else if (i == 1) {
            right = 20.w;
            bottomSize = 0;
            topSize = 5.h;
          } else if (i == 2) {
            leftSize = 10.w;
            right = 10.w;
            bottomSize = 40.h;
            topSize = 20.h;
          }

          return Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 0,
                bottom: bottomSize,
                right: right,
                child: Image.asset(model.image),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget textPageView() {
    return Expanded(
      child: PageView.builder(
        // physics: NeverScrollableScrollPhysics(),
        itemCount: sliderController.bodyInfoGuideList.length,
        controller: _pageControllerText,
        onPageChanged: (int page) {
          sliderController.selectedIndexBodyInfo.value = page;
          openPage(page);
        },
        itemBuilder: (context, i) {
          SensorSliderModel model = sliderController.bodyInfoGuideList[i];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                model.title.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 22.sp,
                ),
              ),
              SizedBox(
                height: 11.h,
              ),
              Flexible(
                child: textDes(i, model.des),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget textDes(int index, String text) {
    return Text(
      text.tr,
      maxLines: 4,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: TextStyle(
        height: 1.9,
        fontFamily: "Montserrat",
        color: AppColor.subTitleColor.withOpacity(0.7),
        fontWeight: FontWeight.w400,
        fontSize: 13.sp,
      ),
    );
  }

  openPage(int page) {
    _pageController.animateToPage(
      page,
      duration: _kDuration,
      curve: _kCurve,
    );
    _pageControllerText.animateToPage(
      page,
      duration: _kDuration,
      curve: _kCurve,
    );
  }
}
