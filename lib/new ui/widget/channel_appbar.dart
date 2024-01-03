import 'package:cached_network_image/cached_network_image.dart';
import 'package:finutss/new%20ui/modules/channel_track/controller/channel_controller.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/utils/assets.dart';
import 'package:finutss/new%20ui/widget/custom_circle_imageview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChannelAppBar extends StatelessWidget {
  ChannelAppBar({
    required this.avatar,
    required this.title,
    required this.trackController,
    this.extent = 260,
    Key? key,
  }) : super(key: key);

  final Widget avatar;
  final double extent;
  final String title;
  final ChannelController trackController;




  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _TransitionAppBarDelegate(
        avatar: avatar,
        title: title,
        extent: extent > 200 ? extent : 200,
        trackController: trackController
      ),
    );
  }
}

class _TransitionAppBarDelegate extends SliverPersistentHeaderDelegate {
  _TransitionAppBarDelegate(
      {required this.avatar, required this.title, this.extent = 250,required this.trackController})
      : assert(extent >= 200, '');

  final Widget avatar;
  final double extent;
  final String title;

  final ChannelController trackController;

  final _avatarAlignTween =
      AlignmentTween(begin: Alignment.bottomLeft, end: Alignment.topLeft);
  final _avatarMarginTween = EdgeInsetsTween(
    end: EdgeInsets.only(left: 14, top: 100),
  );

  final _iconAlignTween =
      AlignmentTween(begin: Alignment.bottomRight, end: Alignment.topRight);
  final _titleMarginTween = EdgeInsetsTween(
    begin: EdgeInsets.only(bottom: 20),
    end: EdgeInsets.only(left: 70, top: 100),
  );

  @override
  double get maxExtent => extent;

  @override
  double get minExtent => 160.h;

  @override
  bool shouldRebuild(_TransitionAppBarDelegate oldDelegate) {
    return avatar != oldDelegate.avatar || title != oldDelegate.title;
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final tempVal = maxExtent * 100 / 100;
    final progress = shrinkOffset > tempVal ? 1.0 : shrinkOffset / tempVal;
    final titleMargin = _titleMarginTween.lerp(progress);

    final avatarAlign = _avatarAlignTween.lerp(progress);

    final avatarSize = 66.h - (progress * 10);
    final imageNargin = 22.h - progress * 22.h;

    return Stack(
      children: <Widget>[
        AnimatedContainer(
          duration: Duration(milliseconds: 100),
          height: 160.h,
          constraints: BoxConstraints(maxHeight: minExtent),
          color: AppColor.whiteColor,
        ),
        Container(
            width: double.infinity,
            height: 180.h,
            child: Obx(()=> CachedNetworkImage(
              imageUrl: trackController.channelModel.value.data?.bannerImage ?? '',
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),)),
        Container(
          width: double.infinity,
          height: 180.h,
          color: AppColor.whiteColor.withOpacity(progress),
        ),
        Container(
          height: 50.h,
          margin: EdgeInsets.only(top: 34.h, left: 20.w, right: 20.w),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: SvgPicture.asset(
                        IconAssets.backIcon,
                        width: 18.w,
                        color: progress < 0.7
                            ? AppColor.whiteColor
                            : AppColor.subTitleColor.withOpacity(progress),
                      ))),
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Text(
                    "CHANNEL".tr.toUpperCase(),
                    style: TextStyle(
                        color: progress < 0.7
                            ? AppColor.whiteColor
                            : AppColor.subTitleColor.withOpacity(progress),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            left: 100.w,
            right: 0,
            child: SizedBox(
              height: 80.h,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Image.asset(ImageAssets.seoulImage,width: 58.h,height: 58.h,fit: BoxFit.cover,),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(() => Text(
                          trackController.channelModel.value.data?.name ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15.5.sp,
                            color: AppColor.subTitleColor,
                          ),
                        )),
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          children: [
                            Text(
                              'Checkins: '+(trackController.channelModel.value.data?.subscriberCount ?? 0).toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 11.sp,
                                color:
                                    AppColor.subTitleColor.withOpacity(0.5),
                              ),
                            ),
                            Spacer(),
                            SvgPicture.asset(IconAssets.markerIcon),
                            SizedBox(
                              width: 6.w,
                            ),
                            Text(
                              "CHECK_IN".tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10.sp,
                                  color: AppColor.alreadyTextColor),
                            ),
                            SizedBox(
                              width: 18.w,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )),
        Positioned(
            bottom: imageNargin,
            left: 14.w,
            child: SizedBox(
                height: 80.h,
                child: Center(
                    child: Obx(()=>CustomCircleImageview(
                      width: avatarSize,
                      imagePath: trackController.channelModel.value.data?.image ?? '',
                    ))
                ),),),
        Padding(
          padding: titleMargin,
          child: Align(
            alignment: avatarAlign,
            child: Text(
              '',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    );
  }
}
