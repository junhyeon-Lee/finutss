import 'package:carousel_slider/carousel_slider.dart';
import 'package:finutss/new%20ui/modules/home/controller/home_screen_controller.dart';
import 'package:finutss/new%20ui/modules/home/widget/workout_user_bottom_sheet.dart';
import 'package:finutss/new%20ui/modules/record/service/user_service.dart';
import 'package:finutss/new%20ui/modules/sign_in/model/login_model.dart';
import 'package:finutss/new%20ui/modules/track/controller/track_controller.dart';
import 'package:finutss/new%20ui/modules/track/presentation/track_detail_screen.dart';
import 'package:finutss/new%20ui/modules/track/widget/track_card.dart';
import 'package:finutss/new%20ui/modules/user_profile/presentation/user_profile_screen.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/cache_network_image.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/widget/people_card_view.dart';
import 'package:finutss/new%20ui/widget/shimmer/shimmer_from_colors.dart';
import 'package:finutss/new%20ui/widget/view_all_button.dart';
import 'package:finutss/presentation/presentation/animation/bouncing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import '../../photo_video/presentation/photo_video_list_screen.dart';

class HomeSensorStatesScreen extends StatefulWidget {
  HomeSensorStatesScreen({Key? key, this.scrollController}) : super(key: key);

  final ScrollController? scrollController;

  @override
  State<HomeSensorStatesScreen> createState() => _HomeSensorStatesScreenState();
}

class _HomeSensorStatesScreenState extends State<HomeSensorStatesScreen> {
  final HomeScreenController controller = Get.put(HomeScreenController());
  final TrackController _trackController = Get.put(TrackController());

