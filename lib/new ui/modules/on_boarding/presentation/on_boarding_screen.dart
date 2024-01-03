import 'package:finutss/helper/shared_preference.dart';
import 'package:finutss/new%20ui/modules/user_guide/controller/user_guide_controller.dart';
import 'package:finutss/new%20ui/modules/user_guide/model/sensor_model.dart';
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

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);
  final UserGuideController controller = Get.find();
  final PageController _pageController = PageController();
  final PageController _pageControllerText = PageController();
  static const _kDuration = Duration(milliseconds: 350);
  static const _kCurve = Curves.ease;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColor.onBoardingBG,
      ),
      child: Material(
        child: SafeArea(
          child: Container(
            color: AppColor.onBoardingBG,
            child: Column(
              children: [
                SizedBox(
                  height: 18.h,
                ),
                Expanded(
                  child: Container(
                    child: Obx(
                      () {
                        controller.selectedOnBoardingIndex.value;
                        return Column(
                          children: [
                            skipButton(),
                            SizedBox(
                              height: 28.h,
                            ),
                            imagePageView(),
                            SizedBox(
                              height: 5.h,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 31.w,
                    ),
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
                          listLength: controller.onBoardingList.length,
                          selectedIndex: controller.selectedOnBoardingIndex,
                          iconSize: 7.5.w,
                          height: 19.w,
                        ),
                        SizedBox(
                          height: 36.h,
                        ),
                        textPageView(),
                        SizedBox(
                          height: 5.h,
                        ),
                        Obx(() {
                          return controller.selectedOnBoardingIndex.value == 0
                              ? CustomSliderButton(
                                  width: 144.w,
                                  height: 49.w,
                                  title: 'NEXT'.tr,
                                  onTap: () {
                                    openPage(controller
                                            .selectedOnBoardingIndex.value +
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
                                        openPage(controller
                                                .selectedOnBoardingIndex.value -
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
                                            controller.onBoardingList.length -
                                                1;
                                        return CustomSliderButton(
                                          height: 49.w,
                                          title: listLength ==
                                                  controller
                                                      .selectedOnBoardingIndex
                                                      .value
                                              ? "START_NOW".tr.toUpperCase()
                                              : 'NEXT'.tr,
                                          onTap: () async {
                                            if (listLength !=
                                                controller
                                                    .selectedOnBoardingIndex
                                                    .value) {
                                              openPage(controller
                                                      .selectedOnBoardingIndex
                                                      .value +
                                                  1);
                                            } else {
                                              await SharedPrefs.setOnBoarding(true);
                                              Navigation.replaceAll(
                                                  Routes.signIn);
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
                          height: 36.h,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget imagePageView() {
    return Expanded(
      child: PageView.builder(
        itemCount: controller.onBoardingList.length,
        controller: _pageController,
        onPageChanged: (int page) {
          controller.selectedOnBoardingIndex.value = page;
          openPage(page);
        },
        itemBuilder: (context, i) {
          SensorSliderModel model = controller.onBoardingList[i];

          return Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 8.h,
                bottom: 18.h,
                left: 50.w,
                right: 50.w,
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
        itemCount: controller.onBoardingList.length,
        controller: _pageControllerText,
        onPageChanged: (int page) {
          controller.selectedOnBoardingIndex.value = page;
          openPage(page);
        },
        itemBuilder: (context, i) {
          SensorSliderModel model = controller.onBoardingList[i];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                model.title.tr.toUpperCase(),
                style: TextStyle(
                  color: AppColor.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 21.sp,
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
        height: 1.8,
        fontFamily: "Montserrat",
        color: AppColor.subTitleColor.withOpacity(0.7),
        fontWeight: FontWeight.w400,
        fontSize: 14.sp,
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

  Widget skipButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () async {
            await SharedPrefs.setOnBoarding(true);
            Navigation.replaceAll(Routes.signIn);
          },
          child: Container(
            height: 26.h,
            margin: EdgeInsets.only(right: 14.w),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColor.purple.withOpacity(0.1),
            ),
            child: Center(
              child: Text(
                "SKIP".tr,
                style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColor.purple),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
