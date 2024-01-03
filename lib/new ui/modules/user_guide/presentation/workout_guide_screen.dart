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

class WorkoutGuideScreen extends StatelessWidget {
  WorkoutGuideScreen({Key? key}) : super(key: key);

  final UserGuideController sliderController = Get.find();
  final PageController _pageController = PageController();
  final PageController _pageControllerText = PageController();
  static const _kDuration = Duration(milliseconds: 350);
  static const _kCurve = Curves.ease;

  @override
  Widget build(BuildContext context) {
    sliderController.selectedIndexWorkoutGuide.value = 0;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColor.workoutStatusBar,
      ),
      child: Scaffold(
        body: Container(
          color: AppColor.blue.withOpacity(0.08),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: Obx(() {
                    sliderController.selectedIndexWorkoutGuide.value;
                    return SafeArea(
                      child: Column(
                        children: [
                          GuideSensorAppBar(iconColor: AppColor.blue, title: 'TUTORIAL_2_TITLE_WORKOUT',),
                          imagePageView(),
                          SizedBox(
                            height: 5.h,
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 31.w),
                  decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.vertical(
                        top: Radius.elliptical(
                            MediaQuery.of(context).size.width, 100.0)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 38.h,
                      ),
                      SliderIndicator(
                        listLength: sliderController.workoutGuideList.length,
                        selectedIndex:
                            sliderController.selectedIndexWorkoutGuide,
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
                      Obx(() {
                        return sliderController
                                    .selectedIndexWorkoutGuide.value ==
                                0
                            ? CustomSliderButton(
                                width: 144.w,
                                height: 49.w,
                                title: 'NEXT'.tr,
                                onTap: () {
                                  openPage(sliderController
                                          .selectedIndexWorkoutGuide.value +
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
                                              .selectedIndexWorkoutGuide.value -
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
                                              .workoutGuideList.length -
                                          1;
                                      return CustomSliderButton(
                                        height: 49.w,
                                        title: listLength ==
                                                sliderController
                                                    .selectedIndexWorkoutGuide
                                                    .value
                                            ? "LETS_GO".tr.toUpperCase()
                                            : 'NEXT'.tr,
                                        onTap: () {
                                          if (listLength !=
                                              sliderController
                                                  .selectedIndexWorkoutGuide
                                                  .value) {
                                            openPage(sliderController
                                                    .selectedIndexWorkoutGuide
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
                      }),
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
        // physics: NeverScrollableScrollPhysics(),
        itemCount: sliderController.workoutGuideList.length,
        controller: _pageController,
        onPageChanged: (int page) {
          sliderController.selectedIndexWorkoutGuide.value = page;
          openPage(page);
        },
        itemBuilder: (context, i) {
          SensorSliderModel model = sliderController.workoutGuideList[i];

          double leftSize = 0;
          double bottomSize = 0;
          double topSize = 0;
          if (i == 0) {
            leftSize = 0;
            bottomSize = 26.h;
            topSize = 26.h;
          } else if (i == 1) {
            leftSize = 0;
            bottomSize = 24.h;
            topSize = 0;
          } else if (i == 2) {
            leftSize = 74.w;
            bottomSize = 20.h;
            topSize = 20.h;
          }

          return Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 0,
                bottom: bottomSize,
                left: leftSize,
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
        itemCount: sliderController.workoutGuideList.length,
        controller: _pageControllerText,
        onPageChanged: (int page) {
          sliderController.selectedIndexWorkoutGuide.value = page;
          openPage(page);
        },
        itemBuilder: (context, i) {
          SensorSliderModel model = sliderController.workoutGuideList[i];
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
                child: textDes(
                  i,
                  model.des.tr,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget textDes(int index, String text) {
    return Text(
      text,
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
