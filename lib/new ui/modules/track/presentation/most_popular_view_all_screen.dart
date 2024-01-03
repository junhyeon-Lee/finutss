import 'package:finutss/new%20ui/modules/app_setting/widget/custom_setting_row.dart';
import 'package:finutss/new%20ui/modules/home/controller/home_screen_controller.dart';
import 'package:finutss/new%20ui/modules/photo_video/presentation/photo_video_list_screen.dart';
import 'package:finutss/new%20ui/modules/track/controller/track_controller.dart';
import 'package:finutss/new%20ui/modules/track/presentation/track_detail_screen.dart';
import 'package:finutss/new%20ui/modules/track/widget/track_card.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/app_string.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/routes.dart';
import 'package:finutss/new%20ui/widget/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MostPopularViewAllScreen extends StatefulWidget {
  MostPopularViewAllScreen({Key? key}) : super(key: key);

  @override
  State<MostPopularViewAllScreen> createState() => _MostPopularViewAllScreenState();
}

class _MostPopularViewAllScreenState extends State<MostPopularViewAllScreen> {
  final TrackController _trackController = Get.find();

  final HomeScreenController controller = Get.find();

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   controller.getDailyTrack();
    // });
  }

  String? title;

  bool isMostPopular = false;

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    title = arg['title'];
    isMostPopular = arg['isMostPopular'];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColor.backGroundColor,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.backGroundColor,
          body: Column(
            children: [
              Obx(() => _trackController.isSearchEnable.value
                  ? searchView()
                  : CustomSettingRow(
                      title: title ?? "MOST_POPULAR".tr.toUpperCase(),
                      horizontalPadding: 20.w,
                      fontsize: 18.sp,
                      fontWeight: FontWeight.w600,
                      child: InkWell(
                          onTap: () {
                            _trackController.isSearchEnable.value = true;
                          },
                          child: Center(
                              child: Image.asset(
                            IconAssets.search,
                            width: 18.w,
                          ))),
                    )),
              Expanded(
                child: isMostPopular
                    ? Obx(() => controller.tempMostPopularTrackList.length == 0
                        ? Center(
                            child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 18.w),
                                child: CustomVIew.noRecordLayout(title: "THERE_IS_NO_POPULAR_TRACK".tr, isLoading: false, borderRadius: 10.w),
                              ),
                            ],
                          ))
                        : mostPopularCardView())
                    : Scrollbar(
                        child: ListView.separated(
                          itemCount: 3,
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
                          shrinkWrap: true,
                          itemBuilder: (context, int index) => TrackCard(
                            titleText: AppString.fitnessTrack,
                            onTap: () {},
                            onTapComment: () {},
                            onTapLike: () {},
                            onTapPhoto: () {},
                          ),
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 16.h,
                            );
                          },
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget searchView() {
    return SizedBox(
      height: 52.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                autofocus: true,
                style: TextStyle(
                  color: AppColor.subTitleColor,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
                controller: _trackController.searchController,
                onChanged: (val) {
                  controller.searchTrack(text: val);
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                  border: InputBorder.none,
                  hintText: "SEARCH_FRIEND".tr + "...",
                  hintStyle: TextStyle(
                    color: AppColor.subTitleColor.withOpacity(0.45),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                _trackController.isSearchEnable.value = false;
                _trackController.searchController.text = '';
                controller.searchTrack(text: '');
              },
              child: CircleAvatar(
                radius: 12,
                backgroundColor: AppColor.CloseColor,
                child: Icon(
                  Icons.close,
                  size: 14.w,
                  color: AppColor.backIconColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget mostPopularCardView() {
    return Scrollbar(
        child: Obx(
      () => ListView.separated(
        itemCount: controller.tempMostPopularTrackList.length,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        shrinkWrap: true,
        itemBuilder: (context, int index) {
          return TrackCard(
            imageUrl: controller.tempMostPopularTrackList[index].previewImage,
            circleImagePath: controller.tempMostPopularTrackList[index].channel?.image ?? '',
            titleText: controller.tempMostPopularTrackList[index].name,
            kmtr: Constants.meterToKmConvert(((controller.tempMostPopularTrackList[index].parsedGpx?.tracks?.length ?? 0) == 0
                    ? 0
                    : controller.tempMostPopularTrackList[index].parsedGpx?.tracks?[0].distance?.total ?? 0)
                .toString()),
            subTitleText: controller.tempMostPopularTrackList[index].description,
            view: (controller.tempMostPopularTrackList[index].totalUses ?? 0).toString(),
            createdDate: controller.tempMostPopularTrackList[index].createdAt,
            isLiked: (controller.tempMostPopularTrackList[index].isTrackLiked ?? false),
            like: (controller.tempMostPopularTrackList[index].totalReactionCount ?? 0).toString(),
            comment: (controller.tempMostPopularTrackList[index].totalCommentsCount ?? 0).toString(),
            galleryView: (controller.tempMostPopularTrackList[index].totalPhotosCount ?? 0).toString(),
            energyPoint: (controller.tempMostPopularTrackList[index].monetizationDetails?.energyPointsRequired ?? 0),
            isFree: (controller.tempMostPopularTrackList[index].channel?.settings?.isOfficial ?? false),
            onTap: () {
              Get.to(
                TrackDetailScreen(trackId: controller.tempMostPopularTrackList[index].id ?? ''),
                transition: Routes.defaultTransition,
              );
            },
            onTapComment: () {
              controller.getTrackDetail(
                  id: controller.mostPopularTrackList[index].id ?? '', type: Constants.mostPopularScreen, index: index, controller: controller);
            },
            onTapLike: () {
              if (controller.tempMostPopularTrackList[index].isTrackLiked ?? false) {
                controller.likeUnlikePopularTrack(
                    status: Constants.unlike,
                    trackID: controller.tempMostPopularTrackList[index].id ?? '',
                    screenCode: Constants.mostPopularScreen,
                    index: index);
              } else {
                controller.likeUnlikePopularTrack(
                    status: Constants.like,
                    trackID: controller.tempMostPopularTrackList[index].id ?? '',
                    screenCode: Constants.mostPopularScreen,
                    index: index);
              }
            },
            onTapPhoto: () {
              // controller.getWorkoutRecord(trackId: widget.trackId);
              Get.to(PhotoVideoListScreen(
                isApiCall: true,
                trackId: controller.mostPopularTrackList[index].id,
                isOpenThroughWorkoutScreen: true,
              ));
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 16.h,
          );
        },
      ),
    ));
  }
}
