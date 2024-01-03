import 'package:finutss/new%20ui/modules/photo_video/controller/photo_video_controller.dart';
import 'package:finutss/new%20ui/modules/photo_video/widget/photo_video_view.dart';
import 'package:finutss/new%20ui/modules/track/controller/track_detail_controller.dart';
import 'package:finutss/new%20ui/modules/track/presentation/posts_screen.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/navigation_utils/navigation.dart';
import 'package:finutss/new%20ui/widget/custom_view.dart';
import 'package:finutss/new%20ui/widget/shimmer/shimmer_from_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PhotoVideoListScreen extends StatefulWidget {
  PhotoVideoListScreen({Key? key, required this.isApiCall, this.trackId, required this.isOpenThroughWorkoutScreen, this.trackDetailController})
      : super(key: key);
  bool isApiCall;
  String? trackId;
  bool isOpenThroughWorkoutScreen;
  TrackDetailController? trackDetailController;

  @override
  State<PhotoVideoListScreen> createState() => _PhotoVideoListScreenState();
}

class _PhotoVideoListScreenState extends State<PhotoVideoListScreen> {
  final PhotoVideoController controller = Get.find();
  late TrackDetailController trackController = Get.put(TrackDetailController(), tag: widget.trackId);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      controller.isLoading.value = true;
      await trackController.getWorkoutRecord(trackId: widget.trackId ?? '');
      controller.isLoading.value = false;
      controller.limit = 21;
      controller.startIndex = 0;
      controller.isLoadPagination.value = false;
      if (widget.isApiCall) {
        controller.getTrackDetail(widget.trackId ?? '');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: AppColor.photoBgColor,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.photoBgColor,
          body: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigation.pop();
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 12.w, top: 20.h, bottom: 20.h),
                    child: Image.asset(
                      IconAssets.close,
                      color: AppColor.whiteColor,
                      width: 19.w,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Obx(() {
                  return controller.isLoading.value
                      ? imagesShimmer()
                      : Obx(
                          () => controller.photosList.length == 0
                              ? Center(child: CustomVIew.errorMessageShow('THERE_IS_NO_IMAGES_VIDEO_FOUND', textColor: AppColor.whiteColor))
                              : GridView.builder(
                                  controller: controller.scrollController,
                                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
                                  itemCount: controller.photosList.length,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 3 / 3,
                                    mainAxisSpacing: 4,
                                    crossAxisSpacing: 4,
                                  ),
                                  itemBuilder: (BuildContext context, int index) {
                                    return Obx(() => PhotoVideoView(
                                          isVisible: trackController.isTrackCompleted.value
                                              ? false.obs
                                              : index == 0
                                                  ? false.obs
                                                  : true.obs,
                                          controller: controller,
                                          index: index,
                                          onTap: () {
                                            if (widget.isOpenThroughWorkoutScreen) {
                                              Navigator.of(context).push(
                                                PageRouteBuilder(
                                                  opaque: false,
                                                  pageBuilder: (BuildContext context, _, __) => PostsScreen(
                                                    pinpointId: controller.photosList[index].pinPointId,
                                                    index: index,
                                                    photosList: controller.photosList,
                                                    trackDetailController: trackController,
                                                    type: Constants.mostPopularScreen,
                                                    trackId: widget.trackId!,
                                                  ),
                                                ),
                                              );
                                            } else {
                                              Navigator.pop(context, controller.photosList[index].pinPointId);
                                            }
                                            /*  Get.to(() => FullScreenImage(
              url: widget.controller.photosList[widget.index].url,
              type: widget.controller.photosList[widget.index].type,
            ));*/
                                          },
                                        ));
                                  },
                                ),
                        );
                }),
              ),
              Obx(() => controller.isLoadPagination.value
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : SizedBox())
            ],
          ),
        ),
      ),
    );
  }

  Widget imagesShimmer() {
    return CustomShimmer(
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 20,
        itemBuilder: (context, int index) {
          return Container(
            color: AppColor.whiteColor,
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 3 / 3,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
        ),
      ),
    );
  }
}
