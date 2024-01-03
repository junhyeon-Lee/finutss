import 'package:carousel_slider/carousel_slider.dart';
import 'package:finutss/constants.dart';
import 'package:finutss/data/data_service/lib_helper.dart';
import 'package:finutss/data/models/ad.dart';
import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/domain/controller/dummy_data_controller.dart';
import 'package:finutss/domain/controller/home_controller.dart';
import 'package:finutss/domain/controller/map_controller.dart';
import 'package:finutss/domain/controller/workout_in_controller.dart';
import 'package:finutss/domain/controller/workout_record_controller.dart';
import 'package:finutss/presentation/screens/setting_page/user_guide_list_screen.dart';
import 'package:finutss/presentation/screens/track_screens/live_user_screen.dart';
import 'package:finutss/presentation/screens/track_screens/track_distance_screen.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_button.dart';
import 'package:finutss/presentation/widgets/common_widgets/list_progress_bar.dart';
import 'package:finutss/presentation/widgets/daily_track_container.dart';
import 'package:finutss/presentation/widgets/home_page_widgets/activity_progress_percent_card.dart';
import 'package:finutss/presentation/widgets/home_page_widgets/promo_cards.dart';
import 'package:finutss/presentation/widgets/home_page_widgets/user_card.dart';
import 'package:finutss/presentation/widgets/home_page_widgets/user_guide_card.dart';
import 'package:finutss/presentation/widgets/user_notic_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:finutss/domain/bloc/main_bloc/main_bloc.dart';
import 'package:finutss/domain/bloc/main_bloc/main_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  final ScrollController scrollController;
  HomeScreen({required this.scrollController});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DummyDataController dummyDataController = Get.put(DummyDataController());
  final WorkoutRecordController workoutRecordController = WorkoutRecordController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      return GetBuilder<HomeController>(builder: (homeController) {
        double kcal = 0.0;
        double? bmr = 0.0;
        if (authController.user != null) {
          ///TODO usersDetails
          /*
          bmr = authController.user?.usersDetails.bmr != null
              ? authController.user!.usersDetails.bmr.toDouble()
              : 0.0.toDouble();

           */

          kcal = workoutRecordController.jsonWorkDailyTotalObject != null
              ? workoutRecordController.jsonWorkDailyTotalObject["kcal"].toDouble()
              : 0.0.toDouble();
        }

        return Container(
          color: colorBackgroundSilver,
          child: Column(
            children: [
              SizedBox(height: 14.h),

              /* -------------------------------------------------------------------------- */
              /*                               promo listView                               */
              /* -------------------------------------------------------------------------- */

              Container(
                height: 160,
                child: CarouselSlider(
                    options: CarouselOptions(
                      height: 160.0,
                      enableInfiniteScroll: true,
                      // autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      onPageChanged: (index, reason) {
                        homeController.promoSliderPage = index;
                        homeController.update();
                      },
                    ),
                    items: [
                      for (Ad ads in homeController.jsonAdsList)
                        promoCard(
                          imageUrl: ads.contentSrc,
                          url: ads.url,
                        )
                    ]),
              ),
              listProgressBar(currentPage: homeController.promoSliderPage + 1, totalNumbers: 5),

              /* -------------------------------------------------------------------------- */
              /*                        activity and user guide cards                       */
              /* -------------------------------------------------------------------------- */
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 14.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    activityProgressCard(
                        context: context,
                        isCompleted: homeController.isComplete == true ? true : false,
                        kcal: kcal,
                        bmr: bmr,
                        onPressedFunction: () {
                          BlocProvider.of<MainBloc>(context).add(MainEventCheckTapButtonNavigationBarByIndex(index: 1));
                          homeController.bottomNavIndex = 1;
                          // homeController.isComplete = !homeController.isComplete;
                          homeController.update();
                        }),
                    userGuideCard(
                        context: context,
                        OnTap: () {
                          Get.to(() => UserGuideListScreen());
                        }),
                  ],
                ),
              ),
              /* -------------------------------------------------------------------------- */
              /*                            daily track container                           */
              /* -------------------------------------------------------------------------- */

              GetBuilder<MapController>(builder: (mapController) {
                return dailyTrackContainer(
                  track: mapController.jsonTrack,
                  title: "DAILY_TRACK".tr,
                  context: context,
                  onViewButtonPressed: () async {
                    var guest = await LocalDB.getInt("userAsGuest");
                    guest == null ? Get.dialog(UserNoticeDialog()) : Get.to(() => TrackDistanceScreen());
                  },
                  onInfoCardPressed: () {
                    // Get.to(PrecautionsPage());
                    // Get.dialog(PrecautionsDialog(),
                    //     barrierDismissible: false);
                  },
                );
              }),
              size15,
              /* -------------------------------------------------------------------------- */
              /*                           users in workout cards                           */
              /* -------------------------------------------------------------------------- */
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'USER_IN_WORKOUT'.tr,
                      style: TextStyle(color: Color(0xff303443), fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    customButton(
                        text: 'MORE'.tr,
                        textColor: Colors.white,
                        color: Colors.black,
                        height: 20,
                        width: 60,
                        onTapFunction: () async {
                          var guest = await LocalDB.getInt("userAsGuest");
                          guest == null
                              ? Get.dialog(UserNoticeDialog())
                              : showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return SafeArea(
                                        child: Padding(
                                      padding: EdgeInsets.only(top: 40.0.h),
                                      child: LiveUserScreen(
                                        isMapPage: false,
                                      ),
                                    ));
                                  });
                        },
                        textSize: 10,
                        fontWeight: FontWeight.bold)
                  ],
                ),
              ),
              size15,
              GetBuilder<WorkoutInController>(builder: (controller) {
                return Container(
                  height: 250,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: GridView.builder(
                    itemCount: controller.docs.length > 6 ? 6 : controller.docs.length, //item 개수
                    physics: new NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
                      childAspectRatio: 1 / 1, //item 의 가로 1, 세로 2 의 비율
                      mainAxisSpacing: 20, //수평 Padding
                      crossAxisSpacing: 20, //수직 Padding
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      //item 의 반목문 항목 형성
                      return authController.user?.userId != controller.docs[index]["writer"]["id"]
                          ? userCard(
                              context: context,
                              userInfo: controller.docs[index]["writer"],
                            )
                          : SizedBox();
                    },
                  ),
                );
              }),
              size30
            ],
          ),
        );
      });
    });
  }
}