  @override
  void initState() {
    super.initState();

    if (!Constants.isGuest) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.getTimeZoneData();
        getUserData();
        controller.getDailyTrack().then((value) {
          controller.getBanner().then((value) {
            controller.getUserId().then((value) {
              controller.getDailyCal();
            });
          });
        });
      });
    }
  }

  LoginModel? user;

  Future<void> getUserData() async {
    user = await UserService.getUserInfo();
    debugPrint(user?.data?.email);
    debugPrint(user?.data?.gender);
    if (user?.data?.gender == null) {
      ///tutorial
      // Get.dialog(TutorialScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Container(
        child: SingleChildScrollView(
          controller: widget.scrollController,
          child: Column(
            children: [
              slider(),
              SizedBox(
                height: 4.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    cardView(
                      checkNowOnTap: () async {
                        Navigation.pushNamed(
                          Routes.userGuideScreen,
                        );
                        // LoginController loginController = Get.find();
                        // loginController.user?.data?.workoutType?.value = Constants.riding;
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    dailyTrackView(),
                    SizedBox(
                      height: 6.h,
                    ),
                    workoutUserView(),
                    SizedBox(
                      height: 90.h,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardView({required VoidCallback checkNowOnTap}) {
    return Row(
      children: [
        Expanded(
          child: customCard(Padding(
            padding: EdgeInsets.only(bottom: 11.h, top: 11.h, left: 10.w, right: 10.w),
            child: Column(
              children: [
                Obx(() => Expanded(
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Positioned(
                            top: 0,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () {},
                              child: Obx(() => SleekCircularSlider(
                                    initialValue: double.parse((controller.todayCal.value).toString()),
                                    innerWidget: null,
                                    appearance: CircularSliderAppearance(
                                      size: 70.h,
                                      customWidths: CustomSliderWidths(
                                        trackWidth: 3,
                                        progressBarWidth: 5,
                                      ),
                                      infoProperties: InfoProperties(
                                          bottomLabelStyle: TextStyle(
                                              color: AppColor.subTitleColor.withOpacity(0.5),
                                              fontSize: 10.sp,
                                              fontFamily: 'MontserratItalic',
                                              fontWeight: FontWeight.w500),
                                          bottomLabelText: '/2000 ' + 'KCAL'.tr + ' \n\n',
                                          mainLabelStyle: TextStyle(
                                              color: controller.isDailyTraining.value ? AppColor.orangeColor : AppColor.blue,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w700),
                                          modifier: (double value) {
                                            final kcal = controller.todayCal;
                                            return '$kcal';
                                          }),
                                      customColors: CustomSliderColors(
                                        progressBarColor: controller.isDailyTraining.value ? AppColor.orangeColor : AppColor.blue,
                                        trackColor: AppColor.gray.withOpacity(0.50),
                                        shadowColor: AppColor.gray,
                                      ),
                                      animationEnabled: false,
                                    ),
                                    min: 0,
                                    max: 2000,
                                    onChange: null,
                                    onChangeEnd: null,
                                  )),
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                                  width: 24.h,
                                  height: 24.h,
                                  child: IgnorePointer(
                                    child:
                                        SvgPicture.asset(controller.isDailyTraining.value ? IconAssets.rightRoundedIcon : IconAssets.stepRoundIcon),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    )),
                SizedBox(
                  height: 8.h,
                ),
                Center(
                  child: Text(
                    "DAILY_TRAINING".tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColor.subTitleColor.withOpacity(0.7),
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                      letterSpacing: 1,
                    ),
                  ),
                )
              ],
            ),
          )),
        ),
        SizedBox(
          width: 12.w,
        ),
        Expanded(
          child: customCard(Padding(
            padding: EdgeInsets.all(13.h),
            child: Column(
              children: [
                SizedBox(
                  height: 4.h,
                ),
                SvgPicture.asset(
                  IconAssets.guideIcon,
                  height: 32.h,
                ),
                SizedBox(
                  height: 9.h,
                ),
                Text(
                  "USER_GUIDE".tr,
                  style: TextStyle(color: AppColor.subTitleColor.withOpacity(0.7), fontWeight: FontWeight.w600, fontSize: 13.sp),
                ),
                Spacer(),
                Bouncing(
                  duration: Duration(milliseconds: 100),
                  onPressed: checkNowOnTap,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.w,
                        color: AppColor.purple,
                      ),
                      borderRadius: BorderRadius.circular(9.w),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 6.h),
                    child: Text(
                      "CHECK_NOW".tr,
                      style: TextStyle(color: AppColor.purple, fontWeight: FontWeight.w700, fontSize: 12.sp),
                    ),
                  ),
                )
              ],
            ),
          )),
        ),
      ],
    );
  }

  Widget customCard(Widget child) {
    return Container(
      height: 120.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.w),
        color: AppColor.whiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColor.cardGradiant1.withOpacity(0.06),
            spreadRadius: 30,
            blurRadius: 80,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: child,
    );
  }

  Widget slider() {
    return SizedBox(
      height: 170.h,
      child: Obx(
        () => CarouselSlider.builder(
          itemCount: controller.sliderImage.length,
          itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
            return controller.sliderImage.length > 0
                ? CacheNetworkImageView(
                    loader: CustomShimmer(
                      child: Container(
                        width: double.infinity,
                        height: 170.h,
                        color: Colors.grey,
                      ),
                    ),
                    imageUrl: controller.sliderImage[itemIndex].imageUrl.toString(),
                  )
                : CustomShimmer(
                    child: Container(
                      width: double.infinity,
                      height: 170.h,
                      color: Colors.grey,
                    ),
                  );
          },
          options: CarouselOptions(
            height: 142.h,
            aspectRatio: 1,
            viewportFraction: 0.86,
            clipBehavior: Clip.none,
            disableCenter: false,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: false,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          ),
        ),
      ),
    );
  }

  Widget dailyTrackView() {
    return Column(
      children: [
        Obx(
          () => controller.dailyTrack.value.id != null || controller.isLoading.value
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 14.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "DAILY_TRACK".tr,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        letterSpacing: 0.5,
                        color: AppColor.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                )
              : SizedBox(),
        ),
        Obx(() {
          return controller.isLoading.value
              ? CustomShimmer(
                  child: TrackCard(
                    onTapComment: () {},
                    onTapLike: () {},
                    onTapPhoto: () {},
                    onTap: () {},
                  ),
                )
              : controller.dailyTrack.value.id == null
                  ? SizedBox()
                  : TrackCard(
                      isDoneMarkShow: false,
                      imageUrl: controller.dailyTrack.value.previewImage ?? '',
                      titleText: controller.dailyTrack.value.name ?? '',
                      subTitleText: controller.dailyTrack.value.description ?? '',
                      galleryView: (controller.dailyTrack.value.totalPhotosCount ?? 0).toString(),
                      comment: (controller.dailyTrack.value.totalCommentsCount ?? 0).toString(),
                      like: (controller.dailyTrack.value.totalReactionCount ?? 0).toString(),
                      view: (controller.dailyTrack.value.totalUses ?? 0).toString(),
                      isLiked: (controller.dailyTrack.value.isTrackLiked ?? false),
                      createdDate: controller.dailyTrack.value.createdAt,
                      energyPoint: (controller.dailyTrack.value.monetizationDetails?.energyPointsRequired ?? 0),
                      isFree: (controller.dailyTrack.value.channel?.settings?.isOfficial ?? false),
                      kmtr: Constants.meterToKmConvert((controller.dailyTrack.value.distanceInMetres ?? 0).toString()),
                      circleImagePath: (controller.dailyTrack.value.channel?.image ?? '').toString(),
                      onTap: () {
                        String trackID = controller.dailyTrack.value.id ?? '';
                        if (trackID.isNotEmpty) {
                          Get.to(TrackDetailScreen(trackId: controller.dailyTrack.value.id ?? ''), transition: Routes.defaultTransition);
                        }
                      },
                      onTapComment: () {
                        controller.getTrackDetail(
                            id: controller.dailyTrack.value.id ?? '', type: Constants.dailyTrackScreen, index: 0, controller: controller);
                      },
                      onTapLike: () {
                        if (controller.dailyTrack.value.isTrackLiked ?? false) {
                          controller.likeUnlike(status: Constants.unlike, trackID: controller.dailyTrack.value.id ?? '');
                        } else {
                          controller.likeUnlike(status: Constants.like, trackID: controller.dailyTrack.value.id ?? '');
                        }
                      },
                      onTapPhoto: () {
                        Get.to(PhotoVideoListScreen(
                          isApiCall: true,
                          isOpenThroughWorkoutScreen: true,
                          trackId: controller.dailyTrack.value.id,
                        ));
                      },
                    );
        })
      ],
    );
  }

  Widget workoutUserView() {
    return Obx(() => controller.workoutUserList.length == 0
        ? SizedBox()
        : Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 18.h),
                child: ViewAllButton(
                  onTap: () {
                    workoutUserBottomSheet(context, title: "WORKOUT_USERS");
                  },
                  title: "WORKOUT_USERS".tr.toUpperCase(),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.only(bottom: 10.h),
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 3 / 2.85,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemCount: controller.workoutUserList.length > 6 ? 6 : controller.workoutUserList.length,
                itemBuilder: (BuildContext ctx, index) {
                  return PeopleCardView(
                    image: controller.workoutUserList[index].profilePhoto ?? '',
                    name: controller.workoutUserList[index].username ?? '',
                    onTap: () {
                      Get.to(
                          UserProfileScreen(
                            userId: controller.workoutUserList[index].id ?? '',
                            index: index,
                            type: Constants.workoutUser,
                          ),
                          transition: Routes.defaultTransition);
                    },
                  );
                },
              ),
            ],
          ));
  }
}
