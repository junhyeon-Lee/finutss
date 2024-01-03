import 'package:finutss/constants.dart';
import 'package:finutss/domain/controller/auth_controller.dart';
import 'package:finutss/domain/controller/dummy_data_controller.dart';
import 'package:finutss/domain/controller/hot_people_controller.dart';
import 'package:finutss/domain/controller/recommand_controller.dart';
import 'package:finutss/domain/controller/social_controller.dart';
import 'package:finutss/domain/controller/workout_in_controller.dart';
import 'package:finutss/presentation/screens/social_pages/hot_people_screen.dart';
import 'package:finutss/presentation/screens/social_pages/recommended_screen.dart';
import 'package:finutss/presentation/screens/track_screens/live_user_screen.dart';
import 'package:finutss/presentation/widgets/common_widgets/custom_text.dart';
import 'package:finutss/presentation/widgets/home_page_widgets/user_card.dart';
import 'package:finutss/presentation/widgets/social_page_widgets/profile_information_card.dart';
import 'package:finutss/presentation/widgets/social_page_widgets/recommendation_card.dart';
import 'package:finutss/presentation/widgets/social_page_widgets/social_page_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SocialScreen extends StatelessWidget {
  final DummyDataController dummyDataController =
      Get.put(DummyDataController());

  final ScrollController scrollController;

  SocialScreen({required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      return GetBuilder<SocialController>(
          init: SocialController(),
          builder: (socialController) {
            return Container(
                color: colorBackgroundSilver,
                // height: Get.height * 1.211,
                // width: Get.width,
                child: Column(
                  children: [
                    /* ------------------------ profile information card ------------------------ */
                    profileInformationCard(context, authController),
                    /* ----------------------------- recommendation ----------------------------- */
                    Padding(
                      padding: EdgeInsets.only(
                        left: 16.w,
                        right: 16.w,
                      ),
                      child: widgetRecommend(context),
                    ),

                    // /* ------------------------------- hot people ------------------------------- */

                    Padding(
                      padding: EdgeInsets.only(
                          left: 16.w, right: 16.w, top: 8.0.h, bottom: 13.h),
                      child: HotPeople(),
                    ),
                    size15,
                    /* ---------------------------- users in workout ---------------------------- */

                    Padding(
                      padding: EdgeInsets.only(left: 16.w, right: 16.w),
                      child:
                          UsersInWorkout(userID: authController.user?.userId),
                    ),

                    size30
                  ],
                ));
          });
    });
  }

  Widget widgetRecommend(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 10.0.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customText(
                text: 'RECOMMEND'.tr,
                fontColor: Color(0xFF303443),
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
              socialPageButton(
                text: "MORE".tr,
                function: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return SafeArea(
                            child: Padding(
                          padding: EdgeInsets.only(top: 40.0.h),
                          child: RecommendedScreen(),
                        ));
                      });
                },
              ),
            ],
          ),
        ),
        GetBuilder<RecommandController>(builder: (recommandController) {
          return Container(
            height: 204.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: recommandController.docs.length > 5
                  ? 5
                  : recommandController.docs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: index != 0
                      ? EdgeInsets.all(8.r)
                      : EdgeInsets.fromLTRB(0, 8.h, 8.w, 8.h),
                  child: recommendationCard(
                    userInfo: recommandController.docs[index],
                  ),
                );
              },
            ),
          );
        }),
      ],
    );
  }
}

class HotPeople extends StatelessWidget {
  const HotPeople({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customText(
              text: 'HOT_PEOPLE'.tr,
              fontColor: Color(0xFF303443),
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
            socialPageButton(
              text: 'MORE'.tr,
              function: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return SafeArea(
                      child: Padding(
                        padding: EdgeInsets.only(top: 40.0.h),
                        child: HotPeopleScreen(),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
        size15,
        GetBuilder<HotPeopleController>(builder: (hotPeopleController) {
          return Container(
            height: 250,
            child: GridView.builder(
              itemCount: hotPeopleController.docs.length > 6
                  ? 6
                  : hotPeopleController.docs.length, //item 개수
              physics: new NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
                childAspectRatio: 1 / 1, //item 의 가로 1, 세로 2 의 비율
                mainAxisSpacing: 20, //수평 Padding
                crossAxisSpacing: 20, //수직 Padding
              ),
              itemBuilder: (BuildContext context, int index) {
                //item 의 반목문 항목 형성
                return userCard(
                  context: context,
                  userInfo: hotPeopleController.docs[index],
                );
              },
            ),
          );
        }),
      ],
    );
  }
}

class UsersInWorkout extends StatelessWidget {
  int? userID;

  UsersInWorkout({Key? key, this.userID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customText(
              text: "USER_IN_WORKOUT".tr,
              fontColor: Color(0xFF303443),
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
            socialPageButton(
              text: "MORE".tr,
              function: () {
                showModalBottomSheet(
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
            ),
          ],
        ),
        size15,
        GetBuilder<WorkoutInController>(builder: (workoutInController) {
          return Container(
            height: 250,
            child: GridView.builder(
              itemCount: workoutInController.docs.length > 6
                  ? 6
                  : workoutInController.docs.length, //item 개수
              physics: new NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
                childAspectRatio: 1 / 1, //item 의 가로 1, 세로 2 의 비율
                mainAxisSpacing: 20, //수평 Padding
                crossAxisSpacing: 20, //수직 Padding
              ),
              itemBuilder: (BuildContext context, int index) {
                //item 의 반목문 항목 형성
                return userID != workoutInController.docs[index]["writer"]["id"]
                    ? userCard(
                        context: context,
                        userInfo: workoutInController.docs[index]["writer"],
                      )
                    : SizedBox();
              },
            ),
          );
        }),
      ],
    );
  }
}
