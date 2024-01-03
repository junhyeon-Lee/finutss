import 'package:finutss/new%20ui/modules/user_guide/model/sensor_model.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/app_string.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/widget/custom_slider_button.dart';
import 'package:finutss/new%20ui/widget/slider_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreenNew extends StatelessWidget {
  SplashScreenNew({Key? key}) : super(key: key);

  RxInt selectedIndex = 0.obs;
  List<SensorSliderModel> sliderLIst = [
    SensorSliderModel('', AppString.createYourOwnPath, AppString.loremIpsum),
    SensorSliderModel('', AppString.createYourOwnPath, AppString.loremIpsum),
    SensorSliderModel('', AppString.createYourOwnPath, AppString.loremIpsum),
  ];
  final PageController _pageControllerText = PageController();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColor.green[100],
      ),
      child: Material(
        child: Container(
          color: AppColor.green[100],
          child: Column(
            children: [
              SizedBox(
                height: 12.h,
              ),
              Expanded(
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 10.h, right: 10.h, top: 13.h),
                              child: Image.asset(
                                ImageAssets.splashImage,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              child: SafeArea(
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        margin: EdgeInsets.only(right: 14.w),
                                        height: 27.h,
                                        width: 56.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color:
                                              AppColor.green.withOpacity(0.1),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "SKIP".tr,
                                            style: TextStyle(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w600,
                                                color: AppColor.green),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 26),
                              decoration: BoxDecoration(
                                color: AppColor.whiteColor,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.elliptical(
                                        MediaQuery.of(context).size.width,
                                        100.0)),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 28.h,
                                  ),
                                  SliderIndicator(
                                    listLength: sliderLIst.length,
                                    selectedIndex: selectedIndex,
                                    iconSize: 10.w,
                                    height: 20.w,
                                  ),
                                  SizedBox(
                                    height: 41.h,
                                  ),
                                  textSlider(),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    child: CustomSliderButton(
                                      height: 42.h,
                                      title: "SIGN_UP".tr.toUpperCase(),
                                      onTap: () {
                                        Navigation.pushNamed(Routes.signUp);
                                      },
                                      isCancelButton: false,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50.h,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigation.pushNamed(Routes.signIn);
                                    },
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                          text: 'SIGN_IN_ALREADY_HAVE_ACCOUNT'.tr,
                                          style: TextStyle(
                                            color: AppColor.alreadyTextColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13.sp,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: "Sign In",
                                                style: TextStyle(
                                                  color: AppColor.orangeColor,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 13.sp,
                                                )),
                                          ]),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 26.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget textSlider() {
    return Expanded(
      child: PageView.builder(
        itemCount: sliderLIst.length,
        controller: _pageControllerText,
        onPageChanged: (int page) {
          selectedIndex.value = page;
        },
        itemBuilder: (context, i) {
          SensorSliderModel model = sliderLIst[i];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                model.title.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 1.9,
                  color: AppColor.subTitleColor,
                  fontFamily: "MontserratItalic",
                  fontWeight: FontWeight.w800,
                  fontSize: 17.sp,
                ),
              ),
              SizedBox(
                height: 13.h,
              ),
              Text(
                model.des,
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 1.9,
                  color: AppColor.subTitleColor.withOpacity(0.5),
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
