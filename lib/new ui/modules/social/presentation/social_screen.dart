import 'package:finutss/new%20ui/modules/home/controller/home_screen_controller.dart';
import 'package:finutss/new%20ui/modules/home/widget/workout_user_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/record/controller/bmi_slider_controller.dart';
import 'package:finutss/new%20ui/modules/sign_in/model/login_model.dart';
import 'package:finutss/new%20ui/modules/social/controller/social_controller.dart';
import 'package:finutss/new%20ui/modules/social/presentation/view_all_screen.dart';
import 'package:finutss/new%20ui/modules/user_profile/presentation/user_profile_screen.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/widget/custom_circle_imageview.dart';
import 'package:finutss/new%20ui/widget/people_card_view.dart';
import 'package:finutss/new%20ui/widget/shimmer/shimmer_from_colors.dart';
import 'package:finutss/new%20ui/widget/user_profile_card.dart';
import 'package:finutss/new%20ui/widget/view_all_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SocialScreen extends StatefulWidget {
  SocialScreen({Key? key, required this.scrollController}) : super(key: key);

  final ScrollController scrollController;

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> with AutomaticKeepAliveClientMixin{
  final SocialController controller = Get.put(SocialController());

  final BmiSliderController bmiSliderController = Get.find();

  final HomeScreenController homeController = Get.find();

  @override
  void initState() {
    super.initState();

    if (!Constants.isGuest) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.getRecommendedUser().then((value) {
          bmiSliderController.getUserInfo();
        });
      });
    } else {
      bmiSliderController.userModel.value = LoginModel();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          controller: widget.scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => UserProfileCard(
                        profileOnTap: () {
                          if (!Constants.isGuest) {
                            Navigation.pushNamed(Routes.profileScreen);
                          }
                        },
                        BottomRow: false,
                        button: false,
                        isCurrentUser: true,
                        showExerciseMenu: false,
                        isSocialScreen: false,
                        userModel: bmiSliderController.userModel.value,
                        valueChangedHandler: (value) {},
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                  ],
                ),
              ),
              Constants.isGuest ? SizedBox() : recommendedUserView(),
              size15(),
              Constants.isGuest
                  ? SizedBox()
                  : Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                      ),
                      child: Column(
                        children: [
                          hotPeopleUserView(),
                          size15(),
                          workoutUserView(context),
                          SizedBox(
                            height: 90.h,
                          ),
                        ],
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  Widget userItemView(
      {String? name, String? image, VoidCallback? onTapFollow,VoidCallback? onTap,required bool isShowLable}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 138.w,
        margin: EdgeInsets.only(right: 10.w),
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(
            12.w,
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.07),
              blurRadius: 2.0,
              spreadRadius: 0.7,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10.h,
            horizontal: 10.w,
          ),
          child: Column(
            children: [
              CustomCircleImageview(
                imagePath: image ?? '',
                width: 50.h,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                name ?? " ",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13.sp,
                  color: AppColor.blueTextColor,
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              isShowLable ? Text(
                "FOLLOW_YOU".tr,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 10.sp,
                  color: AppColor.blueTextColor.withOpacity(0.45),
                  fontStyle: FontStyle.italic,
                ),
              ) : SizedBox(),
              Spacer(),
              GestureDetector(
                onTap: onTapFollow,
                child: followButton(
                  AppColor.orangeColor,
                  "FOLLOW".tr,
                  AppColor.orangeColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget size15() {
    return SizedBox(
      height: 17.h,
    );
  }

  Widget followButton(Color color, String? title, Color titleColor) {
    return Container(
      height: 24.h,
      width: 80.w,
      decoration: BoxDecoration(
        border: Border.all(
          color: color,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Center(
        child: Text(
          title ?? "VIEW".tr,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: titleColor,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }

  Widget recommendedUserView() {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            controller.recommendedUsers.length > 0 ||
                    controller.isLoadingHotPeople.value
                ? Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 14.w),
                    child: ViewAllButton(
                      title: "RECOMMENDED".tr,
                      onTap: () {
                        Get.to(ViewAllScreen(
                          isHotPeople: false,
                          title: "RECOMMENDED".tr,
                        ));
                      },
                    ),
                  )
                : Container(),
            controller.isLoadingHotPeople.value
                ? shimmerRecommended()
                : controller.recommendedUsers.length > 0
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 154.h,
                            child: Obx(
                              () => ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                padding:
                                    EdgeInsets.only(left: 14.w, bottom: 4.h),
                                itemCount: controller.recommendedUsers.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {


                                  return userItemView(
                                    onTap: (){
                                      Get.to(
                                        UserProfileScreen(
                                          userId: controller.recommendedUsers[index].id,type: Constants.recommendedUser,index: index,
                                        ),
                                          transition: Routes.defaultTransition
                                      );
                                    },
                                    onTapFollow: () {
                                      controller.FollowApi(
                                        index,
                                        controller.recommendedUsers[index].id ??
                                            '',
                                      );
                                    },
                                    image: controller
                                        .recommendedUsers[index].profilePhoto,
                                    name: controller
                                        .recommendedUsers[index].username,
                                    isShowLable: controller
                                        .recommendedUsers[index].isShowFollowYou ?? false,
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      )
                    : SizedBox(),
          ],
        ));
  }

  Widget shimmerHotPeople() {
    return Container(
      height: 200.h,
      child: CustomShimmer(
        child: GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.only(bottom: 10.h),
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 3 / 2.85,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemCount: 6,
          itemBuilder: (BuildContext ctx, index) {
            return PeopleCardView(
              image: '',
              name: '',
              onTap: () {},
            );
          },
        ),
      ),
    );
  }

  Widget shimmerRecommended() {
    return Container(
      height: 154.h,
      child: CustomShimmer(
        child: ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.only(left: 14.w, bottom: 4.h),
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return userItemView(
              onTapFollow: () {},
              image: '',
              name: '',
              isShowLable: false
            );
          },
        ),
      ),
    );
  }

  Widget hotPeopleUserView() {
    return Column(
      children: [
        Obx(() => controller.isLoadingHotPeople.value ||
                controller.hotUserList.length > 0
            ? ViewAllButton(
                title: "HOT_PEOPLE".tr,
                onTap: () {
                  Get.to(
                    ViewAllScreen(
                      isHotPeople: true,
                      title: "HOT_PEOPLE".tr,
                    ),
                  );
                },
              )
            : SizedBox()),
        size15(),
        Obx(() => controller.isLoadingHotPeople.value
            ? shimmerHotPeople()
            : controller.hotUserList.length > 0
                ? GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(bottom: 10.h),
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 3 / 2.85,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                    ),
                    itemCount: controller.hotUserList.length >= 6
                        ? 6
                        : controller.hotUserList.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return PeopleCardView(
                        image: controller.hotUserList[index].profilePhoto,
                        name: controller.hotUserList[index].username,
                        onTap: () {
                          Get.to(
                            UserProfileScreen(
                              userId: controller.hotUserList[index].id,index: index,type: Constants.hotPeople,
                            ),
                              transition: Routes.defaultTransition
                          );
                          /*Navigation.pushNamed(
                              Routes.userProfileScreen,
                            );*/
                        },
                      );
                    },
                  )
                : SizedBox()),
      ],
    );
  }

  Widget workoutUserView(BuildContext context) {
    return Obx(
      () => homeController.workoutUserList.length == 0
          ? SizedBox()
          : Column(
              children: [
                ViewAllButton(
                  title: "USER_IN_WORKOUT".tr,
                  onTap: () {
                    workoutUserBottomSheet(context, title: "WORKOUT_USERS");
                  },
                ),
                size15(),
                GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(bottom: 10.h),
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 3 / 2.85,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemCount: homeController.workoutUserList.length > 6
                      ? 6
                      : homeController.workoutUserList.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return PeopleCardView(
                      name:
                          homeController.workoutUserList[index].username ?? '',
                      image:
                          homeController.workoutUserList[index].profilePhoto ??
                              '',
                      onTap: () {
                        Get.to(
                          UserProfileScreen(
                            userId:
                                homeController.workoutUserList[index].id ?? '',index: index,type: Constants.workoutUser,
                          ),
                            transition: Routes.defaultTransition
                        );
                      },
                    );
                  },
                ),
              ],
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
