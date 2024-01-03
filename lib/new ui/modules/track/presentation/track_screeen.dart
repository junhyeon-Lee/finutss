import 'package:finutss/new%20ui/modules/home/controller/home_screen_controller.dart';
import 'package:finutss/new%20ui/modules/home/widget/custom_button.dart';
import 'package:finutss/new%20ui/modules/photo_video/presentation/photo_video_list_screen.dart';
import 'package:finutss/new%20ui/modules/track/controller/track_controller.dart';
import 'package:finutss/new%20ui/modules/track/presentation/track_detail_screen.dart';
import 'package:finutss/new%20ui/modules/track/widget/most_popular_card.dart';
import 'package:finutss/new%20ui/modules/track/widget/track_card.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/app_string.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/widget/custom_scrollable_list_tab.dart';
import 'package:finutss/new%20ui/widget/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:measure_size/measure_size.dart';

class TrackScreen extends StatefulWidget {
  TrackScreen({Key? key, required this.scrollController}) : super(key: key);
  final ScrollController scrollController;

  @override
  State<TrackScreen> createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {
  final TrackController _trackController = Get.find();
  final HomeScreenController controller = Get.find();
  double screenHeight = 0.0;
  RxDouble bottomSpaceHeight = 0.0.obs;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _trackController.getMostPopularTrack();
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = {
      "DAILY_TRACK".tr: [
        dailyTrack(),
      ],
      "MOST_POPULAR".tr: [
        MostPopularCardGridView(context),
      ],
      "EDITORS_PICK".tr: [
        editorPicks(),
      ],
      // "MY_CHECK_IN".tr: [
      //   myCheckInCardGridView(context),
      // ],
      "POPULAR_HASHTAGS".tr: [
        buildChoiceChips(),
      ],
      // "RECENT_USED".tr: [
      //   recentlyUsedGridView(context),
      // ],
    };
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: MeasureSize(
        onChange: (Size newSize) {
          screenHeight = newSize.height;
        },
        child: Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: CustomScrollableListTabScroller(
            scrollController: widget.scrollController,
            tabBuilder: (BuildContext context, int index, bool active) => Column(
              children: [
                SizedBox(
                  height: 3.h,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      data.keys.elementAt(index),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: !active
                          ? TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.sp,
                              color: AppColor.subTitleColor.withOpacity(0.5),
                            )
                          : TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13.sp,
                              color: AppColor.orangeColor,
                            ),
                    ),
                  ),
                ),
                Container(
                  width: 52.w,
                  height: 3.h,
                  decoration: !active
                      ? BoxDecoration()
                      : BoxDecoration(
                          color: AppColor.orangeColor,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.w),
                            topLeft: Radius.circular(10.w),
                          ),
                        ),
                ),
              ],
            ),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 10.h,
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            Text(
                              data.keys.elementAt(index),
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp,
                                letterSpacing: 0.4,
                              ),
                            ),
                            Spacer(),
                            index == 1
                                ? CustomButton(
                                    title: "VIEW".tr,
                                    fontColor: AppColor.green,
                                    borderColor: AppColor.green,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    borderRadius: 8,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 18.w,
                                      vertical: 7.h,
                                    ),
                                    onTap: () {
                                      clearSearchView();
                                      Navigation.pushNamed(Routes.mostPopularViewAllScreen, arg: {
                                        'title': 'MOST_POPULAR'.tr,
                                        'isMostPopular': true,
                                      });
                                    },
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ),
                    ...data.values
                            .elementAt(index)
                            .asMap()
                            .map(
                              (index, value) => MapEntry(
                                index,
                                value,
                              ),
                            )
                            .values ??
                        ""
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget dailyTrack() {
    return Obx(() {
      return controller.dailyTrack.value.name == null
          ? CustomVIew.noRecordLayout(title: "THERE_IS_NO_DAILY_TRACK_FOUND".tr, isLoading: false)
          : TrackCard(
              imageUrl: controller.dailyTrack.value.previewImage ?? '',
              titleText: controller.dailyTrack.value.name ?? '',
              subTitleText: controller.dailyTrack.value.description ?? '',
              galleryView: (controller.dailyTrack.value.totalPhotosCount ?? 0).toString(),
              comment: (controller.dailyTrack.value.totalCommentsCount ?? 0).toString(),
              like: (controller.dailyTrack.value.totalReactionCount ?? 0).toString(),
              view: (controller.dailyTrack.value.totalUses ?? 0).toString(),
              kmtr: Constants.meterToKmConvert((controller.dailyTrack.value.distanceInMetres ?? 0).toString()),
              isLiked: (controller.dailyTrack.value.isTrackLiked ?? false),
              energyPoint: (controller.dailyTrack.value.monetizationDetails?.energyPointsRequired ?? 0),
              isFree: (controller.dailyTrack.value.channel?.settings?.isOfficial ?? false),
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
                  _trackController.likeUnlike(
                      status: Constants.unlike, trackID: controller.dailyTrack.value.id ?? '', screenCode: Constants.dailyTrackScreen);
                } else {
                  _trackController.likeUnlike(
                      status: Constants.like, trackID: controller.dailyTrack.value.id ?? '', screenCode: Constants.dailyTrackScreen);
                }
              },
              onTapPhoto: () {
                Get.to(PhotoVideoListScreen(
                  isApiCall: true,
                  trackId: controller.dailyTrack.value.id,
                  isOpenThroughWorkoutScreen: true,
                ));
              },
              isDoneMarkShow: true,
            );
    });
  }

  Widget buildChoiceChips() => Obx(
        () => Wrap(
          runSpacing: 8,
          spacing: 9,
          children: _trackController.choiceChips
              .map(
                (choiceChip) => ChoiceChip(
                  label: Text(
                    choiceChip.label,
                    style: TextStyle(color: AppColor.lightBlueTextColor, fontWeight: FontWeight.w500, fontSize: 14.sp),
                  ),
                  labelStyle: TextStyle(color: AppColor.lightBlueTextColor, fontWeight: FontWeight.w500, fontSize: 14.sp),
                  onSelected: (isSelected) {
                    _trackController.choiceChips.value = _trackController.choiceChips.map((otherChip) {
                      final newChip = otherChip.copy(isSelected: false);
                      return choiceChip == newChip ? newChip.copy(isSelected: isSelected) : newChip;
                    }).toList();
                  },
                  selected: choiceChip.isSelected,
                  selectedColor: AppColor.whiteColor[300],
                  backgroundColor: AppColor.whiteColor[300],
                ),
              )
              .toList(),
        ),
      );

  Widget editorPicks() {
    return Column(
      children: [
        TrackCard(
          imageTag: true,
          titleText: AppString.fitnessTrack,
          onTapComment: () {},
          onTapLike: () {},
          onTapPhoto: () {},
          onTap: () {},
        ),
        SizedBox(
          height: 10.h,
        ),
        TrackCard(
          imageTag: true,
          titleText: AppString.seoulTrack,
          onTapComment: () {},
          onTapLike: () {},
          onTapPhoto: () {},
          onTap: () {},
        ),
      ],
    );
  }

  Widget MostPopularCardGridView(context) {
    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      removeTop: true,
      removeLeft: true,
      removeRight: true,
      child: Obx(
        () => controller.isLoading.value
            ? CustomVIew.mostPopularShimmer()
            : controller.mostPopularTrackList.length == 0
                ? CustomVIew.noRecordLayout(title: "THERE_IS_NO_POPULAR_TRACK".tr, isLoading: false)
                : GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.mostPopularTrackList.length > 10 ? 10 : controller.mostPopularTrackList.length,
                    itemBuilder: (context, int index) {
                      return GestureDetector(
                          onTap: () {
                            Get.to(TrackDetailScreen(trackId: controller.mostPopularTrackList[index].id ?? ''), transition: Routes.defaultTransition);
                          },
                          child: MostPopularCard(
                            trackImage: controller.mostPopularTrackList[index].previewImage,
                            trackName: controller.mostPopularTrackList[index].name,
                            distanceInKm: Constants.meterToKmConvert(((controller.mostPopularTrackList[index].parsedGpx?.tracks?.length ?? 0) == 0
                                    ? 0
                                    : controller.mostPopularTrackList[index].parsedGpx?.tracks?[0].distance?.total ?? 0)
                                .toString()),
                            description: controller.mostPopularTrackList[index].description,
                            userView: (controller.mostPopularTrackList[index].totalUses ?? 0).toString(),
                            energyPoint: controller.mostPopularTrackList[index].monetizationDetails?.energyPointsRequired ?? 0,
                          ));
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 1.2,
                    ),
                  ),
      ),
    );
  }

  Widget myCheckInCardGridView(context) {
    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      removeTop: true,
      removeLeft: true,
      removeRight: true,
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 4,
        itemBuilder: (context, int index) {
          return MostPopularCard(
            energyPoint: 0,
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          childAspectRatio: 1 / 1.2,
        ),
      ),
    );
  }

  Widget recentlyUsedGridView(context) {
    return Column(
      children: [
        MeasureSize(
          onChange: (Size newSize) {
            if (screenHeight > newSize.height) {
              screenHeight = screenHeight - newSize.height - 50.h - 10.h - 16.sp;
            }

            if (bottomSpaceHeight.value == 0.0) {
              bottomSpaceHeight.value = screenHeight;
            }
          },
          child: MediaQuery.removePadding(
            context: context,
            removeBottom: true,
            removeTop: true,
            removeLeft: true,
            removeRight: true,
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 2,
              itemBuilder: (context, int index) {
                return MostPopularCard(
                  energyPoint: 0,
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.2,
              ),
            ),
          ),
        ),
        Obx(() => SizedBox(
              height: bottomSpaceHeight.value,
            )),
        /*  SizedBox(
          height: 70.h,
        )*/
      ],
    );
  }

  Widget mostPopularViewAll(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: CustomButton(
        title: "VIEW".tr,
        fontColor: AppColor.green,
        borderColor: AppColor.green,
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        borderRadius: 10,
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
        onTap: () {
          clearSearchView();

          Navigation.pushNamed(Routes.mostPopularViewAllScreen, arg: {
            'title': "MOST_POPULAR".tr.toUpperCase(),
          });
        },
      ),
    );
  }

  clearSearchView() {
    _trackController.isSearchEnable.value = false;
    _trackController.searchController.text = '';
    controller.setTempList();
  }
}

// TrackTabBar(),
// Expanded(
//   child: TabBarView(
//     controller: _trackController.tabController,
//     children: [
//       DailyTrackTabView(
//         scrollController: scrollController,
//       ),
//       MostPopularTabView(
//         scrollController: scrollController,
//       ),
//       EditorPickTabView(),
//       MyTrackTabView(),
//     ],
//   ),
// ),
