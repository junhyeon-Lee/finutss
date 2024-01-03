import 'package:carousel_slider/carousel_slider.dart';
import 'package:finutss/domain/controller/home_controller.dart';
import 'package:finutss/presentation/screens/introductory_screens/anytime_screen.dart';
import 'package:finutss/presentation/screens/introductory_screens/anywhere_screen.dart';
import 'package:finutss/presentation/screens/introductory_screens/fitness_screen.dart';
import 'package:finutss/presentation/screens/introductory_screens/step_by_step_screen.dart';
import 'package:finutss/presentation/screens/introductory_screens/with_people_screen.dart';
import 'package:finutss/presentation/screens/signup_screens/sign_in_screen/signin_screen.dart';
import 'package:finutss/presentation/widgets/common_widgets/list_progress_bar.dart';
import 'package:finutss/presentation/widgets/introduction_screens_widget/skip_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

// ignore: must_be_immutable
class IntroductoryScreen extends StatefulWidget {
  @override
  _IntroductoryScreenState createState() => _IntroductoryScreenState();
}

class _IntroductoryScreenState extends State<IntroductoryScreen> with TickerProviderStateMixin {
  HomeController homeController = Get.put(HomeController());
  int? myIndex;
  late AnimationController _animationController;

  double currentPage = 0;
  late Animation<double> animationTranslation;
  Animation<double>? animationTranslationBottom;
  CarouselController buttonCarouselController = CarouselController();

  bool isCenterImage = false;
  bool isPageChanged = false;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    )..addListener(() {
        setState(() {});
      });

    animationTranslation = Tween(begin: 0.0, end: -200.0).animate(_animationController);
    animationTranslationBottom = Tween(begin: 0.0, end: 600.0).animate(_animationController);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<HomeController>(builder: (homeController) {
      return SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Transform.translate(
                offset: Offset(0, animationTranslation.value),
                child: Column(
                  children: [
                    size20,
                    Padding(
                      padding: EdgeInsets.only(right: 20.0.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          skipText(),
                        ],
                      ),
                    ),
                    size20,
                    /* ---------------------------------- images ---------------------------------- */
                    Image.asset(
                      'assets/images/logo.png',
                      height: 45.h,
                    ),
                    size50,
                  ],
                ),
              ),
              Container(
                height: 540.h,
                child: CarouselSlider(
                  carouselController: buttonCarouselController,
                  options: CarouselOptions(
                      height: Get.height,
                      // aspectRatio: 8 / 16,
                      viewportFraction: 0.94,
                      enableInfiniteScroll: false,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        homeController.introductionSliderPage = index;
                        homeController.update();

                        setState(() {
                          myIndex = index;
                        });
                      },
                      onScrolled: (value) {}),
                  items: [
                    AnywhereScreen(),
                    AnytimeScreen(),
                    WithPeopleScreen(),
                    StepByStepScreen(),
                    FitnessScreen(
                      onPressed: () async {
                        setState(() {
                          isCenterImage = true;
                        });
                        _animationController.forward();
                        await Future.delayed(Duration(milliseconds: 300));

                        Get.off(() => SignInScreen(), transition: Transition.fadeIn);
                      },
                      isCenterImage: isCenterImage,
                      bottomAnimationTranslation: animationTranslationBottom,
                    )
                  ],
                ),
              ),
              size20,
              homeController.introductionSliderPage == 4
                  ? Container()
                  : listProgressBar(totalNumbers: 5, currentPage: homeController.introductionSliderPage + 1)
            ],
          ),
        ),
      );
    }));
  }
}
