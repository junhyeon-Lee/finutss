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

class SensorSliderScreen extends StatelessWidget {
  SensorSliderScreen({Key? key}) : super(key: key);

  final UserGuideController sliderController = Get.find();
  final PageController _pageController = PageController();
  final PageController _pageControllerText = PageController();
  static const _kDuration = Duration(milliseconds: 350);
  static const _kCurve = Curves.ease;

  @override
  Widget build(BuildContext context) {
    sliderController.selectedIndex.value = 0;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColor.sliderStatusBarColor,
      ),
      child: Scaffold(
        body: Container(
          color: AppColor.pinkSlider.withOpacity(0.08),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: Obx(() {
                    sliderController.selectedIndex.value;
                    return SafeArea(
                      child: Column(
                        children: [
                          GuideSensorAppBar(iconColor: AppColor.pink, title: 'TUTORIAL_1_TITLE_SENSOR',),
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
                        listLength: sliderController.sliderList.length,
                        selectedIndex: sliderController.selectedIndex,
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
                        return sliderController.selectedIndex.value == 0
                            ? CustomSliderButton(
                                width: 144.w,
                                height: 49.w,
                                title: 'NEXT'.tr,
                                onTap: () {
                                  openPage(
                                      sliderController.selectedIndex.value + 1);
                                },
                                isCancelButton: false,
                              )
                            : Row(
                                children: [
                                  CustomSliderButton(
                                    height: 49.w,
                                    title: 'NEXT'.tr,
                                    onTap: () {
                                      openPage(
                                          sliderController.selectedIndex.value -
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
                                      int listLength =
                                          sliderController.sliderList.length -
                                              1;
                                      return CustomSliderButton(
                                        height: 49.w,
                                        title: listLength ==
                                                sliderController
                                                    .selectedIndex.value
                                            ? 'PROCEED'.tr
                                            : 'NEXT'.tr,
                                        onTap: () {
                                          if (listLength !=
                                              sliderController
                                                  .selectedIndex.value) {
                                            openPage(sliderController
                                                    .selectedIndex.value +
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
        itemCount: sliderController.sliderList.length,
        controller: _pageController,
        onPageChanged: (int page) {
          sliderController.selectedIndex.value = page;
          openPage(page);
        },
        itemBuilder: (context, i) {
          SensorSliderModel model = sliderController.sliderList[i];

          double leftSize = 0;
          double bottomSize = 0;
          double topSize = 0;
          if (i == 0) {
            leftSize = 15.w;
          } else if (i == 1 || i == 2) {
            leftSize = 56.w;
            bottomSize = 0;
            topSize = 5.h;
          } else if (i == 3) {
            leftSize = 42.w;
            bottomSize = 0;
            topSize = 50.h;
          } else if (i == 5 || i == 7) {
            leftSize = 82.w;
            bottomSize = 0.h;
            topSize = 0.h;
          } else if (i == 6) {
            leftSize = 18.w;
            bottomSize = 0;
            topSize = 0;
          } else if (i == 8) {
            leftSize = 76.w;
            bottomSize = 11.h;
            topSize = 0;
          }

          return Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 0,
                bottom: bottomSize,
                left: leftSize,
                right: leftSize,
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
        itemCount: sliderController.sliderList.length,
        controller: _pageControllerText,
        onPageChanged: (int page) {
          sliderController.selectedIndex.value = page;
          openPage(page);
        },
        itemBuilder: (context, i) {
          SensorSliderModel model = sliderController.sliderList[i];
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
  /*  if (index == 7) {
      return RichText(
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(children: [
          TextSpan(
            text:
                "Search for a sensors. A list of sensors you have \nis coming out. If the sensor is not listed, make \nsure the Bluetooth device is paired and press \nthe ",
            style: textStyle(),
          ),
          TextSpan(
              text: "Rescan",
              style: TextStyle(
                height: 1.9,
                color: AppColor.orangeColor.withOpacity(0.7),
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
              )),
          TextSpan(
            text: " button.",
            style: textStyle(),
          ),
        ]),
      );
    } else if (index == 8) {
      return RichText(
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(text: "Pressing the ", style: textStyle(), children: [
          TextSpan(
              text: "Connect",
              style: TextStyle(
                height: 1.9,
                color: AppColor.orangeColor.withOpacity(0.7),
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
              )),
          TextSpan(
            text:
                " button connects \nthe device and is ready to start workout.\nShall we connect it now?",
            style: textStyle(),
          ),
        ]),
      );
    } else {*/
      return Text(
        text.tr,
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: textStyle(),
      );
   // }
  }

  TextStyle textStyle() {
    return TextStyle(
      height: 1.9,
      fontFamily: "Montserrat",
      color: AppColor.subTitleColor.withOpacity(0.7),
      fontWeight: FontWeight.w400,
      fontSize: 13.sp,
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
